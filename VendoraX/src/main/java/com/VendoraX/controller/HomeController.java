package com.VendoraX.controller;

import java.util.Collections;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {

	@GetMapping("/")
	public String mainPage() {
		return "index"; // Return the index.html or index.jsp page
	}

	@GetMapping("/homePage")
	public String homePage() {
		return "index"; // Return the index page
	}

	@GetMapping("/logInPage")
	public String logInPage(HttpServletRequest request) {
		System.out.println("Request Headers: " + Collections.list(request.getHeaderNames()).stream()
				.map(headerName -> headerName + ": " + request.getHeader(headerName))
				.collect(Collectors.joining(", ")));
		return "login"; // Return the logIn.html or logIn.jsp page
	}

	@GetMapping("/registerPage")
	public String registerPage() {
		return "register"; // Return the register.html or register.jsp page
	}

	@GetMapping("/adminLoginPage")
	public String adminLoginPage() {
		return "adminlogin"; // Return the admin login page
	}

	
}
