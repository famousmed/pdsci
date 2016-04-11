package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum QuestionTypeEnum implements GeneralEnum<String> {
	
	Type15("15","��ѡ��"),
	Type18("18","��ѡ��"),
	Type25("25","������"),
	Type26("26","������"),
	Type27("27","�Ƿ���"),
	Type28("28","�����"),
	Type29("29","���ʽ���"),
	Type30("30","�����"),
	Type31("31","������"),
	Type32("32","K����"),
	Type33("33","����������"),
	Type34("34","������"),
	Type35("35","�ʻ�ѡ��"),
	Type36("36","�Ķ��ж�"),
	Type37("37","������������ɾ���"),
	Type38("38","�Ķ����"),
	Type47("47","��ý����"),
	Type48("48","����")
	;

	private final String id;
	private final String name;
	
	QuestionTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, QuestionTypeEnum.class).getName();
	}
}
