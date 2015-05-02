package com.cloud.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.app.model.Group;
import com.cloud.app.service.IGroupService;
import com.cloud.framwork.dao.GroupMapper;
import com.cloud.framwork.dao.MemberMapper;

@Service
public class GroupServiceImpl implements IGroupService {
	
	@Autowired
	private GroupMapper groupDao;
	
	@Autowired
	private MemberMapper memberDao;

	@Override
	public List<Group> ShowGroup(int userId) {
		// TODO Auto-generated method stub
		List<Group> AllGroups = groupDao.selectAllGroups(userId);
		return AllGroups;
	}

	@Override
	public int exitGroup(String groupIds, Integer userId) {
		// TODO Auto-generated method stub
		String [] vals = groupIds.split(",");
		for(String groupId:vals){
			memberDao.deleteByGroupIdAndUserId(Integer.parseInt(groupId), userId);
		}
		return 1;
	}
	

}
