package com.vimaan.service;


import com.vimaan.dao.LeavesDao;
import com.vimaan.mail.MailService;
import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import com.vimaan.model.enums.Status;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

/**
 * Created by IT Division on 10-10-2017.
 */
@Service
@Transactional
public class LeavesServiceImpl implements LeavesService {
    @Autowired
    DataSource datasource;

    @Autowired
    LeavesDao leavesDao;

    @Autowired
    UserService userService;

    @Autowired
    MailService mailService;

    public List<Leaves> gettodayleave(HttpServletRequest request) {
            List<Leaves> leaves = leavesDao.gettodayleave(request.getParameter("selecteddate"));
            return leaves;
    }

    public void saveleave(HttpServletRequest request) {
        try {
            String loggedInUser = SecurityContextHolder.getContext().getAuthentication().getName();

            Leaves leaves = new Leaves();
            leaves.setFromDate(convdate(request.getParameter("fromdate")));
            leaves.setNoOfDays(Integer.parseInt(request.getParameter("noofdays")));
            leaves.setToDate(convdate(request.getParameter("todate")));
            leaves.setReason(request.getParameter("reason"));
            leaves.setStatus(Status.values()[0]);
            leaves.setStatusReason("");
            leaves.setToUser(userService.getUserByUsername(request.getParameter("touser")));
            leaves.setUser(userService.getUserByUsername(loggedInUser));

            leavesDao.saveleave(leaves);

            mailService.sendMail(leaves.getUser().getUsername(), request.getParameter("touser"),"Leave Request",leaves.getReason());
        } catch (Exception e) {
            System.out.println("Exception === " + e.getMessage());
        }
    }

    public Date convdate(String startDateString) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date startDate = new Date(df.parse(startDateString.toString().trim()).getTime());
        return startDate;
    }

    public void updateleave(Leaves leaves) {
        leavesDao.updateleave(leaves);
    }

    public List<Leaves> getLeaves() {
        List<Leaves> leaves = leavesDao.getLeaves();
        return leaves;
    }

    public List<Leaves> getLeaves(User user) {
        List<Leaves> leaves = leavesDao.getLeaves(user);
        return leaves;
    }

    public List<Leaves> getLeavesByStatus(Status status){
        List<Leaves> leaves = leavesDao.getLeavesByStatus(status);
        return leaves;
    }

    public List<Leaves> getLeavesByStatusByUser(Status status, String user){
        List<Leaves> leaves = leavesDao.getLeavesByStatusByUser(status,user);
        return leaves;
    }
}