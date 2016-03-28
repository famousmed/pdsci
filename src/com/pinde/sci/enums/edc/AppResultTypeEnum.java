package com.pinde.sci.enums.edc;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum AppResultTypeEnum implements GeneralEnum<String> {
	
	Success("200","交易成功"),
	Req404("404","不存在的交易码"),
	Illegal("403","授权错误"),
	Error("500","后台错误"),
	
	PhoneEmpty("0101","手机号为空"),
	PasswordEmpty("0102","密码为空"),
	LoginError("0199","手机号或密码错误"),
	UserFlowNull("0103","用户为空"),
	UserUnActivated("0104","用户未激活或已锁定"),
	
	UserFlowEmpty("0201","用户唯一标识为空"),
	UserNotFound("0202","错误的用户唯一标识"),
	
	
	PatientNotFound("0401","申请失败：未发现受试者"),
	RecNotFound("0402","申请失败：无可用随机号"),
	DrugNotFound("0403","申请失败：药物不足"),
	CfgNotFound("0404","申请失败：随机类型未设置"),
	RandomLock("0409","申请失败：随机锁定")
	;

	private final String id;
	private final String name;
	
	AppResultTypeEnum(String id,String name) {
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
		return EnumUtil.getById(id, AppResultTypeEnum.class).getName();
	}
}
