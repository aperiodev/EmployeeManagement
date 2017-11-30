package com.vimaan.dao;

import com.vimaan.model.Account;
import com.vimaan.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AccountDaoImpl extends BaseDao implements AccountDao {

    @Autowired
    SessionFactory sessionFactory;

    public Account getAccount(User user) {
        String sql = "from Account where user.username='" + user.getUsername() + "'";
        List<Account> accounts = getSession().createQuery(sql).list();
        return accounts.size() > 0 ? accounts.get(0) : null;
    }

    public void registerAccount(Account account) {
        try {
            getSession().save(account);
        } catch (Exception e) {
            System.out.println(" exce   " + e.getMessage());
        }
    }

    public void saveOrUpdateAccount(Account account) {
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.saveOrUpdate(account);
        tx.commit();
    }

    public Account getUserByEmpcode(String empcode) {
        String sql = "from Account where employeecode='" + empcode + "'";
        List<Account> accounts = getSession().createQuery(sql).list();
        return accounts.size() > 0 ? accounts.get(0) : null;
    }

    public Account checkEmployeeCode(Account account) {
        String sql = "from Account where employeecode='" + account.getEmployeecode() + "' and user_account_id="+account.getId()+"";
        List<Account> accounts = getSession().createQuery(sql).list();
        return accounts.size() > 0 ? accounts.get(0) : null;
    }

    public Account getUserByEmpcodeById(String empcode,String email) {
        String sql = "from Account where employeecode='" + empcode + "' and username!='"+email+"'";
        List<Account> accounts = getSession().createQuery(sql).list();
        return accounts.size() > 0 ? accounts.get(0) : null;
    }
}