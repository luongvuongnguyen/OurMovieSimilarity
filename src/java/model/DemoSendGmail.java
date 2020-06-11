    import java.util.Properties;
     
    import javax.mail.Message;
    import javax.mail.MessagingException;
    import javax.mail.Session;
    import javax.mail.Transport;
    import javax.mail.internet.AddressException;
    import javax.mail.internet.InternetAddress;
    import javax.mail.internet.MimeMessage;
     
    public class DemoSendGmail {
     
      public static void sendHTML() throws AddressException, MessagingException {
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
     
        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("abc@gmail.com")); //Replace abc with the recipient's email address
     
        // Choosing CC, BCC
        //generateMailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress("cc@gmail.com")); //cc gmail
     
     
        mailMessage.setSubject("Demo send gmail from Java");
        String emailBody = "<p style='color: red'>Demo send HTML from Java<p>";
        mailMessage.setContent(emailBody, "text/html");
     
        // Step3: Send mail
        Transport transport = getMailSession.getTransport("smtp");
     
        // Replace your_gmail to your gmail, replace your_password to your gmail password
        transport.connect("smtp.gmail.com", "your_gmail", "your_password"); 
        transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
        transport.close();
      }
     
    }