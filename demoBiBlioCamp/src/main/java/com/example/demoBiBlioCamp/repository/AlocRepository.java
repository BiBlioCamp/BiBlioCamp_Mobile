package com.example.demoBiBlioCamp.repository;

import com.example.demoBiBlioCamp.model.Aloc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AlocRepository extends JpaRepository<Aloc, Integer> {

    @Query("select c from Aloc c where c.userId = ?1 and c.status != 'entregue'")
    List<Aloc> findByUserId(int id);

    @Query("select c from Aloc c where c.userId = ?1")
    List<Aloc> findAllByUserId(int id);

    @Query("select count(c) as count from Aloc c where c.userId = ?1 and c.status !='entregue'")
    int countByIdStatus(int id);

    @Query("select c.bookId from Aloc c where c.userId = ?1 and c.status = 'em posse' ")
    List<String> findBookInPosse(int id);

    @Modifying
    @Query("delete from Aloc c where c.userId = ?1 and c.bookId = ?2 and c.status = 'retirar'")
    void deleteByIds(int userId, int bookId);
}
