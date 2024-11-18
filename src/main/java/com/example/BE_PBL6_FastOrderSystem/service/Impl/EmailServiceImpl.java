package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.service.IEmailService;
import jakarta.mail.*;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Properties;

@Service
public class EmailServiceImpl implements IEmailService {

    private JavaMailSender javaMailSender;

    @Autowired
    public EmailServiceImpl(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
    @Override
    public void sendEmail(String to, String subject, String content) {
        if (to == null || to.isEmpty() || subject == null || subject.isEmpty() || content == null || content.isEmpty()) {
            throw new IllegalArgumentException("Email parameters cannot be null or empty.");
        }
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            content = content.replace("\n", "<br>");
            helper.setText(content, true);
            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to send email: " + e.getMessage());
        }
    }

    public void receiveEmail(String host, String storeType, String user, String password, String senderEmail) {
        Properties properties = new Properties();
        properties.put("mail.store.protocol", "imaps");
        properties.put("mail.imaps.host", host);
        properties.put("mail.imaps.port", "993");
        properties.put("mail.imaps.ssl.enable", "true"); // Bật SSL
        Session emailSession = Session.getInstance(properties);
        Store store = null;
        Folder emailFolder = null;

        try {
            // Kết nối tới máy chủ email
            store = emailSession.getStore("imaps");
            store.connect(user, password);

            // Mở thư mục INBOX
            emailFolder = store.getFolder("INBOX");
            emailFolder.open(Folder.READ_ONLY);

            // Lấy danh sách email
            Message[] messages = emailFolder.getMessages();
            System.out.println("Total messages: " + messages.length);

            for (Message message : messages) {
                String fromEmail = message.getFrom()[0].toString(); // Lấy người gửi
                // Kiểm tra xem người gửi có trùng với senderEmail không
                if (fromEmail.contains(senderEmail)) {
                    System.out.println("Email Number: " + message.getMessageNumber());
                    System.out.println("Subject: " + message.getSubject());
                    System.out.println("From: " + message.getFrom()[0]);
                    System.out.println("Text: " + message.getContent().toString());
                }
            }
        } catch (MessagingException | IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to receive email: " + e.getMessage());
        } finally {
            try {
                if (emailFolder != null && emailFolder.isOpen()) {
                    emailFolder.close(false);
                }
                if (store != null) {
                    store.close();
                }
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
    }






}
