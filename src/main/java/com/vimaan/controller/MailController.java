package com.vimaan.controller;

import com.vimaan.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import java.io.FileNotFoundException;

@Controller
@RequestMapping(value = "/auth/user")
public class MailController {

    @Autowired
    MailService mailService;

    @RequestMapping(value = "/sendMail")
    public ModelAndView sendEmailMail() throws Exception {
        mailService.sendMail("vimaandev@gmail.com", "anushac@apeiro.us", "Test Mail", "Hi you r successful in sending email","","");
        return new ModelAndView("redirect:/auth/home");
    }
}
