package com.cloud.app.controller;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloud.app.model.Group;
import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
import com.cloud.app.service.IFriendService;
import com.cloud.app.service.IGroupService;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IUserService;

@Controller
public class GroupController {

	@Autowired
	@Qualifier("friendService")
	private IFriendService friendService;
	
	@Autowired
	private IMessageService messageService;
	
	@Autowired
	private IUserService userSerivce;
	
	@Autowired
	private IGroupService groupService;
	


	@RequestMapping("/groups")
	public String groups(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		List<Group> allGroups = groupService.ShowGroup(user
				.getUserId());
		model.addAttribute("allGroups", allGroups);
		return "groups";
	}
	
	@RequestMapping("/exitGroup")
	public String exitGroup(@RequestParam("groupIds") String groupIds,HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		groupService.exitGroup(groupIds, user.getUserId());
		return "redirect:/groups";
	}
	@RequestMapping("/creatGroup")
	public String creatGroup(Group group,HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		groupService.creatGroup(group, user.getUserId());
		return "redirect:/groups";
	}
	

	
}
