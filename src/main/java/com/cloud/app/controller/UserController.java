package com.cloud.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.app.model.User;
import com.cloud.app.service.IUserService;

@Controller 

public class UserController {
	
	
	@Resource  
    private IUserService userService;  
	
	@RequestMapping("/showUser")  
    public String toIndex(Model model){  
      
        User user = this.userService.getUserById(1);  
        model.addAttribute("user", user); 
        return "showUser";  
    }
	
	@RequestMapping("user/regists")  
    public String regist(User user){  
        int userid = this.userService.save(user); 
        System.out.println("+++++++++++++++++++"+user.getBirthday());
        System.out.println("++++++++++++++++++++++++++"+userid);
        System.out.println("++++++++++++++++++++++++++"+user.getUserId());
        return "index";  
    }
	
	@RequestMapping("/login")  
    public String login(User user,HttpServletRequest request,Model model){  
		//如果有账号密码...
		if(request.getSession().getAttribute("currentUser")!=null){
			return "index";
		}
		else if(user.getUserName()!=null){
		System.out.println(user);
		
        User userresult = this.userService.getUserByNameAndPassword(user);
        System.out.println(userresult);
        
        if(userresult!=null){
        
        request.getSession().setAttribute("currentUser", userresult.getUserName());
        return "index";  
        }else
        model.addAttribute("wrong", "账号或密码错误!");
        return "login";
        }
		return "login";
		
    }
    
    @RequestMapping("/logout")  
    public String logout(HttpServletRequest request){  
		
		
        
        request.getSession().removeAttribute("currentUser");
         
        return "login";
       
		
    }

}
