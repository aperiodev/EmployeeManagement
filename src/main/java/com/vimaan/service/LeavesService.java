package com.vimaan.service;

import com.vimaan.model.Account;
import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import com.vimaan.model.enums.Status;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface LeavesService {
    List<Leaves> gettodayleave(HttpServletRequest request);
    void saveleave(HttpServletRequest request);
    void updateleave(Leaves leaves);
    List<Leaves> getLeaves();
    List<Leaves> getLeaves(User user);
    List<Leaves> getLeavesByStatus(Status status);
}
