package com.nhom11.Book_Store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhom11.Book_Store.model.Notification;
import com.nhom11.Book_Store.repository.NotificationRepository;

@Service
public class NotificationService {
    @Autowired
    private NotificationRepository notificationRepository;
    
    public List<Notification> getAllNotification(Long userId){
        return notificationRepository.findAllByUserId(userId);
    }
    public void markAsRead(Long id) {
    Notification n = notificationRepository.findById(id).orElse(null);
    if (n != null && !n.isRead()) {
        n.setRead(true);
        notificationRepository.save(n);
    }
}
}
