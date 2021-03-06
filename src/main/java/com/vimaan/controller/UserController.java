package com.vimaan.controller;

import com.vimaan.mail.MailService;
import com.vimaan.model.*;
import com.vimaan.model.enums.Status;
import com.vimaan.service.HolidaysService;
import com.vimaan.service.LeavesService;
import com.vimaan.service.UserService;
import com.vimaan.service.AccountService;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.Principal;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.List;
import java.util.Locale;


@Controller
@RequestMapping(value = "/auth/user")
@Transactional
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

    @Autowired
    MailService mailService;

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

    @RequestMapping(value = "/leaves", method = RequestMethod.GET)
    public ModelAndView showLeavesLists(HttpServletRequest request,Authentication authentication) {
        Collection authorities = authentication.getAuthorities();

        User user = getLoggedInUser();
        Status status;
        ModelAndView model = null;
        if (user == null) {
            return new ModelAndView("redirect:/auth/home");
        }

        if(!request.getParameterMap().containsKey("status")){
            status = Status.WAITING_FOR_APPROVAL;
            model = new ModelAndView("views/pendingleaveslist");
        } else {
            status = Status.valueOf(request.getParameter("status"));
            model = new ModelAndView("views/leavesByStatus");
        }

        List<Leaves> user_leaves = null;
        if (authentication.getAuthorities().toString().contains("ROLE_HR"))
        {
            user_leaves=leavesService.getLeavesByStatusByUser(status,user.getUsername().toString());
        }
        else
        {
            user_leaves=leavesService.getLeavesByStatus(status);
        }


        model.addObject("userleaves", user_leaves);
        model.addObject("LeaveType", status);
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

        List<Account> hr_users = userService.getHrUsers();
        List<Holidays> holidaylist = holidaysService.getHolidays();
        ModelAndView mav = null;
        Account account = accountService.getAccount(user);
       log.debug("account obj is : " + account);

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
    String requestLeaveCheck(HttpServletRequest request) throws ParseException {
        leavesService.saveleave(request);
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

    @RequestMapping(value = "/ajaxApproveOrRejectLeave", method = RequestMethod.POST)
    public
    @ResponseBody
    String approveOrRejectLeave(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Leaves leaves = new Leaves();
        leaves.setId(Integer.parseInt(request.getParameter("leaveId")));
        leaves.setStatus(Status.valueOf(request.getParameter("leaveStatus")));
        leavesService.updateleave(leaves);
        /*try {
            mailService.sendMail(leaves.getUser().getUsername(), leaves.getToUser().getUsername(),leaves.getStatus().toString() , leaves.getStatus().toString());
        } catch (Exception e){
            StringWriter sw = new StringWriter();
            new Throwable("").printStackTrace(new PrintWriter(sw));
            String stackTrace = sw.toString();
            System.out.println("Exception=="+ stackTrace);

        }*/
        return "success";
    }

    /**
     * Show password page
     * @return
     */
    @RequestMapping(value = "/showChangePassword", method = RequestMethod.GET)
    public ModelAndView showChangePassword(){
     ModelAndView mav = new ModelAndView("/views/changePassword");
    Account account = accountService.getAccount(getLoggedInUser());
     mav.addObject("user", getLoggedInUser());
     mav.addObject("account", account);
     return mav;
    }

    /**
     * Update the current password to new password
     * @param request
     * @return
     */
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    public ModelAndView changePassword(HttpServletRequest request){
        ModelAndView mav = null;
        int result = userService.updatePassword(request.getParameter("newPassword"), getLoggedInUserName());
        mav = new ModelAndView("redirect:/auth/home");
        return mav;
    }


    /**
     * Ajax call to check the old password
     * @param request
     * @return
     */
    @RequestMapping(value = "/confirmOldPassword")
    public
    @ResponseBody
    String confirmOldPassword(HttpServletRequest request){
        boolean isOldPassword = false;
        isOldPassword = userService.checkOldPassword(request.getParameter("oldPassword").trim(), getLoggedInUserName());
        return isOldPassword == false ? "false" : "true";
    }
}