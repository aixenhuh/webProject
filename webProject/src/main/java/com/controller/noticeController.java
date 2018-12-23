package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.service.NoticeService;


@Controller
public class noticeController {

	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	public ModelAndView noticeInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		
		List<Map<String, Object>> noticeList = noticeService.noticeInfo(hashmap);
		
        ModelAndView mav = new ModelAndView();
        JSONArray noticeArray = new JSONArray(noticeList);
        mav.addObject("noticeList", noticeArray);
        mav.setViewName("/notice/notice_view");
		return mav;
	}
	
}