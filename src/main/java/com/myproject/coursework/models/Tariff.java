package com.myproject.coursework.models;

import java.io.Serializable;

public class Tariff implements Serializable {

    private int ID;
    private String title;
    private double price;

    public Tariff() {
    }

    public int getID() {
        return ID;
    }
    public void setID(int ID) {
        this.ID = ID;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
}