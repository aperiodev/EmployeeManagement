package com.vimaan.DAO;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.io.Serializable;

/**
 * Created by pc on 9/25/2017.
 */
public class BaseDao implements Serializable{

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
