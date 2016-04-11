package com.pinde.sci.dao.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbUser;

public interface IrbUserExtMapper {

	List<IrbUser> queryIrbUserList(String year);
}
