package com.pinde.sci.common;

import java.math.BigDecimal;

import com.pinde.core.util.StringUtil;


public class NumTrans{ 
	/**
	 * 阿拉伯数字转换为中文小写数字
	 */
	public static String transNum(String mum) {
		String []aa = {"","十","百","千","万","十万","百万","千万","亿","十亿"};
		String []bb = {"一","二","三","四","五","六","七","八","九"};
		String newNum = "";
		char[] ch = mum.toCharArray();
		int maxindex = ch.length;
		//字符的转换
		//两位数的特殊转换
		if(maxindex == 2){
		   for(int i=maxindex-1,j=0;i>=0;i--,j++){
			   if(ch[j]!=48){
				   if(j==0&&ch[j]==49){
					   newNum += aa[i];
				   }else{
					   newNum += bb[ch[j]-49]+aa[i];
				   }
			   }
		   }
		//其他位数的特殊转换，使用的是int类型最大的位数为十亿
		}else{
		   for(int i=maxindex-1,j=0;i>=0;i--,j++){
			   if(ch[j]!=48){
				   newNum += bb[ch[j]-49]+aa[i];
			   }
		   	}
		 } 
		return newNum;
	}
	
	/**
	 * 两数相除得百分比
	 * @param num1
	 * @param num2
	 * @param decimalNum(保留小数点位数)
	 * @return
	 */
	public static String transPercent(String num1,String num2,Integer decimalNum) {
		String newNum = "";
		if (StringUtil.isBlank(num1)) {
			num1 = "0";
		}
		Float f = null;
		if (StringUtil.isBlank(num2) || "0".equals(num2)) {
			f = Float.valueOf("0");
		} else {
			f = (Float.valueOf(num1)/Float.valueOf(num2))*100;
		}
		BigDecimal b = new BigDecimal(f).setScale(decimalNum,BigDecimal.ROUND_HALF_UP);
		newNum = String.valueOf(b)+"%";
		return newNum;
	}
	
	/**
	 * 两数相除得百分比
	 * @param num1
	 * @param decimalNum(保留小数点位数)
	 * @return
	 */
	public static String transPercent(String num1,Integer decimalNum) {
		BigDecimal b = new BigDecimal(num1).setScale(decimalNum,BigDecimal.ROUND_HALF_UP);
		return String.valueOf(b);
	}
	 
}