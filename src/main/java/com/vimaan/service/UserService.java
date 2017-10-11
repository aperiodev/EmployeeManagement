package com.vimaan.service;

import com.vimaan.model.User;

/**
 * Created by pc on 9/25/2017.
 */
public interface UserService {

   User validateUser(User user);
    void register(User user);
}
