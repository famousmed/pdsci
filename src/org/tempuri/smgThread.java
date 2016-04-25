package org.tempuri;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

class ReviceThread extends Thread{
	public void run() {
		while (true) {
			try {
				recive();
				sleep(10*1000);
			} catch (Exception e) {
				// TODO 自动生成 catch 块
				e.printStackTrace();
			} 
		}
	}
	private void recive(){
		// TODO Auto-generated method stub
		WmgwLocator wmgwLocator = new WmgwLocator();
		String strArgs[] = new String[10];
		strArgs[0] = "J00361";		//帐号
		strArgs[1] = "130138";		//密码
		try {
			System.out.println("Test mongateCsGetSmsExEx ...");
			String[] strRet = wmgwLocator.getwmgwSoap().mongateCsGetSmsExEx(strArgs[0], strArgs[1]);
			System.out.println("back value is :");
			if (strRet != null)
			{
				for(int i = 0; i < strRet.length; ++i)
				{
					System.out.println(strRet[i]);
				}
			}
			else
			{
				System.out.println("null");
			}
			System.out.println("send mongateCsGetSmsExEx end !");
			System.out.println();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
