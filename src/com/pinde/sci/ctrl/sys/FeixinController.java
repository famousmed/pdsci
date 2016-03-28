package com.pinde.sci.ctrl.sys;

import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GeneralController;
import com.sdk.Tools;
import com.sdk.entites.MessageBody;
import com.sdk.entites.MessageData;
import com.sdk.utils.GloatContant;
import com.sdk.utils.Utils;

@Controller
@RequestMapping("/feixin")
public class FeixinController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(FeixinController.class);
	
	@RequestMapping(value={"/receive"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String receive(String clientid,String sign,String timestamp,String nonce,String echostr,String message,HttpServletRequest request,HttpServletResponse response,Model model){
		System.out.println("clientid="+clientid);
		System.out.println("sign="+sign);
		System.out.println("timestamp="+timestamp);
		System.out.println("echostr="+echostr);
		System.out.println("nonce="+nonce);
		System.out.println("message="+message);
		String result=GloatContant.ResultOK;
		//��ȡ����keystr
//		String keyStr = SDKUtil.readData(GloatContant.KEYSTR,"clientinfo.properties");
		
//		String cs = Tools.checkSignByPost(request, keyStr);//����sdk ��֤sign
		//���echoStr��Ϊ�գ�֤������֤url����ֱ�ӷ���echoStr����
		
		if(StringUtil.isNotBlank(echostr)){
			result = echostr;
		}
		//����sdk ��֤sign
		String cs = Tools.checkSignByPost(request, "njpdxx");
		if(cs.equals(GloatContant.ResultOK)){
			//����sdk��������messagedata
			MessageData mdata = Tools.anlyzeMessageByPost(request);
			if(!Utils.isEmpty(mdata.getToken())){
				logger.info("recieve write token::"+mdata.getToken());
			}
		}
		return result;
	}
	
	@RequestMapping(value={"/getToken"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String getToken(HttpServletRequest request,HttpServletResponse response,Model model){
		String result=GloatContant.ResultOK;

		String timestamp = String.valueOf(System.currentTimeMillis());
		String nonce = String.valueOf(new Random().nextInt(10000));
		String url = "http://221.176.30.209/op/gettoken.php";
		
		Map<String, String> map = new TreeMap<String, String>();
		map.put(GloatContant.CLIENTID, "10715");
		map.put(GloatContant.KEYSTR, "njpdxx");
		map.put(GloatContant.NONCE, nonce);
		map.put(GloatContant.TIMESTAMP, timestamp);
		map.put(GloatContant.URL, url);
		result = Tools.getToken(map);//����sdk��������token�ӿ�
		return result;
	}
	
	@RequestMapping(value={"/send"},method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String send(HttpServletRequest request,HttpServletResponse response,Model model){
		String result=GloatContant.ResultOK;
		//����Ϣʵ������
		MessageBody mbody = new MessageBody();
		mbody.setPpid("4010982525");
		mbody.setUseruri("15895865441");
		mbody.setMsgtype("PublicPlatformMsg");
		mbody.setContent("����ʡ��ҽԺ��������-�ٴ��о�����ƽ̨ ������Ϣ");
//		mbody.setCallid("809");
		mbody.setCseqvalue("1");
		mbody.setMsgid(PkUtil.getUUID());
//		mbody.setClienttype("PCV4");
//		mbody.setPackageid("13");
		mbody.setUsertype("CMCC/1:E,S2,SWS,L14");
		mbody.setNickname("ʩ��");
		
		String timestamp = String.valueOf(System.currentTimeMillis());
		String nonce = String.valueOf(new Random().nextInt(10000));
		String url = "http://221.176.30.209/op/get.php";
		Map<String, String> map = new TreeMap<String, String>();
		map.put(GloatContant.CLIENTID, "10715");
		map.put(GloatContant.NONCE, nonce);
		map.put(GloatContant.TOKEN, "ffd72a2dc03e691f32db2806003d470b");
		map.put(GloatContant.TIMESTAMP, timestamp);
		map.put(GloatContant.MESSAGE, mbody.toXMLString());
		map.put(GloatContant.URL, url);
		
		logger.info("sendmessage::"+map.toString());
		result = Tools.sendMessageByPost(map);//����sdk����Ϣ
		logger.info("sendmessage::result::"+result);
		return result;
	}
	
}

