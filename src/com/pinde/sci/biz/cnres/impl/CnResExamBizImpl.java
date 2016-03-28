package com.pinde.sci.biz.cnres.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.aop.framework.AopContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.cnres.ICnResExamBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResDoctorMapper;
import com.pinde.sci.dao.base.ResExamDoctorMapper;
import com.pinde.sci.dao.base.ResExamMapper;
import com.pinde.sci.dao.base.ResExamRoomMapper;
import com.pinde.sci.dao.base.ResExamSiteMapper;
import com.pinde.sci.dao.res.ResDoctorExtMapper;
import com.pinde.sci.enums.res.ExamStatusEnum;
import com.pinde.sci.enums.res.ExamTypeEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResExam;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResExamDoctorExample;
import com.pinde.sci.model.mo.ResExamDoctorExample.Criteria;
import com.pinde.sci.model.mo.ResExamDoctorExample.Criterion;
import com.pinde.sci.model.mo.ResExamExample;
import com.pinde.sci.model.mo.ResExamRoom;
import com.pinde.sci.model.mo.ResExamRoomExample;
import com.pinde.sci.model.mo.ResExamSite;
import com.pinde.sci.model.mo.ResExamSiteExample;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorExt;
import com.pinde.sci.model.res.ResExamDoctorExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class CnResExamBizImpl implements ICnResExamBiz{

	@Autowired
	private ResExamSiteMapper examSiteMapper;
	@Autowired
	private ResDoctorExtMapper doctorExtMapper;
	@Autowired
	private ResDoctorMapper doctorMapper;
	@Autowired
	private ResExamMapper examMapper;
	@Autowired
	private ResExamDoctorMapper examDoctorMapper;
	@Autowired
	private ResExamRoomMapper examRoomMapper;
	
	@Override
	public List<ResExam> findALLExam() {
		ResExamExample example = new ResExamExample();
		example.setOrderByClause("CREATE_TIME DESC");//根据创建时间倒序
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return this.examMapper.selectByExample(example);
	}
	
	@Override
	public void saveExam(ResExam exam) {
		String examFlow = exam.getExamFlow();
		String year = InitConfig.getSysCfg("res_reg_year");
		if(StringUtil.isBlank(year)){
			throw new RuntimeException("后台系统没有设置报名年份");
		}
		if(StringUtil.isBlank(examFlow)){
			ResExam exitExam = findExamByCfgYearAndTypeId(year, exam.getExamTypeId());
			if(exitExam!=null){
				throw new RuntimeException(year+"年,考试类型:"+ExamTypeEnum.getNameById(exam.getExamTypeId())+"已经存在");
			}
			exam.setExamYear(year);
			exam.setExamFlow(PkUtil.getUUID());
			exam.setExamStatusId(ExamStatusEnum.Arrange.getId());
			exam.setExamStatusName(ExamStatusEnum.Arrange.getName());
			exam.setExamTypeName(ExamTypeEnum.getNameById(exam.getExamTypeId()));
			GeneralMethod.setRecordInfo(exam, true);
			this.examMapper.insertSelective(exam);
		}else{
			exam.setExamYear(year);
			GeneralMethod.setRecordInfo(exam, false);
			this.examMapper.updateByPrimaryKeySelective(exam);
		}
		
	}
	
	@Override
	public ResExam findExamByFlow(String examFlow){
		return this.examMapper.selectByPrimaryKey(examFlow);
	}

	@Override
	public ResExam findExamByCfgYearAndTypeId(String cfgYear , String typeId){
		ResExamExample example = new ResExamExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamYearEqualTo(cfgYear)
		.andExamTypeIdEqualTo(typeId);
		List<ResExam> exams = this.examMapper.selectByExample(example);
		if(exams.size()==1){
			return exams.get(0); 
		}
		return null;
	}

	
	@Override
	public void saveDoctorRecruit(ResDoctorRecruit doctorRecruit) {
		
	}
	
	@Override
	public List<ResExamSite> findAllExamSite() {
		ResExamSiteExample example = new ResExamSiteExample();
		example.setOrderByClause("SITE_CODE");
		return this.examSiteMapper.selectByExample(example);
	}

	@Override
	public List<ResExamSite> findAllUsablelExamSite(String examFlow) {
		ResExamSiteExample example = new ResExamSiteExample();
		example.setOrderByClause("SITE_CODE");
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andExamFlowEqualTo(examFlow);
		return this.examSiteMapper.selectByExample(example);
	}

	@Override
	public List<ResDoctorExt> findDocotrAndRecruitInfo(
			Map<String, Object> paramMap) {
		return doctorExtMapper.searchResDoctorUserRecruit(paramMap);
	}

	@Override
	public ResExamSite findExamSiteByCode(String code) {
		ResExamSiteExample example = new ResExamSiteExample();
		example.createCriteria().andSiteCodeEqualTo(code).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		List<ResExamSite> site = this.examSiteMapper.selectByExample(example);
		if(site!=null && site.size()==1){
			return site.get(0);
		}
		return null;
	}
	
	@Override
	public ResExamSite findExamSiteByRecordFlow(String recordFlow) {
		return this.examSiteMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public List<String> getGraduatedIdsByExamSiteCode(String code) {
		List<String> graduatedIds = null;
		if(StringUtil.isNotBlank(code)){
			ResExamSite site = findExamSiteByCode(code);
			if(site!=null){
				String colleges = site.getColleges();
				if(StringUtil.isNotBlank(colleges)){
					String[] collegesArray = colleges.split(",");
					graduatedIds = Arrays.asList(collegesArray);
				}
			}
		}
		return graduatedIds;
	}
	
	@Override
	public void smartAllotExamCode(String examFlow , String siteFlow){
		int roomCount = findRoomCountBySiteFlow(siteFlow);
		if(roomCount==0){
			throw new RuntimeException("该考点没有分配考场");
		}
		//查询出某场考试某个考点下没有被分配准考证的学员数量
		ResExamDoctorExample examDoctorExample = new ResExamDoctorExample();
		examDoctorExample.createCriteria().
		andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow)
		.andSiteFlowEqualTo(siteFlow)
		.andTicketNumIsNull();
		int notAllotUserNum = this.examDoctorMapper.countByExample(examDoctorExample);
		if(notAllotUserNum==0){
			throw new RuntimeException("没有需要被分配的学员");
		}
		//该考点下可分配的座位数
		int usableSeatNum = getUsableSeatNumInSite(examFlow , siteFlow);
		if(usableSeatNum<notAllotUserNum){
			throw new RuntimeException("可用座位数不能小于待分配的人数");
		}
		
		Map<String, Object> notAllotTicketNumUserInExamAndSiteParamMap = new HashMap<String, Object>();
		notAllotTicketNumUserInExamAndSiteParamMap.put("examFlow", examFlow);
		notAllotTicketNumUserInExamAndSiteParamMap.put("siteFlow", siteFlow);
		//排序查询该场考试 该考点下没有被分配准考证的学员
		List<ResExamDoctor> examDoctors = this.doctorExtMapper.searchNotAllotTicketNumUserInExamAndSite(notAllotTicketNumUserInExamAndSiteParamMap);
		ResExamSite site = this.findExamSiteByRecordFlow(siteFlow);
		//查询该考点下的所有考场
        List<ResExamRoom> rooms = this.findExamRoomsBySiteFlow(siteFlow);
        Queue<String> seatCodes = null;
        ResExamRoom beChooseRoom = null;
		for(ResExamDoctor examDoctor : examDoctors){
			if(seatCodes==null || seatCodes.isEmpty()){
				beChooseRoom = this.chooseRoom(rooms);
			}
			
			if(beChooseRoom==null){
				throw new RuntimeException("考点已被分配满了,请增加考点或座位号");
			}
			ResDoctor doctor = this.doctorMapper.selectByPrimaryKey(examDoctor.getDoctorFlow());
			String spe = doctor.getSpecialized();
			if(seatCodes==null || seatCodes.isEmpty()){
			    //计算座位号
			    seatCodes = allotSeatCode(examFlow , beChooseRoom);
			}
			String seatCode = seatCodes.poll();
			String ticketNum = countTicketNum(site.getSiteCode() , beChooseRoom.getRoomCode() , seatCode , spe);
			System.out.println(ticketNum+"----------------------");
			boolean isExistExamCode = checkExamCodeIsExist(examFlow , ticketNum);
			if(isExistExamCode){
				throw new RuntimeException("学员:"+examDoctor.getDoctorFlow()+"准考证号:"+ticketNum+"已存在,分配准考证号异常");
			}
			examDoctor.setRoomFlow(beChooseRoom.getRoomFlow());
			examDoctor.setRoomCode(beChooseRoom.getRoomCode());
			examDoctor.setTicketNum(ticketNum);
			GeneralMethod.setRecordInfo(examDoctor, false);
			this.examDoctorMapper.updateByPrimaryKeySelective(examDoctor);
			
		}
		
	}
	
	/**
	 * 生成准考证号
	 * countTicketNum
	 * @param siteCode
	 * @param room
	 * @param seatCode
	 * @param specialized
	 * @return
	 */
	private String countTicketNum(String siteCode, String room , String seatCode , String specialized){
		return "42"+siteCode+room+seatCode+specialized;
	}
	
	/**
	 * 计算剩余的座位号
	 * @return
	 */
	private Queue<String> allotSeatCode(String examFlow , ResExamRoom beChooseRoom){
		Queue<String> seatCodes = new LinkedList<String>();
		Integer end = Integer.parseInt(beChooseRoom.getSeatNum());
		for(int i = 1 ; i<=end; i++){
			String code = tensDigitReplaceZero(i);
			if(!checkSeatCodeIsExistInExamAndSiteAndRoom(examFlow, beChooseRoom.getSiteCode(), beChooseRoom.getRoomCode(), code)){
				seatCodes.offer(tensDigitReplaceZero(i));
			}
		}
		return seatCodes;
	}
	
	/**
	 * 给要分配准考证的学员自动选择考场
	 * key
	 * room 自动选择的room
	 * alreadyRoomUserCount 已经被分配的数量
	 * @return
	 */
	private ResExamRoom chooseRoom(List<ResExamRoom> rooms){
		for(ResExamRoom room:rooms){
			Integer seatNum = Integer.parseInt(room.getSeatNum());
			String roomFlow = room.getRoomFlow();
			Integer alreadyRoomUserCount = getAlreadyRoomUserCount(roomFlow);
			if(seatNum>alreadyRoomUserCount){
				return room;
			}
			
		}
		return null;
	}
	
	@Override
	public Integer getAlreadyRoomUserCount(String roomFlow){
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRoomFlowEqualTo(roomFlow);
		return this.examDoctorMapper.countByExample(example);
	}
	
	/**
	 * 获取某场考试下某个考点可分配的座位数量
	 * @param examFlow
	 * @param siteFlow
	 * @return
	 */
	private Integer getUsableSeatNumInSite(String examFlow , String siteFlow){
		return getTotalSeatNumInSite(siteFlow) - getAlreadyAllotSeatNumInSiteAndExam(examFlow , siteFlow);
	}
	
	/**
	 * 获取某个考点下的总座位数
	 * @param siteFlow
	 * @return
	 */
	private Integer getTotalSeatNumInSite(String siteFlow){
		int totalSeatNum = 0;
		List<ResExamRoom> rooms = this.findExamRoomsBySiteFlow(siteFlow);
		for(ResExamRoom room:rooms){
			int seatNum = Integer.parseInt(room.getSeatNum());
			totalSeatNum+=seatNum;
		}
		return totalSeatNum;
	}
	
	
	/**
	 * 获取某场考试中某个考点下已经被分配的座位数量
	 * @param siteFlow
	 * @param examFlow
	 * @return
	 */
	@Override
	public Integer getAlreadyAllotSeatNumInSiteAndExam(String examFlow , String siteFlow){
		int alreadyAllotSeatNum = 0;
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow).andSiteFlowEqualTo(siteFlow)
		.andTicketNumIsNotNull();
		alreadyAllotSeatNum = this.examDoctorMapper.countByExample(example);
		return alreadyAllotSeatNum;
	}
	
	/**
	 * 根据准考证号获考点号
	 * @param examCode
	 * @return
	 */
	private String getSiteCodeByExamCode(String examCode){
		return allotCodeByExamCode(examCode)[1];
	}
	
	@Override
	public String findRoomByExamCode(String examCode) {
		return allotCodeByExamCode(examCode)[2];
	}
	
	/**
	 * 根据准考证号计算各个位置编号
	 * 4201010101
	 * 42代表省份，固定死
       01代表考点  （详见考点分布表中标号栏）
       01代表考场号
       01代表座位号
       01代表毕业专业（01或02）
	 * @param examCode
	 * @return
	 */
    private String[] allotCodeByExamCode(String examCode){
    	String[] codes = new String[5];
    	if(StringUtil.isNotBlank(examCode)){
    		codes[0] = examCode.substring(0, 2);
    		codes[1] = examCode.substring(2, 4);
    		codes[2] = examCode.substring(4, 6);
    		codes[3] = examCode.substring(6, 8);
    		codes[4] = examCode.substring(8, 10);
    	}
		return codes;
	}
    
    /**
     * 判断准考证号在某场考试是否存在
     * @param examFlow
     * @param examCode
     * @return
     */
    private boolean checkExamCodeIsExist(String examFlow , String examCode){
    	ResExamDoctorExample example = new ResExamDoctorExample();
    	example.createCriteria()
    	.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
    	.andTicketNumEqualTo(examCode)
    	.andExamFlowEqualTo(examFlow);
		int count = this.examDoctorMapper.countByExample(example );
		if(count==0){
			return false;
		}
		return true;
    }
    
    public boolean checkSeatCodeIsExistInExamAndSiteAndRoom(String examFlow , String siteCode , String roomCode , String seatCode){
    	String examCodeMatch = "42"+siteCode+roomCode+seatCode+"__";
    	ResExamDoctorExample example = new ResExamDoctorExample();
    	example.createCriteria()
    	.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
    	.andExamFlowEqualTo(examFlow)
    	.andTicketNumLike(examCodeMatch);
    	int count = this.examDoctorMapper.countByExample(example);
    	if(count==0){
			return false;
		}
		return true;
    }

	@Override
	public ResExamSite findExamSiteByExamCode(String examCode) {
		String siteCode = this.getSiteCodeByExamCode(examCode);
		return this.findExamSiteByCode(siteCode);
	}

	@Override
	public ResExam readCurrExam() {
		ResExamExample example = new ResExamExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andExamTypeIdEqualTo(ExamTypeEnum.Register.getId())
		.andExamStatusIdEqualTo(ExamStatusEnum.Arrange.getId());
		List<ResExam> examlist = examMapper.selectByExample(example);
		if(examlist!=null && examlist.size()>0){
			return examlist.get(0);
		}
		return null;
	}

	@Override
	public Integer findExamUserCountByExamFlow(String examFlow) {
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andExamFlowEqualTo(examFlow);
		return this.examDoctorMapper.countByExample(example);
	}

	@Override
	public List<SysUser> findUserNotInExam(String examFlow) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("statusId", RegStatusEnum.Passed.getId());
		paramMap.put("regYear", InitConfig.getSysCfg("res_reg_year"));
		paramMap.put("examFlow", examFlow);
		return this.doctorExtMapper.searchNotInExamUser(paramMap);
	}

	@Override
	public void addExamUser(String examFlow) {
		List<SysUser> users = findUserNotInExam(examFlow);
		if(users!=null && !users.isEmpty()){
			for(SysUser user:users){
				ResExamDoctor record = new ResExamDoctor();
				record.setRecordFlow(PkUtil.getUUID());
				record.setDoctorFlow(user.getUserFlow());
				record.setDoctorName(user.getUserName());
				ResExamSite site = findExamSiteByDoctorFlowAndExamFlow(user.getUserFlow(),examFlow);
				if(site==null){
					throw new RuntimeException(user.getUserName()+" 该学生没有考点");
				}
				record.setSiteFlow(site.getRecordFlow());
				record.setSiteCode(site.getSiteCode());
				record.setExamFlow(examFlow);
				record.setSiteName(site.getSiteName());
				GeneralMethod.setRecordInfo(record, true);
				examDoctorMapper.insertSelective(record );
			}
		}else{
			throw new RuntimeException("没有添加的学员");
		}
	}
	
	/**
	 * 根据学员流水号设置查询该学员参考的考点
	 * @param doctorFlow
	 * @return
	 */
	private ResExamSite findExamSiteByDoctorFlowAndExamFlow(String doctorFlow , String examFlow){
		ResDoctor doctor = this.doctorMapper.selectByPrimaryKey(doctorFlow);
		String graduatedId = doctor.getGraduatedId();
		String graduationTime = doctor.getGraduationTime();
		String graduationYear = "";
		if (StringUtil.isNotBlank(graduationTime)) {
			graduationYear = graduationTime.substring(0, 4);
		}
		ResExamSiteExample examSiteExample = new ResExamSiteExample();
		examSiteExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andExamFlowEqualTo(examFlow);
		List<ResExamSite> examSites = this.examSiteMapper.selectByExample(examSiteExample);
		ResExamSite defaultSite = getDefaultExamSite(examSites);
		ResExamSite resultSite = null;
		
		
		for(ResExamSite site:examSites){
			String coverYear = StringUtil.defaultIfEmpty(site.getCoverYear(), "");
			String colleges = site.getColleges();
			if(coverYear.equals(graduationYear)){
				if(isContainsGraduatedIdInClooeges(graduatedId , colleges)){
					return site;
				}else{
					continue;
				}
			}
		}
		
		resultSite = defaultSite;
		String regYear = InitConfig.getSysCfg("res_reg_year");
		if(StringUtil.isBlank(regYear)){
			throw new RuntimeException("后台系统没有设置报名年份");
		}
		if(resultSite!=null){
			if(regYear.equals(graduationYear) && !isContainsGraduatedIdInClooeges(graduatedId , resultSite.getColleges())){
				resultSite = null;
			}
		}
		
		return resultSite;
	}
	
	/**
	 * 获取默认考点
	 * @param examSites
	 * @return
	 */
	private ResExamSite getDefaultExamSite(List<ResExamSite> examSites){
		for(ResExamSite site:examSites){
			if(StringUtil.isBlank(site.getCoverYear())){
				return site;
			}
		}
		
		return null;
	}
	
	/**
	 * 是否涵盖毕业院校的Id
	 * @param graduatedId
	 * @param colleges eg:01,02,03
	 * @return
	 */
	private boolean isContainsGraduatedIdInClooeges(String graduatedId , String colleges){
		if(StringUtil.isNotBlank(colleges)){
			String[] collegesArray = colleges.split(",");
			List<String> clooeges = Arrays.asList(collegesArray);
			if(clooeges.contains(graduatedId)){
				return true;
			}
		}
		return false;
	}
	

	@Override
	public List<ResExamRoom> findExamRoomsBySiteFlow(String siteFlow) {
		ResExamRoomExample example = new ResExamRoomExample();
		example.setOrderByClause("ROOM_CODE");
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSiteFlowEqualTo(siteFlow);
		return this.examRoomMapper.selectByExample(example);
	}
	
	@Override
	public Integer findRoomCountBySiteFlow(String siteFlow){
		ResExamRoomExample example = new ResExamRoomExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSiteFlowEqualTo(siteFlow);
		return this.examRoomMapper.countByExample(example);
	}
	
	@Override
	public Map<String , Integer> countRoomSpeNum(String siteCode , String roomCode , String roomFlow){
		Map<String , Integer> resultMap = new HashMap<String, Integer>();
		List<SysDict> graduatedMajors = DictTypeEnum.sysListDictMap.get(DictTypeEnum.GraduateMajor.getId());
		if(graduatedMajors!=null && !graduatedMajors.isEmpty()){
			for(SysDict dict:graduatedMajors){
				String id = dict.getDictId();
				ResExamDoctorExample example = new ResExamDoctorExample();
				example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andRoomFlowEqualTo(roomFlow).andTicketNumLike("42"+siteCode+roomCode+"__"+id);
				int count = this.examDoctorMapper.countByExample(example);
				resultMap.put(id, count);
			}
			
		}
		
		return resultMap;
	}

	@Override
	public void addRoom(ResExamRoom room) {
		String siteFlow = room.getSiteFlow();
		if(StringUtil.isNotBlank(siteFlow)){
			ResExamSite site = this.findExamSiteByRecordFlow(siteFlow);
			if(site!=null){
				room.setRoomFlow(PkUtil.getUUID());
				room.setSiteCode(site.getSiteCode());
				//考场编号是从前台传还是在这个地方算--待定
				GeneralMethod.setRecordInfo(room, true);
				this.examRoomMapper.insertSelective(room);
			}
			
		}
		
		
	}

	@Override
	public void initRoom(String siteFlow, Integer roomNum, Integer seatNum) {
		if(roomNum>=100){
			throw new RuntimeException("考场数不可大于100");
		}
		if(seatNum>=100){
			throw new RuntimeException("座位数不可大于100");
		}
		for(int i=1;i<=roomNum;i++){
			ResExamRoom room = new ResExamRoom();
			room.setSiteFlow(siteFlow);
			room.setSeatNum(seatNum.toString());
			room.setRoomCode(tensDigitReplaceZero(i));
			this.addRoom(room);
		}
		
	}
	
	/**
	 * 十位数补零
	 * @param inx
	 * @return
	 */
	private String tensDigitReplaceZero(int inx){
		String code = "";
		if(inx<10){
			code = "0"+inx;
		}else{
			code = String.valueOf(inx);
		}
		return code;
	}

	@Override
	public void modRoomByRoomFlow(ResExamRoom room) {
		this.examRoomMapper.updateByPrimaryKeySelective(room);
	}

	@Override
	public ResExamRoom findRoomByRoomFlow(String roomFlow) {
		return this.examRoomMapper.selectByPrimaryKey(roomFlow);
	}

	@Override
	public List<ResExamDoctorExt> findExamDoctorExts(ResExamDoctorExt examDoctor) {
		return this.doctorExtMapper.searchExamDoctorExt(examDoctor);
	}

	@Override
	public void changeRoom(String examFlow , String roomFlow, List<String> userFlows) {
		ResExamRoom beChooseRoom = this.findRoomByRoomFlow(roomFlow);
		//计算可用座位数
		Integer seatNum = Integer.parseInt(beChooseRoom.getSeatNum());
		Integer alreadySeatNum = this.getAlreadyRoomUserCount(roomFlow);
		Integer usableSeatNum = seatNum-alreadySeatNum;
		if(usableSeatNum<=0){
			throw new RuntimeException("没有可用座位数量,请增加座位数");
		}
		Queue<String> seatCodes = null;
		seatCodes = allotSeatCode(examFlow, beChooseRoom);
		for(String userFlow : userFlows){
			ResExamDoctor examDoctor = this.findExamDoctorByExamFlowAndDoctorFlow(examFlow , userFlow);
			ResDoctor doctor = this.doctorMapper.selectByPrimaryKey(userFlow);
			String spe = doctor.getSpecialized();
			if(seatCodes==null || seatCodes.isEmpty()){
				throw new RuntimeException("没有可用座位数量,请增加座位数");
			}
			String seatCode = seatCodes.poll();
			String ticketNum = countTicketNum(beChooseRoom.getSiteCode() , beChooseRoom.getRoomCode() , seatCode , spe);
			boolean isExistExamCode = checkExamCodeIsExist(examFlow , ticketNum);
			if(isExistExamCode){
				throw new RuntimeException("学员:"+examDoctor.getDoctorFlow()+"准考证号:"+ticketNum+"已存在,分配准考证号异常");
			}
			examDoctor.setRoomFlow(beChooseRoom.getRoomFlow());
			examDoctor.setRoomCode(beChooseRoom.getRoomCode());
			examDoctor.setTicketNum(ticketNum);
			GeneralMethod.setRecordInfo(examDoctor, false);
			this.examDoctorMapper.updateByPrimaryKeySelective(examDoctor);
		}
		
		
	}

	@Override
	public ResExamDoctor findExamDoctorByExamFlowAndDoctorFlow(String examFlow,
			String doctorFlow) {
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow)
		.andDoctorFlowEqualTo(doctorFlow);
		List<ResExamDoctor> examDoctors = this.examDoctorMapper.selectByExample(example);
		if(examDoctors.size()==1){
			return examDoctors.get(0);
		}
		return null;
	}

	@Override
	public void finishExam(String examFlow) {
		ResExam record = new ResExam();
		record.setExamFlow(examFlow);
		record.setExamStatusId(ExamStatusEnum.Finished.getId());
		record.setExamStatusName(ExamStatusEnum.Finished.getName());
		GeneralMethod.setRecordInfo(record, false);
		this.examMapper.updateByPrimaryKeySelective(record);
		
	}

	@Override
	public Integer getUserCountInExamSite(String examFlow, String siteFlow) {
		int alreadyAllotSeatNum = 0;
		ResExamDoctorExample example = new ResExamDoctorExample();
		example.createCriteria()
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andExamFlowEqualTo(examFlow).andSiteFlowEqualTo(siteFlow);
		alreadyAllotSeatNum = this.examDoctorMapper.countByExample(example);
		return alreadyAllotSeatNum;
	}

	@Override
	public List<ResExamDoctorExt> findExamDoctorExts(
			Map<String, Object> paramMap) {
        return this.doctorExtMapper.searchExamDoctorExtByMap(paramMap);
	}

	@Override
	public void delRoom(String roomFlow) {
		ResExamRoom room = this.examRoomMapper.selectByPrimaryKey(roomFlow);
		if(room!=null){
			//判断该room是否是最后一个
			//Integer.parseint("01") ---> 1;
			Integer roomCode = Integer.parseInt(room.getRoomCode());
			Integer roomNum = this.findRoomCountBySiteFlow(room.getSiteFlow());
			if(!roomNum.equals(roomCode)){
				throw new RuntimeException("删除的不是最后一个考场");
			}
			//判断该room中是否有人
			Integer i = this.getAlreadyRoomUserCount(roomFlow);
			if(i>0){
				throw new RuntimeException("该考场已有学员,不可删除");
			}
			room.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			this.examRoomMapper.updateByPrimaryKeySelective(room);
		}
		
	}

	@Override
	public Integer getDoctorCountInExamForSpe(String examFlow, String speId) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("examFlow", examFlow);
		paramMap.put("speId", speId);
		return this.doctorExtMapper.searchJoinExamDoctorCountByParamMap(paramMap);
	}

	@Override
	public List<ResExamDoctor> searchExamDoctor(String examFlow,
			String siteFlow, String roomFlow) {
		ResExamDoctorExample example = new ResExamDoctorExample();
		Criteria criteria =  example.createCriteria().andExamFlowEqualTo(examFlow).andSiteFlowEqualTo(siteFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(roomFlow)){
			criteria.andRoomFlowEqualTo(roomFlow);
		}
		example.setOrderByClause("TICKET_NUM");
		return examDoctorMapper.selectByExample(example);
	}

}
