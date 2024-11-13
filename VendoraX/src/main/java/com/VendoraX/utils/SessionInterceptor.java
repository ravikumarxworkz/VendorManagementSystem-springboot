package com.VendoraX.utils;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Component
public class SessionInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUserId") == null) {
            try {
				response.sendRedirect(request.getContextPath() + "/logInPage");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // Redirect to login if not logged in
            return false;
        }
        return true; // Continue to the handler
    }
}

