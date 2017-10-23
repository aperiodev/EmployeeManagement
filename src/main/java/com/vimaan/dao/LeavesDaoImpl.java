package com.vimaan.dao;

import com.vimaan.model.Leaves;
import com.vimaan.model.User;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

@Repository
@Transactional
public class LeavesDaoImpl extends BaseDao implements LeavesDao {

    @Autowired
    SessionFactory sessionFactory;

    public void saveleave(Leaves leaves) {
        try {
            System.out.println("leaves====" + leaves);
            getSession().merge(leaves);
        } catch (Exception e){
            System.out.println("error message "+ e.getMessage());
        }
    }

    public void updateleave(Leaves leaves) {
        Query query = getSession().createQuery("update Leaves set status = :leaveStatus" +
                " where id = :leavesId");
        query.setParameter("leaveStatus", leaves.getStatus());
        query.setParameter("leavesId", leaves.getId());
        query.executeUpdate();
    }

    public List<Leaves> getLeaves(User user) {
        String sql = "from Leaves where user.username='" + user.getUsername() + "'";
        List<Leaves> leaves = getSession().createQuery(sql).list();
        return leaves.size() > 0 ? leaves : null;
    }
}