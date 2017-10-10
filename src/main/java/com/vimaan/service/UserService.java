package com.vimaan.service;

import com.vimaan.model.Login;
import com.vimaan.model.User;

/**
 * Created by pc on 9/25/2017.
 */
public interface UserService {

    User validateUser(Login login);
    void register(User user);
}
