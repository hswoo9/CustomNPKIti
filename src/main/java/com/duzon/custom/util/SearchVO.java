package com.duzon.custom.util;

import java.text.ParseException;
import java.util.Date;

public class SearchVO{
	
	private int page;
	
	private int rowCount;
	
	private int searchType;
	
	private String searchColumn;
	
	private String searchMultipleColumn;
	
	private String searchContent;
	
	private String mode;
	
	private String startDt;
	
	private String endDt;
	
	private String categoryUUID1;
	
	private String categoryUUID2;
	
	private String categoryUUID3;
	
	private String returnUrl;
	
	private int type;

	public int getPage() {
		
		if(page == 0) page = 1;
		
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRowCount() {
		
		if(rowCount == 0) rowCount = 10;
		
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public int getSearchType() {
		return searchType;
	}

	public void setSearchType(int searchType) {
		this.searchType = searchType;
	}

	public String getSearchColumn() {
		return searchColumn == null ? "" : searchColumn;
	}

	public void setSearchColumn(String searchColumn) {
		this.searchColumn = searchColumn;
	}
	
	public void setSearchMultipleColumn(String searchMultipleColumn) {
		this.searchMultipleColumn = searchMultipleColumn;
	}

	public String getStartDt() {
		return startDt;
	}
	
	public Date getStartDt(String format) throws ParseException {
		return DateTimeUtil.strToDateTime(startDt, format);
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}
	
	public Date getEndDt(String format) throws ParseException {
		return DateTimeUtil.strToDateTime(endDt, format);
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getSearchMultipleColumn() {
		return searchMultipleColumn;
	}

	public String getSearchContent() {
		return searchContent == null ? "" : searchContent;
	}

	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}

	public String getMode() {
		return mode == null ? "" : mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getCategoryUUID1() {
		return categoryUUID1;
	}

	public void setCategoryUUID1(String categoryUUID1) {
		this.categoryUUID1 = categoryUUID1;
	}

	public String getCategoryUUID2() {
		return categoryUUID2;
	}

	public void setCategoryUUID2(String categoryUUID2) {
		this.categoryUUID2 = categoryUUID2;
	}

	public String getCategoryUUID3() {
		return categoryUUID3;
	}

	public void setCategoryUUID3(String categoryUUID3) {
		this.categoryUUID3 = categoryUUID3;
	}

	public String getReturnUrl() {
		return returnUrl;
	}

	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
