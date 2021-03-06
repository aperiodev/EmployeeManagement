package com.vimaan.controller;

import com.vimaan.mail.MailMessages;
import com.vimaan.mail.MailService;
import com.vimaan.model.*;
import com.vimaan.service.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.servlet.http.HttpServletRequest;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author anusha
 */
@Secured("IS_AUTHENTICATED_ANONYMOUSLY")
@Controller
public class LoginController extends BaseController {
    static Logger log = Logger.getLogger(LoginController.class);


    @Autowired
    UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    LeavesService leavesService;

    @Autowired
    CompanyleavesService companyleavesService;

    @Autowired
    HolidaysService holidaysService;

    @Autowired
    MailService mailService;

    /**
     * This methods maps default url
     * user is navigated to login page if isNotAuthenticated
     * and navigated to home if isAuthenticatedO
     *
     * @param authentication
     * @return
     */
    @RequestMapping(value = {"/", "/welcome**"}, method = RequestMethod.GET)
    public ModelAndView welcomePage(Authentication authentication) throws IOException{
        try {
            log.info("isAuthenticated: " + authentication.isAuthenticated());

            if (authentication.isAuthenticated()) {
                return new ModelAndView("redirect:/auth/home");
            } else {
                ModelAndView model = new ModelAndView();
                model.setViewName("login/login");
                return model;
            }
        }
        catch (Exception ex)
        {
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
                              @RequestParam(value = "logout", required = false) String logout,
                              @RequestParam(value = "msg", required = false) String msg, HttpServletRequest request) {

        ModelAndView model = new ModelAndView();
        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }

        if (error != null) {

            AuthenticationException ex = ((AuthenticationException) request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION));
            if (ex instanceof DisabledException) {
                model.addObject("msg", "Your Account is locked!");
            } else {
                model.addObject("error", "Invalid email and password!");
            }
        }

