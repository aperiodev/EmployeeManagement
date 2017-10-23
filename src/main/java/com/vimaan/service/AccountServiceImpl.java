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
        accountObj.setFirstname(request.getParameter("firstname"));
        accountObj.setAadharnumber(request.getParameter("aadharnumber"));
        accountObj.setAddress(request.getParameter("address"));
        accountObj.setCurrentemployee(new Boolean(request.getParameter("currentemployee")));
        accountObj.setDesignation(request.getParameter("designation"));
        accountObj.setDob(doj);
        accountObj.setDoj(dob);
        accountObj.setEmail(request.getParameter("email"));
        accountObj.setEmergencycontactnumber(Long.parseLong(request.getParameter("emergencycontactnumber")));
        accountObj.setPannumber(request.getParameter("pannumber"));
        accountObj.setFirstname(request.getParameter("firstname"));
        accountObj.setLastname(request.getParameter("lastname"));
        accountObj.setEmployeecode(request.getParameter("employeecode"));
        accountObj.setGender(request.getParameter("gender"));
        accountObj.setPhonenumber(Long.parseLong(request.getParameter("phonenumber")));
        accountDao.saveOrUpdateAccount(accountObj);
    }

    public void registerAccount(Account account) {
        accountDao.registerAccount(account);
    }
}
