package com.VendoraX.configuration;

import java.security.cert.X509Certificate;
import java.util.Properties;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfiguration {

	public JavaMailSenderImpl mailConfig() {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		mailSender.setUsername("xworkzvendormanagement@gmail.com");
		mailSender.setPassword("bkxf gomx yjse buio");
		configureSSL(mailSender);
		Properties properties = mailSender.getJavaMailProperties();
		properties.put("mail.transport.protocol", "smtp");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.debug", "true");
		
		return mailSender;
	}
	
    private void configureSSL(JavaMailSenderImpl mailSender) {
        try {
            // Trust all certificates (for development only)
            TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() { return null; }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) { }
                    public void checkServerTrusted(X509Certificate[] certs, String authType) { }
                }
            };

            SSLContext sc = SSLContext.getInstance("TLS");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            SSLContext.setDefault(sc);

            // Add SSL/TLS socket factory to properties
            mailSender.getJavaMailProperties().put("mail.smtp.ssl.socketFactory", sc.getSocketFactory());
        } catch (Exception e) {
            throw new RuntimeException("Failed to configure SSL/TLS", e);
        }
    }

}