        if (msg != null) {
            model.addObject("msg", msg);

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
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            String yearInString = String.valueOf(year);
           /* The user is logged in :) */

            //TODO: need to do admin dashboard
            /*if (authentication.getAuthorities().toString().contains("ROLE_ADMIN")) {
                log.info("In admin dashboard");
                return new ModelAndView("views/admin/adminDashboard");
            } else*/
            if (authentication.getAuthorities().toString().contains("ROLE_USER") && !authentication.getAuthorities().toString().contains("ROLE_ADMIN")) {
                log.info("In user dashboard");
                User user = getLoggedInUser();
                ModelAndView model = null;
                if (user == null) {
                    return new ModelAndView("redirect:/auth/home");
                } else {
                    List<Holidays> holidaylist = holidaysService.getHolidays();
                    List<Leaves> user_leaves = leavesService.getLeaves(user);
                    Account user_account = accountService.getAccount(user);
                    Companyleaves companyleaves = new Companyleaves();
                    companyleaves.setFinancialyear(yearInString);
                    companyleaves = companyleavesService.checkFinancialyear(companyleaves);
                    int tnofleaves = 0;
                    int uerLeaves = user_leaves != null ? user_leaves.size() : 0;
                    int holidays = holidaylist != null ? holidaylist.size() : 0;

                    if (companyleaves != null) {
                        tnofleaves = companyleaves.getCasualleaves() + companyleaves.getSickleaves();
                    }
                    model = new ModelAndView("views/employee/userDashboard");
                    if (user_account != null) {
                        //if (user_account.getFirstname().toString().trim().equals("") || user_account.getLastname().toString().trim().equals("") || user_account.getDesignation().toString().trim().equals("")) {
                        if (user_account.getFirstname() == null || user_account.getLastname() == null || user_account.getDesignation() == null) {
                            return new ModelAndView("redirect:/auth/user/profile");
                        } else {
                            model.addObject("username", user_account.getFirstname() + " " + user_account.getLastname());
                            model.addObject("userrole", user_account.getDesignation());

                            if (user_leaves != null) {
                                model.addObject("totalleaves", uerLeaves);
                                int wfa = 0, apr = 0, rej = 0, can = 0, nol = 0;
                                for (int i = 0; i < uerLeaves; i++) {
                                    Leaves leaves = user_leaves.get(i);
                                    if (leaves.getStatus().toString().trim().equals("WAITING_FOR_APPROVAL")) {
                                        wfa = wfa + 1;
                                    } else if (leaves.getStatus().toString().trim().equals("APPROVED")) {
                                        apr = apr + 1;
                                        nol = leaves.getNoOfDays();
                                    } else if (leaves.getStatus().toString().trim().equals("REJECTED")) {
                                        rej = rej + 1;
                                    } else if (leaves.getStatus().toString().trim().equals("CANCEL")) {
                                        can = can + 1;
                                    }
                                }
                                model.addObject("leavesapply", wfa);
                                model.addObject("approvedleaves", apr);
                                model.addObject("cancelleaves", can);
                                model.addObject("rejectedleaves", rej);
                                model.addObject("tnofleaves", tnofleaves);
                                model.addObject("currentyear", yearInString);


                                List<String> date_array = new ArrayList<String>();
                                for (int i = 0; i < holidays; i++) {
                                    date_array.add(holidaylist.get(i).getDate() + "");
                                }

                                List<String> date_all = new ArrayList<String>();

                                for (int i = 0; i < user_leaves.size(); i++) {
                                    if (user_leaves.get(i).getStatus().toString().trim().equals("APPROVED")) {
                                        Date date1 = user_leaves.get(i).getFromDate();
                                        Date date2 = user_leaves.get(i).getToDate();
                                        Calendar cal1 = Calendar.getInstance();
                                        Calendar cal2 = Calendar.getInstance();
                                        cal1.setTime(date1);
                                        cal2.setTime(date2);


                                        while (cal1.before(cal2) || cal1.compareTo(cal2) == 0) {
                                            if ((Calendar.SATURDAY != cal1.get(Calendar.DAY_OF_WEEK)) && (Calendar.SUNDAY != cal1.get(Calendar.DAY_OF_WEEK))) {
                                                String month, datee;

                                                if (((cal1.get(Calendar.MONTH) + 1) + "").toString().length() > 1) {
                                                    month = (cal1.get(Calendar.MONTH) + 1) + "";
                                                } else {
                                                    month = "0" + (cal1.get(Calendar.MONTH) + 1);
                                                }

                                                if ((cal1.get(Calendar.DATE) + "").toString().length() > 1) {
                                                    datee = "" + cal1.get(Calendar.DATE);
                                                } else {
                                                    datee = "0" + cal1.get(Calendar.DATE);
                                                }

                                                date_all.add(cal1.get(Calendar.YEAR) + "-" + month + "-" + datee);
                                            }
                                            cal1.add(Calendar.DATE, 1);
                                        }
                                    }
                                }

                                HashSet<String> hashSet = new HashSet<String>();
                                hashSet.addAll(date_all);
                                date_all.clear();
                                date_all.addAll(hashSet);

                                try
                                {
                                    for (int i = 0; i < date_all.size(); i++) {
                                        for (int j = 0; j < date_array.size(); j++) {
                                            if (date_all.get(i).equals(date_array.get(j))) {
                                                //date_all.remove(date_array.get(j));
                                                date_all.set(date_all.indexOf(date_array.get(j)),"testxxx");
                                            }
                                        }
                                    }

                                    hashSet.addAll(date_all);
                                    date_all.clear();
                                    date_all.addAll(hashSet);
                                    date_all.remove("testxxx");

                                    Collections.sort(date_all);
                                    Collections.reverse(date_all);
                                    //yearInString

                                    int jan = 0, feb = 0, mar = 0, api = 0, may = 0, jun = 0, july = 0, aug = 0, spt = 0, oct = 0, nov = 0, dec = 0;
                                    int totala = 0;
                                    for (int i = 0; i < date_all.size(); i++) {
                                        String yar[] = date_all.get(i).split("-");
                                        if (yar[0].equals(yearInString)) {
                                            totala = totala + 1;
                                            if (yar[1].equals("01")) {
                                                jan = jan + 1;
                                            } else if (yar[1].equals("02")) {
                                                feb = feb + 1;
                                            } else if (yar[1].equals("03")) {
                                                mar = mar + 1;
                                            } else if (yar[1].equals("04")) {
                                                api = api + 1;
                                            } else if (yar[1].equals("05")) {
                                                may = may + 1;
                                            } else if (yar[1].equals("06")) {
                                                jun = jun + 1;
                                            } else if (yar[1].equals("07")) {
                                                july = july + 1;
                                            } else if (yar[1].equals("08")) {
                                                aug = aug + 1;
                                            } else if (yar[1].equals("09")) {
                                                spt = spt + 1;
                                            } else if (yar[1].equals("10")) {
                                                oct = oct + 1;
                                            } else if (yar[1].equals("11")) {
                                                nov = nov + 1;
                                            } else if (yar[1].equals("12")) {
                                                dec = dec + 1;
                                            }
                                        }
                                    }

                                    String cymonth = "[{y: '" + yearInString + "-01', item1: " + jan + "}," +
                                            "{y: '" + yearInString + "-02', item1: " + feb + "}," +
                                            "{y: '" + yearInString + "-03', item1: " + mar + "}," +
                                            "{y: '" + yearInString + "-04', item1: " + api + "}," +
                                            "{y: '" + yearInString + "-05', item1: " + may + "}," +
                                            "{y: '" + yearInString + "-06', item1: " + jun + "}," +
                                            "{y: '" + yearInString + "-07', item1: " + july + "}," +
                                            "{y: '" + yearInString + "-08', item1: " + aug + "}," +
                                            "{y: '" + yearInString + "-09', item1: " + spt + "}," +
                                            "{y: '" + yearInString + "-10', item1: " + oct + "}," +
                                            "{y: '" + yearInString + "-11', item1: " + nov + "}," +
                                            "{y: '" + yearInString + "-12', item1: " + dec + "}]";

                                    model.addObject("nol", totala);

                                    model.addObject("cymonth", cymonth);

                                    String allyears = "[";
                                    for (int y = (Integer.parseInt(yearInString) - 5); y <= (Integer.parseInt(yearInString) + 5); y++) {
                                        int total = 0;
                                        for (int i = 0; i < date_all.size(); i++) {
                                            String yar[] = date_all.get(i).split("-");
                                            if (yar[0].equals(y + "")) {
                                                total = total + 1;
                                            }
                                        }
                                        if (allyears.equals("[")) {
                                            allyears = allyears + "{y: '" + y + "', item1: " + total + "}";
                                        } else {
                                            allyears = allyears + ",{y: '" + y + "', item1: " + total + "}";
                                        }
                                    }
                                    allyears = allyears + "]";

                                    model.addObject("allyears", allyears);
                                }
                                catch (Exception ex)
                                {

                                }
                            } else {
                                model.addObject("leavesapply", 0);
                                model.addObject("approvedleaves", 0);
                                model.addObject("cancelleaves", 0);
                                model.addObject("rejectedleaves", 0);
                                model.addObject("tnofleaves", tnofleaves);
                                model.addObject("currentyear", yearInString);
                                model.addObject("nol", 0);

                                String cymonth = "[{y: '" + yearInString + "-01', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-02', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-03', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-04', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-05', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-06', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-07', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-08', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-09', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-10', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-11', item1: " + 0 + "}," +
                                        "{y: '" + yearInString + "-12', item1: " + 0 + "}]";

                                model.addObject("cymonth", cymonth);
                                String allyears = "[";
                                for (int y = (Integer.parseInt(yearInString) - 5); y <= (Integer.parseInt(yearInString) + 5); y++) {
                                    int total = 0;
                                    if (allyears.equals("[")) {
                                        allyears = allyears + "{y: '" + y + "', item1: " + total + "}";
                                    } else {
                                        allyears = allyears + ",{y: '" + y + "', item1: " + total + "}";
                                    }
                                }
                                allyears = allyears + "]";
                                model.addObject("allyears", allyears);

                            }
                            return model;
                        }
                    } else {
                        model.addObject("msg", "Account is not present");
                        model.setViewName("redirect:/login");
                        return model;
                    }
                }
            } else {

                ModelAndView model = new ModelAndView("views/hrDashboard");

                List<Holidays> holidaylist = holidaysService.getHolidays();
                List<Leaves> user_leaves = leavesService.getLeaves();

                int uerLeaves = user_leaves != null ? user_leaves.size() : 0;
                int holidays = holidaylist != null ? holidaylist.size() : 0;

                List<String> date_all = new ArrayList<String>();
                List<String> date_array = new ArrayList<String>();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date currentDate = new Date();

                date_all.add(sdf.format(currentDate));

                for (int i = 0; i < holidays; i++) {
                    date_array.add(holidaylist.get(i).getDate() + "");
                }

                for (int i = 0; i < uerLeaves; i++) {
                    if (user_leaves.get(i).getStatus().toString().trim().equals("APPROVED")) {
                        Date date1 = user_leaves.get(i).getFromDate();
                        Date date2 = user_leaves.get(i).getToDate();
                        Calendar cal1 = Calendar.getInstance();
                        Calendar cal2 = Calendar.getInstance();
                        cal1.setTime(date1);
                        cal2.setTime(date2);

                        while (cal1.before(cal2) || cal1.compareTo(cal2) == 0) {
                            if ((Calendar.SATURDAY != cal1.get(Calendar.DAY_OF_WEEK)) && (Calendar.SUNDAY != cal1.get(Calendar.DAY_OF_WEEK))) {
                                String month, datee;

                                if (((cal1.get(Calendar.MONTH) + 1) + "").toString().length() > 1) {
                                    month = (cal1.get(Calendar.MONTH) + 1) + "";
                                } else {
                                    month = "0" + (cal1.get(Calendar.MONTH) + 1);
                                }

                                if ((cal1.get(Calendar.DATE) + "").toString().length() > 1) {
                                    datee = "" + cal1.get(Calendar.DATE);
                                } else {
                                    datee = "0" + cal1.get(Calendar.DATE);
                                }

                                date_all.add(cal1.get(Calendar.YEAR) + "-" + month + "-" + datee);
                            }
                            cal1.add(Calendar.DATE, 1);
                        }
                    }
                }

                HashSet<String> hashSet = new HashSet<String>();
                hashSet.addAll(date_all);
                date_all.clear();
                date_all.addAll(hashSet);

                for (int i = 0; i < date_all.size(); i++) {
                    for (int j = 0; j < date_array.size(); j++) {
                        if (date_all.get(i).equals(date_array.get(j))) {
                            date_all.remove(date_array.get(j));
                            break;
                        }
                    }
                }

                Collections.sort(date_all);

                model.addObject("date_all", date_all);
                return model;
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

    @RequestMapping(value = "/auth/user/ajaxgettodayLeaves", method = RequestMethod.POST)
    public
    @ResponseBody
    String requestLeaveCheck(HttpServletRequest request) throws ParseException {
        List<Leaves> leavesL = leavesService.gettodayleave(request);
        String res = "[";
        if (leavesL != null) {
            for (int i = 0; i < leavesL.size(); i++) {
                Leaves leave = leavesL.get(i);
                if (i == 0) {
                    res = res + "{ \"username\":\"" + leave.getUser().getUsername() + "\", \"reason\":\"" + String.format("%040x", new BigInteger(1, leave.getReason().getBytes(/*YOUR_CHARSET?*/))) + "\"}";
                } else {
                    res = res + ",{ \"username\":\"" + leave.getUser().getUsername() + "\", \"reason\":\"" + String.format("%040x", new BigInteger(1, leave.getReason().getBytes(/*YOUR_CHARSET?*/))) + "\"}";
                }
            }
        }
        res = res + "]";
        return res;
    }

    @Secured("IS_AUTHENTICATED_ANONYMOUSLY")
    @RequestMapping(value = {"/forgot"}, method = RequestMethod.GET)
    public ModelAndView forgotPassword() {
        ModelAndView model = new ModelAndView();
        model.setViewName("login/forgotPassword");
        return model;

    }

    @Secured("IS_AUTHENTICATED_ANONYMOUSLY")
    @RequestMapping(value = "/sendPasswordUrl", method = RequestMethod.POST)
    public ModelAndView sendPasswordUrl(HttpServletRequest request) {
        String userEmail = request.getParameter("username");

        //get user object from username
        User user = userService.getUserByUsername(userEmail);
        ModelAndView mav = new ModelAndView("login/forgotPassword");
        try {
            if (user != null) {
                String message = new MailMessages().forgotPasswordMsg(user);
                mailService.sendMail("vimaan@gmail.com", userEmail, "Forgot Password", message,"","");
                mav.addObject("msg", "Thanks! You password was sent to given email successfully!");
            } else {
                mav.addObject("msg", "User not registered with provided email or does not exist!");
            }
        } catch (Exception e) {
            mav.addObject("msg", e.getMessage());
        }
        return mav;
    }

    protected String getSaltString() {
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 18) { // length of the random string.
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;

    }
}

    /*@RequestMapping(value = "/ajaxLoginProcess", method = RequestMethod.POST)
    public
    @ResponseBody
    String requestLeaveCheck(HttpServletRequest request) throws ParseException {
        List<Leaves> leavesL = leavesService.gettodayleave(request);
        String res = "[";
        if (leavesL != null) {
            for (int i = 0; i < leavesL.size(); i++) {
                Leaves leave = leavesL.get(i);
                if (i == 0) {
                    res = res + "{ \"username\":\"" + leave.getUser().getUsername() + "\", \"reason\":\"" + leave.getReason() + "\"}";
                } else {
                    res = res + ",{ \"username\":\"" + leave.getUser().getUsername() + "\", \"reason\":\"" + leave.getReason() + "\"}";
                }
            }
        }
        res = res + "]";
        return res;
    }*/

