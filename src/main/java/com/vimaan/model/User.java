package com.vimaan.model;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.AUTO;

/**
 * Created by pc on 9/25/2017. */
@Entity
public class User implements Serializable{

    @Id
    @GeneratedValue(strategy = AUTO)
    private int id;

    @Column(unique=true)
    private String username;

    @Column
    private String password;

    @Column
    private String role;

    @Column
    private boolean isactive;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {return role;}

    public void setRole(String role) {this.role = role;}

    public boolean isIsactive() {
        return isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }
}
