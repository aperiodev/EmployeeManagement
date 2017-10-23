package com.vimaan.controller;

import com.vimaan.model.User;
import com.vimaan.model.UserRole;
import com.vimaan.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Collection;

/**
 * @author anusha
 */
public class BaseController {

    @Autowired
    UserService userService;

    /**
     * To get loggedIn User  username
     *
     * @return username
     */
    public String getLoggedInUserName() {
        String loggedInUser = SecurityContextHolder.getContext().getAuthentication().getName();
        return loggedInUser;
    }

    /**
     * To get loggedIn user object
     *
     * @return user
     */
    public User getLoggedInUser() {
        User user = userService.getUserByUsername(getLoggedInUserName());
        if(user instanceof User){
            return user;
        } else {
            return user = null;
        }
    }

    /**
     * To get loggedInUser roles as collection
     *
     * @return
     */
    public Collection getLoggedInUserRoles() {
        return SecurityContextHolder.getContext().getAuthentication().getAuthorities();
    }

    /**
     * To check whether currentUser is authenticated or not
     * @return isAuthenticated
     */
    public Boolean isAuthenticated() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Boolean isAuthenticated = false;

        if (!(auth instanceof AnonymousAuthenticationToken)) {
            isAuthenticated = true;
        }
        return isAuthenticated;
    }
}