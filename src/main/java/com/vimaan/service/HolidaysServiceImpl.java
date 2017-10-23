package com.vimaan.service;


import com.vimaan.dao.AccountDao;
import com.vimaan.dao.HolidaysDao;
import com.vimaan.model.Account;
import com.vimaan.model.Holidays;
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
public class HolidaysServiceImpl implements HolidaysService {
    @Autowired
    DataSource datasource;

    @Autowired
    HolidaysDao holidaysDao;

    public List<Holidays> getHolidays() {
        List<Holidays> holidays = holidaysDao.getHolidays();
        return holidays;
    }
}
