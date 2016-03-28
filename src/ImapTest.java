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
        // 准备连接服务器的会话信息 
        Properties props = new Properties(); 
        props.setProperty("mail.store.protocol", "imap"); 
        props.setProperty("mail.imap.host", "www.njpdxx.com"); 
        props.setProperty("mail.imap.port", "143"); 

        // 创建Session实例对象 
        Session session = Session.getInstance(props); 

        // 创建IMAP协议的Store对象 
        Store store = session.getStore("imap"); 

        // 连接邮件服务器 
        store.connect("shij@njpdxx.com", "njpdxx123456"); 

        // 获得收件箱 
        Folder folder = store.getFolder("INBOX"); 
        // 以读写模式打开收件箱 
        folder.open(Folder.READ_WRITE); 

        // 获得收件箱的邮件列表 
        Message[] messages = folder.getMessages(); 

        // 打印不同状态的邮件数量 
        System.out.println("收件箱中共" + messages.length + "封邮件!"); 
        System.out.println("收件箱中共" + folder.getUnreadMessageCount() + "封未读邮件!"); 
        System.out.println("收件箱中共" + folder.getNewMessageCount() + "封新邮件!"); 
        System.out.println("收件箱中共" + folder.getDeletedMessageCount() + "封已删除邮件!"); 

        System.out.println("------------------------开始解析邮件----------------------------------"); 

        // 解析邮件 
        for (Message message : messages) { 
            IMAPMessage msg = (IMAPMessage) message; 
            System.out.println("发送时间：" + DateUtil.formatDate(message.getSentDate(), DateUtil.defDtPtn02) );      
            String subject = MimeUtility.decodeText(msg.getSubject()); 
            InternetAddress sender = (InternetAddress) msg.getSender();
            
            System.out.println(sender.getPersonal()+"给你发送了一份邮件,邮件主题："+StringUtil.defaultString(subject)); 
            msg.setFlag(Flag.SEEN, true);   //设置已读标志 
         
            Flags flags = message.getFlags();  
            if (flags.contains(Flags.Flag.SEEN)) {   
        	}else {}    
        } 

        // 关闭资源 
        folder.close(false); 
        store.close(); 
	}
}
