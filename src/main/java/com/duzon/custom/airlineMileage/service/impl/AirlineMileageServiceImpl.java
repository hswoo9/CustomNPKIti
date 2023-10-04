package com.duzon.custom.airlineMileage.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.airlineMileage.dao.AirlineMileageDAO;
import com.duzon.custom.airlineMileage.service.AirlineMileageService;
import com.duzon.custom.common.dao.CommonDAO;
import com.duzon.custom.common.excel.ExcelRead;
import com.duzon.custom.common.excel.ExcelReadOption;
import com.duzon.custom.subHoliday.service.Impl.SubHolidayServiceImpl;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Service
public class AirlineMileageServiceImpl implements AirlineMileageService{
	private static final Logger logger = LoggerFactory.getLogger(AirlineMileageServiceImpl.class);
	
	@Autowired
	private CommonDAO commonDAO;
	@Autowired
	private AirlineMileageDAO airlineMileageDAO;
	@Value("#{bizboxa['BizboxA.fileRootPath']}")
	private String fileRootPath;

	@Override
	public Map<String, Object> excelUpload(Map<String, Object> map, MultipartHttpServletRequest multi, Model model) throws Exception {
		// TODO Auto-generated method stub
		
		XSSFRow row;
		DataFormatter formatter = new DataFormatter();
		
		MultipartFile fileNm = multi.getFile("fileNm");
		File dest = new File(fileNm.getOriginalFilename());
		fileNm.transferTo(dest);
		FileInputStream inputStream = new FileInputStream(dest);
		
		XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
		XSSFSheet sheet = workbook.getSheetAt(0);

		int rows = sheet.getPhysicalNumberOfRows();

		
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(dest.getAbsolutePath());
		excelReadOption.setOutputColumns("B","C","D","E","F","G","H","I","J","K","L");
		excelReadOption.setStartRow(9);		
		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		System.out.println(excelContent.size());
		for (Map<String, String> article: excelContent) {

				Map<String, Object> otMap = new HashMap<String, Object>();
				if(article.get("B").equals("")) {
					System.out.println("@@@@@@@@@@@@@@@@"+"데이터 x");
					break;
				}
				otMap.put("sdate", article.get("B"));
				otMap.put("edate", article.get("C"));
				otMap.put("emp_name", article.get("D"));
				Map<String, Object> empMap = commonDAO.getEmpInfoByName2(otMap);
				otMap.put("emp_seq", empMap.get("emp_seq"));
				otMap.put("dept_seq", empMap.get("dept_seq"));
				otMap.put("dept_name", empMap.get("dept_name"));
				otMap.put("area", article.get("E"));
				otMap.put("division",article.get("F"));
				otMap.put("use_mileage",article.get("G"));				
				otMap.put("save_mileage",article.get("I"));
				otMap.put("lose_mileage","");
				otMap.put("total_mileage","");
				otMap.put("flight",article.get("J"));
				otMap.put("remark","");
				otMap.put("create_emp_seq", empMap.get("emp_seq"));

	              System.out.println("출발일 = "+article.get("B"));
	              System.out.println("도착일 = "+empMap.get("emp_seq"));
	          	  System.out.println("이름 = "+article.get("D"));
	              System.out.println("지역 = "+article.get("E"));
	              System.out.println("구분 = "+article.get("F"));
	              System.out.println("사용마일리지 = "+article.get("G"));
	              System.out.println("적립마일리지 = "+article.get("I"));
	              System.out.println("항공 = "+article.get("J"));

				try {
					airlineMileageDAO.setMileageSave(otMap);
				}catch (Exception e) {
					// TODO: handle exception
					e.getStackTrace();
					map.put("msg", e);
					return map;
				}
		}
		
		map.put("msg", "모든 데이터가 업로드 되었습니다.");
		
		return map;
	}
	
	//마일리지 리스트
	@Override
	public List<Map<String, Object>> mileageListSearch(Map<String, Object> map) throws Exception {
		return airlineMileageDAO.mileageListSearch(map);
	}
	
	//마일리지 리스트 토탈
	@Override
	public int mileageListSearchTotal(Map<String, Object> map) throws Exception {
		return airlineMileageDAO.mileageListSearchTotal(map);
	}
	
