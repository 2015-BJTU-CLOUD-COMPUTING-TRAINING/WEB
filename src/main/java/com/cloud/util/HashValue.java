package com.cloud.util;

import java.math.BigInteger;
import java.security.MessageDigest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
@Service
public class HashValue {
		
		//获得文件约定长度的hash值
	    public String getHashValue(MultipartFile file,int length) throws Exception{
	    	 byte[] uploadBytes = file.getBytes();
	    	    MessageDigest md5 = MessageDigest.getInstance("MD5");
	    	    byte[] digest = md5.digest(uploadBytes);
	    	    String hashString = new BigInteger(1, digest).toString(length);
	    	    return hashString.toUpperCase();
	  
	    }  
}
