package com.cloud.app.controller;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloud.app.model.User;
import com.cloud.app.model.UserAllFile;
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



	@RequestMapping("/showAllFriends")
	public String getAllFile(HttpSession session, Model model) {
		System.out
				.println("--------------------------getAllFile--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("index session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("index model:" + modelKey + " -- " + modelValue);
		}
		
		User user = (User) session.getAttribute("currentUser");
		List<User> allFriends = friendService.Showfriend(user
				.getUserId());
		model.addAttribute("allFriends", allFriends);
		return "friends";
	}
	
	@RequestMapping("/selectUser")
	public String selectUser(HttpSession session, Model model) {
		System.out
				.println("--------------------------getAllFile--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("index session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("index model:" + modelKey + " -- " + modelValue);
		}
		
		return "friends";
	}
	
	@RequestMapping("/addfriend")
	public String addfriend(@RequestParam("friendId") Integer friendB,HttpSession session, Model model) {
		System.out
				.println("--------------------------getAllFile--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("index session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("index model:" + modelKey + " -- " + modelValue);
		}
		User user = (User) session.getAttribute("currentUser");
		messageService.Addfriendmessage(user.getUserId(), friendB);
		return "friends";
	}
	
}
