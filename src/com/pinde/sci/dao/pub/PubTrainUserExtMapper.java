package com.pinde.sci.dao.pub;

import java.util.List;

import com.pinde.sci.model.pub.PubTrainUserExt;

public interface PubTrainUserExtMapper {
	List<PubTrainUserExt> selectGcpList(List<String> userFlows);
}
