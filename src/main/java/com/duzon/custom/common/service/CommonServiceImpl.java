package com.duzon.custom.common.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.common.dao.CommonDAO;
import com.duzon.custom.common.utiles.CtFileUtile;

import com.duzon.custom.common.utiles.EgovUserDetailsHelper;
import com.duzon.custom.subHoliday.dao.SubHolidayDAO;

import bizbox.orgchart.service.vo.LoginVO;

/**
 * 
 * @author duzon
 *
 */
@Service
public class CommonServiceImpl implements CommonService {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonServiceImpl.class);
	
	@Autowired
	private CommonDAO commonDAO;
	@Autowired private SubHolidayDAO subHolidayDAO;
	/**
	* YH
	* 2017. 12. 11.
	* 설명: 파일업로드
	*/
	@Override
	public void ctFileUpLoad(Map<String, Object> map, MultipartHttpServletRequest multi) {

		//파일유틸
		CtFileUtile ctFileUtile = new CtFileUtile();
		
		//멀티파트파일 확인
		Map<String, MultipartFile> files = multi.getFileMap();
		
		//파일 업로드시작
		Map<String, Object> result = ctFileUtile.fileUpdate(files.get("file1"));
		
		//TODO 디비 저장 기능 개발 필요
		logger.info((String) result.get("filePath"));
		logger.info((String) result.get("fileNm"));
		
	}


	public Map<String, Object> commonGetEmpInfo (HttpServletRequest servletRequest) throws NoPermissionException {
		 java.util.Map<String, Object> result = new java.util.HashMap<String, Object>( );
		 
//		 LoginVO loginVo = (LoginVO) servletRequest.getSession().getAttribute("loginVO");
		 //곽경훈 수정 꼮 수정!!!!!!!
		 LoginVO loginVo = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		 
		 if ( loginVo == null ) {
		  
		  loginVo = new bizbox.orgchart.service.vo.LoginVO( );
		  loginVo.setGroupSeq( "klti" );
		  loginVo.setCompSeq( "10163" );
		  loginVo.setBizSeq( "707010002050" );
		  //loginVo.setOrgnztId( "1110" );
		  loginVo.setOrgnztId( "1327" );
		  //loginVo.setUniqId( "1" );
		  loginVo.setUniqId( "1403" );
		  loginVo.setLangCode( "kr" );
		  loginVo.setUserSe( "ADMIN" );
		  loginVo.setErpEmpCd( "2017051501" );
		  loginVo.setErpCoCd( "3585" );
		  loginVo.setEaType( "eap" );
		  loginVo.setEmail("function7");
		  loginVo.setEmailDomain("gwa.tpf.kro.kr");
		  loginVo.setId("function7");
		  //loginVo.setEmpname("관리자");
		  //loginVo.setOrganNm("관리팀");
		  loginVo.setEmpname("곽경훈");
		  loginVo.setOrgnztNm("정보기술부");
		  //loginVo.setEmpname("노시영");
		  //loginVo.setOrgnztNm("관리팀");
		  loginVo.setPositionCode("A7"); // 직급
		  loginVo.setPositionNm("6급");
		  loginVo.setClassCode("A8"); // 직책
		  loginVo.setClassNm("주임");
		  loginVo.setDeptname("정보기술부");
		  loginVo.setDept_seq("1327");
		  // 보안 취약점 수정: 하드코드된 비밀번호 제거
		  // loginVo.setPasswd("1111");
		  loginVo.setPasswd(ConfigProperties.getProperty("default.password"));
		 }
		 result.put("organNm", loginVo.getOrganNm()); /*부서 명*/
		 result.put("orgnztNm", loginVo.getOrgnztNm()); /*부서 명*/
		 result.put("empName", loginVo.getName()); /*사원 이름*/
		 result.put( "groupSeq",  loginVo.getGroupSeq()); /* 그룹시퀀스 */
		 result.put( "compSeq",  loginVo.getCompSeq()); /* 회사시퀀스 */
		 result.put( "bizSeq",  loginVo.getBizSeq()); /* 사업장시퀀스 */
		 result.put( "deptSeq",  loginVo.getOrgnztId()); /* 부서시퀀스 */
		 result.put( "empSeq",  loginVo.getUniqId()); /* 사원시퀀스 */
		 result.put( "langCode",  loginVo.getLangCode()); /* 사용언어코드 */
		 result.put( "userSe",  loginVo.getUserSe()); /* 사용자접근권한 */
		 result.put( "erpEmpSeq",  loginVo.getErpEmpCd()); /* ERP사원번호 */
		 result.put( "erpCompSeq", loginVo.getErpCoCd()); /* ERP회사코드 */
		 result.put( "erpDeptSeq", loginVo.getErpDeptCd()); /* ERP부서코드 */
		 result.put( "eaType",  loginVo.getEaType()); /* 연동 전자결재 구분 */
		 result.put( "eaType",  loginVo.getEaType()); /* 연동 전자결재 구분 */
		 result.put( "email",  loginVo.getEmail() + "@" + loginVo.getEmailDomain()); /* 연동 이메일 */
		 result.put( "id",  loginVo.getId()); /* 연동 id*/
		 result.put("positionCode", loginVo.getPositionCode());/*직급 번호*/
		 result.put("positionNm", loginVo.getPositionNm());/*직급 명*/
		 result.put("classCode", loginVo.getClassCode());/*직책 번호*/
		 result.put("classNm", loginVo.getClassNm());/*직책 명*/
		 result.put("deptname", loginVo.getDeptname());//부서 명*/
		 result.put("deptSeq", loginVo.getDept_seq());//부서 명*/
		 // 보안 취약점 수정: 비밀번호 평문 노출 방지
		 // result.put("passWd", loginVo.getPassword());
		 return result;

	}

	@Override
	public List<Map<String, Object>> getCode(String code, String orderby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("code", code);
		map.put("orderby", orderby);
		
		return commonDAO.getCode(map);
	}


	@Override
	public Map<String, Object> getDept(String empSeq) {
		return commonDAO.getDept(empSeq);
	}
	
	@Override
	public Map<String, Object> getUpDeptName(Map<String, Object> loginMap) {
		return commonDAO.getUpDeptName(loginMap);
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
	public List<Map<String, Object>> empInformation(Map<String, Object> map) {
		return commonDAO.empInformation(map);
	}


	@Override
	public int empInformationTotal(Map<String, Object> map) {
		return commonDAO.empInformationTotal(map);
	}
	
	@Override
	public List<Map<String, Object>> fileList(Map<String, Object> map) {
		return commonDAO.fileList(map);
	}
	
	@Override
	public void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) {
		String path = "";		
		String fileNm = "";
		String fileExt = "";
		String fileName = "";
		Map<String, Object> result =  commonDAO.fileDown(map);
		
		fileNm = (String) result.get("real_file_name");
		fileExt = (String) result.get("file_extension");
		fileName = fileNm+"."+fileExt;
//		path +=  (String) result.get("file_path") + String.valueOf(result.get("attach_file_id")) + "." + fileExt;
		path +=  (String) result.get("file_path") + String.valueOf(result.get("file_name")) + "." + fileExt; // 저장파일명으로 변경
		
		
		try {
			fileDownLoad(fileName, path, request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void fileDelete(Map<String, Object> map) {
		commonDAO.fileDelete(map);
		
	}
	
	@Override
	public List<Map<String, Object>> getGroupCd(Map<String, Object> map) {
		return commonDAO.getGroupCd(map);
	}


	@Override
	public Map<String, Object> getCodeByKr(String param) {
		return commonDAO.getCodeByKr(param);
	}


	@Override
	public Map<String, Object> getKidzDept(Map<String, Object> map) {
		return commonDAO.getKidzDept(map);
	}


	@Override
	public void dailySecom(Map<String, Object> map) {
		commonDAO.dailySecom(map);
		
	}


	@Override
	public Map<String, Object> getEmpName(String empSeq) {
		return commonDAO.getEmpName(empSeq);
	}


	@Override
	public List<Map<String, Object>> getEmpDept(String deptSeq) {
		return commonDAO.getEmpDept(deptSeq);
	}


	@Override
	public List<Map<String, Object>> getAllDept() {
		return commonDAO.getAllDept();
	}


	@Override
	public Map<String, Object> getCodeOne(String groupCode, String code) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("groupCode", groupCode);
		map.put("code", code);
		
		return commonDAO.getCodeOne(map);
	}


	@Override
	public Map<String, Object> getRestFund(String empSeq) {
		return commonDAO.getRestFund(empSeq);
	}


	@Override
	public List<Map<String, Object>> getDutyPosition(String subKey) {
		return commonDAO.getDutyPosition(subKey);
	}


	@Override
	public Map<String, Object> getKssfUserInfo(String key) {
		return commonDAO.getKssfUserInfo(key);
	}


	@Override
	public Map<String, Object> getEmpInfoByName(Map<String, Object> empInfo) {
		return commonDAO.getEmpInfoByName(empInfo);
	}
	
	@Override
	public Map<String, Object> getEmpInfoByName2(Map<String, Object> empInfo) {
		return commonDAO.getEmpInfoByName2(empInfo);
	}


	@Override
	public Map<String, Object> getCalendarEmpInfo(String empSeq) {
		return commonDAO.getCalendarEmpInfo(empSeq);
	}
	
	@Override
	public List<Map<String, Object>> selectEmp(Map<String, Object> map) {
		return commonDAO.selectEmp(map);
	}


	@Override
	public Map<String, Object> getHeader(Map<String, Object> loginMap) {
		return commonDAO.getHeader(loginMap);
	}
	
	@Override
	public Map<String, Object> getLeader(Map<String, Object> loginMap) {
		return commonDAO.getLeader(loginMap);
	}


	@Override
	public void dailyWorkAgree(Map<String, Object> map) {
		Map<String, Object> temp_map = new HashMap<String, Object>();
		temp_map = subHolidayDAO.overHoliWorkSelect();
		map.put("night_work_reward", temp_map.get("night_work_reward"));
		commonDAO.dailyWorkAgree(map);
		
	}


	@Override
	public void monthlyWorkPlanMake(Map<String, Object> map) {
		final Calendar c = Calendar.getInstance();
		if(c.get(Calendar.DATE) == c.getActualMaximum(Calendar.DATE)) {
			//그 달의 마지막날에만 실행
			commonDAO.monthlyWorkPlanMake(map);
		}
	}

	@Override
	public void replaceHolidayChangeCode() {
		commonDAO.replaceHolidayChangeCode();
	}


	@Override
	public void setAttCode() {
		commonDAO.setAttCode();
	}

	@Override
	public void vcatnUseHistUpdate(){
		commonDAO.vcatnUseHistUpdate();
	}
}
