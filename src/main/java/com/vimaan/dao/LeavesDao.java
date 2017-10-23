package com.vimaan.dao;

import com.vimaan.model.Leaves;
import com.vimaan.model.User;

import java.util.List;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface LeavesDao {
    void saveleave(Leaves leaves);
    void updateleave(Leaves leaves);
    List<Leaves> getLeaves(User user);
}
