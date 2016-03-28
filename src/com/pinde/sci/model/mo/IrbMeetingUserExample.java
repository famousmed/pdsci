package com.pinde.sci.model.mo;

import java.util.ArrayList;
import java.util.List;

public class IrbMeetingUserExample {
    /**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	protected String orderByClause;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	protected boolean distinct;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	protected List<Criteria> oredCriteria;

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public IrbMeetingUserExample() {
		oredCriteria = new ArrayList<Criteria>();
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public void setOrderByClause(String orderByClause) {
		this.orderByClause = orderByClause;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public String getOrderByClause() {
		return orderByClause;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public void setDistinct(boolean distinct) {
		this.distinct = distinct;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public boolean isDistinct() {
		return distinct;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public List<Criteria> getOredCriteria() {
		return oredCriteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public void or(Criteria criteria) {
		oredCriteria.add(criteria);
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public Criteria or() {
		Criteria criteria = createCriteriaInternal();
		oredCriteria.add(criteria);
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public Criteria createCriteria() {
		Criteria criteria = createCriteriaInternal();
		if (oredCriteria.size() == 0) {
			oredCriteria.add(criteria);
		}
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	protected Criteria createCriteriaInternal() {
		Criteria criteria = new Criteria();
		return criteria;
	}

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
	 */
	public void clear() {
		oredCriteria.clear();
		orderByClause = null;
		distinct = false;
	}

