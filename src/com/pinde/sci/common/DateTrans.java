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
	 * 将日期时间从一种格式转换为另一种格式
	 * @param srcDateTime 源串
	 * @param srcPattern	源串格式
	 * @param destPattern 目标串格式
	 * @return String 目标串
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
	 *解析字符串
	 * @param dateStr
	 * @return 返回日期对象
	 */
	public static java.util.Date parseDate(String dateStr, String pattern) {		
		try {
			return DateUtils.parseDate(dateStr,new String[]{pattern});
		} catch (ParseException e) {
			return null;
		}
	}
	
	/**
	 * 得到指定日期后指定月数的日期
	 * @param curDate
	 * @param months
	 * @return
	 */
	public static String newDateOfAddMonths(String curDate,int months) {
		String newDate = "";
		Calendar c = Calendar.getInstance();//获得一个日历的实例
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = null;
	    try{
	         date = sdf.parse(curDate);
	       }catch(Exception e){

	       }
	    c.setTime(date);//设置日历时间
	    c.add(Calendar.MONTH,months);	//增加的月数
	    newDate = sdf.format(c.getTime());
	     
		return newDate;
	}
	
	/**
	 * 得到指定日期后指定月数的日期
	 * @param curDate
	 * @param months
	 * @return
	 */
	public static String newMonthOfAddMonths(String curDate,int months) {
		String newDate = "";
		Calendar c = Calendar.getInstance();//获得一个日历的实例
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date date = null;
		try{
			date = sdf.parse(curDate);
		}catch(Exception e){
			
		}
		c.setTime(date);//设置日历时间
		c.add(Calendar.MONTH,months);	//增加的月数
		newDate = sdf.format(c.getTime());
		
		return newDate;
	}
	
	 
}