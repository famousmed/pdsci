package com.pinde.sci.util;
import java.io.*;
import com.jacob.activeX.*;
import com.jacob.com.*;

public class TestPrint2Flash
{

	public static void main(String[] args) throws java.io.IOException
	{
	
		if (args.length > 0)
		{
			try
			{
				ComThread.InitSTA();
				System.err.println(args[0]); 
				// Create Server object
				ActiveXComponent p2f = new ActiveXComponent("Print2Flash4.Server"); 

				// Setup interface and protection options
				ActiveXComponent defProfile = new ActiveXComponent(p2f.getProperty("DefaultProfile").toDispatch());
				defProfile.setProperty("InterfaceOptions",  P2FConst.INTDRAG | 
						P2FConst.INTZOOMSLIDER | P2FConst.INTZOOMBOX | P2FConst.INTFITWIDTH |
						P2FConst.INTFITPAGE | P2FConst.INTPREVPAGE | P2FConst.INTGOTOPAGE|
						P2FConst.INTNEXTPAGE | P2FConst.INTSEARCHBOX | P2FConst.INTSEARCHBUT|
						P2FConst.INTROTATE | P2FConst.INTPRINT | P2FConst.INTNEWWIND|
						P2FConst.INTHELP | P2FConst.INTBACKBUTTON | P2FConst.INTBACKBUTTONAUTO|
						P2FConst.INTFORWARDBUTTON | P2FConst.INTFORWARDBUTTONAUTO | P2FConst.INTFULLSCREEN| P2FConst.INTFULLSCREENAUTO);
				defProfile.setProperty("ProtectionOptions", P2FConst.PROTDISPRINT | P2FConst.PROTENAPI
						);
				defProfile.setProperty("DocumentType", P2FConst.FLASH | P2FConst.HTML5);

				// Convert document
				p2f.invoke("ConvertFile", new String(args[0]));
				System.out.println("Conversion completed successfully");
			}
			catch (Exception e)
			{
				System.out.println("An error occurred at conversion: "+e.toString());
			}
			finally {
				ComThread.Release();
			}
		}
		else System.out.println("Please provide a document file name as a parameter");
			System.out.println("Press Enter to exit...");
			System.in.read();
	}
}
