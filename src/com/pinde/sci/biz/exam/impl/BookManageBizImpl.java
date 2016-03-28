package com.pinde.sci.biz.exam.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IBookManageBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ExamBookImpDetailMapper;
import com.pinde.sci.dao.base.ExamBookImpMapper;
import com.pinde.sci.dao.base.ExamBookMapper;
import com.pinde.sci.dao.base.ExamBookSubjectMapper;
import com.pinde.sci.dao.base.ExamQuestionBookMapper;
import com.pinde.sci.dao.base.ExamQuestionMapper;
import com.pinde.sci.dao.base.ExamQuestionSubjectMapper;
import com.pinde.sci.dao.base.ExamSubjectMapper;
import com.pinde.sci.dao.exam.ExamBookExtMapper;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookExample;
import com.pinde.sci.model.mo.ExamBookExample.Criteria;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamBookImpDetail;
import com.pinde.sci.model.mo.ExamBookImpDetailExample;
import com.pinde.sci.model.mo.ExamBookImpExample;
import com.pinde.sci.model.mo.ExamBookSubject;
import com.pinde.sci.model.mo.ExamBookSubjectExample;
import com.pinde.sci.model.mo.ExamQuestionBook;
import com.pinde.sci.model.mo.ExamQuestionBookExample;
import com.pinde.sci.model.mo.ExamQuestionExample;
import com.pinde.sci.model.mo.ExamQuestionSubject;
import com.pinde.sci.model.mo.ExamQuestionSubjectExample;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;
import com.pinde.sci.model.mo.ExamSubject;
import com.pinde.sci.model.mo.ExamSubjectExample;

@Service
@Transactional(rollbackFor = Exception.class)
public class BookManageBizImpl implements IBookManageBiz{

	@Autowired
	private ExamBookMapper examBookMapper;

	@Autowired
	private ExamQuestionBookMapper examQuestionBookMapper;
	
	@Autowired
	private ExamBookExtMapper examBookExtMapper;
	
	@Autowired
	private ExamBookSubjectMapper bookSubjectMapper;
	
	@Autowired
	private ExamQuestionSubjectMapper questionSubjectMapper;
	
	@Autowired
	private ExamBookImpMapper bookImpMapper;
	
	@Autowired
	private ExamBookImpDetailMapper bookImpDetailMapper;
	
	@Autowired
	private ExamQuestionMapper questionMapper;
	
	@Autowired
	private ExamSubjectMapper subjectMapper;

