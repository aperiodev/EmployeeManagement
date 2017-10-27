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
import java.util.Date;

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

    public void addHoliday(Holidays holidays) {
        holidaysDao.addHoliday(holidays);
    }

    public Holidays checkHoliday(Holidays holidays) {

        Holidays holidays1 = holidaysDao.checkHoliday(holidays);
        return holidays1;
    }

    public List getHolidayList(){
        return holidaysDao.getHolidayList();
    }

    public int deleteHoliday(int id) {

        return holidaysDao.deleteHoliday(id);

    }
}
