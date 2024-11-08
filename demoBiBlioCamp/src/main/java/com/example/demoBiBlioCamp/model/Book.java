package com.example.demoBiBlioCamp.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "BBC_Book")
public class Book {

    @Id
    private int id;

    @Column
    private String title;

    @Column
    private String author;

    @Column
    private String editor;

    @Column
    private String category;

    @Column
    private String cover;

    @Column
    private int fullStock;

    @Column
    private int actualStock;

    @Column
    private int acesses;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public int getFullStock() {
        return fullStock;
    }

    public void setFullStock(int fullStock) {
        this.fullStock = fullStock;
    }

    public int getActualStock() {
        return actualStock;
    }

    public void setActualStock(int actualStock) {
        this.actualStock = actualStock;
    }

    public int getAcesses() {
        return acesses;
    }

    public void setAcesses(int acesses) {
        this.acesses = acesses;
    }
}
