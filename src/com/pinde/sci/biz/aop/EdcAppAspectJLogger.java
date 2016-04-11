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
 * ʹ��@Aspect ע����࣬ Spring �����������һ�������Bean��һ�����棩��Ҳ����
 * ��������౾����ж�̬����
 */
@Aspect 
public class EdcAppAspectJLogger {
	
	private static Logger logger = LoggerFactory.getLogger(EdcAppAspectJLogger.class);

    /**
     * ����Ϊfinal String���͵�,ע����Ҫʹ�õı���ֻ���Ǿ�̬�������͵�
     */
	public static final String EDP = "execution(* com.pinde.sci.ctrl.edc.AppController.reqFunction(..))";
	
	@Before(EDP)    //spring��Before֪ͨ
	public void logBefore() {
	}
	
	@After(EDP)    //spring��After֪ͨ
	public void logAfter() {
	}
	
	@Around(EDP)   //spring��Around֪ͨ
	public Object logAround(ProceedingJoinPoint joinPoint) {
		logger.debug("logAround��ʼ:����ʱ����:"+new Date()); //����ִ��ǰ�Ĵ�����
		Object[] args = joinPoint.getArgs();
		Object obj = null;
		try {
			obj = joinPoint.proceed(args);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		logger.debug("logAround����:����ʱ����:"+new Date());  //����ִ�к�Ĵ�����
		return obj;
	}
	
}

