package com.pinde.sci.dao.pub;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.pub.PubPatientRecipeExt;

public interface PubPatientRecipeExtMapper {

	List<PubPatientRecipeExt> searchPatientRecipe(Map<String, Object> map);
}
