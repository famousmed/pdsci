package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserNationEnum implements GeneralEnum<String> {
	
	Han("01","汉"),
	Mongolian("02","蒙古族"),
	Hui("03","回族"),
	Zang("04","藏族"),
	Uygur("05","维吾尔"),
	Miao("06","苗族"),
	Yi("07","彝族"),
	Zhuang("08","壮族"),
	Buyi("09","布依族"),
	NorthKorea("10","朝鲜族"),
	Manchu("11","满族"),
	Dong("12","侗族"),
	Yao("13","瑶族"),
	Bai("14","白族"),
	Tujia("15","土家族"),
	Hani("16","哈尼族"),
	Kazak("17","哈萨克族"),
	Dai("18","傣族"),
	Li("19","黎族"),
	Lisu("20","傈僳族"),
	Wa("21","佤族"),
	Yu("22","畲族"),
	Alpine("23","高山族"),
	Lahu("24","拉祜族"),
	Aquarium("25","水族"),
	Dongxiang("26","东乡族"),
	Naxi("27","纳西族"),
	Jinpo("28","景颇族"),
	Kirgiz("29","柯尔克孜"),
	Tu("30","土族"),
	Daur("31","达斡尔族"),
	Molao("32","仫佬族"),
	Qiang("33","羌族"),
	Brown("34","布朗族"),
	Sarah("35","撒拉族"),
	Maonan("36","毛南族"),
	Gelao("37","仡佬族"),
	Siberia("38","锡伯族"),
	Achang("39","阿昌族"),
	Pumi("40","普米族"),
	Tajik("41","塔吉克族"),
	Nu("42","怒族"),
	UzbekBuick("43","乌孜别克"),
	Russian("44","俄罗斯族"),
	Ewenki("45","鄂温克族"),
	DeAngzu("46","德昂族"),
	Security("47","保安族"),
	Yugur("48","裕固族"),
	Jing("49","京族"),
	Tatar("50","塔塔尔族"),
	Derung("51","独龙族"),
	Oroqen("52","鄂伦春族"),
	Hezhe("53","赫哲族"),
	Menbacou("54","门巴族"),
	Lhoba("55","珞巴族"),
	Jinuo("56","基诺族"),
	Other("97","其他"),
	ForeignBlood("98","外国血统"),
	;

	private final String id;
	private final String name;
	
	UserNationEnum(String id,String name) {
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
		return EnumUtil.getById(id, UserNationEnum.class).getName();
	}
}
