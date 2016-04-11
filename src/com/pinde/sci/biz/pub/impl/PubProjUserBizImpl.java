package com.pinde.sci.biz.pub.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubProjUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubProjUserMapper;
import com.pinde.sci.dao.pub.PubProjUserExtMapper;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.pub.PubProjUserExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubProjUserBizImpl implements IPubProjUserBiz {
	@Autowired
	private PubProjUserMapper pubProjUserMapper;
	@Autowired
	private PubProjUserExtMapper pubProjUserExtMapper;

	@Override
	public int edit(PubProjUser user) {
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(user, false);
				return this.pubProjUserMapper.updateByPrimaryKeySelective(user);
			}else{//ÐÂÔö
				user.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(user, true);
				return this.pubProjUserMapper.insertSelective(user);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public void editUsers(List<PubProjUser> users) {
		for (PubProjUser user : users) {
			edit(user);
		}
	}

	@Override
	public List<PubProjUserExt> queryExtList(PubProjUserExt pubProjUserExt) {
		return this.pubProjUserExtMapper.selectList(pubProjUserExt);
	}
	
	@Override
	public void saveProjUserOrder(String[] recordFlow) {
		for(int i=0;i<recordFlow.length;i++){
			PubProjUser update = new PubProjUser();
			update.setRecordFlow(recordFlow[i]);
			update.setOrdinal((i+1));
			this.pubProjUserMapper.updateByPrimaryKeySelective(update);			
		}		
	}
	
}
