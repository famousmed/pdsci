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
	 * ɨ����Ϣ
	 */
	private ExamBookScanInfo bookScanInfo;
	/**
	 * ʶ����Ϣ
	 */
	private ExamBookRecognizeInfo bookRecognizeInfo;
	/**
	 * �Ű���Ϣ
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
