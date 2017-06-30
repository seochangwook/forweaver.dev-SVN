package com.tproject.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AuthAjaxController {
	@RequestMapping(value = "/adminlogoutajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> logout(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultmap = new HashMap<String, Object>();

		boolean is_insert_success = false;

		//로그아웃//
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		System.out.println("--------------------------");
		System.out.println("auth name info: " + auth.getName());
		System.out.println("auth detail info: " + auth.getDetails());
		System.out.println("auth detail info: " + auth.getPrincipal());
		System.out.println("--------------------------");
		
		//로그아웃 상태인지 점검//
		//logout()시 HttpSession을 이용하기에 내부적으로 세션을 만료시킴//
		if(auth != null){
			 new SecurityContextLogoutHandler().logout(request, response, auth);
			 
			 is_insert_success = true;
		}
		
		resultmap.put("resultmsg", ""+is_insert_success);
		
		System.out.println("logout process...");
		
		return resultmap;
	}
}
