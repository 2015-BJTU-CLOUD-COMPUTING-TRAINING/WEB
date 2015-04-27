package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Message;
import com.cloud.app.model.User;

public interface IUserService {
	
	 User getUserById(Integer userId);
	
	 int save(User user);
	
	 User getUserByNameAndPassword(User user);
	 
	 List<Message> getAllMessages(Integer userId);
}
