package com.vimaan.controller;

import com.vimaan.mail.MailMessages;
import com.vimaan.mail.MailService;
import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.enums.Authorities;
import com.vimaan.service.AccountService;
import com.vimaan.service.UserService;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.SimpleTimeZone;

import static java.lang.Integer.parseInt;


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

    @Autowired
    MailService mailService;

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
    public ModelAndView addUser(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("redirect:/auth/admin/users");
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));

        String userRole = request.getParameter("userRole");

        try {
            userService.userRegistration(user, userRole);
            String message = new MailMessages().loginMessage(user);
            try {
                mailService.sendMail("admi@apeiro.us", user.getUsername(), "Account Creation", message,"","");
            } catch (Exception e) {
                mav.addObject("msg", e.getMessage());
            }
        }
        catch (Exception ex)
        {
            mav = new ModelAndView("redirect:/auth/admin/register");
            mav.addObject("msg", "Email already exists or something went wrong. Please try with different email");
        }


        return mav;
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
    public ModelAndView showProfile(Principal principal, HttpServletRequest request) {
        User user;
        if (request.getParameterMap().containsKey("user")) {
            user = userService.getUserByUsername(request.getParameter("user"));
        } else {
            user = getLoggedInUser();
        }

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
    public ModelAndView updateProfile(HttpServletRequest request,
                                      @RequestParam("doj") @DateTimeFormat(pattern = "yyyy-MM-dd") Date doj,
                                      @RequestParam("dob") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dob) {
        ModelAndView mav = null;
        String empcode=request.getParameter("employeecode").trim().toUpperCase();
        String email=request.getParameter("email");

        Account employeeCode=accountService.getUserByEmpcodeById(empcode,email);

        if(employeeCode!=null)
        {
            if (request.getParameter("email")==getLoggedInUserName()) {
                mav = new ModelAndView("redirect:/auth/user/profile");
            } else {
                mav = new ModelAndView("redirect:/auth/user/profile");
                mav.addObject("user",request.getParameter("email"));
            }
            mav.addObject("msg", "Employee Code already exists for another user. Please try with different Employee Code");
        }
        else
        {
            mav = new ModelAndView("redirect:/auth/home");
            accountService.saveOrUpdateAccount(request, doj, dob);
        }
        //mav.addObject("msg", "Email already exists or something went wrong. Please try with different email");
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

    @RequestMapping(value = "/checkEmployeeCode", method = RequestMethod.POST)
    public
    @ResponseBody
    String checkempcode(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Account account=new Account();

        account.setEmployeecode(request.getParameter("employeecode"));
        account.setId(parseInt(request.getParameter("id")));

        Account checkempcode = accountService.checkEmployeeCode(account);
        //System.out.println("financial year---" + financialyear);

        String status = " ";
        if (checkempcode != null) {
            status = "employeecodeexists";
        } else {
            status = "success";
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