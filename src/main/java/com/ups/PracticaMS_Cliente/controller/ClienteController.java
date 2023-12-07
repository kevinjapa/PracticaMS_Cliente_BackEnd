package com.ups.PracticaMS_Cliente.controller;

import com.ups.PracticaMS_Cliente.model.Cliente;
import com.ups.PracticaMS_Cliente.services.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/MS1/Cliente")

public class ClienteController {

   @Autowired // es similar al inject
   public ClienteService clienteService;

   // Para consumir el Guardar Clientes desde Postman o FronEnd
   @PostMapping("/guardar")
   public ResponseEntity<Cliente> save(@RequestBody Cliente cliente){
       Cliente t= clienteService.create(cliente);

       try {
            return ResponseEntity.created(new URI("/MS1/Cliente/guardar"+t.getCedula())).body(t);
       }
       catch (Exception ex)
       {
           return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
       }
   }

   //Para Consumir la lista de Clientes
    @GetMapping("/all")
    public ResponseEntity<List<Cliente>> listAll(){
       return ResponseEntity.ok(clienteService.listClientes());
    }
}
