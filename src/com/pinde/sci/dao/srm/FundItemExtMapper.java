package com.pinde.sci.dao.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundItem;
import com.pinde.sci.model.mo.SrmFundScheme;

public interface FundItemExtMapper {
	public List<SrmFundItem> searchSrmFundItemNotInBySchemeFlow(String schemeFlow);
}
