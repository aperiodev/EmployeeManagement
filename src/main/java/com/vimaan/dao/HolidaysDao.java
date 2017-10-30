package com.vimaan.dao;

import com.vimaan.model.Holidays;

import java.util.List;
import java.util.Date;

/**
 * Created by IT Division on 10-10-2017.
 */
public interface HolidaysDao {

    List<Holidays> getHolidays();

    void addHoliday(Holidays holidays);

    Holidays checkHoliday(Holidays holidays);

    List getHolidayList();

    int deleteHoliday(int id);
}
