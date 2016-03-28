package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

/**
 * ����׶�״̬
 * @author Administrator
 *
 */
public enum ProjApproveStatusEnum implements GeneralEnum<String> {
	Approving("Approving" , "�����"),
	NotApprove("NotApprove" , "���ͨ��"),
	Approve("Approve" , "����ͨ��"),
	Save("Save" , "�²�����"),
	Confirm("Confirm" , "�²�ȷ��")
	;

	private final String id;
	private final String name;
	
	ProjApproveStatusEnum(String id,String name) {
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
		return EnumUtil.getById(id, ProjApproveStatusEnum.class).getName();
	}
}