	@Override
	public Map<String, Object> fileUpload(Map<String, Object> map, MultipartHttpServletRequest multi, Model model) throws Exception {

		Gson gson = new Gson(); 
		Map<String, Object> data = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		map.putAll(data);
		
		List<MultipartFile> fileList = multi.getFiles("file_name");
		//List<MultipartFile> fileList = multi.getFiles("files");
		System.out.println("fileList"+fileList);
		//multi.getFileNames().toString()
		int fileSeq = 0;
		int result = 0;
		for(MultipartFile mFile : fileList) {
			String fileName = mFile.getOriginalFilename();
			if(fileName.equals("")) {
				continue;
			}else {
				//map.put("file_yn", "Y");
				map.put("tableName", "dj_mileage_certificate");
				map.put("targetKey", map.get("targetKey"));
				
				result = fileUploadService(fileSeq++, mFile, map);

			}
		}
				
		map.put("code", "success");	
		map.put("msg", "파일등록되었습니다.");
		return map;
	}
	
	@Override
	public int fileUploadService(int fileSeq, MultipartFile mFile, Map<String, Object> map) {

		String fileName = mFile.getOriginalFilename();
		Long fileSize = mFile.getSize();
		String orgFileName = fileName.substring(0, fileName.lastIndexOf("."));
		String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
		String subPath = String.valueOf(Calendar.getInstance().get(Calendar.YEAR))
				 + "/" + String.valueOf(Calendar.getInstance().get(Calendar.MONTH) + 1);
		String filePath = fileRootPath +"/dj_mileage_certificate"+"/"+ subPath + "/";
		File dir = new File(filePath);
		try {
			if(!dir.isDirectory()) {
				dir.mkdirs();
			}
			map.put("file_seq", fileSeq++);

			airlineMileageDAO.fileUploadSave(map);
			mFile.transferTo(new File(filePath + map.get("attach_file_id") + "." +fileExtension));
			map.put("fileNm", orgFileName);
			map.put("ext", fileExtension);
			map.put("filePath", filePath);
			map.put("fileSize", fileSize);
			System.out.println("#######"+map);
			return airlineMileageDAO.fileUpload(map);
		}catch(Exception e) {
			System.out.println("===============");
			logger.error(e.getMessage());
			System.out.println("===============");
			return -2;
		}
	}
	
	@Override
	public Map<String, Object> updateMileageMaster(Map<String, Object> map) {

		Map<String, Object> resultMap = airlineMileageDAO.masterSearchMember(map); //master테이블에 있는 멤버인지 먼저 조회
		
		if(resultMap == null) {//조회되는 멤버가 없다면
			airlineMileageDAO.mileageMasterInsert(map); //마스터 테이블에 인서트
			airlineMileageDAO.mileageDetailInsert(map); //디데일 테이블에 인서트
		}else {//조회되는 멤버가 있다면
			airlineMileageDAO.mileageMasterUpdate(map); //마스터 테이블 업데이트
			Map<String, Object> totalMileageMap = airlineMileageDAO.masterSearchMember(map); //토탈 마일리지를 가지고와서
			map.put("total_mileage", totalMileageMap.get("total_mileage")); //맵에 넣어준 후
			airlineMileageDAO.mileageDetailInsert2(map); //디데일 테이블에 인서트
		}
		
		
		return map;
	}
	
	@Override
	public Map<String, Object> deleteMileage(Map<String, Object> map) {

		airlineMileageDAO.deleteMileageUpdate(map); //detail테이블 상태값을 y 로 바꿔주고
		airlineMileageDAO.deleteMileageMasterUpdate(map); //master 테이블 총 마일리지를 다시 복구
		
		return map;
	}
	
	@Override
	public List<Map<String, Object>> fileList(Map<String, Object> map) {
		return airlineMileageDAO.fileList(map);
	}
	
	@Override
	public void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) {
		String path = "";		
		String fileNm = "";
		String fileExt = "";
		String fileName = "";
		Map<String, Object> result =  airlineMileageDAO.fileDown(map);
		
		fileNm = (String) result.get("real_file_name");
		fileExt = (String) result.get("file_extension");
		fileName = fileNm+"."+fileExt;
//		path +=  (String) result.get("file_path") + String.valueOf(result.get("attach_file_id")) + "." + fileExt;
		path +=  (String) result.get("file_path") + String.valueOf(result.get("file_name")) + "." + fileExt; // 저장파일명으로 변경
		
		
		try {
			fileDownLoad(fileName, path, request, response);
		} catch (Exception e) {
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
			e.printStackTrace();
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

		response.setHeader("Content-Disposition", dispositionPrefix + "\"" + encodedFilename + "\"");

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

}
