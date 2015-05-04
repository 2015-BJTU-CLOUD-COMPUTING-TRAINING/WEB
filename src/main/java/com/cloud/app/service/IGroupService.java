package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Group;
import com.cloud.app.model.User;

public interface IGroupService {
	
	int creatGroup(Group group,Integer userId);
	
	List<Group> ShowGroup(int userId);
	
	List<String>  exitGroup(String groupIds,Integer userId);
	
	List<User> ShowMembers(Integer groupId);
	
	List<Group>  searchGroup(String groupIdOrName);
	
	List<String>  joinGroup(String groupIds,Integer userId);
}
