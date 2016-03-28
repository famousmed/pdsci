package com.pinde.sci.biz.edc;

import java.util.List;

import com.pinde.sci.model.mo.EdcGroup;

public interface IEdcGroupBiz {
	
	public EdcGroup read(String gruopFlow);
	
	public void add(EdcGroup group);
	
	public void mod(EdcGroup group);
	
	public void del(EdcGroup group);
	
	public List<EdcGroup> searchEdcGroup(String projFlow);

	void save(EdcGroup gruop);

	List<EdcGroup> searchEdcGroup(EdcGroup group);

	EdcGroup searchEdcGroup(String projFlow, String groupName);
	
}
