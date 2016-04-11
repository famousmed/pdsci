package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum CertificateTypeEnum implements GeneralEnum<String> {
	
	Shenfenzheng("01","���֤"),
	Junguanzheng("02","����֤"),
	Taibaozheng("03","̨��֤"),
	Huaqiao("04","�������֤"),
	;
	private final String id;
	private final String name;
	


	CertificateTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, CertificateTypeEnum.class).getName();
	}
}
