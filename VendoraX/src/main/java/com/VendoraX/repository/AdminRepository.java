package com.VendoraX.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.AdminEntity;


@Repository
public interface AdminRepository  extends JpaRepository<AdminEntity, Integer>{

	
	 AdminEntity findByEmailId(String emailId);
}
