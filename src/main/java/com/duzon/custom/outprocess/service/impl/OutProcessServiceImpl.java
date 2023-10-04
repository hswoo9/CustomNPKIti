package com.duzon.custom.outprocess.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URI;
import java.nio.channels.FileChannel;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.duzon.custom.outprocess.dao.OutProcessDAO;
import com.duzon.custom.outprocess.service.OutProcessService;
import com.duzon.custom.subHoliday.dao.SubHolidayDAO;
import com.duzon.custom.workPlan.dao.WorkPlanDAO;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


@Service("OutProcessService")
public class OutProcessServiceImpl implements OutProcessService {
	private static final Logger logger = LoggerFactory.getLogger(OutProcessServiceImpl.class);
	
	@Resource(name = "OutProcessDAO")
	OutProcessDAO outProcessDAO;
	
	//@Resource(name = "CommFileDAO")
	//CommFileDAO commFileDAO;

	@Autowired private SubHolidayDAO subHolidayDAO;
	
	@Autowired private WorkPlanDAO workPlanDAO;
	
	@Value("#{bizboxa['BizboxA.fileRootPath']}")
	private String fileRootPath;
	
	@Value("#{bizboxa['BizboxA.outProcessFilePath']}")
	private String outProcessFilePath;
	
	//@Value("#{bizboxa['BizboxA.groupware.domin']}")
	//private String gwDomin;
	
	/**
	 * Method	:	POST
	 * params	:	processId	프로세스 id
	 * 				approKey	외부시스템 연동키
	 * 				docId		전자결재 id
	 * 				docSts		전자결재 상태(임시보관:10, 상신결재:20, 반려:100, 종결:90, 삭제:999)
	 * 				userId		로그인 사용자 키
	 */
	@Override
	public void outProcessApp(Map<String, Object> bodyMap) throws Exception {
		String processId = String.valueOf(bodyMap.get("processId"));
		String approKey = String.valueOf(bodyMap.get("approKey"));
		String docSts = String.valueOf(bodyMap.get("docSts"));
		approKey = approKey.replace(processId, "");
		bodyMap.put("approKey", approKey);
		outProcessDAO.outProcessApp(bodyMap);
		
		String userId = (String)bodyMap.get("userId");
		bodyMap.put("target_id", approKey);
		bodyMap.put("update_emp_seq", userId);
		bodyMap.put("processId", processId);
		if(processId != null && "OTREQ".equals(processId) && docSts != null) {
			subHolidayDAO.otApplyDocStsUpdate(bodyMap);
		}else if(processId != null && "SHREQ".equals(processId) && docSts != null) {
			subHolidayDAO.otApplyDocStsUpdate(bodyMap);
		}else if(processId != null && "WPREQ".equals(processId) && docSts != null) {
			bodyMap.put("work_plan_id", approKey);
			if("90".equals(docSts)) {//종결
				workPlanDAO.workPlanMasterApproval(bodyMap);
				workPlanDAO.workPlanDetailApproval(bodyMap);
				workPlanDAO.workPlanHistoryUpdate(bodyMap);
			}else if("100".equals(docSts)) {//반려
				List<Map<String, Object>> list = new ArrayList<>();
				bodyMap.put("approval_status", "4");
				list.add(bodyMap);
				workPlanDAO.workPlanMasterReject(list);
				workPlanDAO.workPlanDetailReject(list);
			}else if("999".equals(docSts)) {//삭제
				workPlanDAO.workPlanHistoryCancel(bodyMap);
				workPlanDAO.workPlanDetailCancel(bodyMap);
				workPlanDAO.workPlanCancel(bodyMap);
			}
			workPlanDAO.workPlanDocStsUpdate(bodyMap);
		}else if(processId != null && "WCREQ".equals(processId) && docSts != null) {
			List<Map<String, Object>> changeList = workPlanDAO.getWorkPlanChangeList(bodyMap);
			if("90".equals(docSts)) {
				for(Map<String, Object> changeMap : changeList) {
					workPlanDAO.workPlanDetailChangeApproval(changeMap);
					workPlanDAO.workPlanHistoryChangeApproval(changeMap);
				}
			}else if("100".equals(docSts)) {//반려
				for(Map<String, Object> changeMap : changeList) {
					changeMap.put("update_emp_seq", userId);
					workPlanDAO.workPlanChangeRejectDetailUpdate(changeMap);
					workPlanDAO.workPlanChangeRejectHistoryUpdate(changeMap);
				}
			}else if("999".equals(docSts)) {
				
			}
			
			//기존꺼는 기존꺼 대로 돌게 두고...테이블 하나 새로 팜 dj_work_plan_change
			workPlanDAO.workPlanChangeDocStsUpdate(bodyMap);
		}else if(processId != null && "REHREQ".equals(processId) && docSts != null) {
			if("90".equals(docSts)) {
				Map<String, Object> dataMap = subHolidayDAO.getSubHoliReqData(bodyMap);
				bodyMap.put("use_emp_seq", dataMap.get("use_emp_seq"));
				//bodyMap.put("use_min", dataMap.get("use_min"));
				//bodyMap.put("use_type", "599");
				//subHolidayDAO.sp_subHoliday_req(bodyMap);
				bodyMap.put("approval_status", '2');
				subHolidayDAO.replace_holiday_update(bodyMap);
			}else if("100".equals(docSts)) {//반려
				Map<String, Object> dataMap = subHolidayDAO.getSubHoliReqData(bodyMap);
				bodyMap.put("use_emp_seq", dataMap.get("use_emp_seq"));
				//subHolidayDAO.subHolidayReqDeactivateReject(bodyMap);
				//subHolidayDAO.sp_subHoliday_cancle(bodyMap);
				bodyMap.put("approval_status", '1');
				subHolidayDAO.replace_holiday_update(bodyMap);
			}else if("999".equals(docSts)) {
				subHolidayDAO.replace_holiday_cancle(bodyMap);
			}
			//subHolidayDAO.rehApplyDocStsUpdate(bodyMap);
		}
	}

