import java.util.Date;
import java.util.Properties;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;


public class EmailTest {

	public static void main(String[] args) {
		JavaMailSenderImpl mailSender = null;
		try {
			mailSender = new JavaMailSenderImpl();
			mailSender.setHost("smtp.163.com");
			int port = 25;
			mailSender.setPort(port);
			Properties prop = new Properties();
			prop.setProperty("mail.smtp.auth", "true");
			mailSender.setJavaMailProperties(prop);
			mailSender.setUsername("sczyres");
			mailSender.setPassword("njpdxx");
			MimeMessage mail = mailSender.createMimeMessage(); 
//			SimpleMailMessage mail = new SimpleMailMessage();
			 //multipartģʽ 
		    MimeMessageHelper messageHelper = new MimeMessageHelper(mail,true,"UTF-8"); 
		    
		    messageHelper.setFrom("sczyres@163.com");// ��������Ƭ
		    messageHelper.setTo("shij@njpdxx.com");// �ռ�������
		    messageHelper.setSubject("�ʼ�����");// 
		    messageHelper.setSentDate(new Date());// �ʼ�����ʱ��
		    String context = "<html><head>" +
		            "<meta http-equiv='description' content=''><meta http-equiv='content-type' content='text/html; charset=UTF-8'>" +
		            "</head><body><div>"+"�ʼ�����"+"</div></body></html>";
		    messageHelper.setText(context,true);
			
			mailSender.send(mail);
		} catch (Throwable e) {
			e.printStackTrace();
			mailSender = null;
		}

	}

}
