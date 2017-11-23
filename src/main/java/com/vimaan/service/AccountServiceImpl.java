package com.vimaan.service;


import com.vimaan.dao.AccountDao;
import com.vimaan.model.Account;
import com.vimaan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.util.Date;

import static java.lang.Integer.parseInt;

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

    @Autowired
    UserService userService;

    public Account getAccount(User user) {
        Account account1 = accountDao.getAccount(user);
        return account1;
    }

    public void saveOrUpdateAccount(HttpServletRequest request, Date doj, Date dob) {
        Account accountObj;
        if (request.getParameter("id") == null){
            accountObj = new Account();
        } else {
            accountObj = userService.getAccountById(parseInt(request.getParameter("id")));
        }
        accountObj.setFirstname(request.getParameter("firstname").trim());
        accountObj.setAadharnumber(request.getParameter("aadharnumber").trim());
        accountObj.setAddress(request.getParameter("address").trim());
        accountObj.setCurrentemployee(new Boolean(request.getParameter("currentemployee").trim()));
        accountObj.setDesignation(request.getParameter("designation").trim());
        accountObj.setDob(doj);
        accountObj.setDoj(dob);
        accountObj.setEmail(request.getParameter("email").trim());
        accountObj.setEmergencycontactnumber(Long.parseLong(request.getParameter("emergencycontactnumber").trim()));
        accountObj.setPannumber(request.getParameter("pannumber").trim());
        accountObj.setFirstname(request.getParameter("firstname").trim());
        accountObj.setLastname(request.getParameter("lastname").trim());
        accountObj.setEmployeecode(request.getParameter("employeecode").trim().toUpperCase());
        accountObj.setGender(request.getParameter("gender").trim());
        accountObj.setPhonenumber(Long.parseLong(request.getParameter("phonenumber").trim()));
        accountDao.saveOrUpdateAccount(accountObj);
    }

    public void registerAccount(Account account) {
        accountDao.registerAccount(account);
    }
}
