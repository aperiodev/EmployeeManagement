package com.vimaan.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by IT Division on 10-10-2017.
 */
@Entity
public class Account implements Serializable{

    @Id
    @GeneratedValue
    private int accountid;

    @OneToOne(cascade = CascadeType.ALL)
    private User user;

    @Column
    private String firstname;
    @Column
    private String lastname;

    @Column
    private String email;

    @Column(length = 4000)
    private String address;

    @Column
    private Date dob;

    @Column
    private int phonenumber;

    @Column
    private String pannumber;

    @Column
    private String aadharnumber;

    @Column
    private String designation;

    @Column
    private String gender;

    @Column
    private Date doj;

    @Column
    private int emergencynumber;

    @Column
    private String currentemployee;

    @Column
    private String employeenumber;


    public int getAccountid() {
        return accountid;
    }

    public void setAccountid(int accountid) {
        this.accountid = accountid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public int getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(int phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getPannumber() {
        return pannumber;
    }

    public void setPannumber(String pannumber) {
        this.pannumber = pannumber;
    }

    public String getAadharnumber() {
        return aadharnumber;
    }

    public void setAadharnumber(String aadharnumber) {
        this.aadharnumber = aadharnumber;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDoj() {
        return doj;
    }

    public void setDoj(Date doj) {
        this.doj = doj;
    }

    public int getEmergencynumber() {
        return emergencynumber;
    }

    public void setEmergencynumber(int emergencynumber) {
        this.emergencynumber = emergencynumber;
    }

    public String getCurrentemployee() {
        return currentemployee;
    }

    public void setCurrentemployee(String currentemployee) {
        this.currentemployee = currentemployee;
    }

    public String getEmployeenumber() {
        return employeenumber;
    }

    public void setEmployeenumber(String employeenumber) {
        this.employeenumber = employeenumber;
    }
}
