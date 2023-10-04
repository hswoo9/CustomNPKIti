package com.duzon.custom.airlineMileage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface AirlineMileageService {

	Map<String, Object> excelUpload(Map<String, Object> map, MultipartHttpServletRequest multi, Model model) throws Exception;

	List<Map<String, Object>> mileageListSearch(Map<String, Object> map) throws Exception;

	int mileageListSearchTotal(Map<String, Object> map) throws Exception;

	Map<String, Object> fileUpload(Map<String, Object> map, MultipartHttpServletRequest multi, Model model) throws Exception;

	int fileUploadService(int fileSeq, MultipartFile mFile, Map<String, Object> map);

	Map<String, Object> updateMileageMaster(Map<String, Object> map);

	List<Map<String, Object>> fileList(Map<String, Object> map);

	void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response);

	void fileDownLoad(String fileNm, String path, HttpServletRequest request, HttpServletResponse response) throws Exception;

	Map<String, Object> deleteMileage(Map<String, Object> map);

}
