package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum RecDocCategoryEnum implements GeneralEnum<String> {
	
//	InDoctor("InDoctor","��Ժ����"),
//	OutDoctor("OutDoctor","��Ժ����"),
//	FieldTrain("FieldTrain","���ί��"),
	Doctor("Doctor","סԺҽʦ"),
	Graduate("Graduate","�о���"),
	Intern("Intern","ʵϰ��"),
	Scholar("Scholar","������"),
//	EightYear("EightYear","������"),
//	UnderGrad("UnderGrad","������"),
	Specialist("Specialist","ר��ҽʦ"),
	GeneralDoctor("GeneralDoctor","��ѵѧԱ")
	;
	private final String id;
	private final String name;
	


	RecDocCategoryEnum(String id,String name) {
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
		return EnumUtil.getById(id, RecDocCategoryEnum.class).getName();
	}
}
