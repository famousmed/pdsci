package com.pinde.sci.enums.gcp;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum GcpDrugTypeEnum implements GeneralEnum<String> {
	
	CleanDrug("CleaningDrug","��ϴ��ҩ��"),
	ExamDrug("ExamDrug","����ҩƷ"),
	CompareDrug("CompareDrug","�Ƚ�ҩ��"),
	PositiveDrug("PositiveDrug","���Զ���ҩ"),
	PlaceboDrug("PlaceboDrug","��ο��"),
	SimulatorDrug("SimulatorDrug","ģ���"),
	SymptomDrug("SymptomDrug","��֢����ҩ��"),
	StandardDrug("StandardDrug","����������׼����ҩ��")
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
