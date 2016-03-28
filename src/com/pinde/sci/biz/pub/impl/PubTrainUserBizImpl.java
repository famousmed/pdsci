package com.pinde.sci.biz.pub.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubTrainUserMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.enums.irb.IrbTrainCategoryEnum;
import com.pinde.sci.enums.irb.IrbTrainTypeEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainUser;
import com.pinde.sci.model.mo.PubTrainUserExample;
import com.pinde.sci.model.mo.PubTrainUserExample.Criteria;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
@Service
@Transactional(rollbackFor = Exception.class)
public class PubTrainUserBizImpl implements IPubTrainUserBiz {
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	private PubTrainUserMapper trainUserMapper;
	@Resource
	private PubFileMapper pubFileMapper;
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private IPubTrainBiz trainBiz;
	@Autowired
	private IFileBiz fileBiz;

	@Override
	public List<SysUser> queryUserListFromSysUser(String orgFlow,String deptFlow) {
		SysUserExample example = new SysUserExample();
		com.pinde.sci.model.mo.SysUserExample.Criteria criteria = example.createCriteria().andStatusIdEqualTo(UserStatusEnum.Activated.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(orgFlow)){
			criteria.andOrgFlowEqualTo(orgFlow);
		}
		if(StringUtil.isNotBlank(deptFlow)){
			criteria.andDeptFlowEqualTo(deptFlow);
		}
		List<SysUser> selectUser = sysUserMapper.selectByExample(example);
		return selectUser;
	}

	@Override
	public List<PubTrainUser> queryTrainUserList(PubTrainUser trainUser) {
		PubTrainUserExample example = new PubTrainUserExample();
		PubTrainUserExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(trainUser.getTrainFlow())){
			criteria.andTrainFlowEqualTo(trainUser.getTrainFlow());
		}
		if(StringUtil.isNotBlank(trainUser.getUserName())){
			criteria.andUserNameLike("%"+ trainUser.getUserName() +"%");
		}
		if(StringUtil.isNotBlank(trainUser.getUserFlow())){
			criteria.andUserFlowEqualTo(trainUser.getUserFlow());
		}
		return trainUserMapper.selectByExample(example);
	}

	@Override
	public int editUser(PubTrainUser user) {
		if(null != user){
			//修改
			if(StringUtil.isNotBlank(user.getRecordFlow())){
				GeneralMethod.setRecordInfo(user, false);
				trainUserMapper.updateByPrimaryKeySelective(user);
			}else{//新增
				user.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(user, true);
				trainUserMapper.insert(user);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public String saveFiles(List<MultipartFile> filesList, String[] recordFlows,String[] fileNos) {
		if(filesList != null && filesList.size() > 0){  
            //循环获取file数组中得文件  
            for(int i = 0;i < filesList.size();i++){  
            	String recordFlow = recordFlows[i];
            	String fileNo = "";
            	if (fileNos != null && fileNos.length > i) {
            		fileNo = fileNos[i];
            	}
            	if(StringUtil.isNotBlank(recordFlows[i])){
            		PubTrainUser user = trainUserMapper.selectByPrimaryKey(recordFlow);
                	if(null != user){
                		//保存文件  
                		MultipartFile multipartFile = filesList.get(i);
                    	if(!multipartFile.isEmpty()){
        					PubFile file = new PubFile();
        					String originalFileName = multipartFile.getOriginalFilename();
        					String suffix =originalFileName.substring(originalFileName.lastIndexOf(".")+1); 
        					
        					//设置默认的文件名
        					file.setFileName(originalFileName);
        					//设置文件后缀名
        					file.setFileSuffix(suffix);
        					file.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
        					//file.setFileRemark(fileRemark);
        					try {
        						/*InputStream is = filesList.get(i).getInputStream();
        						byte[] fileData = new byte[(int) filesList.get(i).getSize()];  
        						is.read(fileData);
        						file.setFileContent(fileData); */ 
        						file.setFileContent(multipartFile.getBytes());
        						fileBiz.editFile(file);
        						//修改TrainUser关联的外键
        						user.setFileFlow(file.getFileFlow());
        					} catch (Exception e) {
        						throw new RuntimeException("文件上传异常");
        					}  
        				}
                    	user.setFileNo(fileNo);
						GeneralMethod.setRecordInfo(user, false);
						trainUserMapper.updateByPrimaryKeySelective(user);
                	}
            	}
            } 
            return GlobalConstant.SAVE_SUCCESSED;
        }
		return GlobalConstant.SAVE_FAIL;  
	}

	@Override
	public List<SysDept> queryIrbDept() {
		SysUser currentUser = GlobalContext.getCurrentUser();
		SysDept dept = new SysDept();
		dept.setOrgFlow(currentUser.getOrgFlow());
		dept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		return this.deptBiz.searchDept(dept);
	}

	@Override
	public long queryTrainUserCount(PubTrainUser trainUser) {
		PubTrainUserExample example = new PubTrainUserExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(trainUser!=null){
			if(StringUtil.isNotBlank(trainUser.getTrainFlow())){
				criteria.andTrainFlowEqualTo(trainUser.getTrainFlow());
			}
		}
		return this.trainUserMapper.countByExample(example);
	}
	
	@Override
	public int saveTrainUser(String[] userFlows, PubTrain train){
		//培训信息
		train.setTrainCategoryName(IrbTrainCategoryEnum.getNameById(train.getTrainCategoryId().trim()));
		train.setTrainTypeName(IrbTrainTypeEnum.getNameById(train.getTrainTypeId()));
		trainBiz.saveTrain(train);
		//参培人员
		if(null != userFlows && userFlows.length >0){
			for(String flow : userFlows){
				//新增培训人员
				PubTrainUser user = new PubTrainUser();
				user.setTrainFlow(train.getTrainFlow());
				user.setUserFlow(flow);
				SysUser sysUser = sysUserMapper.selectByPrimaryKey(flow);
				if(sysUser != null){
					user.setUserName(sysUser.getUserName());
				}
				editUser(user);
			}			
		}
		return GlobalConstant.ONE_LINE;
	}
}
