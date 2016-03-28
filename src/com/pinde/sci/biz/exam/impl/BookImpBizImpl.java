package com.pinde.sci.biz.exam.impl;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Set;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.CodeUtil;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IBookImpBiz;
import com.pinde.sci.biz.exam.IBookManageBiz;
import com.pinde.sci.biz.exam.IQuestionManageBiz;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForBL;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForCommon;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForHaveQuestionAnswer;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForImg;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForNoQuestionAnswer;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForPW;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForQuestionAnswer;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyForTK;
import com.pinde.sci.biz.exam.interceptor.QuestionVerifyInterceptor;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.ExamBookComposInfoMapper;
import com.pinde.sci.dao.base.ExamBookImpDetailMapper;
import com.pinde.sci.dao.base.ExamBookImpMapper;
import com.pinde.sci.dao.base.ExamBookRecognizeInfoMapper;
import com.pinde.sci.dao.base.ExamBookReloadRecMapper;
import com.pinde.sci.dao.base.ExamBookScanInfoMapper;
import com.pinde.sci.dao.base.ExamBookSubjectMapper;
import com.pinde.sci.dao.base.ExamQuestionBookMapper;
import com.pinde.sci.dao.base.ExamQuestionDetailMapper;
import com.pinde.sci.dao.base.ExamQuestionMapper;
import com.pinde.sci.dao.base.ExamQuestionSubjectMapper;
import com.pinde.sci.dao.exam.ExamBookImpExtMapper;
import com.pinde.sci.dao.exam.ExamQuestionExtMapper;
import com.pinde.sci.enums.exam.BookImpStatusEnum;
import com.pinde.sci.enums.exam.BookRegistStatusEnum;
import com.pinde.sci.enums.exam.QuestionTypeEnum;
import com.pinde.sci.model.exam.ExamBookImpExt;
import com.pinde.sci.model.exam.ExamBookRegistInfo;
import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookComposInfo;
import com.pinde.sci.model.mo.ExamBookComposInfoExample;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamBookImpDetail;
import com.pinde.sci.model.mo.ExamBookImpDetailExample;
import com.pinde.sci.model.mo.ExamBookImpExample;
import com.pinde.sci.model.mo.ExamBookImpExample.Criteria;
import com.pinde.sci.model.mo.ExamBookRecognizeInfo;
import com.pinde.sci.model.mo.ExamBookRecognizeInfoExample;
import com.pinde.sci.model.mo.ExamBookReloadRec;
import com.pinde.sci.model.mo.ExamBookReloadRecExample;
import com.pinde.sci.model.mo.ExamBookScanInfo;
import com.pinde.sci.model.mo.ExamBookScanInfoExample;
import com.pinde.sci.model.mo.ExamBookSubject;
import com.pinde.sci.model.mo.ExamBookSubjectExample;
import com.pinde.sci.model.mo.ExamQuestion;
import com.pinde.sci.model.mo.ExamQuestionBook;
import com.pinde.sci.model.mo.ExamQuestionBookExample;
import com.pinde.sci.model.mo.ExamQuestionDetail;
import com.pinde.sci.model.mo.ExamQuestionDetailExample;
import com.pinde.sci.model.mo.ExamQuestionDetailWithBLOBs;
import com.pinde.sci.model.mo.ExamQuestionExample;
import com.pinde.sci.model.mo.ExamQuestionSubject;
import com.pinde.sci.model.mo.ExamQuestionSubjectExample;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class BookImpBizImpl implements IBookImpBiz{

	@Autowired
	private ExamBookImpMapper examBookImpMapper;
	@Autowired
	private ExamBookImpDetailMapper examBookImpDetailMapper;
	@Autowired
	private ExamBookImpExtMapper examBookImpExtMapper;
	@Autowired
	private ExamBookSubjectMapper bookSubjectMapper;
	@Autowired
	private IQuestionManageBiz questionSerivce;
	@Autowired
	private ExamQuestionMapper questionMapper;
	@Autowired
	private ExamQuestionDetailMapper questionDetailMapper;
	@Autowired
	private ExamQuestionBookMapper questionBookMapper;
	@Autowired
	private ExamQuestionSubjectMapper questionSubjectMapper;
	@Autowired
	private IBookManageBiz bookManageBiz;
	@Autowired
	private ExamBookScanInfoMapper bookScanInfoMapper;
	@Autowired
	private ExamBookRecognizeInfoMapper bookRecognizeInfoMapper;
	@Autowired
	private ExamBookComposInfoMapper bookComposInfoMapper;
	@Autowired
	private ExamQuestionExtMapper questionExtMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private ExamBookReloadRecMapper bookReloadRecMapper;
	
	private static Logger logger = LoggerFactory.getLogger("RELOADQUESTIONLOG");

	@Override
	public List<ExamBookImp> search(ExamBookImp imp) {
		ExamBookImpExample example = new ExamBookImpExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(imp.getBookImpFlow())){
			criteria.andBookImpFlowEqualTo(imp.getBookImpFlow());
		}
		if(StringUtil.isNotBlank(imp.getBookFlow())){
			criteria.andBookFlowEqualTo(imp.getBookFlow());
		}
		if(StringUtil.isNotBlank(imp.getRecordStatus())){
			criteria.andRecordStatusEqualTo(imp.getRecordStatus());
		}
		return examBookImpMapper.selectByExample(example);
	}

	@Override
	public void addImp(ExamBookImp imp, List<ExamBookImpDetail> impDetailList) {
		String bookImpFlow = imp.getBookImpFlow();
		SysUser currUser = GlobalContext.getCurrentUser();
		imp.setImpUserFlow(currUser.getUserFlow());
		imp.setImpUserName(currUser.getUserName());
		imp.setImpTime(DateUtil.getCurrDateTime());
		imp.setStatusId(BookImpStatusEnum.Save.getId());
		imp.setStatusDesc(BookImpStatusEnum.Save.getName());
		GeneralMethod.setRecordInfo(imp, true);
		examBookImpMapper.insertSelective(imp);		
		
		for(ExamBookImpDetail detail : impDetailList){
			detail.setImpDetailFlow(PkUtil.getUUID());
			detail.setBookImpFlow(bookImpFlow);
			GeneralMethod.setRecordInfo(detail, true);
			examBookImpDetailMapper.insert(detail);
		}
	}

	@Override
	public List<ExamBookImpDetail> searchDetail(String bookImpFlow) {
		ExamBookImpDetailExample example = new ExamBookImpDetailExample();
		example.createCriteria().andBookImpFlowEqualTo(bookImpFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return examBookImpDetailMapper.selectByExample(example);
	}
	
	@Override
	public List<ExamBookImpDetail> searchDetail(ExamBookImpDetail bookImpDetail) {
		ExamBookImpDetailExample example = new ExamBookImpDetailExample();
		com.pinde.sci.model.mo.ExamBookImpDetailExample.Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(bookImpDetail.getImpDetailFlow())){
			criteria.andImpDetailFlowEqualTo(bookImpDetail.getImpDetailFlow());
		}
		if(StringUtil.isNotBlank(bookImpDetail.getBookImpFlow())){
			criteria.andBookImpFlowEqualTo(bookImpDetail.getBookImpFlow());
		}
		if(StringUtil.isNotBlank(bookImpDetail.getQuestionTypeId())){
			criteria.andQuestionTypeIdEqualTo(bookImpDetail.getQuestionTypeId());
		}
		if(StringUtil.isNotBlank(bookImpDetail.getRecordStatus())){
			criteria.andRecordStatusEqualTo(bookImpDetail.getRecordStatus());
		}
		if(StringUtil.isNotBlank(bookImpDetail.getBookFlow())){
			criteria.andBookFlowEqualTo(bookImpDetail.getBookFlow());
		}
		return examBookImpDetailMapper.selectByExample(example);
	}
	
	@Override
	public List<ExamBookImpDetail> searchDetailWithFileContent(String bookImpFlow) {
		ExamBookImpDetailExample example = new ExamBookImpDetailExample();
		example.createCriteria().andBookImpFlowEqualTo(bookImpFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return examBookImpDetailMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public void submit(String bookImpFlow) {
		ExamBookImp imp = new ExamBookImp();
		imp.setBookImpFlow(bookImpFlow);
		imp.setStatusId(BookImpStatusEnum.Submit.getId());
		imp.setStatusDesc(BookImpStatusEnum.Submit.getName());
		GeneralMethod.setRecordInfo(imp, false);
		examBookImpMapper.updateByPrimaryKeySelective(imp);
		
	}

	@Override
	public void parseQuestionFile(ExamBookImpDetail detail,
			MultipartFile questionTypeFile) {
		InputStream inputStream = null;
		try{
			detail.setQuestionFile(questionTypeFile.getBytes());
			inputStream = questionTypeFile.getInputStream();
			String text = IOUtils.toString(inputStream);
			String [] questionUtils = text.split("(\r?\n(\\s*\r?\n)+)");
			detail.setQuestionNum(questionUtils.length);
		}catch(IOException e){
			throw new RuntimeException(e.getMessage());
		}finally{
			if(inputStream!=null){
				try {
					inputStream.close();
				} catch (IOException e) {
					throw new RuntimeException(e.getMessage());
				}
			}
			
		}
		
	}

	@Override
	public List<ExamBookImpExt> search(ExamBookImpExt impExt) {
		return this.examBookImpExtMapper.selectExamBookImp(impExt);
	}

	@Override
	public void operate(ExamBookImp bookImp) {
    	String statusName = BookImpStatusEnum.getNameById(bookImp.getStatusId());
    	bookImp.setStatusDesc(statusName);
    	if(BookImpStatusEnum.Checked.getId().equals(bookImp.getStatusId()) || BookImpStatusEnum.NotChecked.getId().equals(bookImp.getStatusId())){
    		this.checked(bookImp);
    	}else if(BookImpStatusEnum.Audited.getId().equals(bookImp.getStatusId()) || BookImpStatusEnum.NotAudited.getId().equals(bookImp.getStatusId())){
    		
    		try{
    			this.audited(bookImp);
    		}catch(Exception e){
    			e.printStackTrace();
    			throw new RuntimeException(e.getMessage());
    		}
    	}
    	
	}
	
	private void checked(ExamBookImp bookImp){
		//设置校验人和校验时间
		SysUser currUser = GlobalContext.getCurrentUser();
		bookImp.setCheckUserFlow(currUser.getUserFlow());
		bookImp.setCheckUserName(currUser.getUserName());
		bookImp.setCheckTime(DateUtil.getCurrDateTime());
		this.examBookImpMapper.updateByPrimaryKeySelective(bookImp);
		System.out.println("更新成功，线程名称："+Thread.class.getName()+"更新人："+currUser.getUserName());
	}
	
	private void audited(ExamBookImp bookImp){
		//设置审核人和审核时间
		SysUser currUser = GlobalContext.getCurrentUser();
		bookImp.setAuditUserFlow(currUser.getUserFlow());
		bookImp.setAuditUserName(currUser.getUserName());
		bookImp.setAuditTime(DateUtil.getCurrDateTime());
		this.examBookImpMapper.updateByPrimaryKeySelective(bookImp);
		
		if(BookImpStatusEnum.Audited.getId().equals(bookImp.getStatusId())){
			bookImp = this.examBookImpMapper.selectByPrimaryKey(bookImp.getBookImpFlow());
            //如果审核通过
			if(StringUtil.isNotBlank(bookImp.getBookFlow()) && StringUtil.isNotBlank(bookImp.getSubjectFlow())){
				//判断该关联是否存在
				//String bookSubjectFlow = bookImp.getBookFlow()+"_"+bookImp.getSubjectFlow();
				//ExamBookSubject bookSubject = this.bookSubjectMapper.selectByPrimaryKey(bookSubjectFlow);
				
				ExamBookSubjectExample bookSubjectExample = new ExamBookSubjectExample();
				bookSubjectExample.createCriteria()
				.andBookFlowEqualTo(bookImp.getBookFlow())
				.andSubjectFlowEqualTo(bookImp.getSubjectFlow())
				.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
				List<ExamBookSubject> bookSubjects = this.bookSubjectMapper.selectByExample(bookSubjectExample );
				//如果关联不存在就新增一条
				if(bookSubjects==null || bookSubjects.isEmpty()){
					ExamBookSubject bookSubject = new ExamBookSubject();
					bookSubject = new ExamBookSubject();
					bookSubject.setBookSubjectFlow(PkUtil.getUUID());
					bookSubject.setBookFlow(bookImp.getBookFlow());
					bookSubject.setSubjectFlow(bookImp.getSubjectFlow());
					GeneralMethod.setRecordInfo(bookSubject, true);
					this.bookSubjectMapper.insert(bookSubject);
				}
			}
				
				//构造question
				ExamBookImpDetailExample example = new ExamBookImpDetailExample();
				example.createCriteria().andBookImpFlowEqualTo(bookImp.getBookImpFlow())
				.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
				List<ExamBookImpDetail> examBookImpDetails = this.examBookImpDetailMapper.selectByExampleWithBLOBs(example);
				//存放该次审核所有需要入库的题目
				Map<String , List<ExamQuestionExt>> allQuestionDatas = new HashMap<String, List<ExamQuestionExt>>();
				//分别解析每种题型的题目
				for(ExamBookImpDetail bookImpDetail:examBookImpDetails){
			    	List<ExamQuestionExt> questionExts = this.createQuestions(bookImpDetail, bookImp);
			    	allQuestionDatas.put(bookImpDetail.getQuestionTypeId(), questionExts);
					
				}
				
				//所有题型解析完毕后做插入操作
				Set<String> questionTypeIds = allQuestionDatas.keySet();
				for(String typeId:questionTypeIds){
					List<ExamQuestionExt> questionExts = allQuestionDatas.get(typeId);
					//新增题目
					for(ExamQuestionExt questionExt:questionExts){
						//计算题目的code
						String code = this.getQuestionCode(questionExt.getQuestionContent(), questionExt.getQuestionAnswer() , questionExt.getRightAnswer());
						questionExt.setQuestionCode(code);
						GeneralMethod.setRecordInfo(questionExt, true);
						this.questionMapper.insertSelective(questionExt);
						if(questionExt.getQuestionDetails()!=null && !questionExt.getQuestionDetails().isEmpty()){
			    			List<ExamQuestionDetailWithBLOBs> questionDetails = questionExt.getQuestionDetails();
			    			//新增题目子类型
			    			for(ExamQuestionDetailWithBLOBs questionDetail:questionDetails){
			    				questionDetail.setQuestionFlow(questionExt.getQuestionFlow());
			    				questionDetail.setParentQuestionCode(questionExt.getQuestionCode());
			    				//计算子题code
			    				String detailCode = this.getQuestionCode(questionDetail.getQuestionContent(), questionDetail.getQuestionAnswer(), questionDetail.getRightAnswer());
			    				questionDetail.setQuestionCode(detailCode);
			    				GeneralMethod.setRecordInfo(questionDetail, true);
			    				questionDetailMapper.insert(questionDetail);
			    			}
			    		}
						//新增题目和书的关联关系
						if(StringUtil.isNotBlank(questionExt.getCreateBookFlow())){
							ExamQuestionBook record = new ExamQuestionBook();
							//record.setQuestionBookFlow(questionExt.getQuestionFlow()+"_"+questionExt.getCreateBookFlow());
							record.setQuestionBookFlow(PkUtil.getUUID());
							record.setQuestionFlow(questionExt.getQuestionFlow());
							record.setBookFlow(questionExt.getCreateBookFlow());
							record.setSubjectFlow(questionExt.getCreateSubjectFlow());
							record.setQuestionCode(questionExt.getQuestionCode());
							GeneralMethod.setRecordInfo(record, true);
							this.questionBookMapper.insertSelective(record);
						}
						//新增题目和科目的关联关系
						if(StringUtil.isNotBlank(questionExt.getCreateSubjectFlow())){
							ExamQuestionSubject record = new ExamQuestionSubject();
							//record.setQuestionSubjectFlow(questionExt.getQuestionFlow()+"_"+questionExt.getCreateSubjectFlow());
							record.setQuestionSubjectFlow(PkUtil.getUUID());
							record.setQuestionFlow(questionExt.getQuestionFlow());
							record.setSubjectFlow(questionExt.getCreateSubjectFlow());
							record.setBookFlow(questionExt.getCreateBookFlow());
							record.setQuestionCode(questionExt.getQuestionCode());
							GeneralMethod.setRecordInfo(record, true);
							this.questionSubjectMapper.insertSelective(record);
						}
					}
				}
				
			
    	}
	}

	/**
	 * 计算试题的code
	 * @param questionContent
	 * @param questionAnswer
	 * @return
	 */
	private String getQuestionCode(String questionContent , String questionAnswer , String trueAnswer){
		String questionCode = "";
		String content1 = StringUtil.defaultString(questionContent).trim();
		String solu = StringUtil.defaultString(questionAnswer).trim();
		String trueSolu = StringUtil.defaultString(trueAnswer).trim();
		questionCode = CodeUtil.md5(content1+solu+trueSolu);
		return questionCode;
	}
	
	@Override
	public ExamBookImpExt findExamBookImpByExamBookImpFlow(String bookImpFlow) {
		ExamBookImpExt impExt = new ExamBookImpExt();
		impExt.setBookImpFlow(bookImpFlow);
		impExt.setRecordStatus(GlobalConstant.FLAG_Y);
		List<ExamBookImpExt> bookImpExt = this.search(impExt);
		if(bookImpExt.size()==1){
			return bookImpExt.get(0); 
		}
		return new ExamBookImpExt();
	}

	@Override
	public void modifyImp(ExamBookImp imp, List<ExamBookImpDetail> impDetailList) {
		GeneralMethod.setRecordInfo(imp, false);
		this.examBookImpMapper.updateByPrimaryKeySelective(imp);
		ExamBookImpDetailExample example = new ExamBookImpDetailExample();
		example.createCriteria().andBookImpFlowEqualTo(imp.getBookImpFlow()).
		andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		List<ExamBookImpDetail> existsBookImpDetails = this.examBookImpDetailMapper.selectByExample(example);
		Map<String , ExamBookImpDetail> impDetailMap = new HashMap<String, ExamBookImpDetail>();
		//list转map 方便对比
		for(ExamBookImpDetail detail:existsBookImpDetails){
			impDetailMap.put(detail.getQuestionTypeId(), detail);
		}
		for(ExamBookImpDetail detail : impDetailList){
			//判断是新增还是修改
			if(impDetailMap.get(detail.getQuestionTypeId())!=null){
				//修改
				ExamBookImpDetail existsDetail = impDetailMap.get(detail.getQuestionTypeId());
				String bookImpDetailFlow = existsDetail.getImpDetailFlow();
				detail.setImpDetailFlow(bookImpDetailFlow);
				detail.setBookImpFlow(imp.getBookImpFlow());
				detail.setRecordStatus(GlobalConstant.FLAG_Y);
				detail.setCreateTime(existsDetail.getCreateTime());
				detail.setCreateUserFlow(existsDetail.getCreateUserFlow());
				GeneralMethod.setRecordInfo(detail, false);
				examBookImpDetailMapper.updateByPrimaryKeyWithBLOBs(detail);
			}else{
				//新增
				detail.setImpDetailFlow(PkUtil.getUUID());
				detail.setBookImpFlow(imp.getBookImpFlow());
				GeneralMethod.setRecordInfo(detail, true);
				examBookImpDetailMapper.insert(detail);
			}
			
		}
		
	}
	
	@Override
	public void reuploadQuestion(String impDetailFlow , MultipartFile questionFile) {
		SysUser currUser = GlobalContext.getCurrentUser();
		
		ExamBookImpDetail impDetail = this.examBookImpDetailMapper.selectByPrimaryKey(impDetailFlow);
		try {
			impDetail.setQuestionFile(questionFile.getBytes());
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
		GeneralMethod.setRecordInfo(impDetail, false);
		//设置题目个数
		this.parseQuestionFile(impDetail, questionFile);
		this.examBookImpDetailMapper.updateByPrimaryKeyWithBLOBs(impDetail);
		String questionTypeId = impDetail.getQuestionTypeId();
		String bookImpFlow = impDetail.getBookImpFlow();
		ExamBookImp bookImp = this.examBookImpMapper.selectByPrimaryKey(bookImpFlow);
		String bookFlow = bookImp.getBookFlow();
		
		logger.info("重传试题操作开始时间"+DateUtil.getCurrDateTime("yyyy-MM-dd HH:mm")+"--操作人:"+currUser.getUserName()+"--书目flow:"+bookFlow+"--题型:"+QuestionTypeEnum.getNameById(questionTypeId)+"--memo:"+bookImp.getBookName());
		
		List<String> exitQuestionCodes = new ArrayList<String>();
		List<String> needDelQuestionCodes = new ArrayList<String>();
		Map<String , List<String>> questionDetailCodes = new HashMap<String, List<String>>();
		List<String> subquestionCodes = new ArrayList<String>();
		List<ExamQuestionDetail> needDelSubquestion = new ArrayList<ExamQuestionDetail>();
		
		//查询该本书下该种题型的所有题目
		ExamQuestionExample questionExample = new ExamQuestionExample();
		questionExample.createCriteria()
		.andCreateBookFlowEqualTo(bookFlow)
		.andQuestionTypeIdEqualTo(questionTypeId)
		.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		List<ExamQuestion> questions = this.questionMapper.selectByExample(questionExample);
		//查询题目的子题
		for(ExamQuestion question:questions){
			exitQuestionCodes.add(question.getQuestionCode());
			needDelQuestionCodes.add(question.getQuestionCode());
			ExamQuestionDetailExample questionDetailExample = new ExamQuestionDetailExample();
			questionDetailExample.createCriteria()
			.andQuestionFlowEqualTo(question.getQuestionFlow())
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			List<ExamQuestionDetail> questionDetails = this.questionDetailMapper.selectByExample(questionDetailExample );
			subquestionCodes = new ArrayList<String>();
			for(ExamQuestionDetail questionDetail:questionDetails){
				subquestionCodes.add(questionDetail.getQuestionCode());
				needDelSubquestion.add(questionDetail);
			}
			questionDetailCodes.put(question.getQuestionCode(), subquestionCodes);
		}
		
		//存放该次重传所有需要入库的题目
		Map<String , List<ExamQuestionExt>> allQuestionDatas = new HashMap<String, List<ExamQuestionExt>>();
		//分别解析每种题型的题目
	    List<ExamQuestionExt> questionExtDatas = this.createQuestions(impDetail, bookImp);
	    allQuestionDatas.put(impDetail.getQuestionTypeId(), questionExtDatas);
		//所有题型解析完毕后做相应的操作
		Set<String> questionTypeIds = allQuestionDatas.keySet();
		for(String typeId:questionTypeIds){
			List<ExamQuestionExt> questionExts = allQuestionDatas.get(typeId);
			for(ExamQuestionExt questionExt:questionExts){
				//计算题目的code
				String code = this.getQuestionCode(questionExt.getQuestionContent(), questionExt.getQuestionAnswer() , questionExt.getRightAnswer());
				questionExt.setQuestionCode(code);
				if(exitQuestionCodes.contains(code)){
					//防止删除重题
					List<String> questiontmp = new ArrayList<String>();
					questiontmp.add(code);
				    needDelQuestionCodes.removeAll(questiontmp);
					//处理子题
					if(questionExt.getQuestionDetails()!=null && !questionExt.getQuestionDetails().isEmpty()){
		    			List<ExamQuestionDetailWithBLOBs> questionDetails = questionExt.getQuestionDetails();
		    			//题目子类型
		    			for(ExamQuestionDetailWithBLOBs questionDetail:questionDetails){
		    				//计算子题code
		    				String detailCode = this.getQuestionCode(questionDetail.getQuestionContent(), questionDetail.getQuestionAnswer(), questionDetail.getRightAnswer());
		    				questionDetail.setQuestionCode(detailCode);
		    				List<String> subQuestionCodes = questionDetailCodes.get(code);
		    				if(subQuestionCodes!=null && subQuestionCodes.contains(detailCode)){
		    					Iterator<ExamQuestionDetail> needDelSubuestionIterator =  needDelSubquestion.iterator();
		    					while(needDelSubuestionIterator.hasNext()){
		    						ExamQuestionDetail needDelQuestionDet = needDelSubuestionIterator.next();
		    						if(detailCode.equals(needDelQuestionDet.getQuestionCode())){
		    							//needDelSubquestion.remove(needDelQuestionDet);
		    							needDelSubuestionIterator.remove();
		    						}
		    					}
		    					
		    				}else{
		    					ExamQuestionExample example = new ExamQuestionExample();
		    					example.createCriteria().andQuestionCodeEqualTo(code).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
								ExamQuestion exitQuestion = this.questionMapper.selectByExample(example).get(0);
		    					questionDetail.setQuestionFlow(exitQuestion.getQuestionFlow());
			    				questionDetail.setParentQuestionCode(code);
		    					GeneralMethod.setRecordInfo(questionDetail, true);
			    				questionDetailMapper.insert(questionDetail);
			    				logger.info("插入子题--flow:"+questionDetail.getDetailFlow()+"--parentCode:"+code+"--code:"+detailCode);
		    				}
		    			}
		    		}
				}else{
					//主题code不存在就新增
					GeneralMethod.setRecordInfo(questionExt, true);
					this.questionMapper.insertSelective(questionExt);
					logger.info("插入主题--flow:"+questionExt.getQuestionFlow()+"--code:"+questionExt.getQuestionCode());
					if(questionExt.getQuestionDetails()!=null && !questionExt.getQuestionDetails().isEmpty()){
		    			List<ExamQuestionDetailWithBLOBs> questionDetails = questionExt.getQuestionDetails();
		    			//新增题目子类型
		    			for(ExamQuestionDetailWithBLOBs questionDetail:questionDetails){
		    				questionDetail.setQuestionFlow(questionExt.getQuestionFlow());
		    				questionDetail.setParentQuestionCode(questionExt.getQuestionCode());
		    				//计算子题code
		    				String detailCode = this.getQuestionCode(questionDetail.getQuestionContent(), questionDetail.getQuestionAnswer(), questionDetail.getRightAnswer());
		    				questionDetail.setQuestionCode(detailCode);
		    				GeneralMethod.setRecordInfo(questionDetail, true);
		    				questionDetailMapper.insert(questionDetail);
		    				logger.info("插入子题--flow:"+questionDetail.getDetailFlow()+"--parentCode:"+code+"--code:"+detailCode);
		    			}
		    		}
					//新增题目和书的关联关系
					if(StringUtil.isNotBlank(questionExt.getCreateBookFlow())){
						ExamQuestionBook record = new ExamQuestionBook();
						//record.setQuestionBookFlow(questionExt.getQuestionFlow()+"_"+questionExt.getCreateBookFlow());
						record.setQuestionBookFlow(PkUtil.getUUID());
						record.setQuestionFlow(questionExt.getQuestionFlow());
						record.setBookFlow(questionExt.getCreateBookFlow());
						record.setSubjectFlow(questionExt.getCreateSubjectFlow());
						record.setQuestionCode(questionExt.getQuestionCode());
						GeneralMethod.setRecordInfo(record, true);
						this.questionBookMapper.insertSelective(record);
					}
					//新增题目和科目的关联关系
					if(StringUtil.isNotBlank(questionExt.getCreateSubjectFlow())){
						ExamQuestionSubject record = new ExamQuestionSubject();
						//record.setQuestionSubjectFlow(questionExt.getQuestionFlow()+"_"+questionExt.getCreateSubjectFlow());
						record.setQuestionSubjectFlow(PkUtil.getUUID());
						record.setQuestionFlow(questionExt.getQuestionFlow());
						record.setSubjectFlow(questionExt.getCreateSubjectFlow());
						record.setBookFlow(questionExt.getCreateBookFlow());
						record.setQuestionCode(questionExt.getQuestionCode());
						GeneralMethod.setRecordInfo(record, true);
						this.questionSubjectMapper.insertSelective(record);
					}
				}
				
		    }
	    }
	   	
		if(!needDelQuestionCodes.isEmpty()){
			//删除主题
			ExamQuestionExample delQuestionExample = new ExamQuestionExample();
			delQuestionExample.createCriteria().andCreateBookFlowEqualTo(bookFlow).andQuestionCodeIn(needDelQuestionCodes);
			ExamQuestionWithBLOBs record = new ExamQuestionWithBLOBs();
			record.setRecordStatus(GlobalConstant.FLAG_N);
			this.questionMapper.updateByExampleSelective(record , delQuestionExample);
			
			logger.info("删除主题--删除个数:"+needDelQuestionCodes.size()+"--删除的code:"+needDelQuestionCodes);
			
			//删除书目和题目的关联
			ExamQuestionBookExample questionBookExample = new ExamQuestionBookExample();
			questionBookExample.createCriteria()
			.andQuestionCodeIn(needDelQuestionCodes)
			.andBookFlowEqualTo(bookFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			ExamQuestionBook questionBook = new ExamQuestionBook();
			questionBook.setRecordStatus(GlobalConstant.FLAG_N);
			this.questionBookMapper.updateByExampleSelective(questionBook, questionBookExample);
			
			//删除科目和题目的关联
			ExamQuestionSubjectExample questionSubjectExample = new ExamQuestionSubjectExample();
			questionSubjectExample.createCriteria().andQuestionCodeIn(needDelQuestionCodes).andBookFlowEqualTo(bookFlow);
			ExamQuestionSubject questionSubject = new ExamQuestionSubject();
			questionSubject.setRecordStatus(GlobalConstant.FLAG_N);
			this.questionSubjectMapper.updateByExampleSelective(questionSubject, questionSubjectExample);
		}
		
		if(!needDelSubquestion.isEmpty()){
			for(ExamQuestionDetail needDelQuestionDet:needDelSubquestion){
				needDelQuestionDet.setRecordStatus(GlobalConstant.FLAG_N);
				//删除子题
				this.questionDetailMapper.updateByPrimaryKey(needDelQuestionDet);
				logger.info("删除子题--detailFlow:"+needDelQuestionDet.getDetailFlow()+"--parentFlow:"+needDelQuestionDet.getQuestionFlow()+"--parentcode:"+needDelQuestionDet.getParentQuestionCode()+"--code:"+needDelQuestionDet.getQuestionCode());
			}
			
			logger.info("删除子题--删除个数:"+needDelSubquestion.size());
		}
		
		//添加重传记录
		ExamBookReloadRec reloadRec = new ExamBookReloadRec();
		ExamBook book = this.bookManageBiz.read(bookFlow);
		reloadRec.setBookNum(book.getBookNum());
		reloadRec.setBookFlow(book.getBookFlow());
		reloadRec.setBookMemo(book.getMemo());
		reloadRec.setQuestionTypeId(questionTypeId);
		reloadRec.setFileName(questionFile.getOriginalFilename());
		reloadRec.setQuestionTypeName(QuestionTypeEnum.getNameById(questionTypeId));
		
		reloadRec.setOperUserFlow(currUser.getUserFlow());
		reloadRec.setOperUserName(currUser.getUserName());
		reloadRec.setReloadRecFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(reloadRec, true);
		this.bookReloadRecMapper.insertSelective(reloadRec);
		logger.info("重传试题操作结束时间"+DateUtil.getCurrDateTime("yyyy-MM-dd HH:mm")+"--操作人:"+currUser.getUserName());
	}

	@Override
	public Map<Integer, Map<Integer, String>> parseQuestionFile(
			MultipartFile questionTypeFile) {
		String data = "";
		InputStream stream = null;
		try{
			stream =questionTypeFile.getInputStream();
			data = IOUtils.toString(stream);
		}catch(IOException e){
			throw new RuntimeException(e.getMessage());
		}finally{
			if(stream!=null){
				try {
					stream.close();
				} catch (IOException e) {
					throw new RuntimeException(e.getMessage());
				}
			}
		}
		
		return this.parseQuestionDatas(data);
	}
	
	/**
	 * 解析试题文件内容，返回值为Map<第几题  , Map<行号, 该行内容>> 有序
	 * @param data
	 * @return
	 */
	private Map<Integer, Map<Integer, String>> parseQuestionDatas(String data){
		Map<Integer , Map<Integer , String>> result = new HashMap<Integer, Map<Integer,String>>();
		//行号
		int lineNum = 0;
		String [] questionUtils = data.split("(\r?\n(\\s*\r?\n)+)");
		for(int i=0;i<questionUtils.length&&questionUtils!=null;i++){
			String question = questionUtils[i];
			String [] content = question.split("\n|\r|\n\r");
			Map<Integer , String> tmpMap = new LinkedHashMap<Integer, String>();
			for(int j=0;j<content.length&&content!=null;j++){
				if(StringUtil.isNotBlank(content[j])){
					lineNum=lineNum+1;
					tmpMap.put(lineNum, content[j]);
				}
				
			}
        	lineNum = lineNum+1;
        	result.put(i+1, tmpMap);
		}
		return result ;
	}
	
	/**
	 * 解析试题文件内容，返回值为Map<第几题  , Map<从该题算起的行号, 该行内容>> 无序
	 * @param data
	 * @return
	 */
	private Map<Integer, Map<Integer, String>> parseQuestionDatasForEveryQuestionLinenum(String data){
		Map<Integer , Map<Integer , String>> result = new HashMap<Integer, Map<Integer,String>>();
		String [] questionUtils = data.split("(\r?\n(\\s*\r?\n)+)");
		for(int i=0;i<questionUtils.length&&questionUtils!=null;i++){
			String question = questionUtils[i];
			String [] content = question.split("\n|\r|\n\r");
			Map<Integer , String> tmpMap = new HashMap<Integer, String>();
			for(int j=0;j<content.length && content!=null;j++){
				if(StringUtil.isNotBlank(content[j])){
					tmpMap.put(j, content[j]);
				}
			}
        	result.put(i+1, tmpMap);
		}
		return result ;
	}
	

	private Map<String , List<QuestionVerifyInterceptor>> getQuestionFileVerifyConf(){
		Map<String , List<QuestionVerifyInterceptor>> questionFileVerifyConf = new HashMap<String, List<QuestionVerifyInterceptor>>();
		QuestionVerifyInterceptor questionVerifyForBL = new QuestionVerifyForBL();
		QuestionVerifyInterceptor questionVerifyForCommon = new QuestionVerifyForCommon();
		QuestionVerifyInterceptor questionVerifyForHaveQuestionAnswer = new QuestionVerifyForHaveQuestionAnswer();
		QuestionVerifyInterceptor questionVerifyForNoQuestionAnswer = new QuestionVerifyForNoQuestionAnswer();
		QuestionVerifyInterceptor questionVerifyForPW = new QuestionVerifyForPW();
		QuestionVerifyInterceptor questionVerifyForTK = new QuestionVerifyForTK();
		QuestionVerifyInterceptor questionVerifyForQuestionAnswer = new QuestionVerifyForQuestionAnswer();
		QuestionVerifyInterceptor questionVerifyForImg = new QuestionVerifyForImg();
		
		List<QuestionVerifyInterceptor> config1 = new ArrayList<QuestionVerifyInterceptor>();
		config1.add(questionVerifyForCommon);
		config1.add(questionVerifyForImg);
		config1.add(questionVerifyForHaveQuestionAnswer);
		
		List<QuestionVerifyInterceptor> config2 = new ArrayList<QuestionVerifyInterceptor>();
		config2.add(questionVerifyForCommon);
		config2.add(questionVerifyForImg);
		config2.add(questionVerifyForNoQuestionAnswer);
		
		List<QuestionVerifyInterceptor> config3 = new ArrayList<QuestionVerifyInterceptor>();
		config3.add(questionVerifyForImg);
		config3.add(questionVerifyForPW);
		
		List<QuestionVerifyInterceptor> config4 = new ArrayList<QuestionVerifyInterceptor>();
		config4.add(questionVerifyForImg);
		config4.add(questionVerifyForBL);
		
		List<QuestionVerifyInterceptor> config5 = new ArrayList<QuestionVerifyInterceptor>();
		config5.addAll(config2);
		config5.add(questionVerifyForTK);
		
		List<QuestionVerifyInterceptor> config6 = new ArrayList<QuestionVerifyInterceptor>();
		config6.addAll(config1);
		config6.add(questionVerifyForQuestionAnswer);
		
		questionFileVerifyConf.put(QuestionTypeEnum.Type15.getId(), config6);
		questionFileVerifyConf.put(QuestionTypeEnum.Type18.getId(), config6);
		questionFileVerifyConf.put(QuestionTypeEnum.Type25.getId(), config4);
		questionFileVerifyConf.put(QuestionTypeEnum.Type26.getId(), config3);
		questionFileVerifyConf.put(QuestionTypeEnum.Type27.getId(), config6);
		questionFileVerifyConf.put(QuestionTypeEnum.Type28.getId(), config5);
		questionFileVerifyConf.put(QuestionTypeEnum.Type29.getId(), config2);
		questionFileVerifyConf.put(QuestionTypeEnum.Type30.getId(), config2);
		questionFileVerifyConf.put(QuestionTypeEnum.Type31.getId(), config2);
		questionFileVerifyConf.put(QuestionTypeEnum.Type32.getId(), config1);
		questionFileVerifyConf.put(QuestionTypeEnum.Type33.getId(), config2);
		questionFileVerifyConf.put(QuestionTypeEnum.Type34.getId(), config2);
		questionFileVerifyConf.put(QuestionTypeEnum.Type35.getId(), config6);
		questionFileVerifyConf.put(QuestionTypeEnum.Type36.getId(), config4);
		questionFileVerifyConf.put(QuestionTypeEnum.Type37.getId(), config4);
		questionFileVerifyConf.put(QuestionTypeEnum.Type38.getId(), config4);
		questionFileVerifyConf.put(QuestionTypeEnum.Type47.getId(), config1);
		questionFileVerifyConf.put(QuestionTypeEnum.Type48.getId(), config2);
		
		return questionFileVerifyConf;
	}
	
	private void triggerAfterCompletion(Object obj , Integer questionNo , String questionTypeId , int interceptorIndex , Exception ex){
		if(StringUtil.isNotBlank(questionTypeId)){
			Map<String , List<QuestionVerifyInterceptor>> interceptorMap = this.getQuestionFileVerifyConf();
			List<QuestionVerifyInterceptor> interceptors = interceptorMap.get(questionTypeId);
			if(interceptors!=null){
				for(int i = interceptorIndex ; i>=0 ; i--){
					QuestionVerifyInterceptor interceptor = interceptors.get(i);
					interceptor.afterHandle(obj, questionNo, null, ex);
				}
			}
			
		}
		
	}
	@Override
	public QuestionFileVerifyInfo verifyQuestionFile(String questionTypeId,
			MultipartFile questionTypeFile) {
		Map<String , List<QuestionVerifyInterceptor>> interceptorMap = this.getQuestionFileVerifyConf();
		List<QuestionVerifyInterceptor> interceptors = interceptorMap.get(questionTypeId);
		Map<Integer , Map<Integer,String>> datas = this.parseQuestionFile(questionTypeFile);
		Set<Integer> set = datas.keySet();
		for(Integer questionNo:set){
			Map<Integer , String> questionInfo = datas.get(questionNo);
			if(interceptors!=null){
				int interceptorIndex = 0;
				for(int i=0 ; i< interceptors.size();i++){
					QuestionVerifyInterceptor interceptor = interceptors.get(i);
					if(!interceptor.preHandle(questionInfo, questionNo, null)){
						
						triggerAfterCompletion(questionInfo, questionNo, questionTypeId, interceptorIndex, null);
					}
					QuestionFileVerifyInfo verifyInfo = interceptor.handle(questionInfo, questionNo, questionTypeId, null);
					if(verifyInfo!=null){
						triggerAfterCompletion(questionInfo, questionNo, questionTypeId, interceptorIndex, null);
						return verifyInfo;
					}
					interceptorIndex = i;
				}
			}
			
			//如果有处理器的话，这个地方执行相应的处理器方法，现在暂时没有
			
			//拦截器后处理
			if(interceptors!=null){
				for(int i = interceptors.size()-1 ; i>=0 ; i--){
					QuestionVerifyInterceptor interceptor = interceptors.get(i);
					interceptor.afterHandle(questionInfo , questionNo, null, null);
				}
			}
			
		}
		return null;
	}
	
	@Override
	public List<ExamQuestionExt> createQuestions(ExamBookImpDetail bookImpDetail , ExamBookImp bookImp){
		List<ExamQuestionExt> questionInfo = new ArrayList<ExamQuestionExt>();
		ExamQuestionExt questionExt = null;
		//判断题目类型是否需要生成题目的详细
		String questionTypeId = bookImpDetail.getQuestionTypeId();
		
		try{
			if(bookImpDetail.getQuestionFile()==null){
				throw new RuntimeException("操作失败，没有试题文件");
			}
			String data = new String(bookImpDetail.getQuestionFile());
			Map<Integer , Map<Integer , String>> questionDatas = this.parseQuestionDatas(data);
			Set<Integer> questionDatasSet = questionDatas.keySet();
			for(Integer questioNo:questionDatasSet){
			    Map<Integer , String> questionData = questionDatas.get(questioNo);
				questionExt = this.questionSerivce.createQuestion(questionTypeId, bookImp, questionData);
				createQuestionHelp(questionExt);
				questionInfo.add(questionExt);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		
		return questionInfo;
	}
	
	@Override
	public List<ExamQuestionExt> createQuestionsfortest(ExamBookImpDetail bookImpDetail , ExamBookImp bookImp){
		List<ExamQuestionExt> questionInfo = new ArrayList<ExamQuestionExt>();
		ExamQuestionExt questionExt = null;
		//判断题目类型是否需要生成题目的详细
		String questionTypeId = bookImpDetail.getQuestionTypeId();
		
		try{
			if(bookImpDetail.getQuestionFile()==null){
				throw new RuntimeException("操作失败，没有试题文件");
			}
			String data = new String(bookImpDetail.getQuestionFile());
			Map<Integer , Map<Integer , String>> questionDatas = this.parseQuestionDatas(data);
			Set<Integer> questionDatasSet = questionDatas.keySet();
			for(Integer questioNo:questionDatasSet){
			    Map<Integer , String> questionData = questionDatas.get(questioNo);
				questionExt = this.questionSerivce.createQuestion(questionTypeId, bookImp, questionData);
				//createQuestionHelp(questionExt);
				questionInfo.add(questionExt);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		
		return questionInfo;
	}
	
	
	private void createQuestionHelp(ExamQuestionExt questionExt){
		//需要将子题答案的ABCD解析为@@的题目类型
		List<String> needReplaceQuestionDetailAnswer = new ArrayList<String>();
		needReplaceQuestionDetailAnswer.add(QuestionTypeEnum.Type36.getId());
		needReplaceQuestionDetailAnswer.add(QuestionTypeEnum.Type38.getId());
		needReplaceQuestionDetailAnswer.add(QuestionTypeEnum.Type37.getId());
		needReplaceQuestionDetailAnswer.add(QuestionTypeEnum.Type25.getId());
		
		//需要将题目答案的ABCD解析为@@的题目类型
		List<String> needReplaceQuestionAnswer = new ArrayList<String>();
		needReplaceQuestionAnswer.add(QuestionTypeEnum.Type27.getId());
		needReplaceQuestionAnswer.add(QuestionTypeEnum.Type18.getId());
		needReplaceQuestionAnswer.add(QuestionTypeEnum.Type15.getId());
		needReplaceQuestionAnswer.add(QuestionTypeEnum.Type35.getId());
		
		//需要将题干ABCD解析为@@的题目类型
		List<String> needReplaceQuestionContent = new ArrayList<String>();
		needReplaceQuestionContent.add(QuestionTypeEnum.Type26.getId());
		
		if(needReplaceQuestionDetailAnswer.contains(questionExt.getQuestionTypeId())){
			List<ExamQuestionDetailWithBLOBs> questionDetails = questionExt.getQuestionDetails();
			if(questionDetails!=null && !questionDetails.isEmpty()){
				for(ExamQuestionDetailWithBLOBs questionDetail:questionDetails){
					questionDetail.setQuestionAnswer(this.questionSerivce.replaceQuestionStr(questionDetail.getQuestionAnswer()));
				}
			}
		}
		if(needReplaceQuestionAnswer.contains(questionExt.getQuestionTypeId())){
			questionExt.setQuestionAnswer(this.questionSerivce.replaceQuestionStr(questionExt.getQuestionAnswer()));
		}
		if(needReplaceQuestionContent.contains(questionExt.getQuestionTypeId())){
			questionExt.setQuestionContent(this.questionSerivce.replaceQuestionStr(questionExt.getQuestionContent()));
		}
		
	}
	

	@Override
	public ExamBookRegistInfo getBookRegistInfo(String bookFlow) {
		ExamBookRegistInfo bookRegistInfo = new ExamBookRegistInfo();
		if(StringUtil.isNotBlank(bookFlow)){
			ExamBook book = this.bookManageBiz.read(bookFlow);
			if(book!=null){
				bookRegistInfo.setBookFlow(bookFlow);
				String registStatusId = book.getRegistStatusId();
				bookRegistInfo.setRegistStatusId(registStatusId);
				if(BookRegistStatusEnum.Scan.getId().equals(registStatusId)){
					ExamBookScanInfoExample example = new ExamBookScanInfoExample();
					example.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookScanInfo> examBookScanInfos =  this.bookScanInfoMapper.selectByExample(example);
					bookRegistInfo.setBookScanInfo(examBookScanInfos.get(0));
				}else if(BookRegistStatusEnum.Recognize.getId().equals(registStatusId)){
					ExamBookScanInfoExample example = new ExamBookScanInfoExample();
					example.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookScanInfo> examBookScanInfos =  this.bookScanInfoMapper.selectByExample(example);
					bookRegistInfo.setBookScanInfo(examBookScanInfos.get(0));
					
					ExamBookRecognizeInfoExample example2 = new ExamBookRecognizeInfoExample();
					example2.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookRecognizeInfo> bookRecognizeInfos = this.bookRecognizeInfoMapper.selectByExample(example2 );
					bookRegistInfo.setBookRecognizeInfo(bookRecognizeInfos.get(0));
				}else if(BookRegistStatusEnum.Compos.getId().equals(registStatusId)){
					ExamBookScanInfoExample example = new ExamBookScanInfoExample();
					example.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookScanInfo> examBookScanInfos =  this.bookScanInfoMapper.selectByExample(example);
					bookRegistInfo.setBookScanInfo(examBookScanInfos.get(0));
					
					ExamBookRecognizeInfoExample example2 = new ExamBookRecognizeInfoExample();
					example2.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookRecognizeInfo> bookRecognizeInfos = this.bookRecognizeInfoMapper.selectByExample(example2 );
					bookRegistInfo.setBookRecognizeInfo(bookRecognizeInfos.get(0));
					
					ExamBookComposInfoExample example3 = new ExamBookComposInfoExample();
					example3.createCriteria().andBookFlowEqualTo(bookFlow)
					.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
					List<ExamBookComposInfo> bookComposInfos = this.bookComposInfoMapper.selectByExample(example3);
					bookRegistInfo.setBookComposInfo(bookComposInfos.get(0));
				}
			}
		}
		return bookRegistInfo;
	}

	@Override
	public void registBookScanInfo(ExamBookScanInfo bookScanInfo) {
		if(StringUtil.isNotBlank(bookScanInfo.getScanUserFlow())){
			SysUser scanUser = userBiz.readSysUser(bookScanInfo.getScanUserFlow());
			bookScanInfo.setScanUserName(scanUser.getUserName());
		}
		if(StringUtil.isNotBlank(bookScanInfo.getSignUserFlow())){
			SysUser signUser = userBiz.readSysUser(bookScanInfo.getSignUserFlow());
			bookScanInfo.setSignUserName(signUser.getUserName());
		}
		//新增扫描信息
		bookScanInfo.setScanFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(bookScanInfo, true);
        this.bookScanInfoMapper.insertSelective(bookScanInfo);
        
		//更新书目书目信息
        ExamBook book = new ExamBook();
        book.setBookFlow(bookScanInfo.getBookFlow());
        book.setRegistStatusId(BookRegistStatusEnum.Scan.getId());
        book.setRegistStatusName(BookRegistStatusEnum.Scan.getName());
        this.bookManageBiz.mod(book);
	
	}

	@Override
	public void registRecognizeInfo(ExamBookRecognizeInfo recognizeInfo) {
		if(StringUtil.isNotBlank(recognizeInfo.getRecognizeUserFlow())){
			SysUser recognizeUser = userBiz.readSysUser(recognizeInfo.getRecognizeUserFlow());
			recognizeInfo.setRecognizeUserName(recognizeUser.getUserName());
		}
		if(StringUtil.isNotBlank(recognizeInfo.getSignUserFlow())){
			SysUser signUser = userBiz.readSysUser(recognizeInfo.getSignUserFlow());
			recognizeInfo.setSignUserName(signUser.getUserName());
		}
		
		recognizeInfo.setRecognizeFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(recognizeInfo, true);
        this.bookRecognizeInfoMapper.insertSelective(recognizeInfo);
        
        ExamBook book = new ExamBook();
        book.setBookFlow(recognizeInfo.getBookFlow());
        book.setRegistStatusId(BookRegistStatusEnum.Recognize.getId());
        book.setRegistStatusName(BookRegistStatusEnum.Recognize.getName());
        this.bookManageBiz.mod(book);
		
	}

	@Override
	public void registComposInfo(ExamBookComposInfo bookComposInfo) {
		if(StringUtil.isNotBlank(bookComposInfo.getComposUserFlow())){
			SysUser composUser = userBiz.readSysUser(bookComposInfo.getComposUserFlow());
			bookComposInfo.setComposUserName(composUser.getUserName());
		}
		if(StringUtil.isNotBlank(bookComposInfo.getSignUserFlow())){
			SysUser signUser = userBiz.readSysUser(bookComposInfo.getSignUserFlow());
			bookComposInfo.setSignUserName(signUser.getUserName());
		}
		
		bookComposInfo.setComposFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(bookComposInfo, true);
        this.bookComposInfoMapper.insertSelective(bookComposInfo);
        
        ExamBook book = new ExamBook();
        book.setBookFlow(bookComposInfo.getBookFlow());
        book.setRegistStatusId(BookRegistStatusEnum.Compos.getId());
        book.setRegistStatusName(BookRegistStatusEnum.Compos.getName());
        this.bookManageBiz.mod(book);
		
	}

	@Override
	public String findQuestionContentByimpDetailFlow(String detailFlow) {
		String content = "";
		ExamBookImpDetail impDetail = this.examBookImpDetailMapper.selectByPrimaryKey(detailFlow);
		if(impDetail!=null){
			byte[] questionContent = impDetail.getQuestionFile();
			if(questionContent!=null){
				content = new String(questionContent);
			}
		}
		return content;
	}

	@Override
	public ExamBookImp findBookImpByImpFlow(String bookImpFlow) {
		return this.examBookImpMapper.selectByPrimaryKey(bookImpFlow);
	}

	@Override
	public List<ExamBookReloadRec> searchBookReloadRecsByBookFlow(
			String bookFlow) {
		ExamBookReloadRecExample example = new ExamBookReloadRecExample();
		example.setOrderByClause("CREATE_TIME DESC");
		example.createCriteria()
		.andBookFlowEqualTo(bookFlow)
		.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		return this.bookReloadRecMapper.selectByExample(example);
	}

	@Override
	public ExamBookImpDetail findBookImpDetailByDetailFlow(String bookImpDetailFlow) {
		return this.examBookImpDetailMapper.selectByPrimaryKey(bookImpDetailFlow);
	}

	@Override
	public void delImpDetailByImpDetailFlow(String impDetailFlow) {
		ExamBookImpDetail record = new ExamBookImpDetail();
		record.setImpDetailFlow(impDetailFlow);
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		examBookImpDetailMapper.updateByPrimaryKeySelective(record);
		
	}

	

	
	
}
