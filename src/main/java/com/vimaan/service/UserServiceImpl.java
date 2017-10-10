package com.vimaan.service;

import com.vimaan.DAO.UserDao;
import com.vimaan.model.Login;
import com.vimaan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

/**
 * Created by pc on 9/25/2017.
 */
@Service
@Transactional
public class UserServiceImpl implements  UserService {

    @Autowired
    DataSource datasource;

    @Autowired
    UserDao userDao;

    public User validateUser(Login login) {

        User user = userDao.validateUser(login);
        return user;
    }

    public void register(User user) {
        userDao.register(user);
    }
}
