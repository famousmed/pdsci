package com.pinde.sci.common;


public class GlobalConstant {
	//工作站名称
	public static final String SYS_WS_ID = "sys";
	public static final String SRM_WS_ID = "srm";
	public static final String EDC_WS_ID = "edc";
	public static final String IRB_WS_ID = "irb";
	public static final String GCP_WS_ID = "gcp";
	public static final String AEM_WS_ID = "aem";
	public static final String SCH_WS_ID = "sch";
	public static final String EDU_WS_ID = "edu";
	public static final String ERP_WS_ID = "erp";
	public static final String RES_WS_ID = "res";
	public static final String NJMUEDU_WS_ID = "njmuedu";
	public static final String PD_ORG_FLOW="00000000000000000000000000000000";	
	public static final String PD_ORG_CODE="080279573";
	public static final String PD_ORG_NAME="南京迈拓";
	
	
	
	//项目管理配置文件和jsp路径
//	public static final String SRM_PROJ_PAGE_CONFIG_PATH = "srm/product/config";
	public static final String SRM_FORM_CONFIG_PATH = "srm/form";
	
	//伦理审查表单
	public static final String IRB_FORM_CONFIG_PATH = "irb/form";
	
	public static final String IRB_FORM_PRODUCT = "product";
	public static final String IRB_FORM_PRODUCT_VER = "1.0";
	public static final String IRB_FORM_APPLICATION = "Application";
	public static final String IRB_FORM_WORKSHEET = "Worksheet";
	public static final String IRB_FORM_SUGGEST = "suggest";
	public static final String IRB_FORM_DECISION = "decision";
	
	
	//超级用户账号
	public static final String ROOT_USER_FLOW="00000000000000000000000000000000";	
	//超级用户账号
	public static final String ROOT_USER_CODE="root";
	//超级用户账号
	public static final String ROOT_USER_NAME="超级管理员";
	//系统默认密码
	public static final String INIT_PASSWORD="123456";
	
	//默认起始页
	public static final Integer DEFAULT_START_PAGE = 1;
	//默认每页显示记录数
	public static final Integer DEFAULT_PAGE_SIZE = 10;
	public static final String PAGE_SIZE = "pageSize";
	public static final String PAGE_SERVLET_PATH = "pageServletPath";
	
	
	//用户维护 范围标记
	public static final String USER_LIST_SCOPE="userListScope";
	//用户维护 不限
	public static final String USER_LIST_GLOBAL="global";
	//省厅下级审核部门
	public static final String USER_LIST_PROVINCE="province";
	//用户维护 主管部门
	public static final String USER_LIST_CHARGE="charge";
	//用户维护 限本机构
	public static final String USER_LIST_LOCAL="local";
	//用户维护 限本人
	public static final String USER_LIST_PERSONAL="personal";
	
	//部门维护 范围标记
	public static final String DEPT_LIST_SCOPE="deptListScope";
	//部门维护 不限
	public static final String DEPT_LIST_GLOBAL="global";
	//部门维护 限本机构
	public static final String DEPT_LIST_LOCAL="local";
	
	//项目种类 范围标记
	public static final String PROJ_CATE_SCOPE="projCateScope";
	
