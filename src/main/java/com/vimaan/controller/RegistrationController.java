package com.vimaan.controller;

import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.enums.Authorities;
import com.vimaan.service.AccountService;
import com.vimaan.service.UserService;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.Collection;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping(value = "/auth")
public class RegistrationController extends BaseController {
    static Logger log = Logger.getLogger(LoginController.class);

    @Autowired
    public UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    SessionFactory sessionFactory;

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/admin/register", method = RequestMethod.GET)
    public ModelAndView showRegister() {
        ModelAndView model = new ModelAndView("views/admin/register");
        model.addObject("user", new User());
        model.addObject("authorities", Authorities.values());
        return model;
    }

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/admin/registration", method = RequestMethod.POST)
    public ModelAndView addUser(HttpServletRequest request) {

        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));

        String userRole = request.getParameter("userRole");
        userService.userRegistration(user, userRole);
        return new ModelAndView("redirect:/auth/admin/users");
    }

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    public ModelAndView showUsers() {
        List users = userService.getUsersList();
        ModelAndView model = new ModelAndView("views/admin/usersList");
        model.addObject("users", users);
        return model;
    }

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/admin/enableOrDisableAccount", method = RequestMethod.POST)
    public
    @ResponseBody
    String enableOrDisableAccount(@RequestParam(value = "username") String username) {
        int result = userService.toggleAccountStatus(username);
        return result == 1 ? "success" : "failure";
    }

    @Secured({"ROLE_USER", "ROLE_ADMIN", "ROLE_HR"})
    @RequestMapping(value = "/user/profile", method = RequestMethod.GET)
    public ModelAndView showProfile(Principal principal) {
        User user = getLoggedInUser();
        System.out.println("user=== : " + user);
        ModelAndView mav = new ModelAndView("redirect:/auth/home");
        if (principal != null) {
            if (null != user) {
                Account account = accountService.getAccount(user);
                if (account != null) {
                    mav = new ModelAndView("views/employee/profile", "account", account);
                } else {
                    mav = new ModelAndView("views/employee/profile");
                }
            }
        }
        return mav;
    }

    @RequestMapping(value = "/user/updateProfile", method = RequestMethod.POST)
    public ModelAndView updateProfile(@ModelAttribute("account") Account account) {
        ModelAndView mav = null;
        System.out.println("account===" + account);
        System.out.println("account id  " + account.getId());
        try {
            Account accountObj = userService.getAccountById(account.getId());
            System.out.println("accountObj ==" + accountObj.getFirstname());
/*
           accountObj.setAadharnumber(account.getAadharnumber());
           accountObj.setAddress(account.getAddress());
           accountObj.setCurrentemployee(account.getCurrentemployee());
           accountObj.setDesignation(account.getDesignation());
           accountObj.setDob(new Date());
           accountObj.setDoj(new Date());
           accountObj.setEmail(account.getEmail());
           accountObj.setEmergencycontactnumber(account.getEmergencycontactnumber());
           accountObj.setPannumber(account.getPannumber());
           accountObj.setFirstname(account.getFirstname());
           accountObj.setLastname(account.getLastname());
           accountObj.setEmployeecode(account.getEmployeecode());
           accountObj.setGender(account.getGender());
           accountObj.setPhonenumber(account.getPhonenumber());
*/
            System.out.println("before savng-----");
            // accountService.registerAccount(accountObj);
            sessionFactory.openSession().save(account);
            System.out.println("after savng-----");

        } catch (Exception e) {
            System.out.println("exception---" + e.getMessage());
        }
        mav = new ModelAndView("redirect:/auth/home");
        return mav;
    }


    @RequestMapping(value = "/admin/ajaxcheckUsername", method = RequestMethod.POST)
    public
    @ResponseBody
    String checkUsername(HttpServletRequest request, HttpServletResponse response) {
        User user = new User();
        user.setUsername(request.getParameter("username"));

        User username = userService.checkUsername(user);

        String status = " ";
        if (username != null) {
            status = "success";
        } else {
            status = "failure";
        }
        return status;
    }

    /*@RequestMapping(value = "/addemployee", method = RequestMethod.GET)
    public ModelAndView showRegister(HttpServletRequest request, HttpServletResponse response) {
        User user = getLoggedInUser();
        ModelAndView mav = null;

        if (null != user) {
            Collection userRoles = getLoggedInUserRoles();
            if (userRoles.contains("ROLE_ADMIN")) {
                mav = new ModelAndView("views/admin/addemployee");
                mav.addObject("firstname", "Admin");
                mav.addObject("lastname", "Admin");
                mav.addObject("designation", "Administrator");
                mav.addObject("doj", "10-10-2017");
            } else {
                Account account = accountService.getAccount(user);

                if (account != null) {
                    mav = new ModelAndView("views/admin/addemployee");
                    mav.addObject("firstname", account.getFirstname());
                    mav.addObject("lastname", account.getLastname());
                    mav.addObject("designation", account.getDesignation());
                    mav.addObject("doj", account.getDoj());
                } else {
                    mav = new ModelAndView("redirect: /home");
                }
            }

        } else {
            mav = new ModelAndView("redirect: /home");
        }
        return mav;
    }*/
}