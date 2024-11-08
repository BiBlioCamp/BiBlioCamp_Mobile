package com.example.demoBiBlioCamp.controller;

import com.example.demoBiBlioCamp.model.Aloc;
import com.example.demoBiBlioCamp.repository.AlocRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/Aloc")
public class AlocController {

    @Autowired
    AlocRepository alcRepo;

    @GetMapping("/todos")
    public List<Aloc> buscarTodasAlocacoes(){
        return alcRepo.findAll();
    }

    @GetMapping("/select/{id}")
    public List<Aloc> buscarTodasAlocacoesPorId(@PathVariable int id){
        return alcRepo.findByUserId(id);
    }

    @GetMapping("/select/count/{id}")
    public int contadorAlocacoesPorId(@PathVariable int id){
        return alcRepo.countByIdStatus(id);
    }

    @DeleteMapping("/delete/{userId}/{bookId}")
    @Transactional
    public void deleteAloc(@PathVariable int userId, @PathVariable int bookId){
        alcRepo.deleteByIds(userId, bookId);
    }

    @GetMapping("/select/all/{id}")
    public List<Aloc> buscaTudoAlocacoesPorId(@PathVariable int id){
        return alcRepo.findAllByUserId(id);
    }

    @GetMapping("/select/posse/{id}")
    public List<String> buscaLivrosPosse(@PathVariable int id){
        return alcRepo.findBookInPosse(id);
    }

    @PostMapping("/insert")
    public void inserirAloc(@RequestBody Aloc aloc){
        alcRepo.save(aloc);
    }
}
