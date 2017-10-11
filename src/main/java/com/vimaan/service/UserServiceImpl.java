package com.vimaan.service;

import com.vimaan.DAO.UserDao;
import com.vimaan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

    public User validateUser(User user) {

        User user1 = userDao.validateUser(user);
        return user1;
    }

    public void register(User user) {
        userDao.register(user);
    }
}
