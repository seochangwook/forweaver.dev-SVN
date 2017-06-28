package com.tproject.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.tproject.dao.MemberInfoDAOImpl;
import com.tproject.dto.MemberInfoDTO;

@Service("loginservice")
public class LoginServiceImpl implements UserDetailsService{
	@Autowired
	MemberInfoDAOImpl memberinfodao;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@SuppressWarnings("unused")
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		String usercheck = "true";
		System.out.println("Auth Checking...");
		
		UserDetails user = null;
		
		//데이터베이스에서 데이터가 있는지 검증//
		List<MemberInfoDTO> userinfo = memberinfodao.getMemberInfo(username);
		
		//null이면 해당 유저정보가 없다는 의미//
		if(userinfo == null){
			throw new UsernameNotFoundException("No user found with username" + username);
		}
		
		else if(userinfo != null){
			System.out.println("member info: " + userinfo.get(0).getUsername() + "/" + userinfo.get(0).getPassword() + "/" + userinfo.get(0).getRole());
			System.out.println("password encode: " + passwordEncoder.encodePassword(userinfo.get(0).getPassword(), null));
			
			Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();

		    roles.add(new SimpleGrantedAuthority(userinfo.get(0).getRole()));
		    
		    user = new User(userinfo.get(0).getUsername(), userinfo.get(0).getPassword(), roles);

			System.out.println("Auth Checking Success...");
			
			return user;
		}
		
		return user;
	}

}
