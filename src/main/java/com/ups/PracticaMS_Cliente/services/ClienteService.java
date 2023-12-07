package com.ups.PracticaMS_Cliente.services;


import com.ups.PracticaMS_Cliente.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository estudianteRepository;

    public Cliente create(Cliente cliente){
        return estudianteRepository.save(cliente);
        
    }
}
