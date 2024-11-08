package com.example.demoBiBlioCamp.repository;

import com.example.demoBiBlioCamp.model.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AccountRepository  extends JpaRepository<Account, Integer> {

    @Modifying
    @Query("update Account a set a.name = ?1, a.username = ?2 where a.id = ?3")
    void updateAccountName(String name, String username, int id);

    @Modifying
    @Query("update Account a set a.email = ?1 where a.id = ?2")
    void updateAccountEmail(String email, int id);

    @Modifying
    @Query("update Account a set a.password = ?1 where a.id = ?2")
    void updatePassword(String password, int id);

    @Modifying
    @Query("update Account a set a.active = 0 where a.id = ?1")
    void updateActive(int id);

    @Query("select a from Account a where a.email = ?1 and a.password = ?2")
    Account findByEmailPassword(String email, String password);

    @Query("select a.password from Account a where a.id = ?1")
    String findPassword(int id);

    @Query("select a from Account a where a.email = ?1")
    Account findByEmail(String email);

    @Modifying
    @Query("delete from Account a where a.id = ?1")
    void deleteById(int userId);
}
