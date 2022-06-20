package com.myproject.coursework.models;

import java.io.Serializable;

public class User implements Serializable {

    private Roles role;
    private int ID;
    private String name;
    private String surname;
    private String phoneNumber;
    private String email;
    private String password;
    private String address;
    private String banStatus;
    // ...

    public User(int ID, String name, String surname, String phoneNumber, String email, String password, String address) {
        this.role = Roles.CUSTOMER;
        this.ID = ID;
        this.name = name;
        this.surname = surname;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
        this.address = address;
    }
    public User(int ID, String name, String email, String password) {
        role = Roles.CUSTOMER;
        banStatus = "";
        this.ID = ID;
        this.name = name;
        this.email = email;
        this.password = password;
    }
    public User() {
        role = null;
        ID = 0;
        name = null;
        surname = null;
        phoneNumber = null;
        email = null;
        password = null;
        address = null;
        banStatus = null;
    }

    public Roles getRole() {
        return role;
    }
    public void setRole(Roles role) {
        this.role = role;
    }
    public int getID() {
        return ID;
    }
    public void setID(int ID) {
        this.ID = ID;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSurname() {
        return surname;
    }
    public void setSurname(String surname) {
        this.surname = surname;
    }
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getBanStatus() {
        return banStatus;
    }
    public void setBanStatus(String banStatus) {
        this.banStatus = banStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (ID != user.ID) return false;
        if (role != user.role) return false;
        if (name != null ? !name.equals(user.name) : user.name != null) return false;
        if (surname != null ? !surname.equals(user.surname) : user.surname != null) return false;
        if (phoneNumber != null ? !phoneNumber.equals(user.phoneNumber) : user.phoneNumber != null) return false;
        if (email != null ? !email.equals(user.email) : user.email != null) return false;
        if (password != null ? !password.equals(user.password) : user.password != null) return false;
        if (address != null ? !address.equals(user.address) : user.address != null) return false;
        return banStatus != null ? banStatus.equals(user.banStatus) : user.banStatus == null;
    }

    @Override
    public int hashCode() {
        int result = role != null ? role.hashCode() : 0;
        result = 31 * result + ID;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (surname != null ? surname.hashCode() : 0);
        result = 31 * result + (phoneNumber != null ? phoneNumber.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (banStatus != null ? banStatus.hashCode() : 0);
        return result;
    }
}