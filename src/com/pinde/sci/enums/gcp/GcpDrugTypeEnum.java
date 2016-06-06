package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpDrugTypeEnum implements GeneralEnum<String> {
	
	CleanDrug("CleaningDrug","清洗期药物"),
	ExamDrug("ExamDrug","试验药品"),
	CompareDrug("CompareDrug","比较药剂"),
	PositiveDrug("PositiveDrug","阳性对照药"),
	PlaceboDrug("PlaceboDrug","安慰剂"),
	SimulatorDrug("SimulatorDrug","模拟剂"),
	SymptomDrug("SymptomDrug","对症处理药物"),
	StandardDrug("StandardDrug","试验结束后标准治疗药物")
	;

	private final String id;
	private final String name;
	
	GcpDrugTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, GcpDrugTypeEnum.class).getName();
	}
}
