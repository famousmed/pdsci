package com.pinde.sci.common;

import java.lang.reflect.Method;
import java.util.List;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

public class PdfTemplateMethod implements TemplateMethodModel{

	/**
	 * freemarker调用静态java方法模板类
	 * 将此类实例化对象传进freemarker的pdf模板直接调用
	 * 第一个参数为方法所在类全名
	 * 第二个参数为方法名
	 * 第三个之后的为方法需要的参数
	 * 参数只能为String类型
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
