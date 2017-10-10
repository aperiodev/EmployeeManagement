package com.vimaan.controller;

import com.vimaan.model.Login;
import com.vimaan.model.User;
import com.vimaan.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
public class LoginController {
    static Logger log = Logger.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        ModelAndView mav = null;

        log.debug("This is debug message");
        log.info("This is info message");
        log.warn("This is warn message");
        log.fatal("This is fatal message");
        log.error("This is error message");

        if (null != user) {
            mav = new ModelAndView("welcome");
            mav.addObject("firstname", user.getFirstname());
        } else {
            mav = new ModelAndView("/");
        }
        return mav;
    }


    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logOut(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            request.getSession().removeAttribute("user");
        }
        return new ModelAndView("redirect:/");
    }

    @RequestMapping(value = "/ajaxLoginProcess", method = RequestMethod.POST)
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
    }
}