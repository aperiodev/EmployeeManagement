package com.vimaan.model;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

import static javax.persistence.GenerationType.AUTO;
/**
 * Created by IT Division on 13-10-2017.
 */
@Entity
public class Companyleaves {
    @Id
    @GeneratedValue(strategy = AUTO)
    private int id;

    @Column(unique = true)
    @Temporal(TemporalType.DATE)
    private Date financialyear;

    @Column
    private int sickleaves;

    @Column
    private int casualleaves;

    @Column(columnDefinition = "boolean default true")
    private boolean isactive=true;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFinancialyear() {
        return financialyear;
    }

    public void setFinancialyear(Date financialyear) {
        this.financialyear = financialyear;
    }

    public int getSickleaves() {
        return sickleaves;
    }

    public void setSickleaves(int sickleaves) {
        this.sickleaves = sickleaves;
    }

    public int getCasualleaves() {
        return casualleaves;
    }

    public void setCasualleaves(int casualleaves) {
        this.casualleaves = casualleaves;
    }
}
