package com.vimaan.controller;

import com.vimaan.model.Companyleaves;
import com.vimaan.model.Holidays;
import com.vimaan.service.HolidaysService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;

import com.vimaan.service.UserService;
import com.vimaan.service.AccountService;
import com.vimaan.service.CompanyleavesService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping(value = "/auth")
public class AdministratorController extends BaseController {
    static Logger log = Logger.getLogger(LoginController.class);

    @Autowired
    UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    CompanyleavesService companyleavesService;

    @Autowired
    HolidaysService holidaysService;

    @Secured({"ROLE_ADMIN"})
    @RequestMapping(value = "/admin/companyleaves", method = RequestMethod.GET)
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

    @RequestMapping(value = "/admin/savecompanyleaves", method = RequestMethod.POST)
    public
    @ResponseBody
    String yearsaveleaves(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Companyleaves companyleaves = new Companyleaves();

        companyleaves.setFinancialyear(request.getParameter("financialyear"));
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

    @RequestMapping(value = "/admin/ajaxcheckFinancialyear", method = RequestMethod.POST)
    public
    @ResponseBody
    String checkFinancial(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Companyleaves companyleaves = new Companyleaves();

        companyleaves.setFinancialyear(request.getParameter("financialyear"));

        Companyleaves financialyear = companyleavesService.checkFinancialyear(companyleaves);
        String status = " ";
        if (financialyear == null) {
            status = "success";
        } else {
            status = "failure";
        }
        return status;
    }

    @RequestMapping(value = "/admin/deleteCompanyleave", method = RequestMethod.POST)
    public
    @ResponseBody
    String deleteFinancial(@RequestParam(value = "year") String year) throws ParseException {

        int financialyear = companyleavesService.deleteFinancialyear(year);
        return financialyear == 1 ? "success" : "failure";
    }

    public Date convdate(String startDateString) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date startDate = new java.sql.Date(df.parse(startDateString.toString().trim()).getTime());
        return startDate;
    }

    @RequestMapping(value = "/user/holidaysList", method = RequestMethod.GET)
    public ModelAndView showholidays(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        Collection authorities = authentication.getAuthorities();
        log.info("LoggedIn user Authorities are : " + authorities);
        ModelAndView model = null;

        if (authentication.getAuthorities().toString().contains("ROLE_ADMIN")) {

            List holidays = holidaysService.getHolidayList();
            model = new ModelAndView("views/holidayslist");
            model.addObject("holidays", holidays);
        }
        else
        {
            model = new ModelAndView("views/admin/home");
        }
        return model;
    }

    @RequestMapping(value = "/user/saveholiday", method = RequestMethod.POST)
    public
    @ResponseBody
    String holidaysave(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Holidays holidays = new Holidays();

        holidays.setDate(convdate(request.getParameter("fdate")));
        holidays.setOccasion(request.getParameter("occasion"));

        Holidays checkholiday = holidaysService.checkHoliday(holidays);
        //System.out.println("financial year---" + financialyear);

        String status = " ";
        if (checkholiday != null) {
            status = "holidayexists";
        } else {
            holidaysService.addHoliday(holidays);
            status = "success";
        }
        return status;
    }

    @RequestMapping(value = "/user/ajaxcheckholiday", method = RequestMethod.POST)
    public
    @ResponseBody
    String checkHoliday(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Holidays holidays = new Holidays();

        holidays.setDate(convdate(request.getParameter("fdate")));

        Holidays checkholiday = holidaysService.checkHoliday(holidays);
        String status = " ";
        if (checkholiday == null) {
            status = "success";
        } else {
            status = "failure";
        }
        return status;
    }

    @RequestMapping(value = "/user/deleteHoliday", method = RequestMethod.POST)
    public
    @ResponseBody
    String deleteHoliday(@RequestParam(value = "id") String id) throws ParseException {

        int fdate = holidaysService.deleteHoliday(id);
        return fdate == 1 ? "success" : "failure";
    }

}