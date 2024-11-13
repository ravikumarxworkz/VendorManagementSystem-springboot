package com.VendoraX.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.ChatMessage;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<ChatMessage, Long> {

	List<ChatMessage> findByFromUserAndToUserOrToUserAndFromUser(String fromUser1, String toUser1, String fromUser2,
			String toUser2);

	List<ChatMessage> findByToUser(String toUser);

	List<ChatMessage> findByFromUserOrToUser(String userId, String userId2);

}
