package com.pinde.sci.common;

import java.lang.reflect.Method;
import java.util.List;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

public class PdfTemplateMethod implements TemplateMethodModel{

	/**
	 * freemarker���þ�̬java����ģ����
	 * ������ʵ�������󴫽�freemarker��pdfģ��ֱ�ӵ���
	 * ��һ������Ϊ����������ȫ��
	 * �ڶ�������Ϊ������
	 * ������֮���Ϊ������Ҫ�Ĳ���
	 * ����ֻ��ΪString����
	 * */
	@Override
	public Object exec(List arg0) throws TemplateModelException {
		if(arg0!=null && arg0.size()>=2){
			String className = (String)arg0.get(0);
			String methodName = (String)arg0.get(1);
			try {
				Class c = Class.forName(className);
				Method method = null;
				Method[] methods = c.getMethods();
				if(methods!=null && methods.length>0){
					for(Method m : methods){
						String name = m.getName();
						if(name.equals(methodName)){
							method = m;
							break;
						}
					}
					if(method!=null){
						Object[] objs = arg0.subList(2,arg0.size()).toArray();
						return method.invoke(c,objs);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "";
	}
}
