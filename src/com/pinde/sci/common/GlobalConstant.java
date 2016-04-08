package com.pinde.sci.common;


public class GlobalConstant {
	//����վ����
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
	public static final String PD_ORG_NAME="�Ͼ�����";
	
	
	
	//��Ŀ���������ļ���jsp·��
//	public static final String SRM_PROJ_PAGE_CONFIG_PATH = "srm/product/config";
	public static final String SRM_FORM_CONFIG_PATH = "srm/form";
	
	//��������
	public static final String IRB_FORM_CONFIG_PATH = "irb/form";
	
	public static final String IRB_FORM_PRODUCT = "product";
	public static final String IRB_FORM_PRODUCT_VER = "1.0";
	public static final String IRB_FORM_APPLICATION = "Application";
	public static final String IRB_FORM_WORKSHEET = "Worksheet";
	public static final String IRB_FORM_SUGGEST = "suggest";
	public static final String IRB_FORM_DECISION = "decision";
	
	
	//�����û��˺�
	public static final String ROOT_USER_FLOW="00000000000000000000000000000000";	
	//�����û��˺�
	public static final String ROOT_USER_CODE="root";
	//�����û��˺�
	public static final String ROOT_USER_NAME="��������Ա";
	//ϵͳĬ������
	public static final String INIT_PASSWORD="123456";
	
	//Ĭ����ʼҳ
	public static final Integer DEFAULT_START_PAGE = 1;
	//Ĭ��ÿҳ��ʾ��¼��
	public static final Integer DEFAULT_PAGE_SIZE = 10;
	public static final String PAGE_SIZE = "pageSize";
	public static final String PAGE_SERVLET_PATH = "pageServletPath";
	
	
	//�û�ά�� ��Χ���
	public static final String USER_LIST_SCOPE="userListScope";
	//�û�ά�� ����
	public static final String USER_LIST_GLOBAL="global";
	//ʡ���¼���˲���
	public static final String USER_LIST_PROVINCE="province";
	//�û�ά�� ���ܲ���
	public static final String USER_LIST_CHARGE="charge";
	//�û�ά�� �ޱ�����
	public static final String USER_LIST_LOCAL="local";
	//�û�ά�� �ޱ���
	public static final String USER_LIST_PERSONAL="personal";
	
	//����ά�� ��Χ���
	public static final String DEPT_LIST_SCOPE="deptListScope";
	//����ά�� ����
	public static final String DEPT_LIST_GLOBAL="global";
	//����ά�� �ޱ�����
	public static final String DEPT_LIST_LOCAL="local";
	
	//��Ŀ���� ��Χ���
	public static final String PROJ_CATE_SCOPE="projCateScope";
	
