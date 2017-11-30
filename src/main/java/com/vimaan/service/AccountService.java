package com.vimaan.service;

import com.vimaan.model.Account;
import com.vimaan.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface AccountService {

    Account getAccount(User user);
    void registerAccount(Account account);

    void saveOrUpdateAccount(HttpServletRequest request, Date doj, Date dob);

    Account getUserByEmpcode(String empcode);

    Account checkEmployeeCode(Account account);

    Account getUserByEmpcodeById(String empcode,String email);
}
