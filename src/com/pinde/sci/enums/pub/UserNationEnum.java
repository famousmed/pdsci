package com.pinde.sci.enums.pub;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum UserNationEnum implements GeneralEnum<String> {
	
	Han("01","��"),
	Mongolian("02","�ɹ���"),
	Hui("03","����"),
	Zang("04","����"),
	Uygur("05","ά���"),
	Miao("06","����"),
	Yi("07","����"),
	Zhuang("08","׳��"),
	Buyi("09","������"),
	NorthKorea("10","������"),
	Manchu("11","����"),
	Dong("12","����"),
	Yao("13","����"),
	Bai("14","����"),
	Tujia("15","������"),
	Hani("16","������"),
	Kazak("17","��������"),
	Dai("18","����"),
	Li("19","����"),
	Lisu("20","������"),
	Wa("21","����"),
	Yu("22","���"),
	Alpine("23","��ɽ��"),
	Lahu("24","������"),
	Aquarium("25","ˮ��"),
	Dongxiang("26","������"),
	Naxi("27","������"),
	Jinpo("28","������"),
	Kirgiz("29","�¶�����"),
	Tu("30","����"),
	Daur("31","���Ӷ���"),
	Molao("32","������"),
	Qiang("33","Ǽ��"),
	Brown("34","������"),
	Sarah("35","������"),
	Maonan("36","ë����"),
	Gelao("37","������"),
	Siberia("38","������"),
	Achang("39","������"),
	Pumi("40","������"),
	Tajik("41","��������"),
	Nu("42","ŭ��"),
	UzbekBuick("43","���α��"),
	Russian("44","����˹��"),
	Ewenki("45","���¿���"),
	DeAngzu("46","�°���"),
	Security("47","������"),
	Yugur("48","ԣ����"),
	Jing("49","����"),
	Tatar("50","��������"),
	Derung("51","������"),
	Oroqen("52","���״���"),
	Hezhe("53","������"),
	Menbacou("54","�Ű���"),
	Lhoba("55","�����"),
	Jinuo("56","��ŵ��"),
	Other("97","����"),
	ForeignBlood("98","���Ѫͳ"),
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
