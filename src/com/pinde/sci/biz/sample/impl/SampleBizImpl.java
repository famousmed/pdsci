package com.pinde.sci.biz.sample.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.sample.ISampleBiz;

@Service
@Transactional(rollbackFor=Exception.class)
public class SampleBizImpl implements ISampleBiz {
	
//	@Resource
//	private JobsMapper jobsMapper;

//	@Override
//	public List<String> get() {
//		return jobsMapper.selectByExample(new JobsExample());
//	}

}
