package com.vimaan.controller;

import com.vimaan.model.Companyleaves;
import org.springframework.stereotype.Controller;
import com.vimaan.model.User;
import com.vimaan.service.UserService;
import com.vimaan.model.Account;
import com.vimaan.service.AccountService;
import com.vimaan.service.CompanyleavesService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;

@Controller
@RequestMapping(value = "/auth/admin")
public class AdministratorController extends BaseController {
    static Logger log = Logger.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    CompanyleavesService companyleavesService;

    @RequestMapping(value = "/companyleaves", method = RequestMethod.GET)
    public ModelAndView showcompanyleaves(HttpServletRequest request, HttpServletResponse response) {
        User user = getLoggedInUser();
        log.info("user : "+ user);
        ModelAndView mav = null;

        if (null != user) {
            Collection userRoles = getLoggedInUserRoles();
            log.info("userRoles : " + userRoles);
            if (userRoles.contains("ROLE_ADMIN")) {
                mav = new ModelAndView("views/admin/addcompanyleaves");
                mav.addObject("firstname", "Admin");
                mav.addObject("lastname", "Admin");
                mav.addObject("designation", "Administrator");
                mav.addObject("doj", "10-10-2017");
            } else {
                mav = new ModelAndView("views/admin/addcompanyleaves");
            }
        } else {
            mav = new ModelAndView("redirect:/auth/home");
        }
        return mav;
    }

    @RequestMapping(value = "/savecompanyleaves", method = RequestMethod.POST)
    public
    @ResponseBody
    String yearsaveleaves(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Companyleaves companyleaves = new Companyleaves();

        companyleaves.setFinancialyear(convdate(request.getParameter("financialyear")));
        companyleaves.setSickleaves(Integer.parseInt(request.getParameter("sickleaves")));
        companyleaves.setCasualleaves(Integer.parseInt(request.getParameter("casualleaves")));

        Companyleaves financialyear = companyleavesService.checkFinancialyear(companyleaves);
        System.out.println("financial year---" + financialyear);

        String status = " ";
        if (financialyear != null) {
            status = "financialyearexists";
        } else {
            companyleavesService.addCompanyleaves(companyleaves);
            status = "success";
        }
        return status;
    }

    @RequestMapping(value = "/ajaxcheckFinancialyear", method = RequestMethod.POST)
    public
    @ResponseBody
    String checkFinancial(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Companyleaves companyleaves = new Companyleaves();

        companyleaves.setFinancialyear(convdate(request.getParameter("financialyear")));

        Companyleaves financialyear = companyleavesService.checkFinancialyear(companyleaves);
        String status = " ";
        if (financialyear == null) {
            status = "success";
        } else {
            status = "failure";
        }
        return status;
    }

    public Date convdate(String startDateString) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date startDate = new java.sql.Date(df.parse(startDateString.toString().trim()).getTime());
        return startDate;
    }
}