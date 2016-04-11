package com.pinde.sci.biz.hbres;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResExam;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResExamRoom;
import com.pinde.sci.model.mo.ResExamSite;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResExamDoctorExt;

/**
 * ���Թ���ҵ���
 * @author shenzhen
 *
 */
public interface ExamManageBiz {
	
	/**
	 * ��ѯ���п��� ���ݴ���ʱ�䵹��
	 * @return
	 */
	List<ResExam> findALLExam();
	
	/**
	 * ���濼��
	 * @param exam
	 */
	void saveExam(ResExam exam);
	
	/**
	 * ����������ѯ����
	 * @param examFlow
	 * @return
	 */
	ResExam findExamByFlow(String examFlow);

	/**
	 * ��ѯ���п���(Ĭ�ϰ��տ�������������)
	 * @return
	 */
	List<ResExamSite> findAllExamSite();
	
	/**
	 * ��ѯ���п��ÿ���(Ĭ�ϰ��տ�������������)
	 * @return
	 */
	List<ResExamSite> findAllUsablelExamSite(String examFlow);
	
	/**
	 * ����������ѯѧ���Ͷ�Ӧ����¼��Ϣ
	 * ����map��
	 * statusId (String)�û�״̬
	 * sessionNumber(String) ����
	 * graduatedIds (List<String>) ��ҵԺУId
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorExt> findDocotrAndRecruitInfo(Map<String , Object> paramMap);
	
	/**
	 * ����������ȡ������Ϣ
	 * @param code
	 * @return
	 */
	ResExamSite findExamSiteByRecordFlow(String recordFlow);
	
	/**
	 * ���ݿ���ı�Ż�ȡ�ÿ����º��ǵı�ҵԺУ
	 * @param code
	 * @return
	 */
	List<String> getGraduatedIdsByExamSiteFlow(String code);
	
	/**
	 * ����׼��֤�� ��ȡ������
	 * @param examCode
	 * @return
	 */
	String findRoomByExamCode(String examCode);
	
	/**
	 * ����ѧ����¼��Ϣ
	 * @param doctorRecruit
	 */
	void saveDoctorRecruit(ResDoctorRecruit doctorRecruit);
	
	/**
	 * ��ѯ�μ�ĳ�����Ե�����
	 * @param examFlow
	 * @return
	 */
	Integer findExamUserCountByExamFlow(String examFlow);
	
	/**
	 * ��ѯ����ĳ�����Ե��û�
	 * ҵ�����������ͨ��    ָ��ϵͳ���õ�ע�����
	 * @param examFlow
	 * @return
	 */
	List<SysUser> findUserNotInExam(String examFlow);
	
	/**
	 * ��ָ�����������û�
	 * �ڲ�����findUserNotInExam(String examFlow)
	 */
	void addExamUser(String examFlow);
	
	/**
	 * ���ݿ�����ˮ�Ų�ѯ����
	 * @param siteFlow
	 * @return
	 */
	List<ResExamRoom> findExamRoomsBySiteFlow(String siteFlow);
	
	/**
	 * ���ݿ�����ˮ�Ų�ѯ�ÿ����µĿ�������
	 * @param siteFlow
	 * @return
	 */
	public Integer findRoomCountBySiteFlow(String siteFlow);
	
	/**
	 * ��ѯָ��������ͬרҵ����������
	 * @param roomFlow
	 * @return
	 */
	Map<String , Integer> countRoomSpeNum(String siteCode , String roomCode , String roomFlow);
	
	/**
	 * ��ӿ���
	 * @param room
	 */
	void addRoom(ResExamRoom room);
	
	/**
	 * ɾ������
	 * ����ֻ������һ������Ϊ0�Ŀ����ſ���ɾ��
	 * @param roomFlow
	 */
	void delRoom(String roomFlow);
	
	/**
	 * ��ʼ������
	 * @param siteFlow
	 * @param roomNum
	 * @param seatNum
	 */
	void initRoom(String siteFlow , Integer roomNum , Integer seatNum);
	
	/**
	 * ���¿���
	 * @param room
	 */
	void modRoomByRoomFlow(ResExamRoom room);

	ResExam readCurrExam();

	/**
	 * һ������
	 * @param examFlow
	 * @param siteFlow
	 */
	void smartAllotExamCode(String examFlow, String siteFlow);
	
	/**
	 * ��ȡָ���������Ѿ����������λ����
	 * @param roomFlow
	 * @return
	 */
	Integer getAlreadyRoomUserCount(String roomFlow);
	
	/**
	 * ���ݿ�����ˮ�Ż�ȡ������Ϣ
	 * @param roomFlow
	 * @return
	 */
	ResExamRoom findRoomByRoomFlow(String roomFlow);
	
	/**
	 * ��ѯѧԱ�Ϳ�����Ϣ
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> findExamDoctorExts(ResExamDoctorExt examDoctor); 
	
	/**
	 * ��ѯѧԱ�Ϳ�����Ϣ
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> findExamDoctorExts(Map<String , Object> paramMap); 
	
	/**
	 * ��ѧ��������������������׼��֤��
	 * @param roomFlow
	 * @param userFlows
	 */
	void changeRoom(String examFlow , String roomFlow , List<String> userFlows);
	
	/**
	 * ���ݿ�����ˮ�ź�ѧԱ��ˮ�Ų�ѯ�ÿ����ڸôο��Ե���Ϣ
	 * @param examFlow
	 * @param doctorFlow
	 * @return
	 */
	ResExamDoctor findExamDoctorByExamFlowAndDoctorFlow(String examFlow , String doctorFlow);

	/**
	 * ����ϵͳ������ݸ��������Ͳ�ѯ����
	 * ÿһ��ÿ������ֻ��һ�ο���
	 * @param cfgYear
	 * @param typeId
	 * @return
	 */
	ResExam findExamByCfgYearAndTypeId(String cfgYear, String typeId);
	
	/**
	 * ��������
	 * @param examFlow
	 */
	void finishExam(String examFlow);

	/**
	 * ��ȡĳ��������ĳ�������µ�����
	 * @param siteFlow
	 * @param examFlow
	 * @return
	 */	
	Integer getUserCountInExamSite(String examFlow, String siteFlow);

	/**
	 * ��ȡĳ��������ĳ���������Ѿ����������λ����
	 * @param siteFlow
	 * @param examFlow
	 * @return
	 */
	Integer getAlreadyAllotSeatNumInSiteAndExam(String examFlow, String siteFlow);

	List<ResExamDoctor> searchExamDoctor(String examFlow, String siteFlow,
			String roomFlow);
	
	/**
	 * ��ȡĳ������ĳ��רҵ������
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	Integer getDoctorCountInExamForSpe(String examFlow , String speId);
	
	
	
}