	//��Ŀ��ʾ ��Χ���
	public static final String PROJ_LIST_SCOPE="projListScope";
	//��ʾ��Ŀ��¼������
	public static final String PROJ_RECORD_TYPE="recTypeId";	
	// ��ʾ��Ŀ�б��scope ������
	public static final String PROJ_STATUS_SCOPE_PERSONAL="personal";
	// ��ʾ��Ŀ�б��scope ������
	public static final String PROJ_STATUS_SCOPE_LOCAL="local";	
	// ��ʾ��Ŀ�б��scope ���ܲ���
	public static final String PROJ_STATUS_SCOPE_CHARGE="charge";	
	// ��ʾ��Ŀ�б��scope ������
	public static final String PROJ_STATUS_SCOPE_GLOBAL="global";
	//��ǰ�û�
	public static final String CURRENT_USER="currUser";	
	//��ǰ����
	public static final String CURRENT_ORG="currOrg";	
	//��ǰ�����б�
	public static final String CURRENT_DEPT_LIST="currDeptList";	
	//��ǰ����
	public static final String CURRENT_DEPT="currDept";
	//��ǰ�û�
	public static final String CURRENT_USER_NAME="currUserName";	
	//��ǰ�û����еĽ�ɫ
	public static final String CURRENT_ROLE_LIST="currRoleList";
	//��ǰ�û�����ʹ�õĲ˵�
	public static final String CURRENT_MENU_ID_LIST="currUserMenuIdList";
	//��ǰ�û�����ʹ�õĲ˵���
	public static final String CURRENT_MENU_SET_ID_LIST="currUserMenuSetIdList";
	//��ǰ�û�����ʹ�õ�ģ��
	public static final String CURRENT_MODULE_ID_LIST="currUserModuleIdList";
	//��ǰ�û�����ʹ�õĹ���վ
	public static final String CURRENT_WORKSTATION_ID_LIST="currUserWorkStationIdList";	
	//��ǰ�û����еĽ�ɫ-����
	public static final String CURRENT_ROLE_LIST_BACKUP="currRoleListBackup";
	//��ǰ�û�����ʹ�õĲ˵�-����
	public static final String CURRENT_MENU_ID_LIST_BACKUP="currUserMenuIdListBackup";
	//��ǰ�û�����ʹ�õĲ˵���-����
	public static final String CURRENT_MENU_SET_ID_LIST_BACKUP="currUserMenuSetIdListBackup";
	//��ǰ�û�����ʹ�õ�ģ��-����
	public static final String CURRENT_MODULE_ID_LIST_BACKUP="currUserModuleIdListBackup";
	//��ǰ�û�����ʹ�õĹ���վ-����
	public static final String CURRENT_WORKSTATION_ID_LIST_BACKUP="currUserWorkStationIdListBackup";	
	//��ǰ����վ����
	public static final String CURRENT_WS_ID="currWsId";	
	//��ǰ����վ����
	public static final String CURRENT_MODULE_ID="currModuleId";	
	//��ǰEDC��Ŀ
	public static final String EDC_CURR_PROJ="edcCurrProj";
	//��ǰ�������
	public static final String CURR_IRB="currIrb";
	//��ǰEDC��Ŀ
	public static final String EDC_CURR_PROJ_PARAM="edcCurrProjParam";
	//��ǰEDC��Ŀ��Ʊ�
	public static final String PROJ_DESC_FORM="projDescForm";
	//¼�뵱ǰ������
	public static final String EDC_CURR_PATIENT = "currPatient";
	//¼�뵱ǰ������
	public static final String EDC_CURR_VISIT = "currVisit";
	//��ǰ�û���������ҳ��·����EDU��
	public static final String CURRENT_VIEW="currView";
	//RES��ǰ����
	public static final String CURRENT_EXAM="currExam";
	
	
	//����αɾ����ǣ�û��ҵ����
	public static final String RECORD_STATUS_Y = "Y";
	public static final String RECORD_STATUS_N = "N";
	public static final String RECORD_STATUS_D = "D";
	//�������
	public static final String LOCK_STATUS_Y = "Y";
	public static final String LOCK_STATUS_N = "N";
	
	public static final String FLAG_Y = "Y";
	public static final String FLAG_N = "N";
	public static final String FLAG_F = "F";
	public static final String NULL = "NULL";
	public static final String NOT_NULL = "NOTNULL";
	
	public static final String REFRESH_SUCCESSED="ˢ�³ɹ���";
	  
	public static final String OPRE_SUCCESSED="�����ɹ���";
	
	public static final String OPRE_FAIL="����ʧ�ܣ�";
	
	public static final String NOT_START="�޷����ø÷������÷���������Ŀ��Դ���б������ķ�����";
	
	public static final String OPRE_SUCCESSED_FLAG="1";
	
	public static final String OPRE_FAIL_FLAG="0";
	
	public static final String SAVE_SUCCESSED="����ɹ���";
	
	public static final String SAVE_FAIL="����ʧ�ܣ�";
	
	public static final String SELECT_SUCCESSED="�л��ɹ���";
	
	public static final String RELEASE_SUCCESSED="�����ɹ���";
	
	public static final String RELEASE_FAIL="����ʧ�ܣ�";
	
	public static final String UPDATE_SUCCESSED="�޸ĳɹ���";
	
	public static final String UPDATE_FAIL="�޸�ʧ�ܣ�";
	
	public static final String PREPARE_APPROVAL_SUCCESSED="����ɹ���";
	
	public static final String SEND_INVITE_EMAIL_SUCCESSED="�����������ӳɹ���";
	
	public static final String PREPARE_APPROVAL_FAIL="����ʧ�ܣ�";
	
	public static final String RESET_SUCCESSED="���óɹ���";
	
	public static final String ACTIVATE_SUCCESSED="���óɹ���";
	
	public static final String LOCK_SUCCESSED="�����ɹ���";
	
	public static final String PASSWD_ERROR="�������,����������ԭʼ����";

	public static final String DELETE_SUCCESSED="ɾ���ɹ���";
	
	public static final String DELETE_FAIL="ɾ��ʧ�ܣ�";

	public static final String OPERATE_SUCCESSED="�����ɹ���";

