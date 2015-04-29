package com.cloud.app.service;

import java.util.List;

import com.cloud.app.model.Share;
import com.cloud.app.model.ShareDetail;

public interface IShareService {
	
	 
	 List<Share> getAllShareRecordByUserID(Integer userId);
	 
	 List<ShareDetail> getAllShareDetailByMark(String mark);
	 
	 int shareFiles(String uploadIds);
	 
	 int deleteShare(String uploadIds);
	 
}