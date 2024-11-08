package com.example.demoBiBlioCamp.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "BBC_Aloc")
@IdClass(AlocId.class)
public class Aloc {

    @Id
    private int userId;

    @Id
    private int bookId;

    @Id
    @JsonFormat(pattern = "dd/MM/yyyy")
    private LocalDate alocDate;

    @Column
    @JsonFormat(pattern = "dd/MM/yyyy")
    private LocalDate returnDate;

    @Column
    private String status;

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

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
