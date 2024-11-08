package com.example.demoBiBlioCamp.model;


import java.time.LocalDate;

public class AlocId {

    int userId;
    int bookId;
    LocalDate alocDate;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public LocalDate getAlocDate() {
        return alocDate;
    }

    public void setAlocDate(LocalDate alocDate) {
        this.alocDate = alocDate;
    }
}
