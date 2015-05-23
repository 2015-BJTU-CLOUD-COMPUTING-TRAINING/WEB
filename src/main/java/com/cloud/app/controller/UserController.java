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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
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
		//若已经登录
		if (session.getAttribute("currentUser") != null) {
			User userresult = (User) session.getAttribute("currentUser");
			//若为管理员
			if(userresult.getUserType()==0)
				return "redirect:/admin";
			return "redirect:/index";
		}
		//若输入账号密码
		else if (user.getUserName()!= null) {
			User userresult = userService.getUserByNameAndPassword(user);
			//账号密码正确时
			if (userresult != null) {
				//置空密码并存入session
				userresult.setPassword(null);
				session.setAttribute("currentUser",userresult );
				//若为管理员
				if(userresult.getUserType()==0)
					return "redirect:/admin";
				return "redirect:/index";
			} else
				model.addAttribute("wrong", "账号或密码错误!");
			return "login";
		}
		return "login";
	}
	/* A:
	 * in order to put currentUser in session,the UserController should be marked by @SessionAttributes("currentUser").
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
	public String logout(HttpSession session) {
		//清空session中的user和messages
		session.removeAttribute("currentUser");
		session.removeAttribute("messages");
		return "redirect:/login";

	}
	@RequestMapping("/profileview")
	public String profileview(){
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

	@RequestMapping("/admin")
	public String selectAllUsers(HttpSession session,Model model){
		List<User> allUsers=userService.selectAllUsers();
		model.addAttribute("allUsers",allUsers);
		return "admin";
		
	}
	@RequestMapping("/updateVolume")
	public String updateVolume(@RequestParam(value="userIds1")String userIds1,@RequestParam(value="userIds2")String userIds2,HttpServletRequest request,HttpServletResponse response,Model model)throws Exception{
		String[] idVals = userIds1.split(",");
		String[] volumeVals = userIds2.split(",");
		for(int i=0;i<idVals.length;i++){
			User user = userService.getUserById(Integer.parseInt(idVals[i]));
			user.setTotalVolume(Long.parseLong(volumeVals[i]));
			userService.update(user);
		}
		return "redirect:/admin";
	}
	@RequestMapping("/deleteUser")
	public String deleteUser(@RequestParam(value="userIds1")String userIds1,HttpServletRequest request, HttpServletResponse response,Model model){
		String[] idVals = userIds1.split(",");
		for(int i=0;i<idVals.length;i++){
			userService.deleteUser(Integer.parseInt(idVals[i]));
		}
		return "redirect:/admin";
		
	}
	@RequestMapping("/searchUserAdmin")
	public void searchUser(@RequestParam(value="userNickname")String userNickname,HttpServletRequest request,HttpServletResponse response ) throws IOException{
		User user = userService.getUserByUserNickname(userNickname);
		response.setContentType("text/javascript;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(JSON.toJSONString(user));
	
	}
	

}
