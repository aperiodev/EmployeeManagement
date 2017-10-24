package com.vimaan.DAO;

import com.vimaan.model.Account;
import com.vimaan.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;
/**
 * Created by IT Division on 10-10-2017.
 */
@Repository
@Transactional
public class AccountDaoImpl extends BaseDao implements AccountDao{

    @Autowired
    DataSource datasource;

    @Autowired
    SessionFactory sessionFactory;

    public Account getAccount(User user) {
        String sql = "from Account where user_id='" + user.getId() + "'";
        List<Account> accounts = sessionFactory.openSession().createQuery(sql).list();
        return accounts.size() > 0 ? accounts.get(0) : null;
    }

}
