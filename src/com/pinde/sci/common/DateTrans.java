package com.pinde.sci.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.lang.time.FastDateFormat;

import com.pinde.core.util.StringUtil;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

public class DateTrans implements TemplateMethodModel {  
    
	public String  exec(List args) throws TemplateModelException {
		String srcDate = StringUtil.defaultString((String) args.get(0)).trim();
		String dateType = StringUtil.defaultString((String) args.get(1)).trim();
		srcDate = transDate(srcDate,dateType);
		return srcDate;
    } 

	/**
	 * Method transDate.
	 * @param srcDate
	 * @return String
	 */
	public static String transDate(String srcDate, String dateType) {
		srcDate = StringUtil.defaultString(srcDate).trim();
		if (srcDate.length() == 14)
			return transDateTime(srcDate,"yyyyMMddHHmmss",dateType);
		if (srcDate.length() == 12)
			return transDateTime(srcDate,"yyyyMMddHHmm",dateType);
		if (srcDate.length() == 8)
			return transDateTime(srcDate,"yyyyMMdd",dateType);
		return srcDate;
	}

	/**
	 * ������ʱ���һ�ָ�ʽת��Ϊ��һ�ָ�ʽ
	 * @param srcDateTime Դ��
	 * @param srcPattern	Դ����ʽ
	 * @param destPattern Ŀ�괮��ʽ
	 * @return String Ŀ�괮
	 */
	public static String transDateTime(String srcDateTime,	String srcPattern,	String destPattern) {
		srcDateTime = StringUtil.defaultString(srcDateTime).trim();
		try {
			srcDateTime = FastDateFormat.getInstance(destPattern).format(parseDate(srcDateTime, srcPattern));
		} catch (Exception exp) {
		}
		return srcDateTime;
	}
	
	/**
	 *�����ַ���
	 * @param dateStr
	 * @return �������ڶ���
	 */
	public static java.util.Date parseDate(String dateStr, String pattern) {		
		try {
			return DateUtils.parseDate(dateStr,new String[]{pattern});
		} catch (ParseException e) {
			return null;
		}
	}
	
	/**
	 * �õ�ָ�����ں�ָ������������
	 * @param curDate
	 * @param months
	 * @return
	 */
	public static String newDateOfAddMonths(String curDate,int months) {
		String newDate = "";
		Calendar c = Calendar.getInstance();//���һ��������ʵ��
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = null;
	    try{
	         date = sdf.parse(curDate);
	       }catch(Exception e){

	       }
	    c.setTime(date);//��������ʱ��
	    c.add(Calendar.MONTH,months);	//���ӵ�����
	    newDate = sdf.format(c.getTime());
	     
		return newDate;
	}
	
	/**
	 * �õ�ָ�����ں�ָ������������
	 * @param curDate
	 * @param months
	 * @return
	 */
	public static String newMonthOfAddMonths(String curDate,int months) {
		String newDate = "";
		Calendar c = Calendar.getInstance();//���һ��������ʵ��
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = null;
		try{
			date = sdf.parse(curDate);
		}catch(Exception e){
			
		}
		c.setTime(date);//��������ʱ��
		c.add(Calendar.MONTH,months);	//���ӵ�����
		newDate = sdf.format(c.getTime());
		
		return newDate;
	}
	
	 
}