package com.pinde.sci.enums.inx;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

/**
 * ��Ѷ״̬ö��
 *
 */
public enum InfoStatusEnum implements GeneralEnum<String> {
	Edit("Edit","�༭"),
	Passing("Passing","�����"),
	Passed("Passed","���ͨ��"),
	NoPassed("NoPassed","��˲�ͨ��"),
	Failure("Failure","ɾ��")
	;
	
	private InfoStatusEnum(String id, String name) {
		this.id = id;
		this.name = name;
	}

	private final String id;
	private final String name;
	@Override
	public String getId() {
		return this.id;
	}

	@Override
	public String getName() {
		return this.name;
	}
	public static String getNameById(String id) {
		return EnumUtil.getNameById(id, InfoStatusEnum.class);
	}
}
