package com.duzon.custom.common.utiles;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

/**
 * @author 이동광
 * @since 2019. 3. 13.
 * @detail
 * 		- org.apache.poi // poi-ooxml // ver 3.15 
 * 		- com.duzon.custom.common.utiles.ExcelView로 사용
 * 		- SpringFramework에서 제공하는 AbstractView를 상속받아 구현
 * 		- 크로스브라우징 작업 추가
 */
public abstract class AbstractExcelView extends AbstractView{	
	private static final String CONTENT_TYPE ="application/vnd.ms-excel";
	
	public AbstractExcelView() {
		setContentType(CONTENT_TYPE);
	}
	
	@Override
	protected boolean generatesDownloadContent() {
		return true;
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Workbook workbook = createWorkbook();
		System.out.println(model);
		buildExcelDocument(model, workbook, request, response);
		response.setContentType(getContentType());
		response.setCharacterEncoding("UTF-8");
		String fileName = (String)model.get("excelType") + ".xlsx";
		int header = getBrowser(request);
		String docName = "";
		if(header == 1 ) {
			docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		}else {
			docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment ;filename=\""+ docName +"\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		ServletOutputStream out = response.getOutputStream();
		out.flush();
		workbook.write(out);
		out.flush();
		if(workbook instanceof SXSSFWorkbook) {
			//엑셀 대용량 처리시, 메모리에 미리 올려뒀던 데이터 처리
			((SXSSFWorkbook) workbook).dispose();
		}
	}
	
	protected abstract Workbook createWorkbook();
	
	protected abstract void buildExcelDocument(Map<String, Object> model, Workbook workbook, 
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//브라우저별로 분류작업(한글이름 안깨지도록)
	private int getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if(header.contains("MSIE") || header.contains("Trident")) {
			return 1;
		}else if(header.contains("Chrome")) {
			return 2;
		}else if(header.contains("Opera")) {
			return 3;
		}
		return 4;
	}
}
