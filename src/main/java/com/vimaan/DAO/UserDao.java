package com.vimaan.DAO;

import com.vimaan.model.Login;
import com.vimaan.model.User;

/**
 * Created by pc on 9/25/2017.
 */
public interface UserDao  {
    void register(User user);
    User validateUser(Login login);
}
