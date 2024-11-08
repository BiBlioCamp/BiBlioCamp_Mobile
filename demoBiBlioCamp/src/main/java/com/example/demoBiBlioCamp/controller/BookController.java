package com.example.demoBiBlioCamp.controller;

import com.example.demoBiBlioCamp.model.Book;
import com.example.demoBiBlioCamp.repository.BookRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/Book")
public class BookController {

    @Autowired
    BookRepository bookRepo;

    @GetMapping("/todos")
    public List<Book> buscarTodosLivros(){
        return bookRepo.findAll();
    }

    @GetMapping("/id/{id}")
    public Optional<Book> buscarPorId(@PathVariable(value="id") int id){
        return bookRepo.findById(id);
    }

    @GetMapping("/title/{title}")
    public List<Book> buscarPorTitulo(@PathVariable(value="title") String title){
        return bookRepo.findByTitle(title);
    }

    @PutMapping("/updateAcesses/{id}")
    @Transactional
    public void atualizaAcessos(@PathVariable(value="id") int id){
        bookRepo.updateAcesses(id);
    }

    @PutMapping("/ActualStock/less/{id}")
    @Transactional
    public void diminuiAtualStock(@PathVariable(value="id") int id){
        bookRepo.lessActualStock(id);
    }

    @PutMapping("/ActualStock/plus/{id}")
    @Transactional
    public void aumentaAtualStock(@PathVariable(value="id") int id){
        bookRepo.plusActualStock(id);
    }
}
