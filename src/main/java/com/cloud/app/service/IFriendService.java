package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.User;

public interface IFriendService {
	
	List<User> Showfriend(int userId);
	
	int deleteFriend(String friendIds,Integer userId);
	
	List<String>  inviteFriend(String userIds,Integer currentuserId);
}
