package com.vimaan.controller;

import com.vimaan.model.Holidays;
import com.vimaan.service.AccountService;
import com.vimaan.service.HolidaysService;
import com.vimaan.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.List;


@Controller
@RequestMapping(value = "/auth")
public class HolidaysController extends BaseController {
    static Logger log = Logger.getLogger(HolidaysController.class);

    @Autowired
    UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    HolidaysService holidaysService;

    @RequestMapping(value = "/user/holidaysList", method = RequestMethod.GET)
    public ModelAndView showholidaysList(Principal user) {
        ModelAndView mav = new ModelAndView("redirect:/auth/home");

        if (user != null) {
            List<Holidays> holidaylist = holidaysService.getHolidays();
            mav = new ModelAndView("views/holidayslist");
            mav.addObject("holidaylist", holidaylist);
        }
        return mav;
    }

 /*   @RequestMapping(value = "/ajaxLoginProcess", method = RequestMethod.POST)
    public
    @ResponseBody
    String loginCheck(HttpServletRequest request, HttpServletResponse response) {
        User login = new User();

        login.setUsername(request.getParameter("username"));
        login.setPassword(request.getParameter("password"));

        User user = userService.validateUser(login);

        String status = " ";
        if (user != null) {
            status = "success";
            request.getSession().setAttribute("user", user);

        } else {
            status = "failure";
        }
        return status;
    }*/
}