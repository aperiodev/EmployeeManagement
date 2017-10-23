package com.vimaan.service;

import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.UserRole;

import java.util.List;

public interface UserService {
    void userRegistration(User user, String userRole);
    List getUsersList();
    List<UserRole> getHrUsers();
    User getUserByUsername(String username);
    User checkUsername(User user);
    int toggleAccountStatus(String username);

    Account getAccountById(int id);

}
