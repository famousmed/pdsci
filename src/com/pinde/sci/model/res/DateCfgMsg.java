package com.pinde.sci.model.res;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.ResRecruitCfg;

/**
 * 招录设置 业务Bean
 * 根据注册起止时间和当期时间计算显示信息
 * 根据打印起止时间和当前时间计算显示信息
 * @author Administrator
 *
 */
public class DateCfgMsg implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 信息代码
	 */
	private String code;
	/**
	 * 具体信息
	 */
	private String msg;
	/**
	 * 是否允许注册
	 */
	private Boolean allowReg;
	
	/**
	 * 是否允许调剂
	 */
	private Boolean allowSwap;
	
	public Boolean getAllowSwap() {
		return allowSwap;
	}


	public void setAllowSwap(Boolean allowSwap) {
		this.allowSwap = allowSwap;
	}

	/**
	 * 是否允许打印准考证
	 */
	private Boolean allowPrint;
	
	private Map<String , String> msgContent;
	
	private ResRecruitCfg recruitCfg;
	
	private DateCfgMsg(){
		msgContent = new HashMap<String, String>();
		msgContent.put("1", "未设置");
		msgContent.put("2", "已截止");
		msgContent.put("3", "未截止");
		msgContent.put("4", "已关闭");
		msgContent.put("5", "未关闭");
		msgContent.put("6", "已开放");
		msgContent.put("7", "未开放");
		code = "1";
		msg = msgContent.get(code);
	}
	
	
	public DateCfgMsg(ResRecruitCfg recruitCfg){
		this();
		this.recruitCfg = recruitCfg;
		this.allowReg = false; 
		this.allowPrint = false; 
		this.allowSwap = false; 
		
	}
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Boolean getAllowReg() {
		return allowReg;
	}
	public void setAllowReg(Boolean allowReg) {
		this.allowReg = allowReg;
	}
	public Boolean getAllowPrint() {
		return allowPrint;
	}
	public void setAllowPrint(Boolean allowPrint) {
		this.allowPrint = allowPrint;
	}
	
	public void setRegDateMsg(String date){
		if(this.recruitCfg!=null){
			String regBingDate = recruitCfg.getRegBeginDate();
			String regEndDate = recruitCfg.getRegEndDate();
			setDateMsg(regBingDate , regEndDate , date);
			if("3".equals(code)){
				this.allowReg = true;
			}
		}
		
	}
	
	public void setPrintDateMsg(String date){
		if(this.recruitCfg!=null){
			String printBingDate = recruitCfg.getPrintBeginDate();
			String printEndDate = recruitCfg.getPrintEndDate();
			setDateMsg(printBingDate , printEndDate , date);
			if("3".equals(code)){
				this.allowPrint = true;
			}
		}
	
	}
	
	public void setWishDateMsg(String date){
		if(this.recruitCfg!=null){
			String wishBingDate = recruitCfg.getWishBeginDate();
			String wishEndDate = recruitCfg.getWishEndDate();
			setDateMsg(wishBingDate , wishEndDate , date);
		}
	
	}
	
	public void setAdmitDateMsg(String date){
		if(this.recruitCfg!=null){
			String admitBingDate = recruitCfg.getAdmitBeginDate();
			String admitEndDate = recruitCfg.getAdmitEndDate();
			setDateMsg(admitBingDate , admitEndDate , date);
		}
	
	}
	
	public void setSwapDateMsg(String date){
		if(this.recruitCfg!=null){
			String swapBingDate = recruitCfg.getSwapBeginDate();
			String swapEndDate = recruitCfg.getSwapEndDate();
			setDateMsg(swapBingDate , swapEndDate , date);
			if("3".equals(code)){
				this.allowSwap = true;
			}
		}
	
	}
	
	private void setDateMsg(String beginDate , String endDate , String date){
		beginDate = StringUtil.defaultIfEmpty(beginDate, "0");
		endDate = StringUtil.defaultIfEmpty(endDate, "0");
		if("0".equals(beginDate) && "0".equals(endDate)){
			code = "1";
		}else if(endDate.compareTo(date)>=0 && date.compareTo(beginDate)>=0){
			code = "3";
		}else if(endDate.compareTo(date)<0){
			code = "2";
		}else if(date.compareTo(beginDate)<0){
			code = "7";
		}
		msg = this.msgContent.get(code);
	}
	
	
}
