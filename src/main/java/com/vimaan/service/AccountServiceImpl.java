package com.vimaan.service;


import com.vimaan.dao.AccountDao;
import com.vimaan.model.Account;
import com.vimaan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

/**
 * Created by IT Division on 10-10-2017.
 */
@Service
@Transactional
public class AccountServiceImpl implements AccountService {
    @Autowired
    DataSource datasource;

    @Autowired
    AccountDao accountDao;

    public Account getAccount(User user) {
        Account account1 = accountDao.getAccount(user);
        return account1;
    }

    public void registerAccount(Account account) {
        accountDao.registerAccount(account);
    }
}
