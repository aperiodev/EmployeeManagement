package com.vimaan.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static javax.persistence.GenerationType.AUTO;

@Entity
@Table(name = "paySlips")
public class Payslips implements Serializable {

    @Id
    @GeneratedValue(strategy = AUTO)
    @Column(updatable=false, insertable=false)
    private int id;

    @Column
    private String month;

    @Column
    private String year;

    @Column
    private String fileName;

    @Column
    private Byte[] fileData;

    @OneToOne(cascade = CascadeType.ALL)
    private User user;

    @Column(name = "uploaded_date")
    private Date uploadedDate;

   /* @OneToMany(fetch = FetchType.LAZY, mappedBy = "paySlips")
    @Column(nullable = true)
    private Set<EmployeePayslips> employeePayslips = new HashSet<EmployeePayslips>(0);

    public Set<EmployeePayslips> getEmployeePayslips() {
        return employeePayslips;
    }

    public void setEmployeePayslips(Set<EmployeePayslips> employeePayslips) {
        this.employeePayslips = employeePayslips;
    }*/

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Byte[] getFileData() {
        return fileData;
    }

    public void setFileData(Byte[] fileData) {
        this.fileData = fileData;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getUploadedDate() {
        return uploadedDate;
    }

    public void setUploadedDate(Date uploadedDate) {
        this.uploadedDate = uploadedDate;
    }
}
