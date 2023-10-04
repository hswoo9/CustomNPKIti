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
 * 		  <bean name="excelView" class="com.duzon.custom.common.utiles.ExcelView"/> 등록후
 * 		- 컨트롤러에서 "excelView" 리턴하여 사용
 * 		- 컨트롤러에서 excelType 수정하여 엑셀 시트명/다운로드 파일명 지정
 * 		- new SXSSFWorkbook(int); & MyBatis fetchSize="int" // int 같은 숫자로 맞춰서 사용  		
 */
@Component("excelView")
public class ExcelView extends AbstractExcelView{

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
		int colCount = 0;
		String text = "";
		String empName = "";
		int applyMinSum = 0;
		int occurMinSum = 0;
		int agreeMinSum = 0;
		int breakMinSum = 0;
		int nightMinSum = 0;
		int empApplyMinSum = 0;
		int empOccurMinSum = 0;
		int empAgreeMinSum = 0;
		int empBreakMinSum = 0;
		int empNightMinSum = 0;
		String applyTotal = "";
		String occurTotal = "";
		String agreeTotal = "";
		String breakTotal = "";
		String nightTotal = "";
		
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
				if(!key.equals("apply_min") 
						&& !key.equals("occur_min") 
						&& !key.equals("agree_min") 
						&& !key.equals("break_min") 
						&& !key.equals("night_min")) {
					cell =row.createCell(cellCount++);
					cell.setCellStyle(headStyle);
					text = key.toString();
					cell.setCellValue(text);
					colCount++;
				}
			}
			for(Map<String, Object> map : excelList) {
				//occurTotal = String.valueOf(empOccurMinSum/60) + "/" + String.valueOf(empOccurMinSum%60);
				LinkedHashMap<String, Object> mapContent = (LinkedHashMap<String, Object>)map;
				if(!empName.equals(mapContent.get("성명")) && !empName.equals("")) {
					row = sheet.createRow(rowCount++);
					for(int i=0;i<colCount;i++) {
						cell = row.createCell(i);
						cell.setCellStyle(bodyStyle);
						if(i == 1) {
							cell.setCellValue(empName + "합계");
						}else if(i == colCount-6) {
							applyTotal = String.format("%02d", empApplyMinSum/60) + ":" + String.format("%02d", empApplyMinSum%60);
							cell.setCellValue(applyTotal);
						}else if(i == colCount-5) {
							occurTotal = String.format("%02d", empOccurMinSum/60) + ":" + String.format("%02d", empOccurMinSum%60);
							cell.setCellValue(occurTotal);
						}else if(i == colCount-4) {
							breakTotal = String.format("%02d", empBreakMinSum/60) + ":" + String.format("%02d", empBreakMinSum%60);
							cell.setCellValue(breakTotal);
						}else if(i == colCount-3) {
							agreeTotal = String.format("%02d", empAgreeMinSum/60) + ":" + String.format("%02d", empAgreeMinSum%60);
							cell.setCellValue(agreeTotal);
						}else if(i == colCount-2) {
							nightTotal = String.format("%02d", empNightMinSum/60) + ":" + String.format("%02d", empNightMinSum%60);
							cell.setCellValue(nightTotal);
						}
					}
					empApplyMinSum = 0;
					empOccurMinSum = 0;
					empAgreeMinSum = 0;
					empBreakMinSum = 0;
					empNightMinSum = 0;
				}
				empName = (String)mapContent.get("성명");
				
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				for(Object key : mapContent.keySet()) {
					if(!key.equals("apply_min") 
							&& !key.equals("occur_min") 
							&& !key.equals("agree_min")
							&& !key.equals("break_min") 
							&& !key.equals("night_min")) {
						cell = row.createCell(cellCount++);
						cell.setCellStyle(bodyStyle);
						text = mapContent.get(key).toString();
						cell.setCellValue(text == null ? "" : text);
					}else if(key.equals("apply_min")) {
						applyMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
						empApplyMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
					}else if(key.equals("occur_min")) {
						occurMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
						empOccurMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
					}else if(key.equals("agree_min")) {
						agreeMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
						empAgreeMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
					}else if(key.equals("break_min")) {
						breakMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
						empBreakMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
					}else if(key.equals("night_min")) {
						nightMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
						empNightMinSum += Integer.parseInt(String.valueOf(mapContent.get(key)));
					}
				}
			}
			row = sheet.createRow(rowCount++);
			for(int i=0;i<colCount;i++) {
				cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				if(i == 1) {
					cell.setCellValue(empName + "합계");
				}else if(i == colCount-6) {
					applyTotal = String.format("%02d", empApplyMinSum/60) + ":" + String.format("%02d", empApplyMinSum%60);
					cell.setCellValue(applyTotal);
				}else if(i == colCount-5) {
					occurTotal = String.format("%02d", empOccurMinSum/60) + ":" + String.format("%02d", empOccurMinSum%60);
					cell.setCellValue(occurTotal);
				}else if(i == colCount-4) {
					breakTotal = String.format("%02d", empBreakMinSum/60) + ":" + String.format("%02d", empBreakMinSum%60);
					cell.setCellValue(breakTotal);
				}else if(i == colCount-3) {
					agreeTotal = String.format("%02d", empAgreeMinSum/60) + ":" + String.format("%02d", empAgreeMinSum%60);
					cell.setCellValue(agreeTotal);
				}else if(i == colCount-2) {
					nightTotal = String.format("%02d", empNightMinSum/60) + ":" + String.format("%02d", empNightMinSum%60);
					cell.setCellValue(nightTotal);
				}
			}
			
			row = sheet.createRow(rowCount++);
			for(int i=0;i<colCount;i++) {
				cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				if(i == 1) {
					cell.setCellValue("총계");
				}else if(i == colCount-6) {
					applyTotal = String.format("%02d", applyMinSum/60) + ":" + String.format("%02d", applyMinSum%60);
					cell.setCellValue(applyTotal);
				}else if(i == colCount-5) {
					occurTotal = String.format("%02d", occurMinSum/60) + ":" + String.format("%02d", occurMinSum%60);
					cell.setCellValue(occurTotal);
				}else if(i == colCount-4) {
					breakTotal = String.format("%02d", breakMinSum/60) + ":" + String.format("%02d", breakMinSum%60);
					cell.setCellValue(breakTotal);
				}else if(i == colCount-3) {
					agreeTotal = String.format("%02d", agreeMinSum/60) + ":" + String.format("%02d", agreeMinSum%60);
					cell.setCellValue(agreeTotal);
				}else if(i == colCount-2) {
					nightTotal = String.format("%02d", nightMinSum/60) + ":" + String.format("%02d", nightMinSum%60);
					cell.setCellValue(nightTotal);
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
