package com.vimaan.dao;

import com.vimaan.model.Companyleaves;
import com.vimaan.model.User;
import com.vimaan.model.Holidays;
import com.vimaan.model.enums.Authorities;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sql.DataSource;
import java.util.List;


/**
 * Created by pc on 9/25/2017.
 */

@Repository
@Transactional
public class HolidaysDaoImpl extends BaseDao implements HolidaysDao {

    public List<Holidays> getHolidays() {
        String sql = "from Holidays";
        List<Holidays> holidays = getSession().createQuery(sql).list();
        return holidays.size() > 0 ? holidays : null;
    }

    public void addHoliday(Holidays holidays) {
        getSession().saveOrUpdate(holidays);
    }

    public Holidays checkHoliday(Holidays holidays) {
        String sql = "from Holidays where date='" + holidays.getDate() + "' and isactive = true";
        List<Holidays> holidays1 = getSession().createQuery(sql).list();
        return holidays1.size() > 0 ? holidays1.get(0) : null;
    }

    public List getHolidayList() {
        Session session = getSession();
        List holidays = session.createQuery("select h.id, h.date, h.occasion " +
                "from Holidays h where h.isactive=true")
                .list();
        return holidays;
    }

    public int deleteHoliday(String id) {

        String query = "update Holidays  set isactive = false where isactive=true and id = :id ";

        int result = getSession()
                .createQuery(query)
                .setParameter("id", id).executeUpdate();
        System.out.println("the result is "+ result);
        return result;
    }
}

