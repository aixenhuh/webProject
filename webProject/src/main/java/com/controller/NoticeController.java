package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.common.vo.Pagination;
import com.service.NoticeService;


@Controller
public class NoticeController {

	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	public ModelAndView noticeInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int curPage = (request.getParameter("curPage") == null)? 0:Integer.parseInt(request.getParameter("curPage"));
		
		if(curPage==0) curPage = 1;
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		// 전체리스트 개수
		Object noticeCnt = noticeService.noticeInfoCnt(hashmap);
		JSONArray noticeCount = new JSONArray(noticeCnt.toString());
		JSONObject notiObj = (JSONObject) noticeCount.get(0);
		int totalCnt = notiObj.getInt("NOTICE_CNT");
		
		// 페이지 나누기 관련 처리
		Pagination pagenation = new Pagination(totalCnt, curPage);
		int startPage = pagenation.getPageBegin();
		int endPage = pagenation.getPageEnd();
		
		hashmap.put("startPage", startPage);
		hashmap.put("endPage", endPage);
		
		List<Map<String, Object>> noticeListAll = noticeService.noticeInfoAll(hashmap);
		
        ModelAndView mav = new ModelAndView();
        JSONArray noticeArray = new JSONArray(noticeListAll);
        mav.addObject("noticeCnt", noticeCnt);
        mav.addObject("noticeList", noticeArray);
        mav.addObject("pagenation", pagenation);
        mav.setViewName("/notice/notice_view");
		return mav;
		/*HashMap<String, String> hashmap = new HashMap<String, String>();
	
		List<Map<String, Object>> noticeList = noticeService.noticeInfo(hashmap);
		
        ModelAndView mav = new ModelAndView();
        JSONArray noticeArray = new JSONArray(noticeList);
        mav.addObject("noticeList", noticeArray);
        mav.setViewName("/notice/notice_view");
		return mav;*/
	}
	
	@RequestMapping(value = "/notice_write.do", method = RequestMethod.POST)
	public ModelAndView noticeWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
		
		int curPage = (request.getParameter("curPage") == null)? 0:Integer.parseInt(request.getParameter("curPage"));
		
		if(curPage==0) curPage = 1;
		
		// 전체리스트 개수
		Object noticeCnt = noticeService.noticeInfoCnt(hashmap);
		JSONArray noticeCount = new JSONArray(noticeCnt.toString());
		JSONObject notiObj = (JSONObject) noticeCount.get(0);
		int totalCnt = notiObj.getInt("NOTICE_CNT");
		
		// 페이지 나누기 관련 처리
		Pagination pagenation = new Pagination(totalCnt, curPage);
		int startPage = pagenation.getPageBegin();
		int endPage = pagenation.getPageEnd();
		
		hashmap.put("startPage", startPage);
		hashmap.put("endPage", endPage);
		
		List<Map<String, Object>> noticeListAll = noticeService.noticeInfoAll(hashmap);
		
		hashmap.put("TITLE", (String) request.getParameter("title"));
		hashmap.put("CONTENTS", (String) request.getParameter("contents"));
		hashmap.put("CREA_ID", (String) request.getParameter("CREA_ID"));
		hashmap.put("USER_NAME", (String) request.getParameter("USER_NAME"));
		hashmap.put("AGE", (String) request.getParameter("userAge"));
        
		noticeService.writeBoardOne(hashmap);
		
        JSONArray noticeArray = new JSONArray(noticeListAll);
        mav.addObject("noticeCnt", noticeCnt);
        mav.addObject("noticeList", noticeArray);
        mav.addObject("pagenation", pagenation);
        
        mav.setViewName("/notice/notice_view");
		return mav;
	}
	
	@RequestMapping(value = "/notice_read.do", method = RequestMethod.POST)
	public ModelAndView noticeRead(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		ModelAndView mav = new ModelAndView();
		
		hashmap.put("IDX", (String) request.getParameter("IDX"));
        
		List<Map<String, Object>> noticeList = noticeService.readBoardOne(hashmap);
        JSONArray noticeArray = new JSONArray(noticeList);
        JSONObject noticeObject = new JSONObject();
        for (int i=0; i<noticeArray.length(); i++) {
        	noticeObject = (JSONObject) noticeArray.get(i);
        }
        
        mav.addObject("ID", noticeObject.get("ID"));
        mav.addObject("TITLE", noticeObject.get("TITLE"));
        mav.addObject("CONTENTS", noticeObject.get("CONTENTS"));
        mav.addObject("CREA_DTM", noticeObject.get("CREA_DTM"));
        mav.addObject("IDX", noticeObject.get("IDX"));
        
        mav.setViewName("/notice/notice_read_ajax"); 
		return mav;
	}
	
	@RequestMapping(value = "/notice_paging.do", method = RequestMethod.GET)
	public ModelAndView noticePaging(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int curPage = (request.getParameter("curPage") == null)? 0:Integer.parseInt(request.getParameter("curPage"));
		
		if(curPage==0) curPage = 1;
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		
		// 전체리스트 개수
		Object noticeCnt = noticeService.noticeInfoCnt(hashmap);
		JSONArray noticeCount = new JSONArray(noticeCnt.toString());
		JSONObject notiObj = (JSONObject) noticeCount.get(0);
		int totalCnt = notiObj.getInt("NOTICE_CNT");
		
		// 페이지 나누기 관련 처리
		Pagination pagenation = new Pagination(totalCnt, curPage);
		int startPage = pagenation.getPageBegin();
		int endPage = pagenation.getPageEnd();
		
		hashmap.put("startPage", startPage);
		hashmap.put("endPage", endPage);
		
		List<Map<String, Object>> noticeListAll = noticeService.noticeInfoAll(hashmap);
		
        ModelAndView mav = new ModelAndView();
        JSONArray noticeArray = new JSONArray(noticeListAll);
        mav.addObject("noticeCnt", noticeCnt);
        mav.addObject("noticeList", noticeArray);
        mav.addObject("pagenation", pagenation);
        mav.setViewName("/notice/notice_view");
		return mav;
	}
	
}