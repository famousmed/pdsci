package com.pinde.sci.enums.irb;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum IrbTypeEnum implements GeneralEnum<String> {
	
	Init("Init","��ʼ�������","��ʼ���","1"),
	Retrial("Retrial","��������","����","2"),
	Revise("Revise","�������������","���������","3"),
	Schedule("Schedule","�о���չ����","��ȶ��ڸ������","4"),
	Sae("Sae","���ز����¼�����","���ز����¼����","5"),
	Violate("Violate","Υ����������","Υ���������","6"),
	Terminate("Terminate","��ͣ/��ֹ�о�����","��ͣ/��ֹ�о����","7"),
	Finish("Finish","�о���ɱ���","�о�������","8"),
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
