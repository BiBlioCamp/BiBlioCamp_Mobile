package com.example.demoBiBlioCamp.controller;

import com.example.demoBiBlioCamp.model.Account;
import com.example.demoBiBlioCamp.repository.AccountRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/Account")
public class AccountController {

    @Autowired
    AccountRepository accRepo;

    @GetMapping("/select/todos")
    public List<Account> buscarTodasContas(){
        return accRepo.findAll();
    }

    @GetMapping("/select/{id}")
    public Optional<Account> buscarContaPorId(@PathVariable(value="id") int id){
        return accRepo.findById(id);
    }

    @PutMapping("/update/name/{name}/{username}/{id}")
    @Transactional
    public void alteraNome(@PathVariable(value="name") String name, @PathVariable(value="username") String username, @PathVariable(value="id") int id){
        accRepo.updateAccountName(name, username, id);
    }

    @PutMapping("/update/email/{email}/{id}")
    @Transactional
    public void alteraEmail(@PathVariable(value="email") String email, @PathVariable(value="id") int id){
        accRepo.updateAccountEmail(email, id);
    }

    @GetMapping("/select/password/{id}")
    public String buscarSenha(@PathVariable(value="id") int id){
        return accRepo.findPassword(id);
    }

    @PutMapping("/update/password/{password}/{id}")
    @Transactional
    public void alteraSenha(@PathVariable(value="password") String password, @PathVariable(value="id") int id){
        accRepo.updatePassword(password, id);
    }

    @PutMapping("/update/active/{id}")
    @Transactional
    public void alteraActive(@PathVariable(value="id") int id){
        accRepo.updateActive(id);
    }

    @GetMapping("/select/{email}/{password}")
    public ResponseEntity<Account> buscarEmailSenha(@PathVariable(value="email") String email, @PathVariable(value="password") String password) {
        Account account = accRepo.findByEmailPassword(email, password);
        if (account == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok(account);
    }

    @GetMapping("/select/email/{email}")
    public Account buscarEmail(@PathVariable(value="email") String email){
        return accRepo.findByEmail(email);
    }

    @PostMapping("/insert")
    public void inserirAccount(@RequestBody Account account){
        accRepo.save(account);
    }


    @DeleteMapping("/delete/{userId}")
    @Transactional
    public void deleteAcc(@PathVariable int userId){
        accRepo.deleteById(userId);
    }
}
