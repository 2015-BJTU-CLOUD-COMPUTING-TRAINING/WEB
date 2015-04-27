package com.cloud.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.stereotype.Service;
@Service
public class ZipFile {
	
	public void zipFile(String[] filesUrl,String zipUrl) throws IOException{
	 byte[] buffer = new byte[1024];
	 ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipUrl));   
	 
	 for(String fileUrl:filesUrl){
		 FileInputStream fis = new FileInputStream(new File(fileUrl));  
		 out.putNextEntry(new ZipEntry(new File(fileUrl).getName()));
		 
		 int len;   
          //读入需要下载的文件的内容，打包到zip文件   
         while((len = fis.read(buffer))>0) {   
          out.write(buffer,0,len);    
         }   
          out.closeEntry();   
          fis.close();   
	 }
	 out.close();
	 
	 
	}
	
}
