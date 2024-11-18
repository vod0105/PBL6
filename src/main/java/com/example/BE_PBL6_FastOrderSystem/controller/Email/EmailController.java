package com.example.BE_PBL6_FastOrderSystem.controller.Email;
import com.example.BE_PBL6_FastOrderSystem.service.IEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/email")
public class EmailController {

    private final IEmailService emailService;

    @Autowired
    public EmailController(IEmailService emailService) {
        this.emailService = emailService;
    }

    @PostMapping("/send")
    public String sendEmail(@RequestParam String to, @RequestParam String subject, @RequestParam String content) {
        emailService.sendEmail(to, subject, content);
        return "Email sent successfully";
    }

    @GetMapping("/receive")
    public String receiveEmail(@RequestParam String host, @RequestParam String storeType, @RequestParam String user, @RequestParam String password, @RequestParam String senderEmail) {
        emailService.receiveEmail(host, storeType, user, password, senderEmail);
        return "Emails received successfully";
    }
}