	@Override
	public Object outProcessDocSts(Map<String, Object> map) throws Exception {
		return outProcessDAO.outProcessDocSts(map);
	}

	@Override
	public void outProcessTempInsert(Map<String, Object> map) throws Exception {
		outProcessDAO.outProcessTempInsert(map);
	}

	@Override
	public Map<String, Object> outProcessSel(Map<String, Object> map) throws Exception {
		return outProcessDAO.outProcessSel(map);
	}
	
	//@SuppressWarnings("unchecked")
	@Override
	public String makeFileKey(Map<String, Object> map) throws Exception {
		String fileKey = "Y" + java.util.UUID.randomUUID().toString();
		//List<Map<String, Object>> tempSaveFileList = (List<Map<String, Object>>)commFileDAO.getCommFileList(map);
		//for (Map<String, Object> fileMap : tempSaveFileList) {
		//	String filePath = String.valueOf(fileMap.get("file_path"));
		//	String fileName = String.valueOf(fileMap.get("file_name"));
		//	String realFileName = String.valueOf(fileMap.get("real_file_name"));
		//	String fileExtension = String.valueOf(fileMap.get("file_extension"));
		//	String tempPath = CommFileUtil.getFilePath(commFileDAO, "uploadTemp", "N");
		//	
		//	FileInputStream fis = new FileInputStream(filePath + fileName + "." + fileExtension);
		//	CommFileUtil.makeDir(tempPath + fileKey);
		//	FileOutputStream fos = new FileOutputStream(tempPath + fileKey + File.separator + realFileName + "." + fileExtension);
		//	
		//	FileChannel fcin = fis.getChannel();
		//	FileChannel fcout = fos.getChannel();
		//	
		//	long size = fcin.size();
		//	fcin.transferTo(0, size, fcout);
		//	
		//	fcout.close();
		//	fcin.close();
		//	
		//	fis.close();
		//	fos.close();
		//}
		return fileKey;
	}
	
	@Override
	public Object getFileKey(Map<String, Object> map) throws Exception {
		CloseableHttpClient httpClient = null;
		FileInputStream fis = null;
		CloseableHttpResponse response = null;
		try {
			File file = new File((String)map.get("file_path") + map.get("attach_file_id") + "." + map.get("file_extension"));
			fis = new FileInputStream(file);
			httpClient = HttpClients.createDefault();
			HttpPost hPost = new HttpPost(new URI("http://gw.kric.re.kr/gw/outProcessUpload.do"));
			MultipartEntityBuilder builder = MultipartEntityBuilder.create().setCharset(StandardCharsets.UTF_8);
			builder.addTextBody("compSeq", (String)map.get("compSeq"), ContentType.TEXT_PLAIN);
			builder.addTextBody("empSeq", (String)map.get("empSeq"), ContentType.TEXT_PLAIN);
			builder.addTextBody("deleteYN", "Y", ContentType.TEXT_PLAIN);
			builder.addBinaryBody(
					"file", 
					fis, 
					ContentType.APPLICATION_OCTET_STREAM, 
					//MultipartEntityBuilder에 .setCharset(StandardCharsets.UTF_8)을 붙였는데도 한글 깨져서 날라감...
					(String)map.get("real_file_name") + "." + map.get("file_extension")
			);
			HttpEntity multipart = builder.build();
			hPost.setEntity(multipart);
			response = httpClient.execute(hPost);
			HttpEntity responseEntity = response.getEntity();
			if(responseEntity != null) {
				Map<String, Object> result = new Gson().fromJson(
													EntityUtils.toString(responseEntity), 
													new TypeToken<Map<String, Object>>(){}.getType()
												);
				return result.get("fileKey");
			}
			return null;
		} finally {
			if(response != null) response.close();
			if(fis != null) fis.close();
			if(httpClient != null) httpClient.close();			
		}
	}
	
	
	@Override
	public void outProcessDocInterlockInsert(Map<String, Object> map) throws Exception {
		outProcessDAO.outProcessDocInterlockInsert(map);
	}
}
