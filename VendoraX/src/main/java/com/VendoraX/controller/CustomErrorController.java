package com.VendoraX.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError() {
        // Return the name of the error page you want to display
        return "page"; // This corresponds to page.html in your templates or static folder
    }
    
    // Optionally, override the getErrorPath() method (not needed in recent Spring Boot versions)
    public String getErrorPath() {
        return "/error";
    }
}

