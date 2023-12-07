package com.ups.PracticaMS_Cliente;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/data")
public class HellowControler {
        @GetMapping("/hello")
        public String hello(){
            return "hello world";
    }
}
