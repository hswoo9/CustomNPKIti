package com.duzon.custom.util;

public class Pagenation {
	
	private int pageRow;	// 페이지당 게시물 수
	private int pageBlock; 	// 화면당 페이지 수
	private int curPage;	// 현재 페이지
	private int prevPage;	// 이전 페이지
	private int nextPage;	// 다음 페이지
	private int totalPage;	// 전체 페이지 수
	private int totalBlock;	// 전체 페이지 블록 수
	private int curBlock;	// 현재 페이지 블록
	private int prevBlock;	// 이전 페이지 블록
	private int nextBlock;	// 다음 페이지 블록
	
	private int pageBegin;	// #{start}
	private int pageEnd;	// #{end}
	// [이전] blockBegin -> 41 42 43 .... [다음]
	private int blockBegin;	// 현재 페이지 블록의 시작번호
	// [이전] 41 42 43 .... <- blockEnd [다음 ]
	private int blockEnd;	// 현재 페이지 블록의 끝번호
	
	public Pagenation(int count, int curPage, int pageRow, int pageBlock) {
		curBlock = 1; // 현재 페이지 블록 번호
		this.curPage = curPage;
		this.pageRow = pageRow;
		this.pageBlock = pageBlock;
		
		setTotalPage(count);	// 전체 페이지 갯수 계산
		setPageRange();			
		setTotalBlock(count);	// 전체 페이지 블록 갯수 계산
		setBlockRange();		// 페이지 블록의 시작, 끝 번호 계산 
	}
	
	public void setBlockRange() {
		// 현재 페이지가 몇번째 페이지 블록에 속하는지 계산
		curBlock = (int)Math.ceil((curPage -1) / pageBlock) + 1;
		// 현재 페이지 블록의 시작, 끝 번호 계산
		blockBegin = (curBlock-1) * pageBlock + 1;
		// 페이지 블록의 끝번호
		blockEnd = blockBegin + pageBlock - 1;
		// 마지막 블록이 범위를 초과하지 않도록 계산
		if(blockEnd > totalPage) blockEnd = totalPage;
		// 이전을 눌렀을 때 이동할 페이지 번호
		prevPage = curPage - 1;
		// 다음을 눌렀을 때 이동할 페이지 번호
		nextPage = curPage + 1;
		// 마지막 페이지가 범위를 초과하지 않도록 처리
		if(nextPage >= totalPage) nextPage = totalPage;
	}
	
	public void setPageRange() {
		// 시작번호 = (현재페이지-1)*페이지당 게시물 수 +1
		pageBegin = (curPage - 1) * pageRow + 1;
		// 끝번호 = 시작번호 + 페이지당 게시물 수 -1
		pageEnd = pageBegin + pageRow - 1;
	}
	
	public int getPageRow() {
		return pageRow;
	}
	public void setPageRow(int pageRow) {
		this.pageRow = pageRow;
	}
	public int getPageBlock() {
		return pageBlock;
	}
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = (int) Math.ceil(totalPage * 1.0 / pageRow);
	}
	public int getTotalBlock() {
		return totalBlock;
	}
	// 페이지 블록의 갯수 계산(총 100페이지라면 10개의 블록)
	public void setTotalBlock(int count) {
		// 전체 페이지 갯수 / 10
		// 91 / 10 => 9.1 => 10개
		this.totalBlock = (int) Math.ceil(count / pageBlock);
	}
	public int getCurBlock() {
		return curBlock;
	}
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	public int getPrevBlock() {
		return prevBlock;
	}
	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}
	public int getNextBlock() {
		return nextBlock;
	}
	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}
	public int getPageBegin() {
		return pageBegin;
	}
	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}
	public int getPageEnd() {
		return pageEnd;
	}
	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
	public int getBlockBegin() {
		return blockBegin;
	}
	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}
	public int getBlockEnd() {
		return blockEnd;
	}
	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	
}
