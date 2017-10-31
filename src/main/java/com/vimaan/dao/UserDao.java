package com.vimaan.dao;


import com.vimaan.model.Account;

import com.vimaan.model.User;
import com.vimaan.model.UserRole;

import java.util.List;

public interface UserDao  {

    User findByUserName(String username);
    void register(User user, String userRole);
    List<Account> getHrUsers();
    List users();
    User checkUsername(User user);
    int  activateOrDeactivateAccount(String username);
    Account findAccountById(int id);
    boolean confirmOldPassword(String password, String username);

}
