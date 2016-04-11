package com.pinde.sci.model.mo;

import java.util.ArrayList;
import java.util.List;

public class ExamBookReloadRecExample {
    /**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	protected String orderByClause;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	protected boolean distinct;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	protected List<Criteria> oredCriteria;

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public ExamBookReloadRecExample() {
		oredCriteria = new ArrayList<Criteria>();
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public void setOrderByClause(String orderByClause) {
		this.orderByClause = orderByClause;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public String getOrderByClause() {
		return orderByClause;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public void setDistinct(boolean distinct) {
		this.distinct = distinct;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public boolean isDistinct() {
		return distinct;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public List<Criteria> getOredCriteria() {
		return oredCriteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public void or(Criteria criteria) {
		oredCriteria.add(criteria);
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public Criteria or() {
		Criteria criteria = createCriteriaInternal();
		oredCriteria.add(criteria);
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public Criteria createCriteria() {
		Criteria criteria = createCriteriaInternal();
		if (oredCriteria.size() == 0) {
			oredCriteria.add(criteria);
		}
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	protected Criteria createCriteriaInternal() {
		Criteria criteria = new Criteria();
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public void clear() {
		oredCriteria.clear();
		orderByClause = null;
		distinct = false;
	}

	/**
	 * This class was generated by MyBatis Generator. This class corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	protected abstract static class GeneratedCriteria {
		protected List<Criterion> criteria;

		protected GeneratedCriteria() {
			super();
			criteria = new ArrayList<Criterion>();
		}

		public boolean isValid() {
			return criteria.size() > 0;
		}

		public List<Criterion> getAllCriteria() {
			return criteria;
		}

		public List<Criterion> getCriteria() {
			return criteria;
		}

		protected void addCriterion(String condition) {
			if (condition == null) {
				throw new RuntimeException("Value for condition cannot be null");
			}
			criteria.add(new Criterion(condition));
		}

		protected void addCriterion(String condition, Object value,
				String property) {
			if (value == null) {
				throw new RuntimeException("Value for " + property
						+ " cannot be null");
			}
			criteria.add(new Criterion(condition, value));
		}

		protected void addCriterion(String condition, Object value1,
				Object value2, String property) {
			if (value1 == null || value2 == null) {
				throw new RuntimeException("Between values for " + property
						+ " cannot be null");
			}
			criteria.add(new Criterion(condition, value1, value2));
		}

		public Criteria andReloadRecFlowIsNull() {
			addCriterion("RELOAD_REC_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowIsNotNull() {
			addCriterion("RELOAD_REC_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowEqualTo(String value) {
			addCriterion("RELOAD_REC_FLOW =", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowNotEqualTo(String value) {
			addCriterion("RELOAD_REC_FLOW <>", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowGreaterThan(String value) {
			addCriterion("RELOAD_REC_FLOW >", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowGreaterThanOrEqualTo(String value) {
			addCriterion("RELOAD_REC_FLOW >=", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowLessThan(String value) {
			addCriterion("RELOAD_REC_FLOW <", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowLessThanOrEqualTo(String value) {
			addCriterion("RELOAD_REC_FLOW <=", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowLike(String value) {
			addCriterion("RELOAD_REC_FLOW like", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowNotLike(String value) {
			addCriterion("RELOAD_REC_FLOW not like", value, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowIn(List<String> values) {
			addCriterion("RELOAD_REC_FLOW in", values, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowNotIn(List<String> values) {
			addCriterion("RELOAD_REC_FLOW not in", values, "reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowBetween(String value1, String value2) {
			addCriterion("RELOAD_REC_FLOW between", value1, value2,
					"reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andReloadRecFlowNotBetween(String value1, String value2) {
			addCriterion("RELOAD_REC_FLOW not between", value1, value2,
					"reloadRecFlow");
			return (Criteria) this;
		}

		public Criteria andBookNumIsNull() {
			addCriterion("BOOK_NUM is null");
			return (Criteria) this;
		}

		public Criteria andBookNumIsNotNull() {
			addCriterion("BOOK_NUM is not null");
			return (Criteria) this;
		}

		public Criteria andBookNumEqualTo(String value) {
			addCriterion("BOOK_NUM =", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumNotEqualTo(String value) {
			addCriterion("BOOK_NUM <>", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumGreaterThan(String value) {
			addCriterion("BOOK_NUM >", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumGreaterThanOrEqualTo(String value) {
			addCriterion("BOOK_NUM >=", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumLessThan(String value) {
			addCriterion("BOOK_NUM <", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumLessThanOrEqualTo(String value) {
			addCriterion("BOOK_NUM <=", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumLike(String value) {
			addCriterion("BOOK_NUM like", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumNotLike(String value) {
			addCriterion("BOOK_NUM not like", value, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumIn(List<String> values) {
			addCriterion("BOOK_NUM in", values, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumNotIn(List<String> values) {
			addCriterion("BOOK_NUM not in", values, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumBetween(String value1, String value2) {
			addCriterion("BOOK_NUM between", value1, value2, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookNumNotBetween(String value1, String value2) {
			addCriterion("BOOK_NUM not between", value1, value2, "bookNum");
			return (Criteria) this;
		}

		public Criteria andBookFlowIsNull() {
			addCriterion("BOOK_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andBookFlowIsNotNull() {
			addCriterion("BOOK_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andBookFlowEqualTo(String value) {
			addCriterion("BOOK_FLOW =", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowNotEqualTo(String value) {
			addCriterion("BOOK_FLOW <>", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowGreaterThan(String value) {
			addCriterion("BOOK_FLOW >", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowGreaterThanOrEqualTo(String value) {
			addCriterion("BOOK_FLOW >=", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowLessThan(String value) {
			addCriterion("BOOK_FLOW <", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowLessThanOrEqualTo(String value) {
			addCriterion("BOOK_FLOW <=", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowLike(String value) {
			addCriterion("BOOK_FLOW like", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowNotLike(String value) {
			addCriterion("BOOK_FLOW not like", value, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowIn(List<String> values) {
			addCriterion("BOOK_FLOW in", values, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowNotIn(List<String> values) {
			addCriterion("BOOK_FLOW not in", values, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowBetween(String value1, String value2) {
			addCriterion("BOOK_FLOW between", value1, value2, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookFlowNotBetween(String value1, String value2) {
			addCriterion("BOOK_FLOW not between", value1, value2, "bookFlow");
			return (Criteria) this;
		}

		public Criteria andBookMemoIsNull() {
			addCriterion("BOOK_MEMO is null");
			return (Criteria) this;
		}

		public Criteria andBookMemoIsNotNull() {
			addCriterion("BOOK_MEMO is not null");
			return (Criteria) this;
		}

		public Criteria andBookMemoEqualTo(String value) {
			addCriterion("BOOK_MEMO =", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoNotEqualTo(String value) {
			addCriterion("BOOK_MEMO <>", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoGreaterThan(String value) {
			addCriterion("BOOK_MEMO >", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoGreaterThanOrEqualTo(String value) {
			addCriterion("BOOK_MEMO >=", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoLessThan(String value) {
			addCriterion("BOOK_MEMO <", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoLessThanOrEqualTo(String value) {
			addCriterion("BOOK_MEMO <=", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoLike(String value) {
			addCriterion("BOOK_MEMO like", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoNotLike(String value) {
			addCriterion("BOOK_MEMO not like", value, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoIn(List<String> values) {
			addCriterion("BOOK_MEMO in", values, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoNotIn(List<String> values) {
			addCriterion("BOOK_MEMO not in", values, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoBetween(String value1, String value2) {
			addCriterion("BOOK_MEMO between", value1, value2, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andBookMemoNotBetween(String value1, String value2) {
			addCriterion("BOOK_MEMO not between", value1, value2, "bookMemo");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdIsNull() {
			addCriterion("QUESTION_TYPE_ID is null");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdIsNotNull() {
			addCriterion("QUESTION_TYPE_ID is not null");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdEqualTo(String value) {
			addCriterion("QUESTION_TYPE_ID =", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdNotEqualTo(String value) {
			addCriterion("QUESTION_TYPE_ID <>", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdGreaterThan(String value) {
			addCriterion("QUESTION_TYPE_ID >", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdGreaterThanOrEqualTo(String value) {
			addCriterion("QUESTION_TYPE_ID >=", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdLessThan(String value) {
			addCriterion("QUESTION_TYPE_ID <", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdLessThanOrEqualTo(String value) {
			addCriterion("QUESTION_TYPE_ID <=", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdLike(String value) {
			addCriterion("QUESTION_TYPE_ID like", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdNotLike(String value) {
			addCriterion("QUESTION_TYPE_ID not like", value, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdIn(List<String> values) {
			addCriterion("QUESTION_TYPE_ID in", values, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdNotIn(List<String> values) {
			addCriterion("QUESTION_TYPE_ID not in", values, "questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdBetween(String value1, String value2) {
			addCriterion("QUESTION_TYPE_ID between", value1, value2,
					"questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeIdNotBetween(String value1, String value2) {
			addCriterion("QUESTION_TYPE_ID not between", value1, value2,
					"questionTypeId");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameIsNull() {
			addCriterion("QUESTION_TYPE_NAME is null");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameIsNotNull() {
			addCriterion("QUESTION_TYPE_NAME is not null");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameEqualTo(String value) {
			addCriterion("QUESTION_TYPE_NAME =", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameNotEqualTo(String value) {
			addCriterion("QUESTION_TYPE_NAME <>", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameGreaterThan(String value) {
			addCriterion("QUESTION_TYPE_NAME >", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameGreaterThanOrEqualTo(String value) {
			addCriterion("QUESTION_TYPE_NAME >=", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameLessThan(String value) {
			addCriterion("QUESTION_TYPE_NAME <", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameLessThanOrEqualTo(String value) {
			addCriterion("QUESTION_TYPE_NAME <=", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameLike(String value) {
			addCriterion("QUESTION_TYPE_NAME like", value, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameNotLike(String value) {
			addCriterion("QUESTION_TYPE_NAME not like", value,
					"questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameIn(List<String> values) {
			addCriterion("QUESTION_TYPE_NAME in", values, "questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameNotIn(List<String> values) {
			addCriterion("QUESTION_TYPE_NAME not in", values,
					"questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameBetween(String value1, String value2) {
			addCriterion("QUESTION_TYPE_NAME between", value1, value2,
					"questionTypeName");
			return (Criteria) this;
		}

		public Criteria andQuestionTypeNameNotBetween(String value1,
				String value2) {
			addCriterion("QUESTION_TYPE_NAME not between", value1, value2,
					"questionTypeName");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowIsNull() {
			addCriterion("OPER_USER_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowIsNotNull() {
			addCriterion("OPER_USER_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowEqualTo(String value) {
			addCriterion("OPER_USER_FLOW =", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowNotEqualTo(String value) {
			addCriterion("OPER_USER_FLOW <>", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowGreaterThan(String value) {
			addCriterion("OPER_USER_FLOW >", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowGreaterThanOrEqualTo(String value) {
			addCriterion("OPER_USER_FLOW >=", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowLessThan(String value) {
			addCriterion("OPER_USER_FLOW <", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowLessThanOrEqualTo(String value) {
			addCriterion("OPER_USER_FLOW <=", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowLike(String value) {
			addCriterion("OPER_USER_FLOW like", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowNotLike(String value) {
			addCriterion("OPER_USER_FLOW not like", value, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowIn(List<String> values) {
			addCriterion("OPER_USER_FLOW in", values, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowNotIn(List<String> values) {
			addCriterion("OPER_USER_FLOW not in", values, "operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowBetween(String value1, String value2) {
			addCriterion("OPER_USER_FLOW between", value1, value2,
					"operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserFlowNotBetween(String value1, String value2) {
			addCriterion("OPER_USER_FLOW not between", value1, value2,
					"operUserFlow");
			return (Criteria) this;
		}

		public Criteria andOperUserNameIsNull() {
			addCriterion("OPER_USER_NAME is null");
			return (Criteria) this;
		}

		public Criteria andOperUserNameIsNotNull() {
			addCriterion("OPER_USER_NAME is not null");
			return (Criteria) this;
		}

		public Criteria andOperUserNameEqualTo(String value) {
			addCriterion("OPER_USER_NAME =", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameNotEqualTo(String value) {
			addCriterion("OPER_USER_NAME <>", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameGreaterThan(String value) {
			addCriterion("OPER_USER_NAME >", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameGreaterThanOrEqualTo(String value) {
			addCriterion("OPER_USER_NAME >=", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameLessThan(String value) {
			addCriterion("OPER_USER_NAME <", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameLessThanOrEqualTo(String value) {
			addCriterion("OPER_USER_NAME <=", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameLike(String value) {
			addCriterion("OPER_USER_NAME like", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameNotLike(String value) {
			addCriterion("OPER_USER_NAME not like", value, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameIn(List<String> values) {
			addCriterion("OPER_USER_NAME in", values, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameNotIn(List<String> values) {
			addCriterion("OPER_USER_NAME not in", values, "operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameBetween(String value1, String value2) {
			addCriterion("OPER_USER_NAME between", value1, value2,
					"operUserName");
			return (Criteria) this;
		}

		public Criteria andOperUserNameNotBetween(String value1, String value2) {
			addCriterion("OPER_USER_NAME not between", value1, value2,
					"operUserName");
			return (Criteria) this;
		}

		public Criteria andRecordStatusIsNull() {
			addCriterion("RECORD_STATUS is null");
			return (Criteria) this;
		}

		public Criteria andRecordStatusIsNotNull() {
			addCriterion("RECORD_STATUS is not null");
			return (Criteria) this;
		}

		public Criteria andRecordStatusEqualTo(String value) {
			addCriterion("RECORD_STATUS =", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusNotEqualTo(String value) {
			addCriterion("RECORD_STATUS <>", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusGreaterThan(String value) {
			addCriterion("RECORD_STATUS >", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusGreaterThanOrEqualTo(String value) {
			addCriterion("RECORD_STATUS >=", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusLessThan(String value) {
			addCriterion("RECORD_STATUS <", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusLessThanOrEqualTo(String value) {
			addCriterion("RECORD_STATUS <=", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusLike(String value) {
			addCriterion("RECORD_STATUS like", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusNotLike(String value) {
			addCriterion("RECORD_STATUS not like", value, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusIn(List<String> values) {
			addCriterion("RECORD_STATUS in", values, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusNotIn(List<String> values) {
			addCriterion("RECORD_STATUS not in", values, "recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusBetween(String value1, String value2) {
			addCriterion("RECORD_STATUS between", value1, value2,
					"recordStatus");
			return (Criteria) this;
		}

		public Criteria andRecordStatusNotBetween(String value1, String value2) {
			addCriterion("RECORD_STATUS not between", value1, value2,
					"recordStatus");
			return (Criteria) this;
		}

		public Criteria andCreateTimeIsNull() {
			addCriterion("CREATE_TIME is null");
			return (Criteria) this;
		}

		public Criteria andCreateTimeIsNotNull() {
			addCriterion("CREATE_TIME is not null");
			return (Criteria) this;
		}

		public Criteria andCreateTimeEqualTo(String value) {
			addCriterion("CREATE_TIME =", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeNotEqualTo(String value) {
			addCriterion("CREATE_TIME <>", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeGreaterThan(String value) {
			addCriterion("CREATE_TIME >", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeGreaterThanOrEqualTo(String value) {
			addCriterion("CREATE_TIME >=", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeLessThan(String value) {
			addCriterion("CREATE_TIME <", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeLessThanOrEqualTo(String value) {
			addCriterion("CREATE_TIME <=", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeLike(String value) {
			addCriterion("CREATE_TIME like", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeNotLike(String value) {
			addCriterion("CREATE_TIME not like", value, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeIn(List<String> values) {
			addCriterion("CREATE_TIME in", values, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeNotIn(List<String> values) {
			addCriterion("CREATE_TIME not in", values, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeBetween(String value1, String value2) {
			addCriterion("CREATE_TIME between", value1, value2, "createTime");
			return (Criteria) this;
		}

		public Criteria andCreateTimeNotBetween(String value1, String value2) {
			addCriterion("CREATE_TIME not between", value1, value2,
					"createTime");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowIsNull() {
			addCriterion("CREATE_USER_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowIsNotNull() {
			addCriterion("CREATE_USER_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowEqualTo(String value) {
			addCriterion("CREATE_USER_FLOW =", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowNotEqualTo(String value) {
			addCriterion("CREATE_USER_FLOW <>", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowGreaterThan(String value) {
			addCriterion("CREATE_USER_FLOW >", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowGreaterThanOrEqualTo(String value) {
			addCriterion("CREATE_USER_FLOW >=", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowLessThan(String value) {
			addCriterion("CREATE_USER_FLOW <", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowLessThanOrEqualTo(String value) {
			addCriterion("CREATE_USER_FLOW <=", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowLike(String value) {
			addCriterion("CREATE_USER_FLOW like", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowNotLike(String value) {
			addCriterion("CREATE_USER_FLOW not like", value, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowIn(List<String> values) {
			addCriterion("CREATE_USER_FLOW in", values, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowNotIn(List<String> values) {
			addCriterion("CREATE_USER_FLOW not in", values, "createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowBetween(String value1, String value2) {
			addCriterion("CREATE_USER_FLOW between", value1, value2,
					"createUserFlow");
			return (Criteria) this;
		}

		public Criteria andCreateUserFlowNotBetween(String value1, String value2) {
			addCriterion("CREATE_USER_FLOW not between", value1, value2,
					"createUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyTimeIsNull() {
			addCriterion("MODIFY_TIME is null");
			return (Criteria) this;
		}

		public Criteria andModifyTimeIsNotNull() {
			addCriterion("MODIFY_TIME is not null");
			return (Criteria) this;
		}

		public Criteria andModifyTimeEqualTo(String value) {
			addCriterion("MODIFY_TIME =", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeNotEqualTo(String value) {
			addCriterion("MODIFY_TIME <>", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeGreaterThan(String value) {
			addCriterion("MODIFY_TIME >", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeGreaterThanOrEqualTo(String value) {
			addCriterion("MODIFY_TIME >=", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeLessThan(String value) {
			addCriterion("MODIFY_TIME <", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeLessThanOrEqualTo(String value) {
			addCriterion("MODIFY_TIME <=", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeLike(String value) {
			addCriterion("MODIFY_TIME like", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeNotLike(String value) {
			addCriterion("MODIFY_TIME not like", value, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeIn(List<String> values) {
			addCriterion("MODIFY_TIME in", values, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeNotIn(List<String> values) {
			addCriterion("MODIFY_TIME not in", values, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeBetween(String value1, String value2) {
			addCriterion("MODIFY_TIME between", value1, value2, "modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyTimeNotBetween(String value1, String value2) {
			addCriterion("MODIFY_TIME not between", value1, value2,
					"modifyTime");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowIsNull() {
			addCriterion("MODIFY_USER_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowIsNotNull() {
			addCriterion("MODIFY_USER_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowEqualTo(String value) {
			addCriterion("MODIFY_USER_FLOW =", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowNotEqualTo(String value) {
			addCriterion("MODIFY_USER_FLOW <>", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowGreaterThan(String value) {
			addCriterion("MODIFY_USER_FLOW >", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowGreaterThanOrEqualTo(String value) {
			addCriterion("MODIFY_USER_FLOW >=", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowLessThan(String value) {
			addCriterion("MODIFY_USER_FLOW <", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowLessThanOrEqualTo(String value) {
			addCriterion("MODIFY_USER_FLOW <=", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowLike(String value) {
			addCriterion("MODIFY_USER_FLOW like", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowNotLike(String value) {
			addCriterion("MODIFY_USER_FLOW not like", value, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowIn(List<String> values) {
			addCriterion("MODIFY_USER_FLOW in", values, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowNotIn(List<String> values) {
			addCriterion("MODIFY_USER_FLOW not in", values, "modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowBetween(String value1, String value2) {
			addCriterion("MODIFY_USER_FLOW between", value1, value2,
					"modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andModifyUserFlowNotBetween(String value1, String value2) {
			addCriterion("MODIFY_USER_FLOW not between", value1, value2,
					"modifyUserFlow");
			return (Criteria) this;
		}

		public Criteria andFileNameIsNull() {
			addCriterion("FILE_NAME is null");
			return (Criteria) this;
		}

		public Criteria andFileNameIsNotNull() {
			addCriterion("FILE_NAME is not null");
			return (Criteria) this;
		}

		public Criteria andFileNameEqualTo(String value) {
			addCriterion("FILE_NAME =", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameNotEqualTo(String value) {
			addCriterion("FILE_NAME <>", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameGreaterThan(String value) {
			addCriterion("FILE_NAME >", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameGreaterThanOrEqualTo(String value) {
			addCriterion("FILE_NAME >=", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameLessThan(String value) {
			addCriterion("FILE_NAME <", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameLessThanOrEqualTo(String value) {
			addCriterion("FILE_NAME <=", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameLike(String value) {
			addCriterion("FILE_NAME like", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameNotLike(String value) {
			addCriterion("FILE_NAME not like", value, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameIn(List<String> values) {
			addCriterion("FILE_NAME in", values, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameNotIn(List<String> values) {
			addCriterion("FILE_NAME not in", values, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameBetween(String value1, String value2) {
			addCriterion("FILE_NAME between", value1, value2, "fileName");
			return (Criteria) this;
		}

		public Criteria andFileNameNotBetween(String value1, String value2) {
			addCriterion("FILE_NAME not between", value1, value2, "fileName");
			return (Criteria) this;
		}
	}

	/**
	 * This class was generated by MyBatis Generator. This class corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
	 * @mbggenerated  Sat Jan 24 09:24:06 CST 2015
	 */
	public static class Criterion {
		private String condition;
		private Object value;
		private Object secondValue;
		private boolean noValue;
		private boolean singleValue;
		private boolean betweenValue;
		private boolean listValue;
		private String typeHandler;

