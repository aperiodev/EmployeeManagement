package com.vimaan.mail;

import com.vimaan.model.Account;
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

    public String payslipMessage(Account account, String month){
        String message = "Dear " + account.getFirstname() + " " + account.getLastname() + ",</br></br>" +
                "Please find attached here with salary slip for the month of " + month + ". Should you have any query, please contact your local hr desk.</br></br>" +
                "This is a system generated payslip. We request you not to reply to this message </br></br>" +
                "Thanks </br>" +
                "HR - ViMaAn";
        return message;
    }
}
