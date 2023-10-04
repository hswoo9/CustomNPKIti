package com.duzon.custom.educationManagement.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.common.dao.CommonDAO;
import com.duzon.custom.common.excel.ExcelRead;
import com.duzon.custom.common.excel.ExcelReadOption;
import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.educationManagement.dao.EducationDAO;
import com.duzon.custom.educationManagement.service.EducationService;
import com.duzon.custom.educationManagement.vo.OnlineEduVO;

@Service
public class EducationServiceImpl implements EducationService {

private static final Logger logger = LoggerFactory.getLogger(EducationServiceImpl.class);
	
	@Value("#{bizboxa['BizboxA.fileRootPath']}")
	private String fileRootPath;
	
	@Value("#{bizboxa['BizboxA.tpf_education']}")
	private String tpf_education;
	
	@Value("#{bizboxa['BizboxA.tpf_education_result']}")
	private String tpf_education_result;
	
	@Autowired
	private EducationDAO educationDAO;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CommonDAO commonDAO;
	
	@Override
	public void groupEduReg(Map<String, Object> map) {
		map.put("education_start_date", ((String) map.get("education_start_date")).replaceAll("-", ""));
		map.put("education_end_date", ((String) map.get("education_end_date")).replaceAll("-", ""));
		educationDAO.groupEduReg(map);
		
		String[] keyVal = ((String) map.get("subKey")).split(",");
		for (String key : keyVal) {
			Map<String, Object> userInfo = commonService.getKssfUserInfo(key);
			map.put("education_dept_seq", userInfo.get("dept_seq"));
			map.put("education_emp_seq", key);
			map.put("education_dept_name", userInfo.get("dept_name"));
			map.put("education_position", userInfo.get("positionName"));
			map.put("education_duty", userInfo.get("dutyName"));
			educationDAO.groupEduPersonReg(map);
		}
		
	}

	@Override
	public List<Map<String, Object>> eduList(Map<String, Object> map) {
		
		return educationDAO.eduList(map);
	}

	@Override
	public int eduListTotal(Map<String, Object> map) {
		
		return educationDAO.eduListTotal(map);
	}

	@Override
	public List<Map<String, Object>> groupEduDetailList(Map<String, Object> map) {
		return educationDAO.groupEduDetailList(map);
	}

	@Override
	public int groupEduDetailListTotal(Map<String, Object> map) {
		return educationDAO.groupEduDetailListTotal(map);
	}

	@Override
	public void groupEduApproval(Map<String, Object> map) {
		String[] education_id = ((String) map.get("data")).split(",");
		for (int i = 0; i < education_id.length; i++) {
			map.put("education_id", education_id[i]);
			
			educationDAO.groupEduApproval(map);
			
		}
	}

	@Override
	public void eduFinApproval(Map<String, Object> map, MultipartHttpServletRequest multi) {
		String path = tpf_education;
		String filePath = "";		
		
		if(StringUtils.isEmpty((String) map.get("checked"))) {
			
		} else {
			Map<String, Object> getFinEduCd = commonService.getCodeOne("EDUCATION_STEP", "ES03");
			map.put("education_step_code_id", "ES03");
			map.put("education_step", getFinEduCd.get("code_kr"));
			educationDAO.eduFinApproval(map);
			String[] key = ((String) map.get("checked")).split(",");
			for (int i=0 ; i < key.length ; i++) {
				map.put("education_person_id", key[i]);
				Map<String, Object> getFinPersonCd = commonService.getCodeOne("EDU_COMPLETION_STS", "EC02");
				
				map.put("complete_state_code_id", "EC02");
				map.put("complete_state", getFinPersonCd.get("code_kr"));
				
				educationDAO.eduPersonFinApproval(map);
			}
		}
		
		if(StringUtils.isEmpty((String) map.get("notChecked"))) {
			
		} else {
			String[] key = ((String) map.get("notChecked")).split(",");
			for (int i=0 ; i < key.length ; i++) {
				map.put("complete_state_code_id", "");
				map.put("complete_state", "");
				map.put("education_person_id", key[i]);
				educationDAO.eduPersonFinReset(map);
			}
		}
		
		map.put("tableName", "tpf_education");
		map.put("targetKey", map.get("mainKey"));
		map.put("file_seq",commonDAO.getFileSeq(map));
		Iterator<String> files = multi.getFileNames();
		 while(files.hasNext()){
			String uploadFile = files.next();                         
            MultipartFile mFile = multi.getFile(uploadFile);            
            String fileName = mFile.getOriginalFilename();
			String fileSize = String.valueOf(mFile.getSize());
             if(fileName.equals("")) { 
            	
            } else {            	
            	educationDAO.eduFinFileSave(map);
            	String fileNm = map.get("attach_file_id") +"."+ fileName.substring(fileName.lastIndexOf(".")+1);
            	int Idx = fileName.lastIndexOf(".");
            	String _fileName = fileName.substring(0, Idx);
            	Calendar cal = Calendar.getInstance();
            	String yyyy = String.valueOf(cal.get(Calendar.YEAR));
            	String mm = String.valueOf(cal.get(Calendar.MONTH) + 1);
            	String subPath = yyyy+"/"+mm;
            	filePath = fileRootPath+path+subPath+File.separator;
            	String ext = fileName.substring(fileName.lastIndexOf(".")+1);
            	
            	File dir = new File(filePath);
		            if(!dir.isDirectory()){
		                dir.mkdirs();
		            }
		            try {
		                mFile.transferTo(new File(filePath + fileNm));
		                map.put("filePath", filePath);
		        		map.put("fileNm", _fileName);
		        		map.put("ext", ext);
		        		map.put("fileSize", fileSize);
		            } catch (Exception e) {
		            	logger.error(e.getMessage());
		            }	
		            educationDAO.eduFinFileUpload(map);
            	
            	
            }
			 
		 }
		
	}

