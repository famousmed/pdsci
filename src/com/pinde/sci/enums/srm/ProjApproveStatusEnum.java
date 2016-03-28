package com.pinde.sci.enums.srm;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

/**
 * 立项阶段状态
 * @author Administrator
 *
 */
public enum ProjApproveStatusEnum implements GeneralEnum<String> {
	Approving("Approving" , "审核中"),
	NotApprove("NotApprove" , "立项不通过"),
	Approve("Approve" , "立项通过"),
	Save("Save" , "下拨保存"),
	Confirm("Confirm" , "下拨确认")
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