	//项目显示 范围标记
	public static final String PROJ_LIST_SCOPE="projListScope";
	//显示项目记录的类型
	public static final String PROJ_RECORD_TYPE="recTypeId";	
	// 显示项目列表的scope 本机构
	public static final String PROJ_STATUS_SCOPE_PERSONAL="personal";
	// 显示项目列表的scope 本机构
	public static final String PROJ_STATUS_SCOPE_LOCAL="local";	
	// 显示项目列表的scope 主管部门
	public static final String PROJ_STATUS_SCOPE_CHARGE="charge";	
	// 显示项目列表的scope 卫生局
	public static final String PROJ_STATUS_SCOPE_GLOBAL="global";
	//当前用户
	public static final String CURRENT_USER="currUser";	
	//当前机构
	public static final String CURRENT_ORG="currOrg";	
	//当前部门列表
	public static final String CURRENT_DEPT_LIST="currDeptList";	
	//当前部门
	public static final String CURRENT_DEPT="currDept";
	//当前用户
	public static final String CURRENT_USER_NAME="currUserName";	
	//当前用户具有的角色
	public static final String CURRENT_ROLE_LIST="currRoleList";
	//当前用户允许使用的菜单
	public static final String CURRENT_MENU_ID_LIST="currUserMenuIdList";
	//当前用户允许使用的菜单组
	public static final String CURRENT_MENU_SET_ID_LIST="currUserMenuSetIdList";
	//当前用户允许使用的模块
	public static final String CURRENT_MODULE_ID_LIST="currUserModuleIdList";
	//当前用户允许使用的工作站
	public static final String CURRENT_WORKSTATION_ID_LIST="currUserWorkStationIdList";	
	//当前用户具有的角色-备份
	public static final String CURRENT_ROLE_LIST_BACKUP="currRoleListBackup";
	//当前用户允许使用的菜单-备份
	public static final String CURRENT_MENU_ID_LIST_BACKUP="currUserMenuIdListBackup";
	//当前用户允许使用的菜单组-备份
	public static final String CURRENT_MENU_SET_ID_LIST_BACKUP="currUserMenuSetIdListBackup";
	//当前用户允许使用的模块-备份
	public static final String CURRENT_MODULE_ID_LIST_BACKUP="currUserModuleIdListBackup";
	//当前用户允许使用的工作站-备份
	public static final String CURRENT_WORKSTATION_ID_LIST_BACKUP="currUserWorkStationIdListBackup";	
	//当前工作站名称
	public static final String CURRENT_WS_ID="currWsId";	
	//当前工作站名称
	public static final String CURRENT_MODULE_ID="currModuleId";	
	//当前EDC项目
	public static final String EDC_CURR_PROJ="edcCurrProj";
	//当前伦理审查
	public static final String CURR_IRB="currIrb";
	//当前EDC项目
	public static final String EDC_CURR_PROJ_PARAM="edcCurrProjParam";
	//当前EDC项目设计表单
	public static final String PROJ_DESC_FORM="projDescForm";
	//录入当前受试者
	public static final String EDC_CURR_PATIENT = "currPatient";
	//录入当前受试者
	public static final String EDC_CURR_VISIT = "currVisit";
	//当前用户个人中心页面路径（EDU）
	public static final String CURRENT_VIEW="currView";
	//RES当前考试
	public static final String CURRENT_EXAM="currExam";
	
	
	//数据伪删除标记，没有业务含义
	public static final String RECORD_STATUS_Y = "Y";
	public static final String RECORD_STATUS_N = "N";
	public static final String RECORD_STATUS_D = "D";
	//锁定标记
	public static final String LOCK_STATUS_Y = "Y";
	public static final String LOCK_STATUS_N = "N";
	
	public static final String FLAG_Y = "Y";
	public static final String FLAG_N = "N";
	public static final String FLAG_F = "F";
	public static final String NULL = "NULL";
	public static final String NOT_NULL = "NOTNULL";
	
	public static final String REFRESH_SUCCESSED="刷新成功！";
	  
	public static final String OPRE_SUCCESSED="操作成功！";
	
	public static final String OPRE_FAIL="操作失败！";
	
	public static final String NOT_START="无法启用该方案，该方案所属项目来源已有被启动的方案！";
	
	public static final String OPRE_SUCCESSED_FLAG="1";
	
	public static final String OPRE_FAIL_FLAG="0";
	
	public static final String SAVE_SUCCESSED="保存成功！";
	
	public static final String SAVE_FAIL="保存失败！";
	
	public static final String SELECT_SUCCESSED="切换成功！";
	
	public static final String RELEASE_SUCCESSED="发布成功！";
	
	public static final String RELEASE_FAIL="发布失败！";
	
	public static final String UPDATE_SUCCESSED="修改成功！";
	
	public static final String UPDATE_FAIL="修改失败！";
	
	public static final String PREPARE_APPROVAL_SUCCESSED="送审成功！";
	
	public static final String SEND_INVITE_EMAIL_SUCCESSED="发送邀请链接成功！";
	
	public static final String PREPARE_APPROVAL_FAIL="送审失败！";
	
	public static final String RESET_SUCCESSED="重置成功！";
	