	@Override
	public void privateEduReg(Map<String, Object> map, MultipartHttpServletRequest multi) {
		String path = tpf_education;
		String resultPath = tpf_education_result;
		String filePath = "";		
		
		map.put("education_start_date", ((String) map.get("education_start_date")).replaceAll("-", ""));
		map.put("education_end_date", ((String) map.get("education_end_date")).replaceAll("-", ""));
		map.put("complete_hour",map.get("education_hour"));
		if (StringUtils.isEmpty((String) map.get("education_id"))) {
			educationDAO.groupEduReg(map);
			educationDAO.groupEduPersonReg(map);
		} else {
			educationDAO.privateEduUpdate(map);
			educationDAO.privateEduPersonUpdate(map);
		}
		
		map.put("targetKey", map.get("education_id"));
		Iterator<String> files = multi.getFileNames();
		 while(files.hasNext()){
			String uploadFile = files.next();                         
            MultipartFile mFile = multi.getFile(uploadFile);            
            String fileName = mFile.getOriginalFilename();
			String fileSize = String.valueOf(mFile.getSize());
			if(fileName.equals("")) { 
	        }else {
	        	if(uploadFile.equals("education_result_file")) {
					map.put("education_file_seq",educationDAO.getResultFileSeq(map));
					educationDAO.eduResultFileSave(map);
					String fileNm = map.get("education_result_id") +"."+ fileName.substring(fileName.lastIndexOf(".")+1);
					int Idx = fileName.lastIndexOf(".");
	            	String _fileName = fileName.substring(0, Idx);
	            	Calendar cal = Calendar.getInstance();
	            	String yyyy = String.valueOf(cal.get(Calendar.YEAR));
	            	String mm = String.valueOf(cal.get(Calendar.MONTH) + 1);
	            	String subPath = yyyy+"/"+mm;
	            	filePath = fileRootPath+resultPath+subPath+File.separator;
	            	String ext = fileName.substring(fileName.lastIndexOf(".")+1);
	            	
	            	File dir = new File(filePath);
			            if(!dir.isDirectory()){
			                dir.mkdirs();
			            }
			            try {
			                mFile.transferTo(new File(filePath + fileNm));
			                map.put("filePath", filePath);
			        		map.put("fileNm", _fileName);
			        		map.put("ext", ext);
			        		map.put("fileSize", fileSize);
			            } catch (Exception e) {
			            	logger.error(e.getMessage());
			            }	
			            educationDAO.eduResultFileUpload(map);
			            
				} else {
					map.put("tableName", "tpf_education");
					map.put("file_seq",commonDAO.getFileSeq(map));
					educationDAO.eduFinFileSave(map);
	            	String fileNm = map.get("attach_file_id") +"."+ fileName.substring(fileName.lastIndexOf(".")+1);
	            	int Idx = fileName.lastIndexOf(".");
	            	String _fileName = fileName.substring(0, Idx);
	            	Calendar cal = Calendar.getInstance();
	            	String yyyy = String.valueOf(cal.get(Calendar.YEAR));
	            	String mm = String.valueOf(cal.get(Calendar.MONTH) + 1);
	            	String subPath = yyyy+"/"+mm;
	            	filePath = fileRootPath+path+subPath+File.separator;
	            	String ext = fileName.substring(fileName.lastIndexOf(".")+1);
	            	
	            	File dir = new File(filePath);
			            if(!dir.isDirectory()){
			                dir.mkdirs();
			            }
			            try {
			                mFile.transferTo(new File(filePath + fileNm));
			                map.put("filePath", filePath);
			        		map.put("fileNm", _fileName);
			        		map.put("ext", ext);
			        		map.put("fileSize", fileSize);
			            } catch (Exception e) {
			            	logger.error(e.getMessage());
			            }	
			            educationDAO.eduFinFileUpload(map);
				}
	        }
		
		 }
		
	}

