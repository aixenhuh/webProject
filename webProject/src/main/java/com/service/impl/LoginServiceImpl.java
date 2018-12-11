package com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.SampleDAO;
import com.service.LoginService;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
    
    @Resource(name="sampleDAO")
    private SampleDAO sampleDAO;
    
	@SuppressWarnings("rawtypes")
	public List<Map<String, Object>> loginCheck(HashMap hashmap) throws Exception {
        return sampleDAO.loginCheckList(hashmap);
	}

	@SuppressWarnings("rawtypes")
	public Object signUpForm(HashMap hashmap) throws Exception {
		return sampleDAO.signUpDao(hashmap);
	}
}
