package com.duzon.custom.common.utiles;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFExtendedColor;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.sl.usermodel.Background;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Color;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Component;

/**
 * @author 이동광
 * @since 2019. 3. 13.
 * @detail 
 * 		- resource/config/spring/context-common.xml에 
 * 		  <bean name="workPlanExcelList" class="com.duzon.custom.common.utiles.workPlanExcelList"/> 등록후
 * 		- 컨트롤러에서 "workPlanExcelList" 리턴하여 사용
 * 		- 컨트롤러에서 excelType 수정하여 엑셀 시트명/다운로드 파일명 지정
 * 		- new SXSSFWorkbook(int); & MyBatis fetchSize="int" // int 같은 숫자로 맞춰서 사용  		
 */
@Component("workPlanExcelList")
public class workPlanExcelList extends AbstractExcelView{

	@Override
	protected Workbook createWorkbook() {
		/*
		 * *.xls 파일 만들기 : new XSSFWorkbook();
		 * *.xlsx 파일 만들기 : new SXSSFWorkbook(); -> 대용량 엑셀파일 처리에 유리
		 */
		return new SXSSFWorkbook(1000);//fetchSize: 1000행
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String type = model.get("excelType").toString();
		Sheet sheet = workbook.createSheet(type);
		Row row = null;
		Cell cell = null;
		int rowCount = 0;
		int cellCount = 0;
		String text = "";
		
		CellStyle headStyle = workbook.createCellStyle();
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		headStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		
		row = sheet.createRow(rowCount++);
		
		List<Map<String, Object>> excelList = (List<Map<String,Object>>)model.get("excelList");
		if(excelList.size() > 0) {
			LinkedHashMap<String, Object> mapHeader = (LinkedHashMap<String, Object>)excelList.get(0);
			for(Object key : mapHeader.keySet()) {
				cell =row.createCell(cellCount++);
				cell.setCellStyle(headStyle);
				text = key.toString();
				cell.setCellValue(text);
			}
			for(Map<String, Object> map : excelList) {
				LinkedHashMap<String, Object> mapContent = (LinkedHashMap<String, Object>)map;
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				for(Object key : mapContent.keySet()) {
					cell = row.createCell(cellCount++);
					cell.setCellStyle(bodyStyle);
					text = mapContent.get(key).toString();
					cell.setCellValue(text == null ? "" : text);
				}
			}
			
			SXSSFSheet sxSheet = (SXSSFSheet)sheet;
			for(int i=0; i<mapHeader.size(); i++) {
				sxSheet.trackColumnForAutoSizing(i);
			}
			for(int i=0; i<mapHeader.size(); i++) {
				sxSheet.autoSizeColumn(i);
				sxSheet.setColumnWidth(i, sheet.getColumnWidth(i) + 1500);
			}
		}
	}	
}
