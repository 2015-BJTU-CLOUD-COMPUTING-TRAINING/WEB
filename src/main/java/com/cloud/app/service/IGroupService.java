package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Group;

public interface IGroupService {
	
	int creatGroup(Group group,Integer userId);
	
	List<Group> ShowGroup(int userId);
	
	int exitGroup(String groupIds,Integer userId);
}
