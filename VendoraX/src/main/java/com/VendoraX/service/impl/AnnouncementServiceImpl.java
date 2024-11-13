package com.VendoraX.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.VendoraX.dto.AnnouncementDTO;
import com.VendoraX.entity.AnnouncementEntity;
import com.VendoraX.repository.AnnouncementRepository;
import com.VendoraX.service.AnnouncementService;


@Service
@Transactional
public class AnnouncementServiceImpl implements AnnouncementService {

   
    @Autowired
    private AnnouncementRepository announcementRepository;

    @Override
    @CacheEvict(value = "notificationCache", allEntries = true)
    public boolean saveAnnouncement(AnnouncementDTO announcementDTO) {
        if (announcementDTO == null) {
            return false; 
        }

        AnnouncementEntity announcementEntity = new AnnouncementEntity();
        BeanUtils.copyProperties(announcementDTO, announcementEntity);

        announcementEntity = this.announcementRepository.save(announcementEntity);
        return announcementEntity != null; // Return true if save was successful
    }

    @Override
    @Cacheable(value = "notificationCache") 
    public List<AnnouncementDTO> getAllAnnouncements() {
        List<AnnouncementEntity> entities = this.announcementRepository.findAll();
        return entities.stream().map(entity -> {
            AnnouncementDTO dto = new AnnouncementDTO();
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }).collect(Collectors.toList());
    }

    @Override
    @CacheEvict(value = "notificationCache", key = "#id")
    public boolean deleteAnnouncementById(int id) {
        if (this.announcementRepository.existsById(id)) { // Check if the ID exists before deleting
            this.announcementRepository.deleteById(id);
            return true; // Return true if deletion was successful
        }
        return false; // Return false if the ID does not exist
    }
}
