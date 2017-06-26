package com.tproject.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthManageController {
	//메인 페이지에 접속하기 앞서 인증체크를 하고 해당 인증체크(스프링 시큐리티) 성공 후 value로 지정한 페이지로 이동//
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		mv.setViewName("adminmain");
		
		//사용자 정보 출력(세션)//
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("user name :" + user.getUsername());
		
		System.out.println("main page admin adjust");
	
		return mv;
	}
	
	//Spring Security의 커스터마이징 페이지 경로//
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("login/loginview");
		
		System.out.println("security login adjust");
	
		return mv;
	}
	
	//로그인 실패 관련 처리 페이지//
	@RequestMapping(value = "/loginerror.do", method = RequestMethod.GET)
	public ModelAndView loginerror(ModelAndView mv) {
		mv.setViewName("error/loginerrorview");
		
		System.out.println("login error");
	
		return mv;
	}
}
