package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LoginService {
	@SuppressWarnings("rawtypes")
	List<Map<String, Object>> loginCheck(HashMap hashmap) throws Exception;
	@SuppressWarnings("rawtypes")
	Object signUpForm(HashMap hashmap) throws Exception;
}
