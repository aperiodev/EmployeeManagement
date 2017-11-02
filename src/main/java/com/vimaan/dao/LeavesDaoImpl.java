package com.vimaan.dao;

import com.vimaan.mail.MailService;
import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import com.vimaan.model.enums.Status;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class LeavesDaoImpl extends BaseDao implements LeavesDao {

    @Autowired
    SessionFactory sessionFactory;

    public void saveleave(Leaves leaves) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.merge(leaves);
        tx.commit();
    }

    public void updateleave(Leaves leaves) {
        Query query = getSession().createQuery("update Leaves set status = :leaveStatus" +
                " where id = :leavesId");
        query.setParameter("leaveStatus", leaves.getStatus());
        query.setParameter("leavesId", leaves.getId());
        query.executeUpdate();
       // mailService.sendMail(leaves.getUser().getUsername(), leaves.getToUser().getUsername(),leaves.getStatus().toString() ,"Your Leave has been " + leaves.getStatus());
    }

    public List<Leaves> getLeaves() {
        String sql = "from Leaves";
        List<Leaves> leaves = getSession().createQuery(sql).list();
        return leaves.size() > 0 ? leaves : null;
    }

    public List<Leaves> getLeaves(User user) {
        String sql = "from Leaves where user.username='" + user.getUsername() + "'";
        List<Leaves> leaves = getSession().createQuery(sql).list();
        return leaves.size() > 0 ? leaves : null;
    }

    public List<Leaves> gettodayleave(String todaydate) {
        String sql = "from  Leaves where fromDate  <= '" + todaydate + "' and toDate  >= '" + todaydate + "' and status = 'APPROVED'";
        List<Leaves> leaves = getSession().createQuery(sql).list();
        return leaves.size() > 0 ? leaves : null;
    }

    public List<Leaves> getLeavesByStatus(Status status) {
        String sql = "from Leaves where status = '"+ status +"'";
        List<Leaves> leaves = getSession().createQuery(sql).list();
        return leaves.size() > 0 ? leaves : null;
    }
}
