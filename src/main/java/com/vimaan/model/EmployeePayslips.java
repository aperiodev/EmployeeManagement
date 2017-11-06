package com.vimaan.model;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.AUTO;

@Entity
public class EmployeePayslips implements Serializable {

    @Id
    @GeneratedValue(strategy = AUTO)
    @Column(name = "emp_pay_slip_id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payslip_id", nullable = true)
    private Payslips payslips;

    @Column
    private String empPaySlipName;

    @Column
    private byte[] empPaySlip;

    @OneToOne(cascade = CascadeType.ALL)
    private User user;

    @Column
    private String empCode;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Payslips getPayslips() {
        return payslips;
    }

    public void setPayslips(Payslips payslips) {
        this.payslips = payslips;
    }

    public String getEmpPaySlipName() {
        return empPaySlipName;
    }

    public void setEmpPaySlipName(String empPaySlipName) {
        this.empPaySlipName = empPaySlipName;
    }

    public byte[] getEmpPaySlip() {
        return empPaySlip;
    }

    public void setEmpPaySlip(byte[] empPaySlip) {
        this.empPaySlip = empPaySlip;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getEmpCode() {
        return empCode;
    }

    public void setEmpCode(String empCode) {
        this.empCode = empCode;
    }



}
