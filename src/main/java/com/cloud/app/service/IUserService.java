package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Group;
import com.cloud.app.model.User;

public interface IUserService {
	
	 User getUserById(Integer userId);
	
	 int save(User user);
	 
	 int update(User user);
	
	 User getUserByNameAndPassword(User user);
	 
	 List<User>  searchUser(String userIdOrName);
	 
	 List<User> selectAllUsers();
	 
	 int deleteUser(Integer userId);
	 
	 User getUserByUserNickname(String userNickname);
	 
	 
}
