package com.cloud.app.service;

import com.cloud.app.model.User;

public interface IUserService {
	
	 User getUserById(Integer userId);
	
	 int save(User user);
	 
	 int update(User user);
	
	 User getUserByNameAndPassword(User user);
	 
}
