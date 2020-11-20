package org.giangnt.model;

import org.giangnt.entity.Account;

import java.util.Date;

public class AccountInfo {

    private String userName;
    private boolean active;
    private String password;
    private String userRole;
    private String name;
    private String email;
    private String phoneNumber;
    private String address;
    private Date dateCreate;
    private Date dateUpdated;

    public AccountInfo() {
    }

    public AccountInfo(String userName, boolean active, String password, String userRole, String name, String email, String phoneNumber, String address, Date dateCreate, Date dateUpdated) {
        this.userName = userName;
        this.active = active;
        this.password = password;
        this.userRole = userRole;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.dateCreate = dateCreate;
        this.dateUpdated = dateUpdated;
    }

    public AccountInfo(Account account) {
        this.userName = account.getUserName();
        this.active = account.isActive();
        this.password = account.getPassword();
        this.userRole = account.getUserRole();
        this.name = account.getName();
        this.email = account.getEmail();
        this.phoneNumber = account.getPhoneNumber();
        this.address = account.getAddress();
        this.dateCreate = account.getDateCreate();
        this.dateUpdated = account.getDateUpdated();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }
}
