package com.vimaan.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

import static javax.persistence.GenerationType.AUTO;

@Entity
public class Account implements Serializable {

    @Id
    @GeneratedValue(strategy = AUTO)
    @Column(name = "user_account_id")
    private int id;

    @OneToOne
    @JoinColumn(name = "username")
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
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date dob;

    @Column
    private long phonenumber;

    @Column
    private String pannumber;

    @Column
    private String aadharnumber;

    @Column
    private String designation;

    @Column
    private String gender;

    @Column
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date doj;

    @Column
    private long emergencycontactnumber;

    @Column(columnDefinition = "boolean default true")
    private boolean currentemployee = new Boolean(true);

    @Column
    private String employeecode;

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

    public long getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(long phonenumber) {
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

    public long getEmergencycontactnumber() {
        return emergencycontactnumber;
    }

    public void setEmergencycontactnumber(long emergencycontactnumber) {
        this.emergencycontactnumber = emergencycontactnumber;
    }

    public boolean getCurrentemployee() {
        return currentemployee;
    }

    public void setCurrentemployee(boolean currentemployee) {
        this.currentemployee = currentemployee;
    }

    public String getEmployeecode() {
        return employeecode;
    }

    public void setEmployeecode(String employeecode) {
        this.employeecode = employeecode;
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", user=" + user +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", phonenumber=" + phonenumber +
                ", pannumber='" + pannumber + '\'' +
                ", aadharnumber='" + aadharnumber + '\'' +
                ", designation='" + designation + '\'' +
                ", gender='" + gender + '\'' +
                ", emergencycontactnumber=" + emergencycontactnumber +
                ", currentemployee=" + currentemployee +
                ", employeecode='" + employeecode + '\'' +
                '}';
    }
}
