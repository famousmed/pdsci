package com.pinde.sci.biz.erp.impl;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpDocBiz;
import com.pinde.sci.biz.erp.IErpDocLogBiz;
import com.pinde.sci.biz.erp.IErpDocShareBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ErpDocLogMapper;
import com.pinde.sci.dao.base.ErpDocMapper;
import com.pinde.sci.dao.base.ErpDocShareMapper;
import com.pinde.sci.dao.erp.ErpDocExtMapper;
import com.pinde.sci.dao.erp.ErpDocShareExtMapper;
import com.pinde.sci.enums.erp.ShareTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.ReqTypeEnum;
import com.pinde.sci.model.erp.ErpDocShareExt;
import com.pinde.sci.model.mo.ErpDoc;
import com.pinde.sci.model.mo.ErpDocLog;
import com.pinde.sci.model.mo.ErpDocLogExample;
import com.pinde.sci.model.mo.ErpDocShare;
import com.pinde.sci.model.mo.ErpDocShareExample;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.SysUser;
/**
 * 
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class IErpDocBizImpl implements IErpDocBiz, IErpDocShareBiz, IErpDocLogBiz{
	@Autowired
	private ErpDocMapper erpDocMapper;
	@Autowired
	private IFileBiz fileBiz;
	@Autowired
	private ErpDocExtMapper erpDocExtMapper;
	@Autowired
	private ErpDocShareMapper erpDocShareMapper;
	@Autowired
	private ErpDocLogMapper erpDocLogMapper;
	@Autowired
	private ErpDocShareExtMapper erpDocShareExtMapper;

	@Override
	public int saveErpDoc(ErpDoc erpDoc) {
		if(StringUtil.isNotBlank(erpDoc.getDocTypeId())){
			erpDoc.setDocTypeName(DictTypeEnum.DocType.getDictNameById(erpDoc.getDocTypeId()));
		}else{
			erpDoc.setDocTypeName("");
		}
		if(StringUtil.isBlank(erpDoc.getDocFlow())){
			erpDoc.setDocFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(erpDoc, true);
			return erpDocMapper.insert(erpDoc);
		}else{
			GeneralMethod.setRecordInfo(erpDoc, false);
			return erpDocMapper.updateByPrimaryKeySelective(erpDoc);
		}
	}

	@Override
	public int saveDocFile(MultipartFile multipartFile, ErpDoc erpDoc, String[] shareTypeId, String[] shareRecordFlow, String[] shareRecordName) {
		PubFile file = savePubFile(multipartFile);
		erpDoc.setFileFlow(file.getFileFlow());
		erpDoc.setFileName(file.getFileName());
		erpDoc.setDocName(file.getFileName());
		erpDoc.setFileType(file.getFileSuffix());
		StringBuffer recordNames = null;
		if(shareRecordFlow != null && shareRecordFlow.length > 0){
			saveErpDoc(erpDoc);
			String docFlow = erpDoc.getDocFlow();
			for(int i =0; i < shareRecordFlow.length; i++){
				ErpDocShare erpDocShare = new ErpDocShare();
				erpDocShare.setDocFlow(docFlow);
				erpDocShare.setShareTypeId(shareTypeId[i]);
				erpDocShare.setShareTypeName(ShareTypeEnum.getNameById(shareTypeId[i]));
				erpDocShare.setShareRecordFlow(shareRecordFlow[i]);
				erpDocShare.setShareRecordName(shareRecordName[i]);
				saveErpDocShare(erpDocShare);
				if(i==0){
					recordNames = new StringBuffer(shareRecordName[i]);
				}else{
					recordNames.append("、" + shareRecordName[i]);
				}
			}
		} else {
			saveErpDoc(erpDoc);
		}
		//添加操作日志
		//新增日志
		ErpDocLog addLog = new ErpDocLog();
		addLog.setDocFlow(erpDoc.getDocFlow());
		addLog.setReqTypeId(ReqTypeEnum.POST.getId());
		addLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.POST.getId()));
		String operName = "新建";
		addLog.setOperName(operName);
		addLog.setLogDesc(operName+"了文档");
		docLog(addLog);
		//共享日志
		if(recordNames != null){
			ErpDocLog shareLog = new ErpDocLog();
			shareLog.setDocFlow(erpDoc.getDocFlow());
			shareLog.setReqTypeId(ReqTypeEnum.POST.getId());
			shareLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.POST.getId()));
			String operName2 = "共享";
			shareLog.setOperName(operName2);
			shareLog.setLogDesc(operName2 + "了文档给："+ recordNames.toString());
			docLog(shareLog);
		}
		//查阅日志
		ErpDocLog viewLog = new ErpDocLog();
		viewLog.setDocFlow(erpDoc.getDocFlow());
		viewLog.setReqTypeId(ReqTypeEnum.GET.getId());
		viewLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.GET.getId()));
		String operName3 = "查阅";
		viewLog.setOperName(operName3);
		viewLog.setLogDesc(operName3 + "了文档");
		docLog(viewLog);
		return GlobalConstant.ONE_LINE;
	}
	
	/**
	 * 文件保存至PubFile
	 * @param multipartFile
	 * @return
	 */
	private PubFile savePubFile(MultipartFile multipartFile) {
		 PubFile file = new PubFile();
         String originalFileName = multipartFile.getOriginalFilename();
         String suffix =originalFileName.substring(originalFileName.lastIndexOf(".")+1); 
         //默认的文件名
         file.setFileName(originalFileName);
         //文件后缀名
         file.setFileSuffix(suffix);
         try {
             file.setFileContent(multipartFile.getBytes());
             fileBiz.editFile(file);
             return file;
         } catch (Exception e) {
             throw new RuntimeException("文件上传异常");
         } 
	}
	
	@Override
	public List<ErpDoc> searchErpDocList(Map<String, Object> paramMap) {
		return erpDocExtMapper.searchErpDocList(paramMap);
	}

	@Override
	public ErpDoc readErpDoc(String docFlow) {
		return erpDocMapper.selectByPrimaryKey(docFlow);
	}

	@Override
	public List<String> searchFileTypeList() {
		return erpDocExtMapper.searchFileTypeList();
	}

	@Override
	public int saveErpDocShare(ErpDocShare erpDocShare) {
		if(StringUtil.isBlank(erpDocShare.getRecordFlow())){
			erpDocShare.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(erpDocShare, true);
			return erpDocShareMapper.insert(erpDocShare);
		}else{
			GeneralMethod.setRecordInfo(erpDocShare, false);
			return erpDocShareMapper.updateByPrimaryKeySelective(erpDocShare);
		}
	}

	@Override
	public List<ErpDocShare> searchErpDocShareList(ErpDocShare docShare) {
		ErpDocShareExample example = new ErpDocShareExample();
		com.pinde.sci.model.mo.ErpDocShareExample.Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(docShare.getDocFlow())){
			criteria.andDocFlowEqualTo(docShare.getDocFlow());
		}
		if(StringUtil.isNotBlank(docShare.getShareTypeId())){
			criteria.andShareTypeIdEqualTo(docShare.getShareTypeId());
		}
		if(StringUtil.isNotBlank(docShare.getShareRecordFlow())){
			criteria.andShareRecordFlowEqualTo(docShare.getShareRecordFlow());
		}
		if(StringUtil.isNotBlank(docShare.getRecordStatus())){
			criteria.andRecordStatusEqualTo(docShare.getRecordStatus());
		}
		example.setOrderByClause("CREATE_TIME");
		return erpDocShareMapper.selectByExample(example);
	}

	@Override
	public ErpDocShare modifySingleDocShare(ErpDocShare docShare) {
		List<ErpDocShare> docShareList = searchErpDocShareList(docShare);
		ErpDocLog shareLog = new ErpDocLog();
		shareLog.setDocFlow(docShare.getDocFlow());
		shareLog.setReqTypeId(ReqTypeEnum.POST.getId());
		shareLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.POST.getId()));
		if(docShareList != null && !docShareList.isEmpty()){
			docShare = docShareList.get(0);
			if(GlobalConstant.RECORD_STATUS_Y.equals(docShare.getRecordStatus())){
				docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				String operName = "取消共享";
				shareLog.setOperName(operName);
				shareLog.setLogDesc("取消了" + docShare.getShareRecordName() + "的文档共享");
			}else{
				docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				String operName = "共享";
				shareLog.setOperName(operName);
				shareLog.setLogDesc(operName + "了文档给："+ docShare.getShareRecordName());
			}
		}else{
			docShare.setShareTypeName(ShareTypeEnum.getNameById(docShare.getShareTypeId()));
			String operName = "共享";
			shareLog.setOperName(operName);
			shareLog.setLogDesc(operName + "了文档给："+ docShare.getShareRecordName());
		}
		saveErpDocShare(docShare);
		docLog(shareLog);
		return docShare;
	}


	@Override
	public String batchShare(String[] docFlow, String shareTypeId, String shareRecordFlow, String shareRecordName, String recordStatus) {
		if(docFlow !=null && docFlow.length>0){
			SysUser currUser = GlobalContext.getCurrentUser();
			String userFlow = currUser.getUserFlow();
			for(int i = 0; i < docFlow.length; i++){
				ErpDocShare docShare = new ErpDocShare();
				docShare.setDocFlow(docFlow[i]);
				docShare.setShareTypeId(shareTypeId);
				docShare.setShareRecordFlow(shareRecordFlow);
				docShare.setCreateUserFlow(userFlow);
				List<ErpDocShare> docShareList = searchErpDocShareList(docShare);
				ErpDocLog shareLog = new ErpDocLog();
				shareLog.setDocFlow(docShare.getDocFlow());
				shareLog.setReqTypeId(ReqTypeEnum.POST.getId());
				shareLog.setReqTypeName(ReqTypeEnum.getNameById(ReqTypeEnum.POST.getId()));
				if(GlobalConstant.RECORD_STATUS_Y.equals(recordStatus)){
					if(docShareList != null && !docShareList.isEmpty()){
						docShare = docShareList.get(0);
						if(GlobalConstant.RECORD_STATUS_N.equals(docShare.getRecordStatus())){
							docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
							String operName = "共享";
							shareLog.setOperName(operName);
							shareLog.setLogDesc(operName + "了文档给："+ docShare.getShareRecordName());
							saveErpDocShare(docShare);
							docLog(shareLog);
						}
					}else{
						docShare.setShareRecordName(shareRecordName);
						docShare.setShareTypeName(ShareTypeEnum.getNameById(shareTypeId));
						String operName = "共享";
						shareLog.setOperName(operName);
						shareLog.setLogDesc(operName + "了文档给："+ docShare.getShareRecordName());
						saveErpDocShare(docShare);
						docLog(shareLog);
					}
				}else{
					if(docShareList != null && !docShareList.isEmpty()){
						docShare = docShareList.get(0);
						if(docShare.getCreateUserFlow().equals(userFlow) && GlobalConstant.RECORD_STATUS_Y.equals(docShare.getRecordStatus())){
							docShare.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
							String operName = "取消共享";
							shareLog.setOperName(operName);
							shareLog.setLogDesc("取消了" + docShare.getShareRecordName() + "的文档共享");
							saveErpDocShare(docShare);
							docLog(shareLog);
						}
					}
				}
			}
			return recordStatus;
		}
		return null;
	}

	@Override
	public int docLog(ErpDocLog docLog) {
		SysUser currUser = GlobalContext.getCurrentUser();
		docLog.setUserFlow(currUser.getUserFlow());
		docLog.setUserName(currUser.getUserName());
		docLog.setOrgFlow(currUser.getOrgFlow());
		docLog.setOrgName(currUser.getOrgName());
		docLog.setDeptFlow(currUser.getDeptFlow());
		docLog.setDeptName(currUser.getDeptName());
		docLog.setLogTime(DateUtil.getCurrDateTime());
		return save(docLog);
	}

	@Override
	public int save(ErpDocLog docLog) {
		if(StringUtil.isBlank(docLog.getLogFlow())){
			docLog.setLogFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(docLog, true);
			return erpDocLogMapper.insert(docLog);
		}else{
			GeneralMethod.setRecordInfo(docLog, false);
			return erpDocLogMapper.updateByPrimaryKeySelective(docLog);
		}
	}

	@Override
	public List<ErpDocLog> searchErpDocLogList(ErpDocLog docLog) {
		ErpDocLogExample example = new ErpDocLogExample();
		com.pinde.sci.model.mo.ErpDocLogExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(docLog.getDocFlow())){
			criteria.andDocFlowEqualTo(docLog.getDocFlow());
		}
		if(StringUtil.isNotBlank(docLog.getReqTypeId())){
			criteria.andReqTypeIdEqualTo(docLog.getReqTypeId());
		}
		example.setOrderByClause("LOG_TIME DESC");
		return erpDocLogMapper.selectByExample(example);
	}

	@Override
	public int modifyErpDoc(ErpDoc erpDoc) {
		ErpDocLog docLog = new ErpDocLog();
		docLog.setReqTypeId(ReqTypeEnum.PUT.getId());
		String operName = ReqTypeEnum.getNameById(docLog.getReqTypeId());
		docLog.setReqTypeName(operName);
		docLog.setOperName(operName);
		docLog.setDocFlow(erpDoc.getDocFlow());
		ErpDoc existDoc = readErpDoc(erpDoc.getDocFlow());
		if(existDoc != null){
			if(null != erpDoc.getDocName()){
				if(null == existDoc.getDocSummary()){
					docLog.setLogDesc("将文档名称修改为\""+ erpDoc.getDocName() + "\"");
				}else{
					docLog.setLogDesc("将文档名称\"" + existDoc.getDocName() +"\"修改为\""+ erpDoc.getDocName() + "\"");
				}
			}
			else if(null != erpDoc.getDocSummary()){
				docLog.setLogDesc("修改了文档摘要");
			}
			else if(null != erpDoc.getDocTypeId()){
				if(StringUtil.isNotBlank(erpDoc.getDocTypeId())){
					erpDoc.setDocTypeName(DictTypeEnum.DocType.getDictNameById(erpDoc.getDocTypeId()));
				}else{
					erpDoc.setDocTypeName("");
				}
				if(null == existDoc.getDocTypeName()){
					docLog.setLogDesc("将文档类型修改为\""+ erpDoc.getDocTypeName() + "\"");
				}else{
					docLog.setLogDesc("将文档类型\"" + existDoc.getDocTypeName() +"\"修改为\""+ erpDoc.getDocTypeName() + "\"");
				}
			}
			else if(StringUtil.isNotBlank(erpDoc.getIsPublic())){
				if(GlobalConstant.RECORD_STATUS_Y.equals(erpDoc.getIsPublic())){
					docLog.setLogDesc("将公共文档修改为\"是\"");
				}else{
					docLog.setLogDesc("将公共文档修改为\"否\"");
				}
			}
		}
		docLog(docLog);
		return saveErpDoc(erpDoc);
	}

	@Override
	public int batchDelByDocFlowList(List<String> docFlowList) {
		if(docFlowList != null && !docFlowList.isEmpty()){
			return erpDocExtMapper.batchDelByDocFlowList(docFlowList);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<ErpDocShareExt> searchErpDocShareExtList(Map<String, Object> paramMap) {
		return erpDocShareExtMapper.searchErpDocShareExtList(paramMap);
	}
}
