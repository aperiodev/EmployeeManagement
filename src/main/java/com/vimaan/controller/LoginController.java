package com.vimaan.controller;

import com.vimaan.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collection;

/**
 * @author anusha
 */
@Controller
public class LoginController extends BaseController {
    static Logger log = Logger.getLogger(LoginController.class);

    @Autowired
    UserService userService;
    Authentication authentication;

    /**
     * This methods maps default url
     * user is navigated to login page if isNotAuthenticated
     * and navigated to home if isAuthenticatedO
     *
     * @param authentication
     * @return
     */
    @RequestMapping(value = {"/", "/welcome**"}, method = RequestMethod.GET)
    public ModelAndView welcomePage(Authentication authentication) {
        log.info("isAuthenticated: " + authentication.isAuthenticated());

        if (authentication.isAuthenticated()) {
            return new ModelAndView("redirect:/auth/home");
        } else {
            ModelAndView model = new ModelAndView();
            model.setViewName("login/login");
            return model;
        }
    }

    /**
     * Login url mapper
     *
     * @param error
     * @param logout
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }
        model.setViewName("login/login");
        return model;
    }

    /**
     * Default method after login success
     *
     * @param authentication
     * @return ModelAndView
     */
    @RequestMapping(value = "/auth/home", method = RequestMethod.GET)
    public ModelAndView showLogin(Authentication authentication) {
        Collection authorities = authentication.getAuthorities();
        log.info("LoggedIn user Authorities are : " + authorities);

        if (isAuthenticated()) {
           /* The user is logged in :) */
            if (authentication.getAuthorities().toString().contains("ROLE_ADMIN")) {
                log.info("In admin dashboard");
                return new ModelAndView("views/admin/adminDashboard");
            } else if (authentication.getAuthorities().toString().contains("ROLE_USER")){
                log.info("In user dashboard");
                return new ModelAndView("views/employee/userDashboard");
            } else {
                return new ModelAndView("views/hrDashboard");
            }
        } else {
            return new ModelAndView("redirect:/login");
        }
    }

    @RequestMapping(value = {"/accessdenied"}, method = RequestMethod.GET)
    public ModelAndView accessDeniedPage() {
        ModelAndView model = new ModelAndView();
        model.addObject("message", "Either username or password is incorrect.");
        model.setViewName("error/403");
        return model;
    }

    /*@RequestMapping(value = "/ajaxLoginProcess", method = RequestMethod.POST)
    public
    @ResponseBody
    String loginCheck(HttpServletRequest request, HttpServletResponse response) {
        Login login = new Login();

        login.setUsername(request.getParameter("username"));
        login.setPassword(request.getParameter("password"));

        User user = userService.validateUser(login);

        String status = " ";
        if(user != null) {
            status = "success";
            request.getSession().setAttribute("user", user);
        } else {
            status = "failure";
        }
        return status;
    }*/
}