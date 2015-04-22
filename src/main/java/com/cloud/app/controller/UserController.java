package com.cloud.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;

@Controller 
@RequestMapping("/user")
public class UserController {
	
	
	@Resource  
    private IUserService userService;  
	
	@RequestMapping("/showUser")  
    public String toIndex(Model model){  
      
        User user = this.userService.getUserById(1);  
        model.addAttribute("user", user); 
        return "showUser";  
    }
	
	@RequestMapping("/regists")  
    public String regist(User user){  
        int userid = this.userService.save(user); 
        System.out.println("+++++++++++++++++++"+user.getBirthday());
        System.out.println("++++++++++++++++++++++++++"+userid);
        System.out.println("++++++++++++++++++++++++++"+user.getUserId());
        return "index";  
    }
	
	@RequestMapping("/login")  
    public String login(User user){  
		System.out.println("controller have be created");
		System.out.println(user);
        User userresult = this.userService.getUserByNameAndPassword(user);
        System.out.println(userresult);
        return "index";  
    }

}
