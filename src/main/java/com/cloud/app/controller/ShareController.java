package com.cloud.app.controller;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShareController {
	
	@RequestMapping("/shareRecord")
	public String showShareRecord(HttpSession session, Model model){
		System.out
		.println("--------------------------showShareRecord--------------------------");
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
		return "share";
	}

}
