package com.cloud.app.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cloud.app.model.User;
import com.cloud.app.service.IMessageService;
import com.cloud.app.service.IUserService;

public class JudgeAdminInterceptor implements HandlerInterceptor {
	
	@Autowired
	private IMessageService messageService;
	@Autowired
	private IUserService userService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if(currentUser.getUserType()==0)
			return true;
		else 
			response.sendRedirect(request.getContextPath()+"/index");
			return false;
	
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		//刷新messges和用户容量
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
	}

}
