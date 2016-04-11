package com.pinde.sci.model.inx;

import com.pinde.sci.model.mo.InxColumn;
import com.pinde.sci.model.mo.InxInfo;

public class InxInfoExt extends InxInfo {
	/**
	 * 
	 */
	private static final long serialVersionUID = -213115772691048695L;
	/**
	 * ËùÊôÀ¸Ä¿
	 */
	private InxColumn column;

	public InxColumn getColumn() {
		return column;
	}

	public void setColumn(InxColumn column) {
		this.column = column;
	}
	
}
