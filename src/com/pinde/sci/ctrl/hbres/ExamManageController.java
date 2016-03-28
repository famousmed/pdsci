package com.pinde.sci.ctrl.hbres;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.ExamManageBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResExamSiteBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.res.ExamStatusEnum;
import com.pinde.sci.enums.res.RegStatusEnum;
import com.pinde.sci.form.res.AllotExamCodeForm;
import com.pinde.sci.model.mo.ResExam;
import com.pinde.sci.model.mo.ResExamRoom;
import com.pinde.sci.model.mo.ResExamSite;
import com.pinde.sci.model.res.ResExamDoctorExt;

/**
 * 考试管理控制层
 *   考点维护
 *   分配准考证
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/hbres/singup/exam")
public class ExamManageController extends GeneralController{
	@Autowired
	private ExamManageBiz examManageBiz;
	@Autowired
	private IResDoctorBiz resDoctorBiz;
	@Autowired
	private IResExamSiteBiz examSiteBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	/**
	 * 考试安排
	 * @return
	 */
	@RequestMapping("/plan")
	public String examPlan(Model model){
		List<ResExam> exams = examManageBiz.findALLExam();
		List<ResExam> arrangeExams = new ArrayList<ResExam>();
		List<ResExam> finishedExams = new ArrayList<ResExam>();
		for(ResExam exam : exams){
			if(ExamStatusEnum.Arrange.getId().equals(exam.getExamStatusId())){
				arrangeExams.add(exam);
			}else if(ExamStatusEnum.Finished.getId().equals(exam.getExamStatusId())){
				finishedExams.add(exam);
			}
		}
		model.addAttribute("arrangeExams" , arrangeExams);
		model.addAttribute("finishedExams" , finishedExams);
		return "hbres/manage/exam/examplan";
	}
	
	/**
	 * 保存考试
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String saveExam(ResExam exam){
		try{
			this.examManageBiz.saveExam(exam);
			this.setSessionAttribute(GlobalConstant.CURRENT_EXAM, exam);
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException e){
			return e.getMessage();
		}
		
	}
	
	/**
	 * 查找考试
	 * @param examFlow
	 * @return
	 */
	@RequestMapping("/findexam")
	@ResponseBody
	public Object findExam(@RequestParam(required=true)String examFlow){
		ResExam exam = this.examManageBiz.findExamByFlow(examFlow);
		return exam;
	}
	
	@RequestMapping("/finishexam")
	@ResponseBody
	public String finishExam(@RequestParam(required=true)String examFlow){
		this.examManageBiz.finishExam(examFlow);
		this.removeSessionAttribute(GlobalConstant.CURRENT_EXAM);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 进入考试
	 * @return
	 */
	@RequestMapping("/intoexam")
	public String intoExam(@RequestParam(required=true)String examFlow){
		ResExam exam = this.examManageBiz.findExamByFlow(examFlow);
		this.setSessionAttribute(GlobalConstant.CURRENT_EXAM, exam);
		return "redirect:/hbres/singup/exam/siteplan";
	}
	
	/**
	 * 设置参考人员
	 * @return
	 */
	@RequestMapping("/setexamuser")
	public String setExamUser(Model model){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		//查询系统配置年份审核通过的人数
		String regYear = InitConfig.getSysCfg("res_reg_year");
		Map<String, Object> activatedCountParamMap = new HashMap<String, Object>();
		activatedCountParamMap.put("regYear", regYear);
		List<String> activatedCountParamMapStatus = new ArrayList<String>();
		activatedCountParamMapStatus.add(RegStatusEnum.Passed.getId());
		activatedCountParamMap.put("status", activatedCountParamMapStatus);
		Integer activatedCount = this.resDoctorBiz.searchResRegUserCount(activatedCountParamMap);
		model.addAttribute("regNum" , activatedCount);
		//查询已经参考的人数
		Integer examUserCount = this.examManageBiz.findExamUserCountByExamFlow(exam.getExamFlow());
		model.addAttribute("examUserNum" , examUserCount);
		//未参考人数
		Integer surplusUserNum = activatedCount-examUserCount;
		model.addAttribute("surplusUserNum" , surplusUserNum);
		return "hbres/manage/exam/setexamuser";
	}
	
	/**
	 * 确认设置参考人员
	 * @return
	 */
	@RequestMapping("/submitsetexamuser")
	@ResponseBody
	public String submitSetExamUser(){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		try{
			this.examManageBiz.addExamUser(exam.getExamFlow());
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException e){
			return e.getMessage();
		}
		
	}
	
	/**
	 * 考场分配
	 * @param siteCode
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/roommanage")
	public String roomManage(String siteFlow , Model model){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		List<ResExamSite> examSites = this.examManageBiz.findAllUsablelExamSite(exam.getExamFlow());
		model.addAttribute("sites" , examSites);
		return "hbres/manage/exam/examroommanage";
	}
	
	@RequestMapping("/getexamsite2")
	public String getExamSite2(String recordFlow , Model model){
		ResExamSite examSite = this.examManageBiz.findExamSiteByRecordFlow(recordFlow);
		List<ResExamRoom> rooms = this.examManageBiz.findExamRoomsBySiteFlow(examSite.getRecordFlow());
		Map<String , Map<String , Integer>> roomSpeUserNumResultMap = new HashMap<String, Map<String,Integer>>();
		for(ResExamRoom room:rooms){
			Map<String , Integer> roomSpeUserNumMap = this.examManageBiz.countRoomSpeNum(examSite.getSiteCode() , room.getRoomCode() , room.getRoomFlow());
			roomSpeUserNumResultMap.put(room.getRoomFlow(), roomSpeUserNumMap);
		}
		model.addAttribute("examSite" , examSite);
		model.addAttribute("rooms" , rooms);
		model.addAttribute("roomSpeUserNumResultMap" , roomSpeUserNumResultMap);
		//获取该考点下的总人数
		Integer sumDoctorCountInSite = this.examManageBiz.getUserCountInExamSite(examSite.getExamFlow(), recordFlow);
		//获取该考点下已被分配的人数
		Integer alreadyAllotDoctorCountInSite = this.examManageBiz.getAlreadyAllotSeatNumInSiteAndExam(examSite.getExamFlow(), recordFlow);
		//待分配人数
		Integer notAllotDoctorCountInSite = sumDoctorCountInSite - alreadyAllotDoctorCountInSite;
		model.addAttribute("sumDoctorCountInSite", sumDoctorCountInSite);
		model.addAttribute("alreadyAllotDoctorCountInSite", alreadyAllotDoctorCountInSite);
		model.addAttribute("notAllotDoctorCountInSite" , notAllotDoctorCountInSite);
		return "hbres/manage/exam/rooms";
	}
	
	/**
	 * 初始化考场
	 * @param siteFlow
	 * @param roomNum
	 * @param seatNum
	 * @return
	 */
	@RequestMapping("/initroom")
	@ResponseBody
	public String initRoom(String siteFlow , Integer roomNum , Integer seatNum){
		this.examManageBiz.initRoom(siteFlow, roomNum, seatNum);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 添加考场
	 * @param room
	 * @return
	 */
	@RequestMapping("/addroom")
	@ResponseBody
	public String addRoom(ResExamRoom room){
		room.setSeatNum(StringUtil.defaultIfEmpty(room.getSeatNum(), "0"));
		this.examManageBiz.addRoom(room);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 删除考场
	 * @param roomFlow
	 * @return
	 */
	@RequestMapping("/delroom")
	@ResponseBody
	public String delRoom(@RequestParam(required=true)String roomFlow){
		try{
			this.examManageBiz.delRoom(roomFlow);
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException re){
			return re.getMessage();
		}
	}
	
	/**
	 * 更新考场座位数
	 * @param roomFlow
	 * @param seatNum
	 * @return
	 */
	@RequestMapping("/updateseatnum")
	@ResponseBody
	public String updateSeatNum(String roomFlow , Integer seatNum){
		if(seatNum<1 || seatNum>99){
			return "座位数量要在1-99之间";
		}
		Integer alreadyRoomUserCount = this.examManageBiz.getAlreadyRoomUserCount(roomFlow);
		if(seatNum<alreadyRoomUserCount){
			return "人员已被分配,不可减少";
		}
		ResExamRoom room = new ResExamRoom();
		room.setRoomFlow(roomFlow);
		room.setSeatNum(seatNum.toString());
		this.examManageBiz.modRoomByRoomFlow(room);
		return GlobalConstant.OPRE_SUCCESSED_FLAG;
	}
	
	/**
	 * 一键分配准考证号
	 * @param rooms
	 * @return
	 */
	@RequestMapping("/smartallotticketnum")
	@ResponseBody
	public String smartAllotTicketnum(String siteFlow){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		try{
			if(exam!=null){
				this.examManageBiz.smartAllotExamCode(exam.getExamFlow(), siteFlow);
				return GlobalConstant.OPRE_SUCCESSED_FLAG;
			}
		}catch(RuntimeException e){
			return e.getMessage();
		}
		
		return null;
	}
	
	@RequestMapping("/getexamsite")
	@ResponseBody
	public Object getExamSite(String recordFlow){
		return this.examManageBiz.findExamSiteByRecordFlow(recordFlow);
	}
	
	/**
	 * 显示考场信息
	 * @param roomFlow
	 * @return
	 */
	@RequestMapping("/showroom")
	public String showRoom(String roomFlow , Model model){
		ResExamRoom room = this.examManageBiz.findRoomByRoomFlow(roomFlow);
		ResExamSite site = this.examManageBiz.findExamSiteByRecordFlow(room.getSiteFlow());
		//查询该考场的学员
		ResExamDoctorExt examDoctor = new ResExamDoctorExt();
		examDoctor.setRoomFlow(roomFlow);
		List<ResExamDoctorExt> examDoctorExts = this.examManageBiz.findExamDoctorExts(examDoctor);
		model.addAttribute("examDoctorExts",examDoctorExts);
		model.addAttribute("room" , room);
		model.addAttribute("site",site);
		
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		if(ExamStatusEnum.Arrange.getId().equals(exam.getExamStatusId())){
			List<ResExamRoom> rooms = this.examManageBiz.findExamRoomsBySiteFlow(site.getRecordFlow());
			Map<String , Map<String , Integer>> roomSpeUserNumResultMap = new HashMap<String, Map<String,Integer>>();
			for(ResExamRoom tmproom:rooms){
				Map<String , Integer> roomSpeUserNumMap = this.examManageBiz.countRoomSpeNum(site.getSiteCode() , tmproom.getRoomCode() , tmproom.getRoomFlow());
				roomSpeUserNumResultMap.put(tmproom.getRoomFlow(), roomSpeUserNumMap);
			}
			model.addAttribute("rooms" , rooms);
			model.addAttribute("roomSpeUserNumResultMap" , roomSpeUserNumResultMap);
		}
		return "hbres/manage/exam/showroom";
	}
	
	/**
	 * 给学员更换考场重新生成准考证号
	 * @return
	 */
	@RequestMapping("/changeroom")
	@ResponseBody
	public String changeRoom(AllotExamCodeForm form){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		try{
			this.examManageBiz.changeRoom(exam.getExamFlow(), form.getRoomFlow(), form.getUserFlows());
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException e){
			return e.getMessage();
		}
		
	}
	
	@RequestMapping("/users")
	public String getExamUsers(String siteFlow , String ticketNum , String key , Integer currentPage , Model model){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		List<ResExamSite> examSites = this.examManageBiz.findAllUsablelExamSite(exam.getExamFlow());
		model.addAttribute("sites" , examSites);
		ResExamDoctorExt examDoctor = new ResExamDoctorExt();
		examDoctor.setExamFlow(exam.getExamFlow());
		if(StringUtil.isNotBlank(siteFlow)){
			examDoctor.setSiteFlow(siteFlow);
		}
		if(StringUtil.isNotBlank(ticketNum)){
			examDoctor.setTicketNum(ticketNum);
		}
		Map<String , Object> paramMap = new HashMap<String, Object>();
		paramMap.put("examDoctor", examDoctor);
		paramMap.put("key", key);
		PageHelper.startPage(currentPage, 10);
		List<ResExamDoctorExt> examDoctorExts = this.examManageBiz.findExamDoctorExts(paramMap);
		model.addAttribute("examDoctorExts",examDoctorExts);
		return "hbres/manage/exam/examusers";
	}
	
	//**************** 考点安排  *****************
	
	/**
	 * 考点安排
	 * @return
	 */
	@RequestMapping("/siteplan")
	public String siteplan(HttpServletRequest request,  Model model){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		if(exam != null){
			ResExamSite examSite = new ResExamSite();
			examSite.setExamFlow(exam.getExamFlow());
			examSite.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ResExamSite> examSiteList = examSiteBiz.searchExamSiteList(examSite);
			model.addAttribute("examSiteList", examSiteList);
			if(examSiteList != null && !examSiteList.isEmpty()){
				Map<String, List<String>> examSiteCollegesMap = new HashMap<String, List<String>>();
				for(ResExamSite es : examSiteList){
					String colleges =  es.getColleges();
					if(StringUtil.isNotBlank(colleges)){
						String[] collegesArray = colleges.split(",");
						List<String> collegesList = Arrays.asList(collegesArray);
						examSiteCollegesMap.put(es.getSiteCode(), collegesList);
					}
					model.addAttribute("examSiteCollegesMap", examSiteCollegesMap);
				}
			}
		}
		return "hbres/manage/exam/examSitePlan";	
	}
	
	/**
	 * 考点
	 * @return
	 */
	@RequestMapping("/addExamSite")
	public String addExamSite(Model model){
		return "hbres/manage/exam/addExamSite";	
	}
	
	
	/**
	 * 考点涵盖的院校
	 * @return
	 */
	@RequestMapping("/addColleges")
	public String addColleges(String recordFlow, Model model){
		//过滤其它考点已选院校
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		if(exam != null){
			ResExamSite examSite = new ResExamSite();
			examSite.setExamFlow(exam.getExamFlow());
			examSite.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ResExamSite> examSiteList = examSiteBiz.searchExamSiteList(examSite);
			if(examSiteList != null && !examSiteList.isEmpty()){
				StringBuffer sb =  new StringBuffer();
				for(ResExamSite es : examSiteList){
					if(!es.getRecordFlow().equals(recordFlow)){
						sb.append(","+ es.getColleges());
					}
				}
				String[] collegeArrays = sb.toString().split(",");
				List<String> collegeList = Arrays.asList(collegeArrays);
				model.addAttribute("collegeList", collegeList);
			}
		}
		return "hbres/manage/exam/addColleges";	
	}
	
	/**
	 * 保存考点
	 * @param examSiteList
	 * @return
	 */
	@RequestMapping("/saveExamSiteList")
	@ResponseBody
	public String saveExamSiteList(@RequestBody List<ResExamSite> examSiteList){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		if(exam != null){
			ResExamSite examSite = new ResExamSite();
			examSite.setExamFlow(exam.getExamFlow());
			examSite.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			List<ResExamSite> oldExamSiteList = examSiteBiz.searchExamSiteList(examSite);//上次保存的考点
			//记录需要删除的
			Map<String, ResExamSite> oldExamSiteMap = new HashMap<String, ResExamSite>();
			for(ResExamSite  es : oldExamSiteList){
				oldExamSiteMap.put(es.getSiteCode(), es);
			}
			if(examSiteList != null && examSiteList.size()>0){
				for(ResExamSite es : examSiteList){
					boolean add = true;
					for(ResExamSite oldes : oldExamSiteList){
						if(oldes.getSiteCode().equals(es.getSiteCode())){
							add = false;//不填加并移除
							if(oldExamSiteMap.size() > 0){
								oldExamSiteMap.remove(es.getSiteCode());
							}
							break;
						}
					}
					//新增考点
					if(add){
						ResExamSite search = new ResExamSite();
						search.setExamFlow(exam.getExamFlow());
						search.setSiteCode(es.getSiteCode());
						//search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						List<ResExamSite> searchList = examSiteBiz.searchExamSiteList(search);
						if(searchList != null && !searchList.isEmpty()){//修改RECORD_STATUS_N
							search = searchList.get(0);
							search.setColleges("");//院校清空
							search.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						}else{//新增
							search.setSiteName(es.getSiteName());
							search.setSiteAddress(es.getSiteAddress());
						}
						examSiteBiz.saveExamSite(search);
					}
				}
			}
			//删除考点
			if(oldExamSiteMap.size() > 0){
				for(Map.Entry<String, ResExamSite> entry : oldExamSiteMap.entrySet()){
					ResExamSite delExamSite = entry.getValue();
					delExamSite.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
					examSiteBiz.saveExamSite(delExamSite);
				}
			}
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	
	/**
	 * 保存考点院校
	 * @param examSiteList
	 * @return
	 */
	@RequestMapping("/modifyColleges")
	@ResponseBody
	public String modifyColleges(ResExamSite examSite){
		if(StringUtil.isNotBlank(examSite.getRecordFlow())){
			int result = examSiteBiz.saveExamSite(examSite);
			if(GlobalConstant.ZERO_LINE != result){
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping("/test")
	@ResponseBody
	public Object test(){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		List<Map<String , String>> result = new ArrayList<Map<String,String>>();
		List<ResExamSite> sites = this.examManageBiz.findAllUsablelExamSite(exam.getExamFlow());
		for(ResExamSite site:sites){
			Integer count = this.examManageBiz.getUserCountInExamSite(exam.getExamFlow() , site.getRecordFlow());
			Map<String , String> tmpMap = new HashMap<String, String>();
			tmpMap.put("name", site.getSiteName());
			tmpMap.put("value", count.toString());
			result.add(tmpMap);
		}
		return result;
	}
	@RequestMapping("/print")
	public String print(String siteFlow,String roomFlow, Model model,String beginRoomCode,String endRoomCode){
		ResExam exam = (ResExam)this.getSessionAttribute(GlobalConstant.CURRENT_EXAM);
		model.addAttribute("exam",exam);
		List<ResExamSite> examSites = this.examManageBiz.findAllUsablelExamSite(exam.getExamFlow());
		model.addAttribute("sites" , examSites);
		
		if(StringUtil.isNotBlank(siteFlow)){
			List<ResExamRoom> rooms = examManageBiz.findExamRoomsBySiteFlow(siteFlow);
			model.addAttribute("rooms", rooms);
			if(StringUtil.isNotBlank(roomFlow) || (StringUtil.isNotBlank(beginRoomCode)&& StringUtil.isNotBlank(endRoomCode))){
				ResExamDoctorExt ext = new ResExamDoctorExt();
				ext.setExamFlow(exam.getExamFlow());
				ext.setSiteFlow(siteFlow);
				if(StringUtil.isNotBlank(roomFlow)){ 
					ext.setRoomFlow(roomFlow);
				}
				List<ResExamDoctorExt> result = examManageBiz.findExamDoctorExts(ext);
				List<ResExamDoctorExt> examDoctorExts  = new ArrayList<ResExamDoctorExt>();
				if(StringUtil.isNotBlank(beginRoomCode)&& StringUtil.isNotBlank(endRoomCode)){
					for(ResExamDoctorExt temp : result){
						if(temp.getRoomCode().compareTo(beginRoomCode)>=0 && temp.getRoomCode().compareTo(endRoomCode)<=0 ){
							examDoctorExts.add(temp);
						}
					}
				}else {
					examDoctorExts = result;
				}
				
				model.addAttribute("examDoctorExts", examDoctorExts);
				
				Map<String,List<ResExamDoctorExt>> roomDoctorExtMap = new HashMap<String, List<ResExamDoctorExt>>();
				
				Map<String,Integer> speDocCountMap = new HashMap<String, Integer>();
				List<String> speList = new ArrayList<String>();
				Map<String,String> speTicktNumRangeMap = new HashMap<String, String>();
				
				List<String> roomCodeList = new ArrayList<String>();
				Collections.sort(examDoctorExts,new Comparator<ResExamDoctorExt>() {
					@Override
					public int compare(ResExamDoctorExt o1, ResExamDoctorExt o2) {
						return o1.getTicketNum().compareTo(o2.getTicketNum());
					}
				});
				for(ResExamDoctorExt record : examDoctorExts){
					if(!roomCodeList.contains(record.getRoomCode())){
						roomCodeList.add(record.getRoomCode());
					}
					String speid = record.getDoctor().getSpecialized();
					if(!speList.contains(speid)){
						speList.add(speid);
					}
					List<ResExamDoctorExt> doctors = roomDoctorExtMap.get(record.getRoomCode());
					if(doctors==null){
						doctors = new ArrayList<ResExamDoctorExt>();
					}
					doctors.add(record);
					roomDoctorExtMap.put(record.getRoomCode(), doctors);
					
					Integer count = speDocCountMap.get(record.getRoomCode()+"_"+speid);
					if(count==null){
						count=0;
					}
					count++;
					speDocCountMap.put(record.getRoomCode()+"_"+record.getDoctor().getSpecialized(), count);
					
					//准考证范围
					if(speTicktNumRangeMap.get(record.getRoomCode()+"_"+speid+"_S")==null){
						speTicktNumRangeMap.put(record.getRoomCode()+"_"+speid+"_S",record.getTicketNum());
					}
					speTicktNumRangeMap.put(record.getRoomCode()+"_"+speid+"_E",record.getTicketNum());
				}
				model.addAttribute("speList", speList);
				model.addAttribute("speTicktNumRangeMap", speTicktNumRangeMap);
				model.addAttribute("roomCodeList", roomCodeList);
				model.addAttribute("roomDoctorExtMap", roomDoctorExtMap);
				model.addAttribute("speDocCountMap", speDocCountMap);
				ResExamSite site = examSiteBiz.readExamSite(siteFlow);
				model.addAttribute("site", site);
			}
		}
	    return "hbres/manage/exam/print";	
	}
}