	public static final String ACTIVATE_SUCCESSED="重置成功！";
	
	public static final String LOCK_SUCCESSED="锁定成功！";
	
	public static final String PASSWD_ERROR="输入错误,请重新输入原始密码";

	public static final String DELETE_SUCCESSED="删除成功！";
	
	public static final String DELETE_FAIL="删除失败！";

	public static final String OPERATE_SUCCESSED="操作成功！";

	public static final String USER_REG_SUCCESSED="注册成功！";
	//用户名重复
	public static final String USER_CODE_REPETE="该用户名已经被注册！";
	//身份证号重复
	public static final String USER_ID_NO_REPETE="该身份证号已经被注册！";
	//学号重复
	public static final String USER_SID_REPETE="该学号已经存在！";
	//手机号重复
	public static final String USER_PHONE_REPETE="该手机号已经被注册！";
	//电子邮箱重复
	public static final String USER_EMAIL_REPETE="该电子邮箱已经被注册！";
	//姓名不匹配
	public static final String USER_NAME_NOT_EQUAL="姓名不匹配！";
	//身份证号不匹配
	public static final String USER_ID_NO_NOT_EQUAL="身份证号不匹配！";
	//身份证号不匹配
    public static final String USER_ID_NO_VALIDATE="请填写有效身份证";
    //身份证号不匹配 
    public static final String USER_ID_NO_NULL="证件号码不能为空";
	//手机号不匹配
	public static final String USER_PHONE_NOT_EQUAL="手机号不匹配！";
	//所在机构不匹配
	public static final String USER_ORG_NOT_EQUAL="所在机构不匹配！";
	//电子邮箱不匹配
	public static final String USER_EMAIL_NOT_EQUAL="电子邮箱不匹配！";
	//两次密码输入不一致
	public static final String USER_PASSWD_NOT_EQUAL="两次密码输入不一致！";	
	//课程代码已存在
	public static final String COURSE_COURSECODE_EXIST="代码已存在！";
	//课程代码不存在
	public static final String COURSE_COURSECODE_SUCCESSED="可以使用！";
	//用户名不存在
	public static final String USER_CODE_NOT_EXIST="该用户名不存在！";
	//手机号不存在
	public static final String USER_PHONE_NOT_EXIST="该手机号不存在！";
	//电子邮箱不存在
	public static final String USER_EMAIL_NOT_EXIST="该电子邮箱不存在！";
	//电子邮箱不存在
	public static final String ID_NO_NOT_EXIST="该身份证号不存在！";
	
	//客户名称已存在
	public static final String CRM_CUSTOMER_NAME_EXIST = "客户名称已存在！";

	//配置文件中标记为file的
	public static final String IS_FILE = "isFile";
	public static final String RANDOM_FAIL_CFG = "申请失败,请确认是否设置随机类型!";
	public static final String RANDOM_SUCCESSED = "申请成功";   
	public static final String RANDOM_FAIL_RREC = "申请失败,未发现可用的随机记录";
	public static final String RANDOM_FAIL_DRUG = "申请失败,未发现当前匹配的组别药物";
	public static final String PROMPT_SUCCESSED = "揭盲成功";
	public static final String PROMPT_FAIL = "揭盲失败！";
	//元素添加默认属性
	public static final String DEFAULT_ATTR_VALUE_NAME = "录入值";
	public static final String DEFAULT_ATTR_VALUE_VAR_NAME = "val";
	public static final String DEFAULT_ATTR_UNIT_NAME = "单位";
	public static final String DEFAULT_ATTR_UNIT_VAR_NAME = "unit";
	public static final String DEFAULT_ATTR_ABNORMAL_NAME = "是否异常";
	public static final String DEFAULT_ATTR_ABNORMAL_VAR_NAME = "abnormal";
	public static final String DEFAULT_ATTR_DATA_LENGTH = "100";
	public static final int DEFAULT_ATTR_ORDINAL = 1;
	public static final int DEFAULT_TEST_PATIENT_COUNT = 10;
		//实验室检查模块
	public static final String MODULD_TYPE_LB = "LB";
	
	public static final String QUERY_TYPE_SDV = "8";
	
	//异常录入提示
	public static final String INPUT_TIP_BLANK = "未录入数据";
	public static final String INPUT_TIP_LB = "异常，超出正常值范围：";
	
