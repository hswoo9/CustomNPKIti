package com.duzon.custom.common.excel;

import java.text.SimpleDateFormat;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;

public class ExcelCellRef {
	 /**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
        
        return CellReference.convertNumToColString(cellNum);
    }
    
    public static String getValue(Cell cell) {
        String value = "";
        
        if(cell == null) {
            value = "";
        } else {
        	switch(cell.getCellType()) {
            case Cell.CELL_TYPE_FORMULA :
                value = cell.getCellFormula();
                break;
            
            case Cell.CELL_TYPE_NUMERIC :
            	if (DateUtil.isCellDateFormatted(cell)) {
            		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            		value = sdf.format(cell.getDateCellValue());
        		} else {
        			value = (int)cell.getNumericCellValue() + "";
        		}
                break;
                
            case Cell.CELL_TYPE_STRING :
                value = cell.getStringCellValue();
                break;
            
            case Cell.CELL_TYPE_BOOLEAN :
                value = cell.getBooleanCellValue() + "";
                break;
           
            case Cell.CELL_TYPE_BLANK :
                value = "";
                break;
            
            case Cell.CELL_TYPE_ERROR :
                value = cell.getErrorCellValue() + "";
                break;
            default:
                value = cell.getStringCellValue();
        }
        }
        


        
        return value;
    }


}

