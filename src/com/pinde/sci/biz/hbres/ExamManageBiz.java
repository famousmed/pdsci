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
 * 考试管理业务层
 * @author shenzhen
 *
 */
public interface ExamManageBiz {
	
	/**
	 * 查询所有考试 根据创建时间倒序
	 * @return
	 */
	List<ResExam> findALLExam();
	
	/**
	 * 保存考试
	 * @param exam
	 */
	void saveExam(ResExam exam);
	
	/**
	 * 根据主键查询考试
	 * @param examFlow
	 * @return
	 */
	ResExam findExamByFlow(String examFlow);

	/**
	 * 查询所有考点(默认按照考点编号正序排序)
	 * @return
	 */
	List<ResExamSite> findAllExamSite();
	
	/**
	 * 查询所有可用考点(默认按照考点编号正序排序)
	 * @return
	 */
	List<ResExamSite> findAllUsablelExamSite(String examFlow);
	
	/**
	 * 根据条件查询学生和对应的招录信息
	 * 参数map中
	 * statusId (String)用户状态
	 * sessionNumber(String) 届数
	 * graduatedIds (List<String>) 毕业院校Id
	 * @param paramMap
	 * @return
	 */
	List<ResDoctorExt> findDocotrAndRecruitInfo(Map<String , Object> paramMap);
	
	/**
	 * 根据主键获取考点信息
	 * @param code
	 * @return
	 */
	ResExamSite findExamSiteByRecordFlow(String recordFlow);
	
	/**
	 * 根据考点的编号获取该考点下涵盖的毕业院校
	 * @param code
	 * @return
	 */
	List<String> getGraduatedIdsByExamSiteFlow(String code);
	
	/**
	 * 根据准考证号 获取考场号
	 * @param examCode
	 * @return
	 */
	String findRoomByExamCode(String examCode);
	
	/**
	 * 保存学生招录信息
	 * @param doctorRecruit
	 */
	void saveDoctorRecruit(ResDoctorRecruit doctorRecruit);
	
	/**
	 * 查询参加某场考试的人数
	 * @param examFlow
	 * @return
	 */
	Integer findExamUserCountByExamFlow(String examFlow);
	
	/**
	 * 查询不在某场考试的用户
	 * 业务条件：审核通过    指定系统设置的注册年份
	 * @param examFlow
	 * @return
	 */
	List<SysUser> findUserNotInExam(String examFlow);
	
	/**
	 * 给指定考试设置用户
	 * 内部调用findUserNotInExam(String examFlow)
	 */
	void addExamUser(String examFlow);
	
	/**
	 * 根据考点流水号查询考场
	 * @param siteFlow
	 * @return
	 */
	List<ResExamRoom> findExamRoomsBySiteFlow(String siteFlow);
	
	/**
	 * 根据考点流水号查询该考点下的考场数量
	 * @param siteFlow
	 * @return
	 */
	public Integer findRoomCountBySiteFlow(String siteFlow);
	
	/**
	 * 查询指定考场不同专业人数的数量
	 * @param roomFlow
	 * @return
	 */
	Map<String , Integer> countRoomSpeNum(String siteCode , String roomCode , String roomFlow);
	
	/**
	 * 添加考场
	 * @param room
	 */
	void addRoom(ResExamRoom room);
	
	/**
	 * 删除考场
	 * 规则：只有最有一个人数为0的考场才可以删除
	 * @param roomFlow
	 */
	void delRoom(String roomFlow);
	
	/**
	 * 初始化考场
	 * @param siteFlow
	 * @param roomNum
	 * @param seatNum
	 */
	void initRoom(String siteFlow , Integer roomNum , Integer seatNum);
	
	/**
	 * 更新考场
	 * @param room
	 */
	void modRoomByRoomFlow(ResExamRoom room);

	ResExam readCurrExam();

	/**
	 * 一键分配
	 * @param examFlow
	 * @param siteFlow
	 */
	void smartAllotExamCode(String examFlow, String siteFlow);
	
	/**
	 * 获取指定考场中已经被分配的座位数量
	 * @param roomFlow
	 * @return
	 */
	Integer getAlreadyRoomUserCount(String roomFlow);
	
	/**
	 * 根据考场流水号获取考场信息
	 * @param roomFlow
	 * @return
	 */
	ResExamRoom findRoomByRoomFlow(String roomFlow);
	
	/**
	 * 查询学员和考试信息
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> findExamDoctorExts(ResExamDoctorExt examDoctor); 
	
	/**
	 * 查询学员和考试信息
	 * @param examDoctor
	 * @return
	 */
	List<ResExamDoctorExt> findExamDoctorExts(Map<String , Object> paramMap); 
	
	/**
	 * 给学生更换考场并重新生成准考证号
	 * @param roomFlow
	 * @param userFlows
	 */
	void changeRoom(String examFlow , String roomFlow , List<String> userFlows);
	
	/**
	 * 根据考试流水号和学员流水号查询该考生在该次考试的信息
	 * @param examFlow
	 * @param doctorFlow
	 * @return
	 */
	ResExamDoctor findExamDoctorByExamFlowAndDoctorFlow(String examFlow , String doctorFlow);

	/**
	 * 根据系统配置年份个考试类型查询考试
	 * 每一年每种类型只有一次考试
	 * @param cfgYear
	 * @param typeId
	 * @return
	 */
	ResExam findExamByCfgYearAndTypeId(String cfgYear, String typeId);
	
	/**
	 * 结束考试
	 * @param examFlow
	 */
	void finishExam(String examFlow);

	/**
	 * 获取某场考试中某个考点下的人数
	 * @param siteFlow
	 * @param examFlow
	 * @return
	 */	
	Integer getUserCountInExamSite(String examFlow, String siteFlow);

	/**
	 * 获取某场考试中某个考点下已经被分配的座位数量
	 * @param siteFlow
	 * @param examFlow
	 * @return
	 */
	Integer getAlreadyAllotSeatNumInSiteAndExam(String examFlow, String siteFlow);

	List<ResExamDoctor> searchExamDoctor(String examFlow, String siteFlow,
			String roomFlow);
	
	/**
	 * 获取某场考试某个专业的人数
	 * @param examFlow
	 * @param speId
	 * @return
	 */
	Integer getDoctorCountInExamForSpe(String examFlow , String speId);
	
	
	
}
