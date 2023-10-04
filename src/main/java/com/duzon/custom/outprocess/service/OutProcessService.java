package com.duzon.custom.outprocess.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface OutProcessService {

	void outProcessApp(Map<String, Object> bodyMap) throws Exception;

	Object outProcessDocSts(Map<String, Object> map) throws Exception;

	void outProcessTempInsert(Map<String, Object> map) throws Exception;

	Map<String, Object> outProcessSel(Map<String, Object> map) throws Exception;
	
	String makeFileKey(Map<String, Object> map) throws Exception;
	
	Object getFileKey(Map<String, Object> map) throws Exception;
	
	void outProcessDocInterlockInsert(Map<String, Object> map) throws Exception;

}
