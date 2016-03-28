package com.pinde.sci.model.res;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.model.mo.ResGradeBorderline;
import com.pinde.sci.model.mo.ResRecruitCfg;

/**
 * ��¼���� ҵ��Bean
 * ����ע����ֹʱ��͵���ʱ�������ʾ��Ϣ
 * ���ݴ�ӡ��ֹʱ��͵�ǰʱ�������ʾ��Ϣ
 * @author Administrator
 *
 */
public class DateCfgMsg implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * ��Ϣ����
	 */
	private String code;
	/**
	 * ������Ϣ
	 */
	private String msg;
	/**
	 * �Ƿ�����ע��
	 */
	private Boolean allowReg;
	
	/**
	 * �Ƿ��������
	 */
	private Boolean allowSwap;
	
	public Boolean getAllowSwap() {
		return allowSwap;
	}


	public void setAllowSwap(Boolean allowSwap) {
		this.allowSwap = allowSwap;
	}

	/**
	 * �Ƿ������ӡ׼��֤
	 */
	private Boolean allowPrint;
	
	private Map<String , String> msgContent;
	
	private ResRecruitCfg recruitCfg;
	
	private DateCfgMsg(){
		msgContent = new HashMap<String, String>();
		msgContent.put("1", "δ����");
		msgContent.put("2", "�ѽ�ֹ");
		msgContent.put("3", "δ��ֹ");
		msgContent.put("4", "�ѹر�");
		msgContent.put("5", "δ�ر�");
		msgContent.put("6", "�ѿ���");
		msgContent.put("7", "δ����");
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
