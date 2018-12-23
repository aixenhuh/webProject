package com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.SampleDAO;
import com.service.LoginService;
import com.service.NoticeService;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
    
    @Resource(name="sampleDAO")
    private SampleDAO sampleDAO;
    
	@SuppressWarnings("rawtypes")
	public List<Map<String, Object>> noticeInfo(HashMap hashmap) throws Exception {
		return sampleDAO.selectBoardList(hashmap);
	}
}
