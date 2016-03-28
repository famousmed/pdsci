import java.util.Properties;

import javax.mail.Flags;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.sun.mail.imap.IMAPMessage;

public class ImapTest {

	public static void main(String[] args) throws Exception {
        // ׼�����ӷ������ĻỰ��Ϣ 
        Properties props = new Properties(); 
        props.setProperty("mail.store.protocol", "imap"); 
        props.setProperty("mail.imap.host", "www.njpdxx.com"); 
        props.setProperty("mail.imap.port", "143"); 

        // ����Sessionʵ������ 
        Session session = Session.getInstance(props); 

        // ����IMAPЭ���Store���� 
        Store store = session.getStore("imap"); 

        // �����ʼ������� 
        store.connect("shij@njpdxx.com", "njpdxx123456"); 

        // ����ռ��� 
        Folder folder = store.getFolder("INBOX"); 
        // �Զ�дģʽ���ռ��� 
        folder.open(Folder.READ_WRITE); 

        // ����ռ�����ʼ��б� 
        Message[] messages = folder.getMessages(); 

        // ��ӡ��ͬ״̬���ʼ����� 
        System.out.println("�ռ����й�" + messages.length + "���ʼ�!"); 
        System.out.println("�ռ����й�" + folder.getUnreadMessageCount() + "��δ���ʼ�!"); 
        System.out.println("�ռ����й�" + folder.getNewMessageCount() + "�����ʼ�!"); 
        System.out.println("�ռ����й�" + folder.getDeletedMessageCount() + "����ɾ���ʼ�!"); 

        System.out.println("------------------------��ʼ�����ʼ�----------------------------------"); 

        // �����ʼ� 
        for (Message message : messages) { 
            IMAPMessage msg = (IMAPMessage) message; 
            System.out.println("����ʱ�䣺" + DateUtil.formatDate(message.getSentDate(), DateUtil.defDtPtn02) );      
            String subject = MimeUtility.decodeText(msg.getSubject()); 
            InternetAddress sender = (InternetAddress) msg.getSender();
            
            System.out.println(sender.getPersonal()+"���㷢����һ���ʼ�,�ʼ����⣺"+StringUtil.defaultString(subject)); 
            msg.setFlag(Flag.SEEN, true);   //�����Ѷ���־ 
         
            Flags flags = message.getFlags();  
            if (flags.contains(Flags.Flag.SEEN)) {   
        	}else {}    
        } 

        // �ر���Դ 
        folder.close(false); 
        store.close(); 
	}
}
