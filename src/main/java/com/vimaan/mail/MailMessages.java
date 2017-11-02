package com.vimaan.mail;

import com.vimaan.model.User;

public class MailMessages {

    public String loginMessage(User user){
        String message = "<h4><b>Hi " + user.getUsername().split("@")[0] + ",</b></h4></br>" +
                "<h5>Welcome to Apeiro technologies, We are glad to have you in our team,</br> Please login with the following credentials : </br> user name : <b>" + user.getUsername() + "</b>.</br>" +
                "</br>  password: <b>" + user.getPassword() + "</b></h5>" +
                "<h5><b>Thanks & Regards,</b> </br> Apeiro Support Team.</h5>";
        return message;
    }

    public String forgotPasswordMsg(User user){
        String message = "<h4><b>Hi " + user.getUsername().split("@")[0] + ",</b></h4></br>" +
                "<h5>You have recently requested for forgot password for your account <b>" + user.getUsername() + "</b>.</br>" +
                "Please login with the following password: <b>" + user.getPassword() + "</b></h5>"+
                "<h5><b>Thanks & Regards,</b> </br> Apeiro Support Team.</h5>";
        return message;
    }
}
