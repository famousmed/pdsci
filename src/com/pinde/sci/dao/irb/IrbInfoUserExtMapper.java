package com.pinde.sci.dao.irb;

import java.util.List;

import com.pinde.sci.model.irb.IrbInfoUserExt;
import com.pinde.sci.model.mo.IrbInfoUser;

public interface IrbInfoUserExtMapper {
	List<IrbInfoUserExt> selectExtList(IrbInfoUser user);
}
