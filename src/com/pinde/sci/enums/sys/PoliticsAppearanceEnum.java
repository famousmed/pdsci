package com.pinde.sci.enums.sys;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum PoliticsAppearanceEnum implements GeneralEnum<String>{

	Zgdy("01","中国共产党党员"),
	Zgybdy("02","中国共产党预备党员"),
	Zgty("03","中国共产主义青年团团员"),
	Zgmg("04","中国国民党革命委员会会员"),
	Zgmm("05","中国民主同盟盟员"),
	Zgmj("06","中国民主建国会会员"),
	Zgmc("07","中国民主促进会会员"),
	Zgng("08","中国农工民主党党员"),
	Zgzg("09","中国致公党党员"),
	Zg93("10","九三学社社员"),
	Twmz("11","台湾民主自治同盟盟员"),
	Wdp("12","无党派民主人士"),
	Qz("13","群众")
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