	public static final String USER_REG_SUCCESSED="ע��ɹ���";
	//�û����ظ�
	public static final String USER_CODE_REPETE="���û����Ѿ���ע�ᣡ";
	//���֤���ظ�
	public static final String USER_ID_NO_REPETE="�����֤���Ѿ���ע�ᣡ";
	//ѧ���ظ�
	public static final String USER_SID_REPETE="��ѧ���Ѿ����ڣ�";
	//�ֻ����ظ�
	public static final String USER_PHONE_REPETE="���ֻ����Ѿ���ע�ᣡ";
	//���������ظ�
	public static final String USER_EMAIL_REPETE="�õ��������Ѿ���ע�ᣡ";
	//������ƥ��
	public static final String USER_NAME_NOT_EQUAL="������ƥ�䣡";
	//���֤�Ų�ƥ��
	public static final String USER_ID_NO_NOT_EQUAL="���֤�Ų�ƥ�䣡";
	//���֤�Ų�ƥ��
    public static final String USER_ID_NO_VALIDATE="����д��Ч���֤";
    //���֤�Ų�ƥ�� 
    public static final String USER_ID_NO_NULL="֤�����벻��Ϊ��";
	//�ֻ��Ų�ƥ��
	public static final String USER_PHONE_NOT_EQUAL="�ֻ��Ų�ƥ�䣡";
	//���ڻ�����ƥ��
	public static final String USER_ORG_NOT_EQUAL="���ڻ�����ƥ�䣡";
	//�������䲻ƥ��
	public static final String USER_EMAIL_NOT_EQUAL="�������䲻ƥ�䣡";
	//�����������벻һ��
	public static final String USER_PASSWD_NOT_EQUAL="�����������벻һ�£�";	
	//�γ̴����Ѵ���
	public static final String COURSE_COURSECODE_EXIST="�����Ѵ��ڣ�";
	//�γ̴��벻����
	public static final String COURSE_COURSECODE_SUCCESSED="����ʹ�ã�";
	//�û���������
	public static final String USER_CODE_NOT_EXIST="���û��������ڣ�";
	//�ֻ��Ų�����
	public static final String USER_PHONE_NOT_EXIST="���ֻ��Ų����ڣ�";
	//�������䲻����
	public static final String USER_EMAIL_NOT_EXIST="�õ������䲻���ڣ�";
	//�������䲻����
	public static final String ID_NO_NOT_EXIST="�����֤�Ų����ڣ�";
	
	//�ͻ������Ѵ���
	public static final String CRM_CUSTOMER_NAME_EXIST = "�ͻ������Ѵ��ڣ�";

	//�����ļ��б��Ϊfile��
	public static final String IS_FILE = "isFile";
	public static final String RANDOM_FAIL_CFG = "����ʧ��,��ȷ���Ƿ������������!";
	public static final String RANDOM_SUCCESSED = "����ɹ�";   
	public static final String RANDOM_FAIL_RREC = "����ʧ��,δ���ֿ��õ������¼";
	public static final String RANDOM_FAIL_DRUG = "����ʧ��,δ���ֵ�ǰƥ������ҩ��";
	public static final String PROMPT_SUCCESSED = "��ä�ɹ�";
	public static final String PROMPT_FAIL = "��äʧ�ܣ�";
	//Ԫ�����Ĭ������
	public static final String DEFAULT_ATTR_VALUE_NAME = "¼��ֵ";
	public static final String DEFAULT_ATTR_VALUE_VAR_NAME = "val";
	public static final String DEFAULT_ATTR_UNIT_NAME = "��λ";
	public static final String DEFAULT_ATTR_UNIT_VAR_NAME = "unit";
	public static final String DEFAULT_ATTR_ABNORMAL_NAME = "�Ƿ��쳣";
	public static final String DEFAULT_ATTR_ABNORMAL_VAR_NAME = "abnormal";
	public static final String DEFAULT_ATTR_DATA_LENGTH = "100";
	public static final int DEFAULT_ATTR_ORDINAL = 1;
	public static final int DEFAULT_TEST_PATIENT_COUNT = 10;
		//ʵ���Ҽ��ģ��
	public static final String MODULD_TYPE_LB = "LB";
	
	public static final String QUERY_TYPE_SDV = "8";
	
	//�쳣¼����ʾ
	public static final String INPUT_TIP_BLANK = "δ¼������";
	public static final String INPUT_TIP_LB = "�쳣����������ֵ��Χ��";
	
