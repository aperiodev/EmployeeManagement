package com.vimaan.controller;

import com.vimaan.model.Companyleaves;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
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
import java.util.List;
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

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/companyleaves", method = RequestMethod.GET)
    public ModelAndView showcompanyleaves(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        Collection authorities = authentication.getAuthorities();
        log.info("LoggedIn user Authorities are : " + authorities);
        ModelAndView model = null;

        if (authentication.getAuthorities().toString().contains("ROLE_ADMIN")) {

            List companyleaves = companyleavesService.getCompanyLeavesList();
            model = new ModelAndView("views/admin/addcompanyleaves");
            model.addObject("companyleaves", companyleaves);
        }
        else
        {
            model = new ModelAndView("views/admin/home");
        }
        return model;
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
        //System.out.println("financial year---" + financialyear);

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