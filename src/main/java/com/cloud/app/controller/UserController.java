package com.cloud.app.controller;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;

@Controller
public class UserController {

	@Autowired
	@Qualifier("userSerivice")
	private IUserService userService;

	@RequestMapping("/")
	public String welcome() {
		System.out.println("--------------------------Welcome--------------------------");

		return "redirect:/login";
	}

	@RequestMapping("/regists")
	public String regist(User user, HttpServletRequest request,Model model) {
		System.out.println("----------------regist------------");
		//print regist information
		System.out.println(user);
		//save user
		this.userService.save(user);
		//print again
		System.out.println(user);
		//get the currentuser
		User currentUser = userService.getUserById(user.getUserId());
		//print currentuser
		System.out.println(currentUser);
		request.getSession().setAttribute("currentUser", currentUser);
		return "redirect:/index";
	}

	@RequestMapping("/login")
	public String login(User user, HttpSession session, Model model) {
		System.out
				.println("--------------------------login--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("login session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("login model:" + modelKey + " -- " + modelValue);
		}
		// 如果有账号密码...
		if (session.getAttribute("currentUser") != null) {
			return "redirect:/index";
		} else if (user.getUserName() != null) {

			User userresult = this.userService.getUserByNameAndPassword(user);
			if (userresult != null) {
				userresult.setPassword("");
				System.out.println(userresult);
				session.setAttribute("currentUser", userresult);
				
				return "redirect:/index";
			} else
				model.addAttribute("wrong", "账号或密码错误!");
			return "login";
		}
		return "login";

	}
	/* A:
	 * in order to put currentUser in session,the UserController is marked by @SessionAttributes("currentUser").
	 * if model has one attribute named "currentUser" ,the session will have the same.
	 * if session has one attribute named "currentUser" ,the model will have the same,that is obvious,because the model like the sum
	 * because the attribute of model can't be remove ,just removing the attribute of session is not enough.
	 * so the logout method must be in another handler,which can renew the model
	 * 
	 * B:
	 * Don't use the @SessionAttributes("currentUser"),directly put the "currentUser" in session
	 * 
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session, Model model) {
		session.removeAttribute("currentUser");
		
		System.out
				.println("--------------------------logout--------------------------");
		// 打印session
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("login session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("login model:" + modelKey + " -- " + modelValue);
		}
		return "redirect:/login";

	}

	

}