	@Override
	public List<ExamBook> search(ExamBook book) {
		ExamBookExample example = new ExamBookExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(book.getRecordStatus())){
			criteria.andRecordStatusEqualTo(book.getRecordStatus());
		}
		if(StringUtil.isNotBlank(book.getBookParentFlow())){
			criteria.andBookParentFlowEqualTo(book.getBookParentFlow());
		}
		if(StringUtil.isNotBlank(book.getBookNum())){
			criteria.andBookNumLike("%"+book.getBookNum()+"%");
		}
		example.setOrderByClause("BOOK_NUM,ORDINAL");
		return this.examBookMapper.selectByExample(example);
	}

	@Override
	public int countQuestNumOfBook(String bookFlow) {
		ExamQuestionBookExample example = new ExamQuestionBookExample();
		example.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return examQuestionBookMapper.countByExample(example);
	}

	@Override
	public List<Map<String,Integer>> countQuestNumByQuestionTypeOfBook(String bookFlow) {
		return examBookExtMapper.countQuestNumByQuestionTypeOfBook(bookFlow);
	}

	@Override
	public void saveOrder(String[] bookFlows) {
		if(bookFlows==null){
			return;
		}
		int i = 1;
		for(String bookFlow : bookFlows){
			ExamBook book = new ExamBook();
			book.setBookFlow(bookFlow);
			book.setOrdinal(i++);
			examBookMapper.updateByPrimaryKeySelective(book);
		}
	}

	@Override
	public List<ExamBook> searchBookByBook(String bookFlow) {
		return examBookExtMapper.searchBookByBook(bookFlow);
	}

	@Override
	public List<Map<String, Integer>> countQuestNumByBookOfBook(String bookFlow) {
		return examBookExtMapper.countQuestNumByBookOfBook(bookFlow);
	}

	@Override
	public List<Map<String, Integer>> countQuestNumBySubjectOfBook(String bookFlow) {
		return examBookExtMapper.countQuestNumBySubjectOfBook(bookFlow);
	}

	@Override
	public List<ExamSubject> searchSubjectByBook(String bookFlow) {
		return examBookExtMapper.searchSubjectByBook(bookFlow);
	}
	
	@Override
	public List<ExamSubject> findSubjectByBookFlow(String bookFlow){
//		ExamBookSubjectExample bsExample = new ExamBookSubjectExample();
//		bsExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andBookFlowEqualTo(bookFlow);
//		List<ExamBookSubject> bookSubjects = this.bookSubjectMapper.selectByExample(bsExample);
		ExamQuestionSubjectExample bsExample = new ExamQuestionSubjectExample();
		bsExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andBookFlowEqualTo(bookFlow);
		List<ExamQuestionSubject> bookSubjects = this.questionSubjectMapper.selectByExample(bsExample);
		
		List<String> subjects = new ArrayList<String>();
		for(ExamQuestionSubject bs:bookSubjects){
			String subjectFlow = bs.getSubjectFlow();
			if(subjects.contains(subjectFlow)==false){
				subjects.add(subjectFlow);
			}
		}
		if(!subjects.isEmpty()){
			ExamSubjectExample sExample = new ExamSubjectExample();
			sExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSubjectFlowIn(subjects);
			return this.subjectMapper.selectByExample(sExample);
		}
		
		return null;
		
	}

	@Override
	public void unRel(String bookFlow) {
		//解除书和题目的绑定关系
		ExamQuestionBook update = new ExamQuestionBook();
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionBookExample example = new ExamQuestionBookExample();
		example.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		examQuestionBookMapper.updateByExampleSelective(update, example);
		
		//将该书的题目删掉
		ExamQuestionWithBLOBs question = new ExamQuestionWithBLOBs();
		question.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionExample questionExample = new ExamQuestionExample();
		questionExample.createCriteria().andCreateBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		this.questionMapper.updateByExampleSelective(question, questionExample);
		
		//解除书目和导入记录的关系
		ExamBookImp bookImp = new ExamBookImp();
		bookImp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamBookImpExample bookImpExample = new ExamBookImpExample();
		bookImpExample.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		this.bookImpMapper.updateByExampleSelective(bookImp, bookImpExample);
		
		//解除导入具体文件和书的关系
		ExamBookImpDetail bookImpDetail = new ExamBookImpDetail();
		bookImpDetail.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamBookImpDetailExample bookImpDetailExample = new ExamBookImpDetailExample();
		bookImpDetailExample.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		this.bookImpDetailMapper.updateByExampleSelective(bookImpDetail, bookImpDetailExample);
		
		//解除书目和科目的关系
		ExamBookSubject bookSubject = new ExamBookSubject();
		bookSubject.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamBookSubjectExample bookSubjectExample = new ExamBookSubjectExample();
		bookSubjectExample.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		this.bookSubjectMapper.updateByExampleSelective(bookSubject, bookSubjectExample );

		//解除该书目下的题目和科目的关系
		ExamQuestionSubject questionSubject = new ExamQuestionSubject();
		questionSubject.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionSubjectExample questionSubjectExample = new ExamQuestionSubjectExample();
		questionSubjectExample.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		questionSubjectMapper.updateByExampleSelective(questionSubject, questionSubjectExample );
	}

	@Override
	public ExamBook read(String bookFlow) {
		return examBookMapper.selectByPrimaryKey(bookFlow);
	}

	@Override
	public void add(ExamBook book, ExamBook bookParent) {
		book.setBookFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(book, true);
		examBookMapper.insertSelective(book);		
		
		ExamBook updateParent = new ExamBook();
		updateParent.setBookFlow(bookParent.getBookFlow());
		updateParent.setLeafFlag(GlobalConstant.RECORD_STATUS_N);
		examBookMapper.updateByPrimaryKeySelective(updateParent);
	}

	@Override
	public void mod(ExamBook book) {
		GeneralMethod.setRecordInfo(book, false);
		examBookMapper.updateByPrimaryKeySelective(book);	
	}
	
	@Override
	public void modBookAndSubBook(ExamBook book) {
		ExamBook oldBook = this.read(book.getBookFlow());
		if(StringUtil.isBlank(book.getBookParentFlow()) || "0".equals(book.getBookParentFlow())){
			//表示修改的是顶级书，同时要更新掉所有的子节点
			//if(!oldBook.getBookNum().equals(book.getBookNum())){
				ExamBook record = new ExamBook();
				record.setBookNum(book.getBookNum());
				record.setPublishYear(book.getPublishYear());
				record.setBookPress(book.getBookPress());
				record.setBookPageNum(book.getBookPageNum());
				record.setBookSource(book.getBookSource());
				ExamBookExample example = new ExamBookExample();
				example.createCriteria().andBookNumEqualTo(oldBook.getBookNum());
				this.examBookMapper.updateByExampleSelective(record , example);
			//}
		}
		//将该节点下的所有子节点的memo换掉
		if(!oldBook.getBookName().equals(book.getBookName())){
			List<ExamBook> subBooks = this.findSubBookByBookFlow(book.getBookFlow());
			for(ExamBook subBook:subBooks){
				String newmemo = subBook.getMemo().replace(oldBook.getBookName(), book.getBookName());
				subBook.setMemo(newmemo);
				this.examBookMapper.updateByPrimaryKeySelective(subBook);
			}
		}
		this.mod(book);
		
	}
	
	/**
	 * 查询一个节点下的所有子节点
	 * @param bookFlow
	 * @return
	 */
	@Override
	public List<ExamBook> findSubBookByBookFlow(String bookFlow){
		List<ExamBook> subBooks = new ArrayList<ExamBook>();
		ExamBookExample example = new ExamBookExample();
		example.createCriteria().andBookParentFlowEqualTo(bookFlow);
		List<ExamBook> books = this.examBookMapper.selectByExample(example);
		if(books==null || books.isEmpty()){
			return subBooks;
		}
		for(ExamBook book:books){
			subBooks.add(book);
			subBooks.addAll(this.findSubBookByBookFlow(book.getBookFlow()));
		}
		return subBooks;
		
	}

	@Override
	public void del(String bookFlow) {
		ExamBook update = new ExamBook();
		update.setBookFlow(bookFlow);
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		examBookMapper.updateByPrimaryKeySelective(update);
		
		unRel(bookFlow);

		ExamBookExample example = new ExamBookExample();
		Criteria criteria = example.createCriteria();
		criteria.andBookParentFlowEqualTo(bookFlow);
		example.setOrderByClause("ORDINAL");
		List<ExamBook> subExamBookList = examBookMapper.selectByExample(example);
		for(ExamBook subBook : subExamBookList){
			del(subBook.getBookFlow());
		}
//		if(subExamBookList.size()==0){
//			return;
//		}
	}

	@Override
	public void merge(String[] bookFlows) {
		String bookFlow1 = bookFlows[0];
		for(int i=1;i<bookFlows.length;i++ ){
			String bookFlow = bookFlows[i];
			
			ExamBook update = new ExamBook();
			update.setBookFlow(bookFlow);
			update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			examBookMapper.updateByPrimaryKeySelective(update);
			
			ExamQuestionBookExample exampleS = new ExamQuestionBookExample();
			exampleS.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			
			List<ExamQuestionBook> examQuestionBookList = examQuestionBookMapper.selectByExample(exampleS);
			for(ExamQuestionBook qb : examQuestionBookList){
				//建立新的关系
				qb.setQuestionBookFlow(PkUtil.getUUID());
				qb.setBookFlow(bookFlow1);
				qb.setBookName("");
				GeneralMethod.setRecordInfo(qb, true);
				qb.setModifyTime("");
				qb.setModifyUserFlow("");
				examQuestionBookMapper.insertSelective(qb);
			}
			
			//删除就关系
			unRel(bookFlow);
			
			ExamBookExample example = new ExamBookExample();
			Criteria criteria = example.createCriteria();
			criteria.andBookParentFlowEqualTo(bookFlow);
			example.setOrderByClause("ORDINAL");
			List<ExamBook> subExamBookList = examBookMapper.selectByExample(example);
			for(ExamBook subBook : subExamBookList){
				ExamBook updateSub = new ExamBook();
				updateSub.setBookFlow(subBook.getBookFlow());
				updateSub.setBookParentFlow(bookFlow1);
				examBookMapper.updateByPrimaryKeySelective(updateSub);
			}
		}
	}
	
	private static ThreadLocal<Integer> countForTreeLocal = new ThreadLocal<Integer>();

	@Override
	public int countForTree(String bookFlow) {
		countForTreeLocal.set(0);
		_countQuestNumOfBookTree(bookFlow);
		return countForTreeLocal.get();
	}
	
	private void _countQuestNumOfBookTree(String bookFlow) {
		countForTreeLocal.set(countForTreeLocal.get()+ countQuestNumOfBook(bookFlow));
		ExamBookExample example = new ExamBookExample();
		Criteria criteria = example.createCriteria();
		criteria.andBookParentFlowEqualTo(bookFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<ExamBook> subList = examBookMapper.selectByExample(example);
		if(subList.size()==0){
			return;
		}
		for(ExamBook sub : subList){
			_countQuestNumOfBookTree(sub.getBookFlow());
		}
	}
	
	@Override
	public ExamBook findBookByBookFlow(String bookFlow){
		ExamBook book = this.read(bookFlow);
		if("0".equals(book.getBookParentFlow())){
		    return book;	
		}
		return findBookByBookFlow(book.getBookParentFlow());
	}

	@Override
	public void delBookAndSubjectRelation(String bookFlow, String subjectFlow) {
		ExamBookSubject bookAndSubject = new ExamBookSubject();
		bookAndSubject.setRecordStatus(GlobalConstant.FLAG_N);
		ExamBookSubjectExample bookSubjectExample = new ExamBookSubjectExample();
		bookSubjectExample.createCriteria()
		.andBookFlowEqualTo(bookFlow)
		.andSubjectFlowEqualTo(subjectFlow)
		.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		this.bookSubjectMapper.updateByExampleSelective(bookAndSubject, bookSubjectExample);
		
		List<ExamBook> books = findSubBookByBookFlow(bookFlow);
		if(books.isEmpty()){
			ExamQuestionSubject record = new ExamQuestionSubject();
			record.setRecordStatus(GlobalConstant.FLAG_N);
			ExamQuestionSubjectExample example = new ExamQuestionSubjectExample();
			example.createCriteria().andBookFlowEqualTo(bookFlow)
			.andSubjectFlowEqualTo(subjectFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			this.questionSubjectMapper.updateByExampleSelective(record , example);
		}else{
			List<String> needDelQuestionSubjects = new ArrayList<String>();
			for(ExamBook book:books){
				needDelQuestionSubjects.add(book.getBookFlow());
			}
			
			//子书目节点的关联也要删除
			bookAndSubject = new ExamBookSubject();
			bookAndSubject.setRecordStatus(GlobalConstant.FLAG_N);
			bookSubjectExample = new ExamBookSubjectExample();
			bookSubjectExample.createCriteria()
			.andBookFlowIn(needDelQuestionSubjects)
			.andSubjectFlowEqualTo(subjectFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			this.bookSubjectMapper.updateByExampleSelective(bookAndSubject, bookSubjectExample);
			
			ExamQuestionSubject record = new ExamQuestionSubject();
			record.setRecordStatus(GlobalConstant.FLAG_N);
			ExamQuestionSubjectExample example = new ExamQuestionSubjectExample();
			example.createCriteria().andBookFlowIn(needDelQuestionSubjects)
			.andSubjectFlowEqualTo(subjectFlow)
			.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			this.questionSubjectMapper.updateByExampleSelective(record , example);
		}
		
		
		
	}

	@Override
	public void rebindSubject(String bookFlow, String subjectFlow,
			String oldSubjectFlow) {
		ExamBookSubject bookSubject = new ExamBookSubject();
		bookSubject.setSubjectFlow(subjectFlow);
		ExamBookSubjectExample bookSubjectExample = new ExamBookSubjectExample();
		bookSubjectExample.createCriteria()
		.andBookFlowEqualTo(bookFlow)
		.andSubjectFlowEqualTo(oldSubjectFlow)
		.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		this.bookSubjectMapper.updateByExampleSelective(bookSubject , bookSubjectExample);
		
		ExamQuestionSubject record = new ExamQuestionSubject();
		record.setSubjectFlow(subjectFlow);
		ExamQuestionSubjectExample example = new ExamQuestionSubjectExample();
		example.createCriteria()
		.andBookFlowEqualTo(bookFlow)
		.andSubjectFlowEqualTo(oldSubjectFlow)
		.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		this.questionSubjectMapper.updateByExampleSelective(record , example);
		
	}

	
	public void addQuestionSubjectByBookFlow(String bookFlow , String subjectFlow){
		ExamQuestionBookExample example = new ExamQuestionBookExample();
		example.createCriteria().andBookFlowEqualTo(bookFlow).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		List<ExamQuestionBook> questionBooks = this.examQuestionBookMapper.selectByExample(example);
		//以后可以使用批量插入提高性能
		for(ExamQuestionBook questionBook:questionBooks){
			ExamQuestionSubject record = new ExamQuestionSubject();
			record.setQuestionSubjectFlow(PkUtil.getUUID());
			record.setQuestionFlow(questionBook.getQuestionFlow());
			record.setBookFlow(bookFlow);
			record.setSubjectFlow(subjectFlow);
			record.setQuestionCode(questionBook.getQuestionCode());
			GeneralMethod.setRecordInfo(record, true);
			this.questionSubjectMapper.insertSelective(record);
	    }
	}
	
	@Override
	public void addBindSubject(String bookFlow, String subjectFlow) {
		if(StringUtil.isNotBlank(bookFlow)&&StringUtil.isNotBlank(subjectFlow)){
			List<ExamBook> books = findSubBookByBookFlow(bookFlow);
			ExamBookSubject bookSubject = new ExamBookSubject();
			bookSubject.setBookSubjectFlow(PkUtil.getUUID());
			bookSubject.setBookFlow(bookFlow);
			bookSubject.setSubjectFlow(subjectFlow);
			GeneralMethod.setRecordInfo(bookSubject, true);
			this.bookSubjectMapper.insertSelective(bookSubject);
			if(books.isEmpty()){
				addQuestionSubjectByBookFlow(bookFlow , subjectFlow);
			}else{
				for(ExamBook book:books){
					String tmpBookFlow = book.getBookFlow();
					
					//子书目节点也要和该科目建立关联
					bookSubject = new ExamBookSubject();
					bookSubject.setBookSubjectFlow(PkUtil.getUUID());
					bookSubject.setBookFlow(tmpBookFlow);
					bookSubject.setSubjectFlow(subjectFlow);
					GeneralMethod.setRecordInfo(bookSubject, true);
					this.bookSubjectMapper.insertSelective(bookSubject);
					addQuestionSubjectByBookFlow(tmpBookFlow , subjectFlow);
					
				}
			}
		}
	}
	
	@Override
	public void smartOrder(String bookParentFlow){
		ExamBookExample example = new ExamBookExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andBookParentFlowEqualTo(bookParentFlow);
		example.setOrderByClause("CREATE_TIME");
		List<ExamBook> books = this.examBookMapper.selectByExample(example);
		for(int i=0;i<books.size();i++){
			ExamBook book = books.get(i);
			book.setOrdinal(i);
			this.examBookMapper.updateByPrimaryKeySelective(book);
		}
	}

}
