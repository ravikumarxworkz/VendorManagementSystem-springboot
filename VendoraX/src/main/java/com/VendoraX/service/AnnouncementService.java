package com.VendoraX.service;

import java.util.List;

import com.VendoraX.dto.AnnouncementDTO;


public interface AnnouncementService {

	boolean saveAnnouncement(AnnouncementDTO announcementDTO);

	List<AnnouncementDTO> getAllAnnouncements();

	boolean deleteAnnouncementById(int id);

}
