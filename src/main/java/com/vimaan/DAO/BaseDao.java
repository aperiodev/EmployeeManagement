package com.vimaan.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;

/**
 * @author anusha
 */
public class BaseDao implements Serializable{

    @Autowired
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Session getSession() throws HibernateException {
        Session session;
        try {
            session = getSessionFactory().getCurrentSession();
        } catch (HibernateException e) {
            session = getSessionFactory().openSession();
        }

        if (session == null) {
            session = getSessionFactory().openSession();
        }
        return session;
    }

}
