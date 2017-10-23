package com.vimaan.model;

import com.vimaan.model.enums.Status;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

import static javax.persistence.GenerationType.AUTO;

/**
 * Created by pc on 9/25/2017.
 */
@Entity
public class Leaves implements Serializable {

    @Id
    @GeneratedValue(strategy = AUTO)
    private int id;

    @OneToOne(cascade = CascadeType.ALL)
    private User user;

    @Column(length = 4000)
    private String reason;

    @Temporal(TemporalType.DATE)
    private Date fromDate;

    @Temporal(TemporalType.DATE)
    private Date toDate;

    @Column
    private int noOfDays;

    @OneToOne(cascade = CascadeType.ALL)
    private User toUser;

    @Enumerated(EnumType.STRING)
    private Status status;

    @Column(length = 4000)
    private String statusReason;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public int getNoOfDays() {
        return noOfDays;
    }

    public void setNoOfDays(int noOfDays) {
        this.noOfDays = noOfDays;
    }

    public User getToUser() {
        return toUser;
    }

    public void setToUser(User toUser) {
        this.toUser = toUser;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getStatusReason() {
        return statusReason;
    }

    public void setStatusReason(String statusReason) {
        this.statusReason = statusReason;
    }
}
