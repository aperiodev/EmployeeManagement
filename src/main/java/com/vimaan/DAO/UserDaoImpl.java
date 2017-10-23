package com.vimaan.dao;

import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.UserRole;
import com.vimaan.model.enums.Authorities;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

@Repository
@Transactional
public class UserDaoImpl extends BaseDao implements UserDao {
    static Logger log = Logger.getLogger(UserDaoImpl.class);

    public void register(User userObj, String role) {
        Session session = getSession();

        session.beginTransaction();

        User user = new User();
        user.setUsername(userObj.getUsername());
        user.setPassword(userObj.getPassword());
        session.save(user);

        UserRole userRole = new UserRole();
        userRole.setRole(role);

        userRole.setUser(user);
        user.getUserRole().add(userRole);

        session.save(userRole);

        Account account = new Account();
        account.setUser(user);
        session.save(account);
        session.getTransaction().commit();
    }

    public List users() {
        Session session = getSession();
        List users = session.createQuery("select  u.username, a.designation, a.employeecode, a.currentemployee, a.email, a.phonenumber, u.enabled " +
                "from Account a , User u where a.user.username = u.username and u.username not  IN( select r.user.username FROM UserRole r WHERE r.role = :adminRole)")
                .setParameter("adminRole", Authorities.ROLE_ADMIN.toString())
                .list();
        return users;
    }

    public User findByUserName(String username) {
        List<User> users;
        users = getSession()
                .createQuery("from User where username=?")
                .setParameter(0, username)
                .list();

        if (users.size() > 0) {
            return users.get(0);
        } else {
            return null;
        }

    }

    public List<UserRole> getHrUsers() {
        String sql = "from UserRole where role='ROLE_HR'";
        List<UserRole> users = getSession().createQuery(sql).list();
        return users.size() > 0 ? users : null;
    }

    public User checkUsername(User user) {
        String sql = "from User where username='" + user.getUsername() + "'";
        List<User> users = getSession().createQuery(sql).list();
        return users.size() > 0 ? users.get(0) : null;
    }

    public int  activateOrDeactivateAccount(String username) {
        User user = findByUserName(username);
        boolean lockStatus = true;
        System.out.println("user status =="+ user.isEnabled());
        if (user.isEnabled()) {
            lockStatus = false;
        }
        String query = "update User  set enabled = :lockStatus where username = :username ";

        int result = getSession()
                .createQuery(query)
                .setParameter("lockStatus", lockStatus)
                .setParameter("username", username).executeUpdate();
        System.out.println("the result is "+ result);
        return result;
    }

    public Account findAccountById(int id){
        List<Account> account = null;
        String sql = "from Account where id= :accountId ";
        account = getSession().createQuery(sql).setParameter("accountId", id).list();
        return account.size() > 0 ? account.get(0) : null;

    }

   /* public UserDetails loadUserByUsername(String identify) throws UsernameNotFoundException {

        UserDetails userDetails = null;
        // step1, find User by username
        List users = getSession().createCriteria(User.class, "u").add(Restrictions.eq("username", identify)).list();
        System.out.println("users===="+ users);
        if (users != null && users.size() > 0) {
            userDetails = (UserDetails) users.get(0);
        }
        if (userDetails == null) {
            throw new UsernameNotFoundException("user '" + identify + "' does not exist");
        }

        Hibernate.initialize(userDetails.getAuthorities());

        return userDetails;
    }*/
}