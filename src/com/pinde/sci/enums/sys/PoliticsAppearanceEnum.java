package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PoliticsAppearanceEnum implements GeneralEnum<String>{

	Zgdy("01","�й���������Ա"),
	Zgybdy("02","�й�������Ԥ����Ա"),
	Zgty("03","�й�����������������Ա"),
	Zgmg("04","�й����񵳸���ίԱ���Ա"),
	Zgmm("05","�й�����ͬ����Ա"),
	Zgmj("06","�й������������Ա"),
	Zgmc("07","�й������ٽ����Ա"),
	Zgng("08","�й�ũ����������Ա"),
	Zgzg("09","�й��¹�����Ա"),
	Zg93("10","����ѧ����Ա"),
	Twmz("11","̨����������ͬ����Ա"),
	Wdp("12","�޵���������ʿ"),
	Qz("13","Ⱥ��")
	;
	private final String id;
	private final String name;
	


	PoliticsAppearanceEnum(String id,String name) {
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
		return EnumUtil.getById(id, PoliticsAppearanceEnum.class).getName();
	}
}
