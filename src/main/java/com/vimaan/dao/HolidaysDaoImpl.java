package com.vimaan.dao;

import com.vimaan.model.Holidays;
import com.vimaan.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;


/**
 * Created by pc on 9/25/2017.
 */

@Repository
@Transactional
public class HolidaysDaoImpl extends BaseDao implements HolidaysDao {

    @Autowired
    SessionFactory sessionFactory;

    public List<Holidays> getHolidays() {
        String sql = "from Holidays";
        List<Holidays> holidays = getSession().createQuery(sql).list();
        return holidays.size() > 0 ? holidays : null;
    }
}

