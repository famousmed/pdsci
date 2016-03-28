package com.pinde.sci.biz.inx.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IinxColumnManageBiz;
import com.pinde.sci.biz.inx.IinxInfoManageBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.InxInfoMapper;
import com.pinde.sci.dao.inx.InxInfoExtMapper;
import com.pinde.sci.enums.inx.InfoStatusEnum;
import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.inx.InxInfoExt;
import com.pinde.sci.model.mo.InxColumn;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.InxInfoExample;
import com.pinde.sci.model.mo.InxInfoExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class InxInfoManageBizImpl implements IinxInfoManageBiz {
	@Resource
	private InxInfoMapper inxInfoMapper;
	@Resource
	private InxInfoExtMapper inxInfoExtMapper;
	@Autowired
	private IinxColumnManageBiz columnManageBiz;

	@Override
	public int save(InxInfo info) {
		info.setInfoFlow(PkUtil.getUUID());
		info.setInfoStatusId(InfoStatusEnum.Edit.getId());
		info.setInfoStatusName(InfoStatusEnum.Edit.getName());
		InxColumn col = columnManageBiz.getById(info.getColumnId());
		info.setColumnName(col.getColumnName());
		info.setViewNum(new Long(0));
		GeneralMethod.setRecordInfo(info, true);
		return this.inxInfoMapper.insert(info);
	}

	@Override
	public String uploadImg(HttpServletRequest request, String fileInputName) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile(fileInputName);
		String fileName = "";
		if(file!=null){
			List<String> mimeList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")))){
				mimeList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_mime")).split(","));
			}
			List<String> suffixList = new ArrayList<String>();
			if(StringUtil.isNotBlank(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")))){
				suffixList = Arrays.asList(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_support_suffix")).split(","));
			}
			
			String fileType = file.getContentType();//MIME类型;
			fileName = file.getOriginalFilename();//文件名
			String suffix = fileName.substring(fileName.lastIndexOf("."));//后缀名
			if(!(mimeList.contains(fileType)&&suffixList.contains(suffix))){
				return GlobalConstant.UPLOAD_IMG_TYPE_ERROR;
			}
			long limitSize = Long.parseLong(StringUtil.defaultString(InitConfig.getSysCfg("inx_image_limit_size")));//图片大小限制
			if(file.getSize()>limitSize*1024*1024){
				return GlobalConstant.UPLOAD_IMG_SIZE_ERROR +limitSize +"M" ;
			}
			try {
				/*创建目录*/
				String dateString = DateUtil.getCurrDate2();
				String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+"//titleImages//" + dateString ;
				File fileDir = new File(newDir);
				if(!fileDir.exists()){
					fileDir.mkdirs();
				}
				/*文件名*/
				fileName = file.getOriginalFilename();
				fileName = PkUtil.getUUID()+fileName.substring(fileName.lastIndexOf("."));
				File newFile = new File(fileDir, fileName); 
				file.transferTo(newFile);
				return "success:"+dateString+"/"+fileName;
			} catch (Exception e) {
				e.printStackTrace();
				return GlobalConstant.UPLOAD_FAIL;
			}
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	
	@Override
	public InxInfoExt getExtByFlow(String infoFlow) {
		return this.inxInfoExtMapper.selectExtByFlow(infoFlow);
	}

	@Override
	public String getImageBaseUrl() {
		String inxImageUrl = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_url"));
		if(StringUtil.isNotBlank(inxImageUrl)){
			String temp = String.valueOf(inxImageUrl.charAt(inxImageUrl.length()-1));
			if(!"/".equals(temp)){
				inxImageUrl = inxImageUrl+"/";			
			}
			inxImageUrl = inxImageUrl +"titleImages/";
			return inxImageUrl;
		}
		return null;
		
	}

	@Override
	public int update(InxInfo info) {
		if(info!=null){
			if(StringUtil.isNotBlank(info.getColumnId())){
				InxColumn col = columnManageBiz.getById(info.getColumnId());
				info.setColumnName(col.getColumnName());
			}
			GeneralMethod.setRecordInfo(info, false);
			return this.inxInfoMapper.updateByPrimaryKeySelective(info);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public InxInfo getByFlow(String infoFlow) {
		return this.inxInfoMapper.selectByPrimaryKey(infoFlow);
	}

	@Override
	public int updateInfoStatus(List<String> infoFlows, String infoStatusId) {
		InxInfoForm form = new InxInfoForm();
		form.setInfoFlows(infoFlows);
		form.setInfoStatusId(infoStatusId);
		form.setInfoStatusName(InfoStatusEnum.getNameById(infoStatusId));
		return this.inxInfoExtMapper.updateInfoState(form) ;
		
	}

	@Override
	public int deleteTitleImg(String infoFlow) {
		if(StringUtil.isNotBlank(infoFlow)){
			InxInfo info = getByFlow(infoFlow);
			if(info!=null){ //修改资讯时删除
				String img = info.getTitleImg();
				if(StringUtil.isNotBlank(img)){
					try {
						//img = img.replace("/", "\\");
						img = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+File.separator+"titleImages" +File.separator+img;
						File file = new File(img);
						if(file.exists()){
							boolean delRestlt =  file.delete();
							if(delRestlt){//删除成功
								info.setTitleImg(null);
								return this.inxInfoMapper.updateByPrimaryKey(info);
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
						return GlobalConstant.ZERO_LINE;
					}
					
				}
			}else{//新增资讯时删除
				try {
					String img = infoFlow;
					img = img.replace("/", "\\");
					img = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+"//titleImages//" + img;
					File file = new File(img);
					if(file.exists()){
						boolean delRestlt =  file.delete();
						if(delRestlt){
							return GlobalConstant.ONE_LINE;
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					return GlobalConstant.ZERO_LINE;
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<InxInfo> getList(InxInfoForm form) {
		InxInfoExample example = new InxInfoExample();
		Criteria criteria = example.createCriteria();
		criteria.andInfoStatusIdNotEqualTo(InfoStatusEnum.Failure.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(form.getRecordStatus())){
			criteria.andRecordStatusEqualTo(form.getRecordStatus());
		}
		if(StringUtil.isNotBlank(form.getColumnId())){
			criteria.andColumnIdEqualTo(form.getColumnId());
		}
		if(StringUtil.isNotBlank(form.getInfoTitle())){
			criteria.andInfoTitleLike("%"+form.getInfoTitle()+"%");
		}
		if(StringUtil.isNotBlank(form.getStartDate())){
			criteria.andInfoTimeGreaterThanOrEqualTo(form.getStartDate());
		}
		if(StringUtil.isNotBlank(form.getEndDate())){
			criteria.andInfoTimeLessThanOrEqualTo(form.getEndDate());
		}
		if(StringUtil.isNotBlank(form.getInfoStatusId())){
			criteria.andInfoStatusIdEqualTo(form.getInfoStatusId());
		}else{
			List<String> ids = new ArrayList<String>();
			ids.add(InfoStatusEnum.Edit.getId());
			ids.add(InfoStatusEnum.NoPassed.getId());
			criteria.andInfoStatusIdIn(ids);
		}
		example.setOrderByClause("IS_TOP DESC nulls last, INFO_TIME DESC, CREATE_TIME DESC");
		return this.inxInfoMapper.selectByExample(example);
	}

	@Override
	public int modifyInxInfo(InxInfo info) {
		if(StringUtil.isNotBlank(info.getInfoFlow())){
			GeneralMethod.setRecordInfo(info, false);
			return this.inxInfoMapper.updateByPrimaryKeySelective(info);
		}
		return GlobalConstant.ZERO_LINE;
	}

}
