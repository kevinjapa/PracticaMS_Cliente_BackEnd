package com.ups.PracticaMS_Cliente.services;


import com.ups.PracticaMS_Cliente.model.Cliente;
import com.ups.PracticaMS_Cliente.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository clienteRepository;
    // Guardar mis Clientes
    public Cliente create(Cliente cliente){
        return clienteRepository.save(cliente);
    }

    // Listar mis Clientes
    public List<Cliente> listClientes(){
        return clienteRepository.findAll();
    }
}
