package com.pinde.sci.common;

import java.math.BigDecimal;

import com.pinde.core.util.StringUtil;


public class NumTrans{ 
	/**
	 * ����������ת��Ϊ����Сд����
	 */
	public static String transNum(String mum) {
		String []aa = {"","ʮ","��","ǧ","��","ʮ��","����","ǧ��","��","ʮ��"};
		String []bb = {"һ","��","��","��","��","��","��","��","��"};
		String newNum = "";
		char[] ch = mum.toCharArray();
		int maxindex = ch.length;
		//�ַ���ת��
		//��λ��������ת��
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
		//����λ��������ת����ʹ�õ���int��������λ��Ϊʮ��
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
	 * ��������ðٷֱ�
	 * @param num1
	 * @param num2
	 * @param decimalNum(����С����λ��)
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
	 * ��������ðٷֱ�
	 * @param num1
	 * @param decimalNum(����С����λ��)
	 * @return
	 */
	public static String transPercent(String num1,Integer decimalNum) {
		BigDecimal b = new BigDecimal(num1).setScale(decimalNum,BigDecimal.ROUND_HALF_UP);
		return String.valueOf(b);
	}
	 
}