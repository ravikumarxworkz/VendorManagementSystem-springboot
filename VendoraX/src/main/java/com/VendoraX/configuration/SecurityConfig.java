//package com.VendoraX.configuration;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.authentication.AuthenticationProvider;
//import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.web.SecurityFilterChain;
//
//import com.VendoraX.service.impl.LoginServiceImpl;
//
//@EnableWebSecurity
//@Configuration
//public class SecurityConfig {
//
//	@Autowired
//	private LoginServiceImpl loginServiceImpl;
//
//	@Bean
//	public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
//		httpSecurity.authorizeHttpRequests(auth -> auth
//				// Allow public access to these pages
//				.requestMatchers("/", "/homePage", "/login", "/registerPage", "/adminLoginPage", "/res/**").permitAll()
//				// Restrict access to authenticated users with 'USER' role
//				.requestMatchers("/user/**").hasRole("USER")
//				// Restrict access to authenticated users with 'ADMIN' role
//				.requestMatchers("/admin/**").hasRole("ADMIN")
//				// Any other request must be authenticated
//				.anyRequest().authenticated()).formLogin(form -> form.loginPage("/login") // Custom login page URL
//						.defaultSuccessUrl("/defaultLogin", true) // Redirect to this URL after successful login
//						.permitAll() // Allow all users to access the login page
//		).logout(logout -> logout.logoutUrl("/logout") // Logout URL
//				.logoutSuccessUrl("/homePage") // Redirect to home page after logout
//				.permitAll() // Allow everyone to access the logout page
//		).csrf(csrf -> csrf.disable()); // Disable CSRF protection for now (but should be enabled in production)
//
//		return httpSecurity.build();
//	}
//
//	@Bean
//	public AuthenticationProvider authenticationProvider() {
//		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
//		provider.setUserDetailsService(loginServiceImpl);
//		provider.setPasswordEncoder(passwordEncoder()); // Use BCrypt to encode passwords
//		return provider;
//	}
//
//	@Bean
//	public PasswordEncoder passwordEncoder() {
//		return new BCryptPasswordEncoder();
//	}
//}
