package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbTypeEnum implements GeneralEnum<String> {
	
	Init("Init","初始审查申请","初始审查","1"),
	Retrial("Retrial","复审申请","复审","2"),
	Revise("Revise","修正案审查申请","修正案审查","3"),
	Schedule("Schedule","研究进展报告","年度定期跟踪审查","4"),
	Sae("Sae","严重不良事件报告","严重不良事件审查","5"),
	Violate("Violate","违背方案报告","违背方案审查","6"),
	Terminate("Terminate","暂停/终止研究报告","暂停/终止研究审查","7"),
	Finish("Finish","研究完成报告","研究完成审查","8"),
	;

	private final String id;
	private final String name;
	private final String scName;
	private final String ordinal;
	


	IrbTypeEnum(String id,String name,String scName,String ordinal) {
		this.id = id;
		this.name = name;
		this.scName = scName;
		this.ordinal = ordinal;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getScName() {
		return scName;
	}
	
	public String getOrdinal() {
		return ordinal;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, IrbTypeEnum.class).getName();
	}
	
	public static String getOrdinalById(String id) {
		return ((IrbTypeEnum)EnumUtil.getById(id, IrbTypeEnum.class)).getOrdinal();
	}
}
