package com.vimaan.DAO;

import com.vimaan.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;


/**
 * Created by pc on 9/25/2017.
 */

@Repository
@Transactional
public class UserDaoImpl extends BaseDao implements UserDao{
    @Autowired
    DataSource datasource;

    @Autowired
    SessionFactory sessionFactory;

    public void register(User user) {
        sessionFactory.openSession().saveOrUpdate(user);
    }

    public User validateUser(User user) {
        String sql = "from User where username='" + user.getUsername() + "' and password='" + user.getPassword()
                + "'";
        List<User> users = sessionFactory.openSession().createQuery(sql).list();
        return users.size() > 0 ? users.get(0) : null;
    }
}

