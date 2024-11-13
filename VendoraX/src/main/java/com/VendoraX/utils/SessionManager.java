package com.VendoraX.utils;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpSession;

@Component
public class SessionManager {

	private final Map<String, HttpSession> activeSessions = new ConcurrentHashMap<>();

	public void registerSession(String email, HttpSession newSession) {
		HttpSession existingSession = activeSessions.get(email);
		if (existingSession != null && !existingSession.equals(newSession)) {
			// Invalidate old session
			existingSession.invalidate();
		}
		activeSessions.put(email, newSession);
	}

	public void unregisterSession(String email) {
		activeSessions.remove(email);
	}

	public boolean isUserLoggedIn(String email) {
		return activeSessions.containsKey(email);
	}
}