	public static final String MANUAL_QUERY_CONFIRM="����δ���������,�봦����ٷ����ֹ����ʣ�";
	
	//�ϴ�ͼƬ
	public static final String UPLOAD_SUCCESSED="�ϴ��ɹ���";
	public static final String UPLOAD_FAIL="�ϴ�ʧ�ܣ�";
	public static final String UPLOAD_IMG_SIZE_ERROR="�ļ���С���ܳ���";
	public static final String UPLOAD_IMG_TYPE_ERROR="ֻ֧���ϴ�bmp/gif/jpg/png��";
	public static final String UPLOAD_FILE_NULL="�ļ�Ϊ�գ�";
	public static final String VALIDATE_FILE_FAIL = "�ļ�У��ʧ��,��ѡ����ȷ���ļ������ϴ�";
	public static final String FILE_SIZE_PASS_SCOPE = "�ļ���С������Χ";
	
	//���ݿ���Ӱ�������
	public static final int ZERO_LINE = 0;
	public static final int ONE_LINE = 1;
	//�˲������ĵ�����
	public static final String AID_DOC_TYPE_TALENTS = "talents";//�����
	public static final String AID_DOC_TYPE_ASSESS = "assess";//���۱�
	//����ҵ�����
	public static final String SPECIAL_PARAM = "-1";
	
	/***********����**********/
	//�����ļ��嵥code
	public static final String APPLY_FILE_CFG_CODE="irb_apply_file";
	//�貹���ʶ
	public static final String NOTICE_TYPE_APPLY="apply";
	//���޸ı�ʶ
	public static final String NOTICE_TYPE_MODIFY="modify";
	
	
	//��������
	public static final String VISIT_TYPE_CM = "88";		//�ϲ���ҩ
	public static final String VISIT_TYPE_AE = "77";		//�����¼�
	public static final String VISIT_TYPE_OW = "4";		//ʱ����ҳ��
	
	//������
	public static final String NOTICE_OPER_ERROR="���ϴ��ļ�û��ȫ��ȷ�ϣ���Ȩ������һ��������";
	public static final String CHECKWAY_OPER_ERROR="����֪ͨδ��ɣ���Ȩ������һ��������";
	public static final String CHOOSE_MEMBER_OPER_ERROR="��鷽ʽδ��ɣ���Ȩ������һ��������";
	//������������
	public static final String INDEPENDENT_MEMBER="��������";
	//�����Ŀ��ɫ
	public static final String IRB_COMMITTEE_USER="user";//ίԱ
	public static final String IRB_COMMITTEE_SECRETARY="secretary";//����
	//������-�����ͻ
	public static final String IRB_DECISION_CONFLICT="conflict";
	//��ϯίԱ��ɫ����
	public static final String IRB_SIGN_ROLE_FLOW="irb_sign_role_flow";
	
    //����ֵ�쳣
	public static final int smallZero = -1;
	
	//���ʷ��ͷ�ʽ
	public static final String SEND_WAY_SDV = "S";		//SDV����
	public static final String SEND_WAY_MANUAL = "M";	//�ֹ�����
	public static final String SEND_WAY_LOGIC = "L";	//�߼����
	public static final String IRB_DEFAULT_TRACK_REMAIND = "30";
	
	/***********GCP**********/
	//�ļ��嵥code
	public static final String GCP_APPLY_FILE_CFG_CODE="gcp_apply_file";	
	public static final String GCP_FINISH_FILE_CFG_CODE="gcp_finish_file";	
	public static final String RESEARCHER_ROLE_FLOW="researcher_role_flow";	//��Ҫ�о��߽�ɫ
	public static final String DECLARER_ROLE_FLOW="declarer_role_flow";	//��췽��ɫ
	public static final String ROLE_SCOPE_DECLARER="declarer";	//��췽
	public static final String ROLE_SCOPE_RESEARCHER="researcher";	//��Ҫ�о���
	public static final String ROLE_SCOPE_GO="go";	//����
	//�ʿر�
	public static final String QC_FORM_CONFIG_PATH = "gcp/form";
	public static final String QC_FORM_PRODUCT = "product";
	public static final String QC_FORM_PRODUCT_VER = "1.0";
	//�ʿ�����
	public static final String GCP_QC_REMIND = "gcp_qc_remind";
	//��δѡ��ÿγ���ʾ
	public static final String COURSE_LIST_NO_CONTAINS ="�㻹û��ѡ��ÿγ̣�";
	//���½���δѧϰ��
	public static final String SOME_CHAPTER_NO_FINISH="��֮ǰ����δѧϰ����½ڣ�";
	//��ʦ��ɫ
	public static final String TEACHER_ROLE="teacher";
	//ѧ����ɫ
	public static final String STUDENT_ROLE="student";
	//ѧУ����Ա��ɫ
	public static final String ADMIN_ROLE="admin";
	//ϵͳ����Ա��ɫ
	public static final String SYSTEM_ROLE="system";
	//eduUser session
	public static final String CURR_EDU_USER="currEduUser";
	//�˿γ�û����������
	public static final String NOT_NORMAL_FINISH_COURSE="�˿γ�û����������";
	//�Ѿ������һ��
	public static final String LAST_CHAPTER="�Ѿ������һ��";
	//��Ŀ���� ��Χ���
	public static final String EXAM_BANK_TYPE="examBankType";
	//��Ŀ���� ��Χ���
	public static final String EXAM_BANK_TYPE_NAME="examBankTypeName";
     	
