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
//		strArgs[0] = "J00361";		//�ʺ�
//		strArgs[1] = "130138";		//����
		strArgs[0] = "JC2157";		//�ʺ�
		strArgs[1] = "766253";		//����
		strArgs[2] = "15252452508";//�ֻ���
		strArgs[3] = "ͬ�����ã���л���Դ˴β��Ե���ϡ�";	//������Ϣ
		strArgs[4] = "1";			//�ֻ�����
		strArgs[5] = "8";			//�Ӷ˿� 
		//String strMsg = new String(strArgs[3].getBytes("UTF-8"));//web�����ֻ����UTF��8��ʽ�ı���
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
		
//		������
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
		
		
////		//�ն���
//		thread.start();
}
}