	/**
	 * This class was generated by MyBatis Generator. This class corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
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

		public Criteria andRecordFlowIsNull() {
			addCriterion("RECORD_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andRecordFlowIsNotNull() {
			addCriterion("RECORD_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andRecordFlowEqualTo(String value) {
			addCriterion("RECORD_FLOW =", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowNotEqualTo(String value) {
			addCriterion("RECORD_FLOW <>", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowGreaterThan(String value) {
			addCriterion("RECORD_FLOW >", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowGreaterThanOrEqualTo(String value) {
			addCriterion("RECORD_FLOW >=", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowLessThan(String value) {
			addCriterion("RECORD_FLOW <", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowLessThanOrEqualTo(String value) {
			addCriterion("RECORD_FLOW <=", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowLike(String value) {
			addCriterion("RECORD_FLOW like", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowNotLike(String value) {
			addCriterion("RECORD_FLOW not like", value, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowIn(List<String> values) {
			addCriterion("RECORD_FLOW in", values, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowNotIn(List<String> values) {
			addCriterion("RECORD_FLOW not in", values, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowBetween(String value1, String value2) {
			addCriterion("RECORD_FLOW between", value1, value2, "recordFlow");
			return (Criteria) this;
		}

		public Criteria andRecordFlowNotBetween(String value1, String value2) {
			addCriterion("RECORD_FLOW not between", value1, value2,
					"recordFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowIsNull() {
			addCriterion("MEETING_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowIsNotNull() {
			addCriterion("MEETING_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowEqualTo(String value) {
			addCriterion("MEETING_FLOW =", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowNotEqualTo(String value) {
			addCriterion("MEETING_FLOW <>", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowGreaterThan(String value) {
			addCriterion("MEETING_FLOW >", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowGreaterThanOrEqualTo(String value) {
			addCriterion("MEETING_FLOW >=", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowLessThan(String value) {
			addCriterion("MEETING_FLOW <", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowLessThanOrEqualTo(String value) {
			addCriterion("MEETING_FLOW <=", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowLike(String value) {
			addCriterion("MEETING_FLOW like", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowNotLike(String value) {
			addCriterion("MEETING_FLOW not like", value, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowIn(List<String> values) {
			addCriterion("MEETING_FLOW in", values, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowNotIn(List<String> values) {
			addCriterion("MEETING_FLOW not in", values, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowBetween(String value1, String value2) {
			addCriterion("MEETING_FLOW between", value1, value2, "meetingFlow");
			return (Criteria) this;
		}

		public Criteria andMeetingFlowNotBetween(String value1, String value2) {
			addCriterion("MEETING_FLOW not between", value1, value2,
					"meetingFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowIsNull() {
			addCriterion("USER_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andUserFlowIsNotNull() {
			addCriterion("USER_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andUserFlowEqualTo(String value) {
			addCriterion("USER_FLOW =", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowNotEqualTo(String value) {
			addCriterion("USER_FLOW <>", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowGreaterThan(String value) {
			addCriterion("USER_FLOW >", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowGreaterThanOrEqualTo(String value) {
			addCriterion("USER_FLOW >=", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowLessThan(String value) {
			addCriterion("USER_FLOW <", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowLessThanOrEqualTo(String value) {
			addCriterion("USER_FLOW <=", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowLike(String value) {
			addCriterion("USER_FLOW like", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowNotLike(String value) {
			addCriterion("USER_FLOW not like", value, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowIn(List<String> values) {
			addCriterion("USER_FLOW in", values, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowNotIn(List<String> values) {
			addCriterion("USER_FLOW not in", values, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowBetween(String value1, String value2) {
			addCriterion("USER_FLOW between", value1, value2, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserFlowNotBetween(String value1, String value2) {
			addCriterion("USER_FLOW not between", value1, value2, "userFlow");
			return (Criteria) this;
		}

		public Criteria andUserNameIsNull() {
			addCriterion("USER_NAME is null");
			return (Criteria) this;
		}

		public Criteria andUserNameIsNotNull() {
			addCriterion("USER_NAME is not null");
			return (Criteria) this;
		}

		public Criteria andUserNameEqualTo(String value) {
			addCriterion("USER_NAME =", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameNotEqualTo(String value) {
			addCriterion("USER_NAME <>", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameGreaterThan(String value) {
			addCriterion("USER_NAME >", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameGreaterThanOrEqualTo(String value) {
			addCriterion("USER_NAME >=", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameLessThan(String value) {
			addCriterion("USER_NAME <", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameLessThanOrEqualTo(String value) {
			addCriterion("USER_NAME <=", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameLike(String value) {
			addCriterion("USER_NAME like", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameNotLike(String value) {
			addCriterion("USER_NAME not like", value, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameIn(List<String> values) {
			addCriterion("USER_NAME in", values, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameNotIn(List<String> values) {
			addCriterion("USER_NAME not in", values, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameBetween(String value1, String value2) {
			addCriterion("USER_NAME between", value1, value2, "userName");
			return (Criteria) this;
		}

		public Criteria andUserNameNotBetween(String value1, String value2) {
			addCriterion("USER_NAME not between", value1, value2, "userName");
			return (Criteria) this;
		}

		public Criteria andRoleFlowIsNull() {
			addCriterion("ROLE_FLOW is null");
			return (Criteria) this;
		}

		public Criteria andRoleFlowIsNotNull() {
			addCriterion("ROLE_FLOW is not null");
			return (Criteria) this;
		}

		public Criteria andRoleFlowEqualTo(String value) {
			addCriterion("ROLE_FLOW =", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowNotEqualTo(String value) {
			addCriterion("ROLE_FLOW <>", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowGreaterThan(String value) {
			addCriterion("ROLE_FLOW >", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowGreaterThanOrEqualTo(String value) {
			addCriterion("ROLE_FLOW >=", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowLessThan(String value) {
			addCriterion("ROLE_FLOW <", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowLessThanOrEqualTo(String value) {
			addCriterion("ROLE_FLOW <=", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowLike(String value) {
			addCriterion("ROLE_FLOW like", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowNotLike(String value) {
			addCriterion("ROLE_FLOW not like", value, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowIn(List<String> values) {
			addCriterion("ROLE_FLOW in", values, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowNotIn(List<String> values) {
			addCriterion("ROLE_FLOW not in", values, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowBetween(String value1, String value2) {
			addCriterion("ROLE_FLOW between", value1, value2, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleFlowNotBetween(String value1, String value2) {
			addCriterion("ROLE_FLOW not between", value1, value2, "roleFlow");
			return (Criteria) this;
		}

		public Criteria andRoleNameIsNull() {
			addCriterion("ROLE_NAME is null");
			return (Criteria) this;
		}

		public Criteria andRoleNameIsNotNull() {
			addCriterion("ROLE_NAME is not null");
			return (Criteria) this;
		}

		public Criteria andRoleNameEqualTo(String value) {
			addCriterion("ROLE_NAME =", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameNotEqualTo(String value) {
			addCriterion("ROLE_NAME <>", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameGreaterThan(String value) {
			addCriterion("ROLE_NAME >", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameGreaterThanOrEqualTo(String value) {
			addCriterion("ROLE_NAME >=", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameLessThan(String value) {
			addCriterion("ROLE_NAME <", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameLessThanOrEqualTo(String value) {
			addCriterion("ROLE_NAME <=", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameLike(String value) {
			addCriterion("ROLE_NAME like", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameNotLike(String value) {
			addCriterion("ROLE_NAME not like", value, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameIn(List<String> values) {
			addCriterion("ROLE_NAME in", values, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameNotIn(List<String> values) {
			addCriterion("ROLE_NAME not in", values, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameBetween(String value1, String value2) {
			addCriterion("ROLE_NAME between", value1, value2, "roleName");
			return (Criteria) this;
		}

		public Criteria andRoleNameNotBetween(String value1, String value2) {
			addCriterion("ROLE_NAME not between", value1, value2, "roleName");
			return (Criteria) this;
		}

		public Criteria andAttendStatusIsNull() {
			addCriterion("ATTEND_STATUS is null");
			return (Criteria) this;
		}

		public Criteria andAttendStatusIsNotNull() {
			addCriterion("ATTEND_STATUS is not null");
			return (Criteria) this;
		}

		public Criteria andAttendStatusEqualTo(String value) {
			addCriterion("ATTEND_STATUS =", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusNotEqualTo(String value) {
			addCriterion("ATTEND_STATUS <>", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusGreaterThan(String value) {
			addCriterion("ATTEND_STATUS >", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusGreaterThanOrEqualTo(String value) {
			addCriterion("ATTEND_STATUS >=", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusLessThan(String value) {
			addCriterion("ATTEND_STATUS <", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusLessThanOrEqualTo(String value) {
			addCriterion("ATTEND_STATUS <=", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusLike(String value) {
			addCriterion("ATTEND_STATUS like", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusNotLike(String value) {
			addCriterion("ATTEND_STATUS not like", value, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusIn(List<String> values) {
			addCriterion("ATTEND_STATUS in", values, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusNotIn(List<String> values) {
			addCriterion("ATTEND_STATUS not in", values, "attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusBetween(String value1, String value2) {
			addCriterion("ATTEND_STATUS between", value1, value2,
					"attendStatus");
			return (Criteria) this;
		}

		public Criteria andAttendStatusNotBetween(String value1, String value2) {
			addCriterion("ATTEND_STATUS not between", value1, value2,
					"attendStatus");
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
	}

	/**
	 * This class was generated by MyBatis Generator. This class corresponds to the database table PDSCI.IRB_MEETING_USER
	 * @mbggenerated  Thu Aug 21 17:48:25 CST 2014
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
     * This class corresponds to the database table PDSCI.IRB_MEETING_USER
     *
     * @mbggenerated do_not_delete_during_merge Sat Jul 12 11:18:45 CST 2014
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }
}