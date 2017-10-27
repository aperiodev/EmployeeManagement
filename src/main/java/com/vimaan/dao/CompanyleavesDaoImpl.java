package com.vimaan.dao;

import com.vimaan.model.Companyleaves;
import com.vimaan.model.User;
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

@Repository
@Transactional
public class CompanyleavesDaoImpl extends BaseDao implements CompanyleavesDao {

    public void addCompanyleaves(Companyleaves companyleaves) {
        getSession().saveOrUpdate(companyleaves);
    }

    public Companyleaves getCompanyleaves(Companyleaves companyleaves) {
        String sql = "";
        List<Companyleaves> users = getSession().createQuery(sql).list();
        return users.size() > 0 ? users.get(0) : null;
    }

    public Companyleaves checkFinancialyear(Companyleaves companyleaves) {
        String sql = "from Companyleaves where financialyear='" + companyleaves.getFinancialyear() + "' and isactive = true";
        List<Companyleaves> companyleaves1 = getSession().createQuery(sql).list();
        return companyleaves1.size() > 0 ? companyleaves1.get(0) : null;
    }

    public List companyleaves() {
        Session session = getSession();
        List companyleaves = session.createQuery("select cl.financialyear, cl.sickleaves, cl.casualleaves, cl.isactive, cl.id, cl.financialyear as year " +
                "from Companyleaves cl where cl.isactive=true")
                .list();
        return companyleaves;
    }

    public int deleteFinancialyear(String year) {

        String query = "update Companyleaves  set isactive = false where isactive=true and financialyear = :financialyear ";

        int result = getSession()
                .createQuery(query)
                .setParameter("financialyear", year).executeUpdate();
        System.out.println("the result is "+ result);
        return result;
    }

}