	public static final String MANUAL_QUERY_CONFIRM="存在未解决的疑问,请处理后再发送手工疑问！";
	
	//上传图片
	public static final String UPLOAD_SUCCESSED="上传成功！";
	public static final String UPLOAD_FAIL="上传失败！";
	public static final String UPLOAD_IMG_SIZE_ERROR="文件大小不能超过";
	public static final String UPLOAD_IMG_TYPE_ERROR="只支持上传bmp/gif/jpg/png！";
	public static final String UPLOAD_FILE_NULL="文件为空！";
	public static final String VALIDATE_FILE_FAIL = "文件校验失败,请选择正确的文件重新上传";
	public static final String FILE_SIZE_PASS_SCOPE = "文件大小超过范围";
	
	//数据库受影响的行数
	public static final int ZERO_LINE = 0;
	public static final int ONE_LINE = 1;
	//人才培养文档类型
	public static final String AID_DOC_TYPE_TALENTS = "talents";//申请表
	public static final String AID_DOC_TYPE_ASSESS = "assess";//评价表
	//特殊业务参数
	public static final String SPECIAL_PARAM = "-1";
	
	/***********伦理**********/
	//送审文件清单code
	public static final String APPLY_FILE_CFG_CODE="irb_apply_file";
	//需补充标识
	public static final String NOTICE_TYPE_APPLY="apply";
	//需修改标识
	public static final String NOTICE_TYPE_MODIFY="modify";
	
	
	//访视类型
	public static final String VISIT_TYPE_CM = "88";		//合并用药
	public static final String VISIT_TYPE_AE = "77";		//不良事件
	public static final String VISIT_TYPE_OW = "4";		//时点外页面
	
	//受理处理
	public static final String NOTICE_OPER_ERROR="已上传文件没有全部确认，无权进行下一步操作！";
	public static final String CHECKWAY_OPER_ERROR="受理通知未完成，无权进行下一步操作！";
	public static final String CHOOSE_MEMBER_OPER_ERROR="审查方式未完成，无权进行下一步操作！";
	//独立顾问名称
	public static final String INDEPENDENT_MEMBER="独立顾问";
	//审查项目角色
	public static final String IRB_COMMITTEE_USER="user";//委员
	public static final String IRB_COMMITTEE_SECRETARY="secretary";//秘书
	//审查决定-利益冲突
	public static final String IRB_DECISION_CONFLICT="conflict";
	//主席委员角色开关
	public static final String IRB_SIGN_ROLE_FLOW="irb_sign_role_flow";
	
    //返回值异常
	public static final int smallZero = -1;
	
	//疑问发送方式
	public static final String SEND_WAY_SDV = "S";		//SDV疑问
	public static final String SEND_WAY_MANUAL = "M";	//手工疑问
	public static final String SEND_WAY_LOGIC = "L";	//逻辑检查
	public static final String IRB_DEFAULT_TRACK_REMAIND = "30";
	
	/***********GCP**********/
	//文件清单code
	public static final String GCP_APPLY_FILE_CFG_CODE="gcp_apply_file";	
	public static final String GCP_FINISH_FILE_CFG_CODE="gcp_finish_file";	
	public static final String RESEARCHER_ROLE_FLOW="researcher_role_flow";	//主要研究者角色
	public static final String DECLARER_ROLE_FLOW="declarer_role_flow";	//申办方角色
	public static final String ROLE_SCOPE_DECLARER="declarer";	//申办方
	public static final String ROLE_SCOPE_RESEARCHER="researcher";	//主要研究者
	public static final String ROLE_SCOPE_GO="go";	//机构
	//质控表单
	public static final String QC_FORM_CONFIG_PATH = "gcp/form";
	public static final String QC_FORM_PRODUCT = "product";
	public static final String QC_FORM_PRODUCT_VER = "1.0";
	//质控配置
	public static final String GCP_QC_REMIND = "gcp_qc_remind";
	//尚未选择该课程提示
	public static final String COURSE_LIST_NO_CONTAINS ="你还没有选择该课程！";
	//有章节尚未学习完
	public static final String SOME_CHAPTER_NO_FINISH="你之前还有未学习完的章节！";
	//老师角色
	public static final String TEACHER_ROLE="teacher";
	//学生角色
	public static final String STUDENT_ROLE="student";
	//学校管理员角色
	public static final String ADMIN_ROLE="admin";
	//系统管理员角色
	public static final String SYSTEM_ROLE="system";
	//eduUser session
	public static final String CURR_EDU_USER="currEduUser";
	//此课程没有正常结束
	public static final String NOT_NORMAL_FINISH_COURSE="此课程没有正常结束";
	//已经是最后一章
	public static final String LAST_CHAPTER="已经是最后一章";
	//项目种类 范围标记
	public static final String EXAM_BANK_TYPE="examBankType";
	//项目种类 范围标记
	public static final String EXAM_BANK_TYPE_NAME="examBankTypeName";
     	
