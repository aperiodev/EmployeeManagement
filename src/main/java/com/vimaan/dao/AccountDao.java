package com.vimaan.dao;

import com.vimaan.model.Account;
import com.vimaan.model.User;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface AccountDao {
    Account getAccount(User user);
    void registerAccount(Account account);
    void saveOrUpdateAccount(Account account);

    Account getUserByEmpcode(String empcode);
}
