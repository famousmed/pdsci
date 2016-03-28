package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbUser;


public interface IIrbCommitteeBiz {

	List<IrbForm> searchIrbFormList(List<IrbUser> irbUserList);
	/**
	 * ����ίԱͶƱ
	 * @param form
	 * @param irbFlow
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveVote(IrbVoteForm form,String irbFlow,String[] userFlows)throws Exception;
	/**
	 * ��ȡͶƱ
	 * @param irbFlow
	 * @param userFlow
	 * @return
	 * @throws Exception
	 */
	List<IrbVoteForm> queryIrbVoteList(String irbFlow,String userFlow)throws Exception ;
	int saveVoteDecision(IrbVoteForm form) throws Exception;
	
	/**
	 * ���������ͻ�˳�
	 * @param irbFlow
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveConflict(String irbFlow, String[] userFlows)throws Exception;
}
