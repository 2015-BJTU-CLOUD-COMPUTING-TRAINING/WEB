package com.cloud.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

}
