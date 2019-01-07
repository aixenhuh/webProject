package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface NoticeService {
	@SuppressWarnings("rawtypes")
	List<Map<String, Object>> noticeInfo(HashMap hashmap) throws Exception;
	
	@SuppressWarnings("rawtypes")
	Object writeBoardOne(HashMap hashmap) throws Exception;
	
	@SuppressWarnings("rawtypes")
	List<Map<String, Object>> readBoardOne(HashMap hashmap) throws Exception;
}
