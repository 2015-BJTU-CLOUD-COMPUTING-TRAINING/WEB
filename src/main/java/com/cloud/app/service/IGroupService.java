package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Group;
import com.cloud.app.model.User;

public interface IGroupService {
	
	int creatGroup(Group group,Integer userId);
	
	List<Group> ShowGroup(int userId);
	
	int exitGroup(String groupIds,Integer userId);
	
	List<User> ShowMembers(Integer groupId);
}
