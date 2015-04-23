package com.cloud.app.controller;

import java.util.Enumeration;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;

@Controller
public class UserController {

	@Resource
	private IUserService userService;

	@RequestMapping("/")
	public String welcome(HttpServletRequest request, Model model) {
		System.out
				.println("--------------------------Welcome--------------------------");
		// 打印session
		HttpSession session=request.getSession();
		Enumeration<String> e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			System.out.println("welcome session:" + s + " == "
					+ session.getAttribute(s));
		}
		// 打印model
		Map<String, Object> modelMap = model.asMap();
		for (Object modelKey : modelMap.keySet()) {
			Object modelValue = modelMap.get(modelKey);
			System.out.println("welcome model:" + modelKey + " -- "
					+ modelValue);
		}
		return "redirect:/login";
	}

	@RequestMapping("/regists")
	public String regist(User user, HttpServletRequest request, Model model) {

		System.out.println("+++++++++++++++++++" + user.getBirthday());
		System.out.println("++++++++++++++++++++++++++" + user.getUserId());
		int userid = this.userService.save(user);
		System.out.println("+++++++++++++++++++" + user.getBirthday());
		System.out.println("++++++++++++++++++++++++++" + userid);
		System.out.println("++++++++++++++++++++++++++" + user.getUserId());

		request.getSession().setAttribute("currentUser", user);
		return "index";
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
			return "index";
		} else if (user.getUserName() != null) {

			User userresult = this.userService.getUserByNameAndPassword(user);

			if (userresult != null) {
				userresult.setPassword("");
				session.setAttribute("currentUser", userresult);
				
				return "index";
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
