package com.vimaan.controller;

import com.vimaan.model.*;
import com.vimaan.model.enums.Status;
import com.vimaan.service.HolidaysService;
import com.vimaan.service.LeavesService;
import com.vimaan.service.UserService;
import com.vimaan.service.AccountService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;


@Controller
@RequestMapping(value = "/auth/user")
public class UserController extends BaseController {
    static Logger log = Logger.getLogger(UserController.class);

    @Autowired
    UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    HolidaysService holidaysService;

    @Autowired
    LeavesService leavesService;

    @RequestMapping(value = "/leavesLists", method = RequestMethod.GET)
    public ModelAndView showLeavesLists(HttpServletRequest request, HttpServletResponse response) {
        User user = getLoggedInUser();
        ModelAndView model = null;
        if (user == null) {
            return new ModelAndView("redirect:/auth/home");
        }
        List<Leaves> user_leaves = leavesService.getLeaves(user);
        model = new ModelAndView("views/leaveslist");
        model.addObject("userleaves", user_leaves);
        return model;
    }

    @RequestMapping(value = "/requestLeave", method = RequestMethod.GET)
    public ModelAndView showRequestLeave(HttpServletRequest request, HttpServletResponse response) {
        User user = getLoggedInUser();
        log.info("session user is : " + user);

        //redirect to home page if user is null
        if (user == null) {
            log.info("LogggedIn user is null");
            return new ModelAndView("redirect:/auth/home");
        }

        List<UserRole> hr_users = userService.getHrUsers();
        List<Holidays> holidaylist = holidaysService.getHolidays();
        ModelAndView mav = null;
        Account account = accountService.getAccount(user);
        System.out.println("account obj is : " + account);

        if (account != null) {
            mav = new ModelAndView("views/requestleaves");
            mav.addObject("firstname", account.getFirstname());
            mav.addObject("lastname", account.getLastname());
            mav.addObject("designation", account.getDesignation());
            mav.addObject("doj", account.getDoj());
            mav.addObject("userslist", hr_users);
            mav.addObject("holidaylist", holidaylist);
        } else {
            mav = new ModelAndView("redirect:/auth/home");
        }
        return mav;
    }

    @RequestMapping(value = "/ajaxRequestLeave", method = RequestMethod.POST)
    public
    @ResponseBody
    String requestLeaveCheck(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Leaves leaves = new Leaves();
        leaves.setFromDate(convdate(request.getParameter("fromdate")));
        leaves.setNoOfDays(Integer.parseInt(request.getParameter("noofdays")));
        leaves.setReason(request.getParameter("reason"));
        leaves.setStatus(Status.values()[0]);
        leaves.setStatusReason("");
        leaves.setToDate(convdate(request.getParameter("todate")));
        User tou = new User();
        tou.setUsername(request.getParameter("touser"));
        leaves.setToUser(tou);
        User fromu = getLoggedInUser();
        leaves.setUser(fromu);
        System.out.println("user ----: " + leaves.getUser());
        leavesService.saveleave(leaves);
        return "success";
    }

    public Date convdate(String startDateString) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date startDate = new Date(df.parse(startDateString.toString().trim()).getTime());
        return startDate;
    }

    @RequestMapping(value = "/ajaxCancleLeave", method = RequestMethod.POST)
    public
    @ResponseBody
    String CancleLeaveCheck(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Leaves leaves = new Leaves();
        leaves.setId(Integer.parseInt(request.getParameter("leaveId")));
        leaves.setStatus(Status.values()[3]);
        leavesService.updateleave(leaves);
        return "success";
    }
}