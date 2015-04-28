package com.cloud.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.stereotype.Service;
@Service
public class ZipFile {
	
	public void zipFile(String[] filesUrl,String[] filesName,String zipUrl) throws IOException{
	 byte[] buffer = new byte[1024];
	 ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipUrl));   
	 
	 int i = 0;
	 for(String fileUrl:filesUrl){
		 //获得hdfs保留的文件
		 File oldfile = new File(fileUrl);
		 InputStream  oldfileStream  = new FileInputStream(oldfile);     
		 //复制用户自定义名称的文件
		 String newfileUrl = fileUrl.substring(0,fileUrl.lastIndexOf("/")+1)+filesName[i];
		 File newfile = new File(newfileUrl);
		 FileOutputStream newfileStream = new FileOutputStream(newfile); 
		 byte[] bufferc = new byte[2048];
		 int bytesRead;
		 while(-1 != (bytesRead = oldfileStream.read(bufferc, 0, bufferc.length))){
			 newfileStream.write(bufferc, 0, bytesRead);
		 }
		 oldfileStream.close();
		 newfileStream.close();
		 
		 
		 FileInputStream fis = new FileInputStream(new File(newfileUrl));  
		 out.putNextEntry(new ZipEntry(new File(newfileUrl).getName()));
		 
		 int len;   
          //读入需要下载的文件的内容，打包到zip文件   
         while((len = fis.read(buffer))>0) {   
          out.write(buffer,0,len);    
         }   
          out.closeEntry();   
          fis.close();   
          newfile.delete();
          i++;
	 }
	 out.close();
	 
	 
	}
	
}