    public static final String FILE_BEYOND_LIMIT="文件过大，文件大小不得超过100MB";
	
    //eduUser session
  	public static final String CURR_NJMUEDU_USER="currNjmuEduUser";
  	
  	
	/**********res*************/
	//住院医师表单
	public static final String RES_FORM_CONFIG_PATH = "res/form";
	public static final String RES_FORM_PRODUCT = "product";
	public static final String RES_FORM_PRODUCT_VER = "1.0";
    //res角色
	public static final String RES_ROLE_SCOPE_DOCTOR = "doctor";//医师
	public static final String RES_ROLE_SCOPE_LEADER = "leader";//组长
	public static final String RES_ROLE_SCOPE_TUTOR = "tutor";//导师
	public static final String RES_ROLE_SCOPE_TEACHER = "teacher";//带教
	public static final String RES_ROLE_SCOPE_HEAD = "head";//科主任
	public static final String RES_ROLE_SCOPE_MANAGER = "manager";//基地主任
	public static final String RES_ROLE_SCOPE_ADMIN = "admin";//管理员
	public static final String RES_ROLE_SCOPE_CHARGE = "charge";//平台
	//平台
	//public static final String RES_ROLE_SCOPE_PLATFORM = "platform";
	//要求默认其他项
	public static final String RES_REQ_OTHER_ITEM_ID = "00000000000000000000000000000000";
	public static final String RES_REQ_OTHER_ITEM_NAME = "其他";
	/**********hbres*************/
	public static final String HBRES_SPECIALIZED = "医学检验";
	/************erp*****************/
	//ERP总经理特殊标记
	public static final String MANAGER_FLAG="managerFlag";
	//ERP商务特殊标记
	public static final String BUSINESS_FLAG="businessFlag";
	public static final String BUSINESS_DEPT_FLAG="businessDeptFlag";
	//ERP查询范围标记
	public static final String TYPE_SCOPE="typeScope";
	//ERP派工单改派审核标记
	public static final String APPLY_AUDIT="applyAudit";
	//ERP派工单接收审核标记
	public static final String APPLY_TARGET_AUDIT="applyTargetAudit";
	//ERP派工单经理完成审核标记
	public static final String MANAGER_AUDIT="managerAudit";
	//ERP派工单助理完成审核标记
	public static final String ASSISTANT_AUDIT="assistantAudit";
	
	//不可绑定标记
	public static final int CAN_NOT_BIND_FLAG=00;
	
	public static final String CAN_NOT_BIND="该课程已绑定其他试卷";
	
	public static final String FILE_TYPE_NOT_SUPPORT="文件格式不支持！";
	
	public static final String PLEASE_INPUT_TRUE_FILEURL="请输入正确的文件路径！";
	
	//江苏省审核信息
	public static final String BASIC_INFO="BasicInfo";
	
	public static final String ORG_MANAGE="OrgManage";
	
	public static final String TEACH_CONDITION="TeachCondition";
	
	public static final String SUPPORT_CONDITION="SupportCondition";
	
	
	//enso
	public static final String PI_ROLE_FLOW="817cf2c8cb5b4dceb689015359d5c209";
	public static final String REACHER_ROLE_FLOW="dbb6c577f6b64659a2c1a49371cf0e20";
	public static final String CRC_ROLE_FLOW="107bbd0e2d9e42d3b0f04d53bfb234b3";
	
}