	@Override
	public List<Map<String, Object>> privateEduList(Map<String, Object> map) {
		return educationDAO.privateEduList(map);
	}

	@Override
	public int privateEduListTotal(Map<String, Object> map) {
		return educationDAO.privateEduListTotal(map);
	}

	@Override
	public void privateFinApproval(Map<String, Object> map) {
		if(StringUtils.isEmpty((String) map.get("data"))) {
			
		} else {
			
			String[] key = ((String) map.get("data")).split(",");
			for (int i=0 ; i < key.length ; i++) {
				map.put("education_person_id", key[i]);
				Map<String, Object> getFinPersonCd = commonService.getCodeOne("EDU_COMPLETION_STS", "EC02");
				
				map.put("complete_state_code_id", "EC02");
				map.put("complete_state", getFinPersonCd.get("code_kr"));
				
				educationDAO.eduPersonFinApproval(map);
			}
		}
		
		
	}
	
	@Override
	public void privateFinReject(Map<String, Object> map) {
		if(StringUtils.isEmpty((String) map.get("data"))) {
			
		} else {
			
			String[] key = ((String) map.get("data")).split(",");
			for (int i=0 ; i < key.length ; i++) {
				map.put("education_person_id", key[i]);
				Map<String, Object> getFinPersonCd = commonService.getCodeOne("EDU_COMPLETION_STS", "EC03");
				map.put("complete_state_code_id", "EC03");
				map.put("complete_state", getFinPersonCd.get("code_kr"));
				
				educationDAO.privateFinReject(map);
				
			}
		}
							
		
	}
	
	@Override
	public List<Map<String, Object>> privateEduStsList(Map<String, Object> map) {
		return educationDAO.privateEduStsList(map);
	}

	@Override
	public int privateEduStsListTotal(Map<String, Object> map) {
		return educationDAO.privateEduStsListTotal(map);
	}
	
	@Override
	public List<Map<String, Object>> privateEduStsDetailList(Map<String, Object> map) {
		return educationDAO.privateEduStsDetailList(map);
	}

	@Override
	public int privateEduStsDetailListTotal(Map<String, Object> map) {
		return educationDAO.privateEduStsDetailListTotal(map);
	}

	@Override
	public List<Map<String, String>> onlineEduExcelUpload(File destFile, Map<String, Object> map) {
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I","J","K","L","M");
		excelReadOption.setStartRow(2);		
		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		return excelContent;
		/*educationDAO.onlineEduPersonReset(map);
		educationDAO.onlineEduReset(map);*/
		/*for (Map<String, String> article: excelContent) {
			String empSeq = article.get("M");
			String reqYn = article.get("A");
			Map<String, Object> deptList = commonService.getDept(empSeq);
			if (reqYn.contains("필수")) {
				map.put("required_yn", "Y");
			} else {
				map.put("required_yn", "N");
			}
			map.put("online_education_type", article.get("A"));
			map.put("main_category", article.get("B"));
			map.put("middle_category", article.get("C"));
			map.put("small_category", article.get("D"));
			map.put("education_process_code", article.get("E"));
			map.put("education_name", article.get("F"));
			map.put("education_hour", article.get("G"));
			map.put("education_cost", article.get("H"));
			map.put("education_start_date", article.get("I"));
			map.put("education_end_date", article.get("J"));
			map.put("education_emp_seq", article.get("M"));
			map.put("education_dept_name", article.get("N"));
			map.put("score", article.get("O"));
			map.put("education_type", "온라인 교육");
			map.put("education_type_code_id", "ED03");
			map.put("education_position", deptList.get("position"));
			map.put("education_duty", deptList.get("duty"));
			map.put("enroll_date", map.get("enroll_date"));
			if (StringUtils.isNotEmpty(article.get("P"))) {
				if (article.get("P").equals("Y")) {
					map.put("complete_state_code_id", "EC04");
					map.put("complete_state", "수료");
				} else if (article.get("P").equals("N")) {
					map.put("complete_state_code_id", "EC05");
					map.put("complete_state", "미수료");
				} 
			}
			resultList.add(map);
			
			educationDAO.onlineEduSave(map);
			educationDAO.onlineEduPersonSave(map);
			
		}*/
			
		
	}

