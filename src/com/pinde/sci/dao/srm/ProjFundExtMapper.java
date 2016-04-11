package com.pinde.sci.dao.srm;

import java.util.List;

import com.pinde.sci.model.srm.ProjFundDetailExt;
import com.pinde.sci.model.srm.PubProjExt;

/**
 * 经费扩展接口
 * @author Administrator
 *
 */
public interface ProjFundExtMapper {

	public List<ProjFundDetailExt> selectProjFundDetailList(ProjFundDetailExt projFundDetailExt);
	
	public List<PubProjExt> selectProjFundInfoList(PubProjExt projExt);
	public ProjFundDetailExt selectProjFundDetailExt(String fundDetailFlow);
}
