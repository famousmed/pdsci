package com.pinde.sci.enums.exam;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum QuestionTypeEnum implements GeneralEnum<String> {
	
	Type15("15","单选题"),
	Type18("18","多选题"),
	Type25("25","病例题"),
	Type26("26","配伍题"),
	Type27("27","是非题"),
	Type28("28","填空题"),
	Type29("29","名词解释"),
	Type30("30","简答题"),
	Type31("31","论述题"),
	Type32("32","K型题"),
	Type33("33","病例分析题"),
	Type34("34","计算题"),
	Type35("35","词汇选项"),
	Type36("36","阅读判断"),
	Type37("37","概括大意与完成句子"),
	Type38("38","阅读理解"),
	Type47("47","多媒体题"),
	Type48("48","作文")
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
