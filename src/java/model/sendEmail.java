/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
    import java.util.Properties;
     
    import javax.mail.Message;
    import javax.mail.MessagingException;
    import javax.mail.Session;
    import javax.mail.Transport;
    import javax.mail.internet.AddressException;
    import javax.mail.internet.InternetAddress;
    import javax.mail.internet.MimeMessage;

/**
 *
 * @author VUONG NGUYEN
 */
public class sendEmail {
    public static void sendHTML(String emailBody, String toemail) throws AddressException, MessagingException {
        Properties mailServerProperties;
        Session getMailSession;
        MimeMessage mailMessage;
     
        // Step1: setup Mail Server
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
     
        // Step2: get Mail Session
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        mailMessage = new MimeMessage(getMailSession);
     
        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toemail)); //Thay abc bằng địa chỉ người nhận
     
        // Bạn có thể chọn CC, BCC
        // generateMailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress("cc@gmail.com")); //Địa chỉ cc gmail        
     
        mailMessage.setSubject("OurMovieSimilarity-New movie similarity submitted");        
        mailMessage.setContent(emailBody, "text/html");
     
        // Step3: Send mail
        Transport transport = getMailSession.getTransport("smtp");
     
        // Thay your_gmail thành gmail của bạn, thay your_password thành mật khẩu gmail của bạn
        transport.connect("smtp.gmail.com", "ourmoviesimilarity.ke.cau.ac.kr@gmail.com", "kelab51365136");
        transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
        transport.close();
    }    
}
