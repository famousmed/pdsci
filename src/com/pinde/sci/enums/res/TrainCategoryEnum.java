package com.pinde.sci.enums.res;

import com.pinde.core.commom.GeneralEnum;
import com.pinde.core.util.EnumUtil;

public enum TrainCategoryEnum implements GeneralEnum<String> {
	
	WMFirst("WMFirst","��ҽһ�׶�","Before2014"),
	WMSecond("WMSecond","��ҽ���׶�","Before2014"),
	AssiGeneral("AssiGeneral","����ȫ��","Before2014"),
	WM("WM","��ҽ","After2014"),
	TCM("TCM","��ҽ","After2014"),
	;

	private final String id;
	private final String name;
	private final String typeId;
	
	TrainCategoryEnum(String id,String name,String typeId) {
		this.id = id;
		this.name = name;
		this.typeId = typeId;
	}

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}

	public String getTypeId() {
		return typeId;
	}

	public static String getNameById(String id) {
		return EnumUtil.getById(id, TrainCategoryEnum.class).getName();
	}
	
	public static String getCategoryIdById(String id) {
		return ((TrainCategoryEnum)EnumUtil.getById(id, TrainCategoryEnum.class)).getTypeId();
	}
}
