package com.cloud.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
@Service("operateFile") 
public class operateFile {
	
	public void saveFile(MultipartFile file){
		try {  
            String fileName = "demoUpload" + file.getOriginalFilename();  
            //定义上传路径  
            String path = "/Users/cJack1913/Downloads/test/" + fileName;  
            File localFile = new File(path);  
            file.transferTo(localFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
            System.out.println("上传出错");  
        }  
	}
	
	 public  void getFile(HttpServletRequest request,  
		      HttpServletResponse response, String storeName, String contentType
		       ) throws Exception {  
		    
//		    request.setCharacterEncoding("UTF-8");  
//		    BufferedInputStream bis = null;  
//		    BufferedOutputStream bos = null;  
//		  
//		    //获取项目根目录
//		    String ctxPath = request.getSession().getServletContext()  
//		        .getRealPath("");  
//		    
//		    //获取下载文件露肩
//		    String downLoadPath = ctxPath+"/uploadFile/"+ storeName;  
//		  
//		    //获取文件的长度
//		    long fileLength = new File(downLoadPath).length();  
//
//		    //设置文件输出类型
//		    response.setContentType("application/octet-stream");  
//		    response.setHeader("Content-disposition", "attachment; filename="  
//		        + new String(storeName.getBytes("utf-8"), "ISO8859-1")); 
//		    //设置输出长度
//		    response.setHeader("Content-Length", String.valueOf(fileLength));  
//		    //获取输入流
//		    bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
//		    //输出流
//		    bos = new BufferedOutputStream(response.getOutputStream());  
//		    byte[] buff = new byte[2048];  
//		    int bytesRead;  
//		    while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
//		      bos.write(buff, 0, bytesRead);  
//		    }  
//		    //关闭流
//		    bis.close();  
//		    bos.close();  
		 
		 
		 request.setCharacterEncoding("UTF-8");  
		    BufferedInputStream bis = null;  
		    BufferedOutputStream bos = null;  
		  
		    //获取项目根目录
		    String ctxPath = request.getSession().getServletContext()  
		        .getRealPath("");  
		    
		    //获取下载文件露肩
		    String downLoadPath = ctxPath+"/uploadFile/"+ storeName;  
		  
		    //获取文件的长度
		    long fileLength = new File(downLoadPath).length();  
		    String path = "/Users/cJack1913/Downloads/test/" + storeName;  
		    //设置文件输出类型
		    response.setContentType("application/octet-stream");  
		    response.setHeader("Content-disposition", "attachment; filename="  
		        + new String(storeName.getBytes("utf-8"), "ISO8859-1")); 
		    //设置输出长度
		    response.setHeader("Content-Length", String.valueOf(fileLength));  
		    //获取输入流
		    bis = new BufferedInputStream(new FileInputStream(path));  
		    //输出流
		    bos = new BufferedOutputStream(response.getOutputStream());  
		    byte[] buff = new byte[2048];  
		    int bytesRead;  
		    while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
		      bos.write(buff, 0, bytesRead);  
		    }  
		    //关闭流
		    bis.close();  
		    bos.close();  
		  }  
}
