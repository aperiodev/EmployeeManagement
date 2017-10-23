package com.vimaan.service;


import com.vimaan.dao.LeavesDao;
import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

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

    public void saveleave(Leaves leaves) {
        leavesDao.saveleave(leaves);
    }

    public void updateleave(Leaves leaves) {
        leavesDao.updateleave(leaves);
    }

    public List<Leaves> getLeaves(User user) {
        List<Leaves> leaves = leavesDao.getLeaves(user);
        return leaves;
    }
}
