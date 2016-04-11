package com.pinde.sci.biz.aop;

import java.util.Date;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 使用@Aspect 注解的类， Spring 将会把它当作一个特殊的Bean（一个切面），也就是
 * 不对这个类本身进行动态代理
 */
@Aspect 
public class EdcAppAspectJLogger {
	
	private static Logger logger = LoggerFactory.getLogger(EdcAppAspectJLogger.class);

    /**
     * 必须为final String类型的,注解里要使用的变量只能是静态常量类型的
     */
	public static final String EDP = "execution(* com.pinde.sci.ctrl.edc.AppController.reqFunction(..))";
	
	@Before(EDP)    //spring中Before通知
	public void logBefore() {
	}
	
	@After(EDP)    //spring中After通知
	public void logAfter() {
	}
	
	@Around(EDP)   //spring中Around通知
	public Object logAround(ProceedingJoinPoint joinPoint) {
		logger.debug("logAround开始:现在时间是:"+new Date()); //方法执行前的代理处理
		Object[] args = joinPoint.getArgs();
		Object obj = null;
		try {
			obj = joinPoint.proceed(args);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		logger.debug("logAround结束:现在时间是:"+new Date());  //方法执行后的代理处理
		return obj;
	}
	
}