	@Override
	public void excelFile(Map<String, Object> map, MultipartHttpServletRequest multi) {
		String path = "/excel/";
		Map<String, Object> result = new HashMap<String, Object>();
		result = excelPath(multi, String.valueOf(map.get("enroll_date")), path);
		map.putAll(result);
		
	}
	
	/*엑셀경로*/
	@Override
	public Map<String, Object> excelPath(MultipartHttpServletRequest multi, String fileNmKey, String subFilePath) {
		
		Map<String, Object> map = new HashMap<String, Object>();

		String path = fileRootPath + subFilePath + File.separator;
		
		File dir = new File(path);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		Iterator<String> files = multi.getFileNames();
		while (files.hasNext()) {
			String uploadFile = files.next();

			MultipartFile mFile = multi.getFile(uploadFile);
			String fileName = mFile.getOriginalFilename();
			String fileNm = fileNmKey + "." + fileName.substring(fileName.lastIndexOf(".") + 1);

			try {
				mFile.transferTo(new File(path + fileNm));
				map.put("filePath", path);
				map.put("fileNm", fileName);
			} catch (Exception e) {
				e.getMessage();
			}
		}

		return map;
	}

	@Override
	public List<Map<String, Object>> onlineEduExcelList(Map<String, Object> map) {
		return educationDAO.onlineEduExcelList(map);
	}

	@Override
	public void onlineEduUpdate(Map<String, Object> map) {
		educationDAO.onlineEduUpdate(map);
		educationDAO.onlineEduPersonUpdate(map);
		
	}

	@Override
	public void onlineEduDel(Map<String, Object> map) {
		String[] education_id = ((String) map.get("aaa")).split(",");
		String[] education_person_id = ((String) map.get("bbb")).split(",");
		for (int i = 0; i < education_id.length; i++) {
			map.put("education_id", education_id[i]);
			map.put("education_person_id", education_person_id[i]);
			
			educationDAO.onlineEduPersonDel(map);
			educationDAO.onlineEduDel(map);
	
		}
		
		
	}

	@Override
	public void eduReqDel(Map<String, Object> map) {
		educationDAO.eduReqDel(map);
		educationDAO.eduReqPersonDel(map);
	}

	@Override
	public void groupEduCancle(Map<String, Object> map) {
		educationDAO.groupEduCancle(map);		
	}

	@Override
	public List<Map<String, Object>> eduResultFileList(Map<String, Object> map) {
		return educationDAO.eduResultFileList(map);
	}