    public static final String FILE_BEYOND_LIMIT="�ļ������ļ���С���ó���100MB";
	
    //eduUser session
  	public static final String CURR_NJMUEDU_USER="currNjmuEduUser";
  	
  	
	/**********res*************/
	//סԺҽʦ��
	public static final String RES_FORM_CONFIG_PATH = "res/form";
	public static final String RES_FORM_PRODUCT = "product";
	public static final String RES_FORM_PRODUCT_VER = "1.0";
    //res��ɫ
	public static final String RES_ROLE_SCOPE_DOCTOR = "doctor";//ҽʦ
	public static final String RES_ROLE_SCOPE_LEADER = "leader";//�鳤
	public static final String RES_ROLE_SCOPE_TUTOR = "tutor";//��ʦ
	public static final String RES_ROLE_SCOPE_TEACHER = "teacher";//����
	public static final String RES_ROLE_SCOPE_HEAD = "head";//������
	public static final String RES_ROLE_SCOPE_MANAGER = "manager";//��������
	public static final String RES_ROLE_SCOPE_ADMIN = "admin";//����Ա
	public static final String RES_ROLE_SCOPE_CHARGE = "charge";//ƽ̨
	//ƽ̨
	//public static final String RES_ROLE_SCOPE_PLATFORM = "platform";
	//Ҫ��Ĭ��������
	public static final String RES_REQ_OTHER_ITEM_ID = "00000000000000000000000000000000";
	public static final String RES_REQ_OTHER_ITEM_NAME = "����";
	/**********hbres*************/
	public static final String HBRES_SPECIALIZED = "ҽѧ����";
	/************erp*****************/
	//ERP�ܾ���������
	public static final String MANAGER_FLAG="managerFlag";
	//ERP����������
	public static final String BUSINESS_FLAG="businessFlag";
	public static final String BUSINESS_DEPT_FLAG="businessDeptFlag";
	//ERP��ѯ��Χ���
	public static final String TYPE_SCOPE="typeScope";
	//ERP�ɹ���������˱��
	public static final String APPLY_AUDIT="applyAudit";
	//ERP�ɹ���������˱��
	public static final String APPLY_TARGET_AUDIT="applyTargetAudit";
	//ERP�ɹ������������˱��
	public static final String MANAGER_AUDIT="managerAudit";
	//ERP�ɹ������������˱��
	public static final String ASSISTANT_AUDIT="assistantAudit";
	
	//���ɰ󶨱��
	public static final int CAN_NOT_BIND_FLAG=00;
	
	public static final String CAN_NOT_BIND="�ÿγ��Ѱ������Ծ�";
	
	public static final String FILE_TYPE_NOT_SUPPORT="�ļ���ʽ��֧�֣�";
	
	public static final String PLEASE_INPUT_TRUE_FILEURL="��������ȷ���ļ�·����";
	
	//����ʡ�����Ϣ
	public static final String BASIC_INFO="BasicInfo";
	
	public static final String ORG_MANAGE="OrgManage";
	
	public static final String TEACH_CONDITION="TeachCondition";
	
	public static final String SUPPORT_CONDITION="SupportCondition";
	
	
	//enso
	public static final String PI_ROLE_FLOW="817cf2c8cb5b4dceb689015359d5c209";
	public static final String REACHER_ROLE_FLOW="dbb6c577f6b64659a2c1a49371cf0e20";
	public static final String CRC_ROLE_FLOW="107bbd0e2d9e42d3b0f04d53bfb234b3";
	
}