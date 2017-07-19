package com.tproject.controller;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthManageController {
	//Log 기능 이용. getLogger()의 값으로 해당 로그를 출력할 클래스를 지정//
	Logger logger = LoggerFactory.getLogger(AuthManageController.class);
	
	//메인 페이지에 접속하기 앞서 인증체크를 하고 해당 인증체크(스프링 시큐리티) 성공 후 value로 지정한 페이지로 이동//
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		mv.setViewName("adminmain");
		
		//사용자 정보 출력(세션)//
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("user name :" + user.getUsername());
		
		System.out.println("main page admin adjust");
		
		//ip주소를 알아온다.//
		//일반적인 IP주소 얻는 방법이 있지만 정확하지 않아 현재 접속되어 있는 IP주소를 불러온다.//
		String ip = getLocalServerIp();
		System.out.println("ip: " + ip);
		
		mv.addObject("serverip", ip);

		System.out.println("=-=-=-=-=-=-=-=-=-=-=-==-==-=-");
		logger.debug("tproject debug print");
    	logger.trace("tproject trace print");
    	logger.info("tproject info print");
    	logger.warn("tproject warn print");
    	logger.error("tproject error print");
    	System.out.println("=-=-=-=-=-=-=-=-=-=-=-==-==-=-");
	
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
		
		//ip주소를 알아온다.//
		//일반적인 IP주소 얻는 방법이 있지만 정확하지 않아 현재 접속되어 있는 IP주소를 불러온다.//
		String ip = getLocalServerIp();
		System.out.println("ip: " + ip);
				
		mv.addObject("serverip", ip);
	
		return mv;
	}
	
	private String getLocalServerIp() {
		try{
		    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();){
		    	NetworkInterface intf = en.nextElement();
		        for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();){
		            InetAddress inetAddress = enumIpAddr.nextElement();
		            if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress()){
		            	return inetAddress.getHostAddress().toString();
		            }
		        }
		    }
		}
		
		catch (SocketException ex) {}
		
		return null;
	}
}
