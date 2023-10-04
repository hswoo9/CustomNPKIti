package com.duzon.custom.common.vo;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

/**
 * @author yh
 * 쪽지api
 *
 */
public class MessageVO {
	
	private String empSeq = "1"; //관리자 아이디
	private String groupSeq; //그룹코드
	private	String tId = "adfsadfwerwerfcvcx";
	private String pId = "";
	
	private String recvEmpSeq; //타켓 유저 한명만
	private String content = ""; // 쪽지 메시지
	private String contentType = "0";
	private String secuYn = "N";
	private String fileId = "";
	private String callerName = "OZEYE";
	
	private Map<String, Object> header = new HashMap<String, Object>();
	private Map<String, Object> body = new HashMap<String, Object>();
	private Map<String, Object> message = new HashMap<String, Object>();
	
	public void setRecvEmpSeq(String recvEmpSeq) {
		this.recvEmpSeq = recvEmpSeq;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}

	public String getMessage() {
		
		String[] targetEmpSeq = {recvEmpSeq};
		
		header.put("empSeq", empSeq);
		header.put("groupSeq", groupSeq);
		header.put("tId", tId);
		header.put("pId", pId);
		
		body.put("recvEmpSeq", targetEmpSeq);
		body.put("content", content);
		body.put("contentType", contentType);
		body.put("secuYn", secuYn);
		body.put("fileId", fileId);
		body.put("callerName", callerName);
		
		message.put("header", header);
		message.put("body", body);
		
		return new Gson().toJson(message);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	"header": {
//    "empSeq": "1",
//    "groupSeq": "ozeye",
//    "tId": "adfsadfwerwerfcvcx",
//    "pId": ""
//},
//"body": {
//    "recvEmpSeq": ["1083"],
//    "content": "연장근무를 신청해 주세요.",
//    "contentType": "0",
//    "secuYn": "N",
//    "fileId": "",
//    "callerName": "OZEYE"
//}
}
