/**
 * 
 */
package org.tempuri;

import java.io.UnsupportedEncodingException;
import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

/**
 * @author Administrator
 * 
 */
public class WebServiceTest {
	static final ReviceThread thread = new ReviceThread();
	/**
	 * @param args
	 * @throws UnsupportedEncodingException 
	 */
	public static void main(String[] args) throws UnsupportedEncodingException {
		WmgwLocator wmgwLocator = new WmgwLocator();
		String strArgs[] = new String[10];
//		strArgs[0] = "J00361";		//帐号
//		strArgs[1] = "130138";		//密码
		strArgs[0] = "JC2157";		//帐号
		strArgs[1] = "766253";		//密码
		strArgs[2] = "15252452508";//手机号
		strArgs[3] = "同事您好，感谢您对此次测试的配合。";	//测试信息
		strArgs[4] = "1";			//手机个数
		strArgs[5] = "8";			//子端口 
		//String strMsg = new String(strArgs[3].getBytes("UTF-8"));//web服务端只接受UTF—8方式的编码
		String strMsg = strArgs[3];
		//mongateCsSendSmsEx
//		try {
//			System.out.println("Test mongateCsSendSmsEx ...");
//			System.out.println("back value is :"
//					+ wmgwLocator.getwmgwSoap().mongateCsSendSmsEx(strArgs[0],
//							strArgs[1], strArgs[2], strMsg, Integer.valueOf(strArgs[4]).intValue()));
//			System.out.println("send mongateCsSendSmsEx end !");
//			System.out.println();
//		} catch (RemoteException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (ServiceException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
//		发短信
		try {
			System.out.println("Test mongateCsSendSmsExNew ...");
			System.out.println("back value is :"
					+ wmgwLocator.getwmgwSoap().mongateCsSpSendSmsNew(strArgs[0],
							strArgs[1], strArgs[2], strMsg, Integer.valueOf(strArgs[4]).intValue(),strArgs[5]));
			System.out.println("send mongateCsSendSmsExNew end !");
			System.out.println();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//mongateCsGetStatusReportExEx
//		try {
//			System.out.println("Test mongateCsGetStatusReportExEx ...");
//			String[] strRet = wmgwLocator.getwmgwSoap().mongateCsGetStatusReportExEx(strArgs[0], strArgs[1]);
//			System.out.println("back value is :");
//			if (strRet != null)
//			{
//				for(int i = 0; i < strRet.length; ++i)
//				{
//					System.out.println(strRet[i]);
//				}
//			}
//			else
//			{
//				System.out.println("null");
//			}
//			System.out.println("send mongateCsGetStatusReportExEx end !");
//			System.out.println();
//		} catch (RemoteException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (ServiceException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//////
		//mongateQueryBalance
//		try {
//			System.out.println("Test mongateQueryBalance ...");
//			System.out.println("back value is :"
//					+ wmgwLocator.getwmgwSoap().mongateQueryBalance(strArgs[0], strArgs[1]));
//			System.out.println("send mongateQueryBalance end !");
//			System.out.println();
//		} catch (RemoteException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (ServiceException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
		
		
////		//收短信
//		thread.start();
}
}
