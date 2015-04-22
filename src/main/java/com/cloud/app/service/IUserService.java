package com.cloud.app.service;

import com.cloud.app.model.User;

public interface IUserService {
	
	public User getUserById(int userId);
	
	public int save(User user);
	
	public User getUserByNameAndPassword(User user);

}
