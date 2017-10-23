package com.vimaan.service;

import com.vimaan.model.Account;
import com.vimaan.model.Holidays;
import com.vimaan.model.User;

import java.util.List;

/**
 * Created by IT Division on 10-13-2017.
 */
public interface HolidaysService {

    List<Holidays> getHolidays();
}
