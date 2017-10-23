package com.vimaan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorHandler  {
    String path = "/error";

    @RequestMapping(value="/400")
    public String error400(){
        System.out.println("custom error handler");
        return path+"/404Error";
    }

    @RequestMapping(value="/403")
    public String error403(){
        System.out.println("custom error handler 403");
        return path+"/403";
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
    public ModelAndView error500(){
        System.out.println("custom error handler");
        return new ModelAndView("error/500Error");
    }
}