package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;
import com.pinde.sci.common.GlobalConstant;

public enum GlobalRecTypeEnum implements GeneralEnum<String> {
	
	Ethics("Ethics","ҽ��ҽ��",GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	Document("Document","ҽѧ�İ�",GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	Appraisal("Appraisal","ʵϰ�ܼ���",GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	SpeAbilityAssess("SpeAbilityAssess","���רҵ����������",GlobalConstant.RES_ROLE_SCOPE_MANAGER+","+GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	RegistryCheckForm("RegistryCheckForm","��ȿ��˵ǼǱ�",GlobalConstant.RES_ROLE_SCOPE_HEAD+","+GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	AnnualActivity("AnnualActivity","��Ȼ",GlobalConstant.RES_ROLE_SCOPE_MANAGER+","+GlobalConstant.RES_ROLE_SCOPE_ADMIN),
	;

	private final String id;
	private final String name;
	private final String auditScope;

	GlobalRecTypeEnum(String id,String name,String auditScope) {
		this.id = id;
		this.name = name;
		this.auditScope = auditScope;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}
	
	public String getAuditScope() {
		return auditScope;
	}
	
	public static String getNameById(String id) {
		return EnumUtil.getById(id, GlobalRecTypeEnum.class).getName();
	}
}
