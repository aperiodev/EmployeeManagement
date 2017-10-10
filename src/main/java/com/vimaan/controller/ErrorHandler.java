package com.vimaan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorHandler  {
    String path = "/error";

    @RequestMapping(value="/400")
    public String error400(){
        System.out.println("custom error handler");
        return path+"/404Error";
    }

    @RequestMapping(value="/404")
    public String error404(){
        System.out.println("custom error handler");
        return path+"/404Error";
    }

    @RequestMapping(value="/405")
    public String error405(){
        System.out.println("custom error handler");
        return path+"/404Error";
    }

    @RequestMapping(value="/500")
    public String error500(){
        System.out.println("custom error handler");
        return path+"/500Error";
    }
}