	@Override
	public void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) {
		String path = "";		
		String fileNm = "";
		String fileExt = "";
		String fileName = "";
		Map<String, Object> result =  educationDAO.fileDown(map);
		
		fileNm = (String) result.get("real_file_name");
		fileExt = (String) result.get("file_extension");
		fileName = fileNm+"."+fileExt;
		path +=  (String) result.get("file_path") + String.valueOf(result.get("education_result_id")) + "." + fileExt;
		
		
		try {
			fileDownLoad(fileName, path, request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	@Override
	public void fileDownLoad(String fileNm, String path, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		BufferedInputStream in = null;
		BufferedOutputStream out = null;
		File reFile = null;

		reFile = new File(path);
		setDisposition(fileNm, request, response);
		
		try {
			in = new BufferedInputStream(new FileInputStream(reFile));
			out = new BufferedOutputStream(response.getOutputStream());
			
			FileCopyUtils.copy(in, out);
			out.flush();
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "ISO-8859-1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}
	
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) { // IE 10 �씠�븯
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE 11
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	@Override
	public String getOnlineMonthYn(Map<String, Object> map) {
		return educationDAO.getOnlineMonthYn(map);
	}

	@Override
	public void onlineEduSave(OnlineEduVO onlineEduVO) {
		for (int i = 0; i < onlineEduVO.getEducation_names().length; i++) {
			
			onlineEduVO.setOnline_education_type(onlineEduVO.getOnline_education_types()[i]);
			String eduType = onlineEduVO.getOnline_education_type();
			if (eduType.equals("필수")) {
				onlineEduVO.setRequired_yn("Y");
			} else {
				onlineEduVO.setRequired_yn("N");
			}
			onlineEduVO.setMain_category(onlineEduVO.getMain_categorys()[i]);
			onlineEduVO.setMiddle_category(onlineEduVO.getMiddle_categorys()[i]);
			onlineEduVO.setSmall_category(onlineEduVO.getSmall_categorys()[i]);
			onlineEduVO.setEducation_process_code(onlineEduVO.getEducation_process_codes()[i]);
			onlineEduVO.setEducation_name(onlineEduVO.getEducation_names()[i]);
			onlineEduVO.setEducation_hour(onlineEduVO.getEducation_hours()[i]);
			onlineEduVO.setEducation_cost(onlineEduVO.getEducation_costs()[i]);
			String eduCost = onlineEduVO.getEducation_cost();
			if ( StringUtils.isEmpty(eduCost) || eduCost.equals('0') ) {
				onlineEduVO.setEducation_cost_support_yn('N');
			} else {
				onlineEduVO.setEducation_cost_support_yn('Y');
			}
			onlineEduVO.setEducation_start_date(onlineEduVO.getEducation_start_dates()[i]);
			onlineEduVO.setEducation_end_date(onlineEduVO.getEducation_end_dates()[i]);
			onlineEduVO.setEducation_emp_name(onlineEduVO.getEducation_emp_names()[i]);
			Map<String, Object> empInfo = new HashMap<String, Object>();
			empInfo.put("emp_name", onlineEduVO.getEducation_emp_name());
			Map<String, Object> userInfo = commonService.getEmpInfoByName(empInfo);
			if ( MapUtils.isNotEmpty(userInfo) ) {
				onlineEduVO.setEducation_position((String) userInfo.get("position"));
				onlineEduVO.setEducation_duty((String) userInfo.get("duty"));
				onlineEduVO.setEducation_emp_seq((String) userInfo.get("emp_seq"));
				onlineEduVO.setEducation_dept_seq((String) userInfo.get("dept_seq"));
				onlineEduVO.setEducation_login_id((String) userInfo.get("login_id"));
				onlineEduVO.setEducation_dept_name((String) userInfo.get("dept_name"));
				onlineEduVO.setEducation_erp_emp_num((String) userInfo.get("erp_emp_num"));
			} else {
				onlineEduVO.setEducation_position("");
				onlineEduVO.setEducation_duty("");
				onlineEduVO.setEducation_emp_seq("");
				onlineEduVO.setEducation_dept_seq("");
				onlineEduVO.setEducation_login_id("");
				onlineEduVO.setEducation_dept_name("");
				onlineEduVO.setEducation_erp_emp_num("");
			}
			
			onlineEduVO.setScore(onlineEduVO.getScores()[i]);
			String completeYn = onlineEduVO.getComplete_states()[i];
			if ( completeYn.equals("Y") ) {
				Map<String, Object> completeState = commonService.getCodeOne("EDU_COMPLETION_STS", "EC04");
				onlineEduVO.setComplete_state_code_id((String) completeState.get("code"));
				onlineEduVO.setComplete_state((String) completeState.get("code_kr"));
			} else {
				Map<String, Object> completeState = commonService.getCodeOne("EDU_COMPLETION_STS", "EC05");
				onlineEduVO.setComplete_state_code_id((String) completeState.get("code"));
				onlineEduVO.setComplete_state((String) completeState.get("code_kr"));
			}
			educationDAO.onlineEduSave(onlineEduVO);
			educationDAO.onlineEduPersonSave(onlineEduVO);
			
			
		}
		
	}

	@Override
	public void groupEduReject(Map<String, Object> map) {
		if(StringUtils.isEmpty((String) map.get("data"))) {
			
		} else {
			
			String[] key = ((String) map.get("data")).split(",");
			for (int i=0 ; i < key.length ; i++) {
				map.put("education_id", key[i]);
				Map<String, Object> getGroupStepCd = commonService.getCodeOne("EDUCATION_STEP", "ES04");
				Map<String, Object> getGroupCompCd = commonService.getCodeOne("EDU_COMPLETION_STS", "EC03");
				map.put("education_step_code_id", "ES04");
				map.put("complete_state_code_id", "EC03");
				map.put("education_step", getGroupStepCd.get("code_kr"));
				map.put("complete_state", getGroupCompCd.get("code_kr"));
				educationDAO.groupEduReject(map);
				educationDAO.groupEduPersonReject(map);
			}
		}
	}

	@Override
	public Map<String, Object> getGroupMainMap(Map<String, Object> eduMap) {
		return educationDAO.getGroupMainMap(eduMap);
	}

	@Override
	public List<Map<String, Object>> getGroupEmpList(Map<String, Object> eduMap) {
		return educationDAO.getGroupEmpList(eduMap);
	}

	@Override
	public void updateSchmSeq(Map<String, Object> schResult) {
		educationDAO.updateSchmSeq(schResult);
		
	}

	@Override
	public void insertCalendarEmp(Map<String, Object> emp) {
		educationDAO.insertCalendarEmp(emp);
		
	}
	
}
