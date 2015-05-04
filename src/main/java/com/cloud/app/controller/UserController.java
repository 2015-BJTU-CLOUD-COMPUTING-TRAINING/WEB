package com.cloud.app.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloud.app.model.User;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IUserService;

@Controller
public class UserController {

	@Autowired
	@Qualifier("userSerivice")
	private IUserService userService;
	
	@Autowired
	@Qualifier("messageService")
	private IMessageService messageService;

	@RequestMapping("/")
	public String welcome() {
		//通过了拦截器，直接跳转到主页
		return "redirect:/index";
	}

	@RequestMapping("/regists")
	public String regist(User user, HttpServletRequest request,Model model) {
		//保存用户信息并返回userId
		this.userService.save(user);
		//将新的用户放入session
		User currentUser = userService.getUserById(user.getUserId());
		currentUser.setPassword(null);
		request.getSession().setAttribute("currentUser", currentUser);
		return "redirect:/index";
	}

	@RequestMapping("/login")
	public String login(User user, HttpSession session, Model model) {
		//若已经登录.
		if (session.getAttribute("currentUser") != null) {
			return "redirect:/index";
		}
		//若输入账号密码
		else if (user.getUserName()!= null) {
			User userresult = userService.getUserByNameAndPassword(user);
			if (userresult != null) {
				userresult.setPassword(null);
				session.setAttribute("currentUser",userresult );
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
		session.removeAttribute("messages");
		return "redirect:/login";

	}
	@RequestMapping("/profileview")
	public String profileview(HttpSession session){
		return "profile";
	}
	
	@ModelAttribute
	public void getUser(@RequestParam(value="userid",required=false) Integer userid, 
			Model model){
		if(userid != null){
			//从数据库中获取对象
			User oldUser = userService.getUserById(userid);
			model.addAttribute("profileUser", oldUser);
		}
	}
	
	@RequestMapping("/profile")
	public String profile(@ModelAttribute("profileUser")User profileUser,HttpSession session,@RequestParam("passwordN") String passwordN,@RequestParam("passwordO") String passwordO,Model model){
		//当没有填写新密码时，视为不修改密码
		if("".equals(passwordN)||passwordN==null){
			userService.update(profileUser);
		}
		//当旧密码为不为空且正确时，修改密码
		else if(passwordO!=null&&passwordO.equals(profileUser.getPassword())){
			profileUser.setPassword(passwordN);
			userService.update(profileUser);
		}//当旧密码为空或者不正确时，返回错误
		else{
			model.addAttribute("profileError", "原密码不正确");
			return "profile";
		}
		return "redirect:/index";
		
	}
	

}
