package com.pinde.sci.dao.edc;

import com.pinde.sci.model.mo.PubModule;
import com.pinde.sci.model.mo.PubModuleExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface PubModuleExtMapper {
   
    List<PubModule> moduleSearch(String keyWord); 
}