		public String getCondition() {
			return condition;
		}

		public Object getValue() {
			return value;
		}

		public Object getSecondValue() {
			return secondValue;
		}

		public boolean isNoValue() {
			return noValue;
		}

		public boolean isSingleValue() {
			return singleValue;
		}

		public boolean isBetweenValue() {
			return betweenValue;
		}

		public boolean isListValue() {
			return listValue;
		}

		public String getTypeHandler() {
			return typeHandler;
		}

		protected Criterion(String condition) {
			super();
			this.condition = condition;
			this.typeHandler = null;
			this.noValue = true;
		}

		protected Criterion(String condition, Object value, String typeHandler) {
			super();
			this.condition = condition;
			this.value = value;
			this.typeHandler = typeHandler;
			if (value instanceof List<?>) {
				this.listValue = true;
			} else {
				this.singleValue = true;
			}
		}

		protected Criterion(String condition, Object value) {
			this(condition, value, null);
		}

		protected Criterion(String condition, Object value, Object secondValue,
				String typeHandler) {
			super();
			this.condition = condition;
			this.value = value;
			this.secondValue = secondValue;
			this.typeHandler = typeHandler;
			this.betweenValue = true;
		}

		protected Criterion(String condition, Object value, Object secondValue) {
			this(condition, value, secondValue, null);
		}
	}

	/**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table PDSCI.EXAM_BOOK_RELOAD_REC
     *
     * @mbggenerated do_not_delete_during_merge Fri Jan 23 16:14:33 CST 2015
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }
}