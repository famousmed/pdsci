package com.pinde.sci.biz.fstu;

import java.util.List;

import com.pinde.sci.model.mo.FstuCredit;
import com.pinde.sci.model.mo.SysUser;

public interface IFstuCreditBiz {
	List<FstuCredit> searchByUserFlows(List<String> userFlow);

	/**
	 *FstuCredit≤È—Ø
	 */
	public List<FstuCredit> search(FstuCredit credit);
	/**
	 * ±‡º≠
	 * 
	 */
	public int edit(FstuCredit credit);

	FstuCredit findByFlow(String flow);


	List<FstuCredit> searchCreditByUserFlow(String userFlow);

	int saveCreditList(List<FstuCredit> credit);
}
