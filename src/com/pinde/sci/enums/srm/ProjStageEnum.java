package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum ProjStageEnum implements GeneralEnum<String> {
	
	Apply("Apply","Éê±¨½×¶Î"),
	Approve("Approve","Á¢Ïî½×¶Î"),
	Contract("Contract" , "ºÏÍ¬½×¶Î"),
	Schedule("Schedule","ÊµÊ©½×¶Î"),
	Complete("Complete","½áÊø½×¶Î"),
	Archive("Archive","¹éµµ½×¶Î"),
	;

	private final String id;
	private final String name;
	
	ProjStageEnum(String id,String name) {
		this.id = id;
		this.name = name;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, ProjStageEnum.class).getName();
	}
}
