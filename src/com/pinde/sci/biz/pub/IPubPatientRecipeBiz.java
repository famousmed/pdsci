package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubPatientRecipeExample;
import com.pinde.sci.model.pub.PubPatientRecipeExt;


public interface IPubPatientRecipeBiz {

	List<PubPatientRecipe> searchPatientRecipe(PubPatientRecipeExample example);

	PubPatientRecipe readPatientRecipe(String recipeFlow);

	int savePatientRecipe(PubPatientRecipe patientRecipe);

	int savePatientRecipeDrug(PubPatientRecipeDrug patientRecipeDrug);

	List<PubPatientRecipe> searchPatientRecipe(String patientFlow);

	List<PubPatientRecipeDrug> searchPatientRecipeDrugByRecipeFlows(
			List<String> recipeFlows);

	List<PubPatientRecipeExt> searchPatientRecipe(String orgFlow,String patientName,
			String recipeStatusId,String projName);

	List<PubPatientRecipeDrug> searchPatientRecipeDrug(String recipeFlow);

	List<PubPatientRecipe> searchPatientRecipeByPatientRecipe(
			PubPatientRecipe patientRecipe);

	List<PubPatientRecipeDrug> searchRecipeDrug(PubPatientRecipeDrug recipeDrug);

}  
  