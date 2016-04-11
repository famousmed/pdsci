package com.pinde.sci.model.inx;

import com.pinde.sci.model.mo.InxColumn;

public class InxColumnExt extends InxColumn {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4596854929305592253L;
	/**
	 * ËùÊô¸¸À¸Ä¿
	 */
	private InxColumn parentColumn ;

	public InxColumn getParentColumn() {
		return parentColumn;
	}

	public void setParentColumn(InxColumn parentColumn) {
		this.parentColumn = parentColumn;
	}
	
	
}
