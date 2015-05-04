package com.cloud.app.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.cloud.app.model.Group;
import com.cloud.app.model.GroupAllFile;
import com.cloud.app.model.User;
import com.cloud.app.service.IFileService;
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
	
	@Autowired
	private IFileService fileSerive;


	@RequestMapping("/groups")
	public String groups(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		List<Group> allGroups = groupService.ShowGroup(user
				.getUserId());
		model.addAttribute("allGroups", allGroups);
		return "groups";
	}
	
	@RequestMapping("/exitGroup")
	public void exitGroup(@RequestParam("groupIds") String groupIds,HttpServletRequest request,HttpServletResponse response) throws IOException {
		User user = (User) request.getSession().getAttribute("currentUser");
		
		List<String> exitGroupResult=groupService.exitGroup(groupIds, user.getUserId());
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(exitGroupResult));	
		
	}
	@RequestMapping("/creatGroup")
	public String creatGroup(Group group,HttpSession session) {
		User user = (User) session.getAttribute("currentUser");
		groupService.creatGroup(group, user.getUserId());
		return "redirect:/groups";
	}
	
	@RequestMapping("/showGroupFile")
	public void showGroupFile(@RequestParam("groupId") Integer groupId,HttpServletRequest request,HttpServletResponse response) throws IOException{
		List<GroupAllFile> groupAllFile = fileSerive.getAllFileByGroupID(groupId);
		//设置传输类型、编码格式
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		//SerializerFeature.DisableCircularReferenceDetect)避免mybatis返回List存在"$ref":"$[1].group"现象
		response.getWriter().print(JSON.toJSONString(groupAllFile,SerializerFeature.DisableCircularReferenceDetect));
	}
	@RequestMapping("/showGroupMember")
	public void showGroupMember(@RequestParam("groupId") Integer groupId,HttpServletRequest request,HttpServletResponse response) throws IOException{
		List<User> groupAllMembers = groupService.ShowMembers(groupId);
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(groupAllMembers));		
	}
	@RequestMapping("/showGroupAjax")
	public void showGroupAjax(HttpServletRequest request,HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute("currentUser");
		List<Group> allGroups = groupService.ShowGroup(user
				.getUserId());
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(allGroups));		
	}
	
	@RequestMapping("/searchGroup")
	public void searchGroup(@RequestParam("groupIdOrName") String groupIdOrName,HttpServletRequest request,HttpServletResponse response) throws IOException{
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(groupService.searchGroup(groupIdOrName)));		
	}
	@RequestMapping("/joinGroup")
	public void joinGroup(@RequestParam("groupIds") String groupIds,HttpServletRequest request,HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute("currentUser");
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(groupService.joinGroup(groupIds,user.getUserId())));		
	}
	@RequestMapping("/searchUser")
	public void searchUser(@RequestParam("userIdOrName") String userIdOrName,HttpServletRequest request,HttpServletResponse response) throws IOException{
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(userSerivce.searchUser(userIdOrName)));		
	}
}
