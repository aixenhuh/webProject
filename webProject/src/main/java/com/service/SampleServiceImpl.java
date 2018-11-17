package com.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import com.common.dao.SampleDAO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
    
    @Resource(name="sampleDAO")
    private SampleDAO sampleDAO;
     
	@Override
	public List<Map<String, Object>> selectBoardList(String string) throws Exception {
        return sampleDAO.selectBoardList(string);
	}
}
