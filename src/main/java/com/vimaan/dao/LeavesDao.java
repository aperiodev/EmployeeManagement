package com.vimaan.dao;

import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import com.vimaan.model.enums.Status;

import java.util.List;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface LeavesDao {
    void saveleave(Leaves leaves);
    void updateleave(Leaves leaves);
    List<Leaves> getLeaves();
    List<Leaves> getLeaves(User user);
    List<Leaves> gettodayleave(String todaydate);
    List<Leaves> getLeavesByStatus(Status status);

    List<Leaves> getLeavesByStatusByUser(Status status,String User);
}
