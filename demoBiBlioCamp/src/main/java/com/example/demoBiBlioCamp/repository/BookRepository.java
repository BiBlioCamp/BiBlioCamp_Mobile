package com.example.demoBiBlioCamp.repository;

import com.example.demoBiBlioCamp.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Integer> {

    @Query("select b from Book b where b.title LIKE %?1%")
    List<Book> findByTitle(String title);

    @Modifying
    @Query("update Book b set b.acesses = b.acesses + 1 where b.id = ?1")
    void updateAcesses(int id);

    @Modifying
    @Query("update Book b set b.actualStock = b.actualStock - 1 where b.id = ?1")
    void lessActualStock(int id);

    @Modifying
    @Query("update Book b set b.actualStock = b.actualStock + 1 where b.id = ?1")
    void plusActualStock(int id);
}
