package com.tproject.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mv) {
		mv.setViewName("main");
		
		System.out.println("normal main page");
		
		return mv;
	}
	
}
