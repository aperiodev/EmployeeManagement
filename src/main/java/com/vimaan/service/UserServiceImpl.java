package com.vimaan.service;

import com.vimaan.dao.UserDao;
import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author anusha.
 */
@Service
@Transactional
public class UserServiceImpl implements  UserService, UserDetailsService {

    @Autowired
    UserDao userDao;

    public void userRegistration(User user, String userRole) {
        userDao.register(user, userRole);
    }

    public List getUsersList(){
       return userDao.users();
    }

    @Transactional(readOnly=true)
    public UserDetails loadUserByUsername(final String username)
            throws UsernameNotFoundException {

        User user = userDao.findByUserName(username);
        List<GrantedAuthority> authorities =
                buildUserAuthority(user.getUserRole());

        return buildUserForAuthentication(user, authorities);

    }

    // Converts com.vimaan.model.User user to
    // org.springframework.security.core.userdetails.User
    private org.springframework.security.core.userdetails.User buildUserForAuthentication(User user,
                                            List<GrantedAuthority> authorities) {
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
                user.isEnabled(), true, true, true, authorities);
    }

    private List<GrantedAuthority> buildUserAuthority(Set<UserRole> userRoles) {

        Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();

        // Build user's authorities
        for (UserRole userRole : userRoles) {
            setAuths.add(new SimpleGrantedAuthority(userRole.getRole()));
        }

        List<GrantedAuthority> Result = new ArrayList<GrantedAuthority>(setAuths);

        return Result;
    }

    public List<UserRole> getHrUsers() {
        return userDao.getHrUsers();
    }

    public User getUserByUsername(String username) {
        return userDao.findByUserName(username);
    }

    public User checkUsername(User user) {
        User user1 = userDao.checkUsername(user);
        return user1;
    }

    public int toggleAccountStatus(String username){
        return userDao.activateOrDeactivateAccount(username);
    }

     public Account getAccountById(int id){
        return  userDao.findAccountById(id);
     }
}
