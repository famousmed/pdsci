package com.pinde.sci.model.exam;

import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookComposInfo;
import com.pinde.sci.model.mo.ExamBookRecognizeInfo;
import com.pinde.sci.model.mo.ExamBookScanInfo;

public class ExamBookRegistInfo extends ExamBook{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 扫描信息
	 */
	private ExamBookScanInfo bookScanInfo;
	/**
	 * 识别信息
	 */
	private ExamBookRecognizeInfo bookRecognizeInfo;
	/**
	 * 排版信息
	 */
	private ExamBookComposInfo bookComposInfo;
	
	public ExamBookScanInfo getBookScanInfo() {
		return bookScanInfo;
	}
	public void setBookScanInfo(ExamBookScanInfo bookScanInfo) {
		this.bookScanInfo = bookScanInfo;
	}
	public ExamBookRecognizeInfo getBookRecognizeInfo() {
		return bookRecognizeInfo;
	}
	public void setBookRecognizeInfo(ExamBookRecognizeInfo bookRecognizeInfo) {
		this.bookRecognizeInfo = bookRecognizeInfo;
	}
	public ExamBookComposInfo getBookComposInfo() {
		return bookComposInfo;
	}
	public void setBookComposInfo(ExamBookComposInfo bookComposInfo) {
		this.bookComposInfo = bookComposInfo;
	}
	
	

}
