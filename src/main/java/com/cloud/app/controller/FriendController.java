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
import com.cloud.app.model.User;
import com.cloud.app.service.IFriendService;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IUserService;

@Controller
public class FriendController {

	@Autowired
	@Qualifier("friendService")
	private IFriendService friendService;
	
	@Autowired
	private IMessageService messageService;
	
	@Autowired
	private IUserService userSerivce;



	@RequestMapping("/showAllFriends")
	public String showAllFriends(HttpSession session, Model model) {
		User user = (User) session.getAttribute("currentUser");
		if(user==null){
			return "redirect:/login";
		}
		List<User> allFriends = friendService.Showfriend(user
				.getUserId());
		model.addAttribute("allFriends", allFriends);
		session.setAttribute("messages", messageService.getAllMessages(user.getUserId()));
		return "friends";
	}
	
	
	
	@RequestMapping("/inviteFriend")
	public void inviteFriend(@RequestParam("userIds") String userIds,HttpServletRequest request,HttpServletResponse response) throws IOException{
		User user = (User) request.getSession().getAttribute("currentUser");
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(friendService.inviteFriend(userIds,user.getUserId())));		
	}
	@RequestMapping("/deleteFriend")
	public String deleteFriend(String friendIds, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("currentUser");
		friendService.deleteFriend(friendIds,user.getUserId());
		return "redirect:/showAllFriends";
	}
	
}
