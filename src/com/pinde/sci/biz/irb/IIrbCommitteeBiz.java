package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbUser;


public interface IIrbCommitteeBiz {

	List<IrbForm> searchIrbFormList(List<IrbUser> irbUserList);
	/**
	 * 保存委员投票
	 * @param form
	 * @param irbFlow
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveVote(IrbVoteForm form,String irbFlow,String[] userFlows)throws Exception;
	/**
	 * 读取投票
	 * @param irbFlow
	 * @param userFlow
	 * @return
	 * @throws Exception
	 */
	List<IrbVoteForm> queryIrbVoteList(String irbFlow,String userFlow)throws Exception ;
	int saveVoteDecision(IrbVoteForm form) throws Exception;
	
	/**
	 * 保存利益冲突退出
	 * @param irbFlow
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveConflict(String irbFlow, String[] userFlows)throws Exception;
}
