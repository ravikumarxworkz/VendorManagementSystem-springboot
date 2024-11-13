package com.VendoraX.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;



import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/")
public class DisplayImageController {

	
	@GetMapping("/display")
	public void displayUserImageByImagePath(HttpServletResponse response, @RequestParam String imagePath)
			throws IOException {
		String profileImagePath = imagePath;
		File file = new File("E:\\vendorManageMentUserProfileImage\\" + profileImagePath);
		InputStream in = new BufferedInputStream(new FileInputStream(file));
		ServletOutputStream out = response.getOutputStream();
		IOUtils.copy(in, out);
		response.flushBuffer();
	}
	
	
	
	@GetMapping("/displayInvoice")
	public void displayInvoiceByFilePath(HttpServletResponse response, @RequestParam String filePath) throws IOException {
	   System.out.println(filePath);
		File file = new File("E:\\OrderInvoiceFiles\\" + filePath); // Adjust path as needed
	    if (file.exists()) {
	        InputStream in = new BufferedInputStream(new FileInputStream(file));
	        ServletOutputStream out = response.getOutputStream();
	        response.setContentType("application/pdf"); // Assuming invoices are PDFs, change if needed
	        response.setHeader("Content-Disposition", "inline; filename=" + file.getName());
	        IOUtils.copy(in, out);
	        response.flushBuffer();
	    } else {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
	    }
	}

}
