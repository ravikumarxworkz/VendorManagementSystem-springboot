package com.VendoraX.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.AnnouncementEntity;



@Repository
public interface AnnouncementRepository extends JpaRepository<AnnouncementEntity, Integer>  {

	
}
