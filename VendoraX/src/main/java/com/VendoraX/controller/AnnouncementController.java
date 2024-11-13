package com.VendoraX.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.VendoraX.dto.AnnouncementDTO;
import com.VendoraX.service.AnnouncementService;

@RestController
public class AnnouncementController {

	@Autowired
	private AnnouncementService announcementService;

	@GetMapping("/getVendorAnnouncements")
	public List<AnnouncementDTO> getAnnouncements() {
		List<AnnouncementDTO> announcements = this.announcementService.getAllAnnouncements();
		return announcements;
	}
	
	/*----------------------------------save announcement METHOD------------------------------------ */
	@PostMapping("saveAnnouncement")
	public ResponseEntity<Object> saveAnnouncement(@RequestBody AnnouncementDTO announcementDTO) {
		boolean saveAnnouncement = this.announcementService.saveAnnouncement(announcementDTO);
		if (saveAnnouncement) {
			return ResponseEntity.ok().body("Announcement saved successfully");
		}
		return ResponseEntity.ok().body("!Announcement saved successfully");

	}

	/*----------------------------------GET ALL Announcements LIST METHOD------------------------------------ */
	@GetMapping("/getAnnouncements")
	public List<AnnouncementDTO> getAdminAnnouncements() {
		System.out.println("this is  getAnnouncements");
		List<AnnouncementDTO> announcements = this.announcementService.getAllAnnouncements();
		return announcements;
	}

	/*----------------------------------delete announcement METHOD------------------------------------ */
	@PostMapping("deleteAnnouncement")
	public ResponseEntity<Object> deleteAnnouncement(@RequestParam String id) {
	    int announcementId = Integer.parseInt(id);
	    boolean deleteAnnouncement = this.announcementService.deleteAnnouncementById(announcementId);
	    if (deleteAnnouncement) {
	        return ResponseEntity.ok().body("Announcement deleted successfully");
	    }
	    return ResponseEntity.ok().body("!Announcement deleted successfully");
	}

	
	
}
