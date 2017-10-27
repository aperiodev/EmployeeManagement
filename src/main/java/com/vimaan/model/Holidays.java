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
public class Holidays implements Serializable {

    @Id
    @GeneratedValue(strategy = AUTO)
    private int id;

    @Column
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column
    private String occasion;

    @Column(columnDefinition = "boolean default true")
    private boolean isactive=true;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getOccasion() {
        return occasion;
    }

    public void setOccasion(String occasion) {
        this.occasion = occasion;
    }

    public boolean isIsactive() {
        return isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }
}
