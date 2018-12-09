package com.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.service.SampleService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Resource(name="sampleService")
	private SampleService sampleService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/introduce", method = RequestMethod.GET)
	public ModelAndView introduce(Locale locale, Model model) {
		ModelAndView mv = new ModelAndView("introduce");
        
        List<Map<String, Object>> list = null;
		try {
			list = sampleService.selectBoardList("a");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        mv.addObject("list", list);
         
        return mv;
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public ModelAndView signIn(Locale locale, Model model) {
		ModelAndView mv = new ModelAndView("/register/signIn");
        
        List<Map<String, Object>> list = null;
		try {
			list = sampleService.selectBoardList("a");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        mv.addObject("list", list);
         
        return mv;
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/signInForm.do", method = RequestMethod.GET)
	public ModelAndView signInForm(Locale locale, Model model) {
		ModelAndView mv = new ModelAndView("/ajax/signIn_ajax");
        
        List<Map<String, Object>> list = null;
		try {
			list = sampleService.selectBoardList("a");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        mv.addObject("list", list);
         
        return mv;
	}
	
}
