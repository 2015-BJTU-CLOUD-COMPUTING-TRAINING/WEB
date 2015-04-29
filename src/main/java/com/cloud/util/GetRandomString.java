package com.cloud.util;

import java.util.Random;

import org.springframework.stereotype.Service;
@Service
public class GetRandomString {
	
	public String getRandomString(int length){
		String base = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuilder randomString=new StringBuilder("");
		Random random = new Random();  
		
		for(int i=0;i<length;i++){
			int number = random.nextInt(base.length());   
			randomString.append(base.charAt(number));
		}
		
		return randomString.toString();
		
	}

}
