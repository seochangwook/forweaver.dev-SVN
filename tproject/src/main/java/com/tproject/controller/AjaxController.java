package com.tproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.tproject.util.SVNUtil;

@Controller
public class AjaxController {
	@Autowired
	SVNUtil svnUtil;
	
	@RequestMapping(value = "/makerepoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> makerepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		System.out.println("repo url : " + info.get("url"));
		
		String repourl = svnUtil.doMakeRepo(info.get("url").toString());
		
		retVal.put("result", "success");
		retVal.put("repourl", repourl);
		
		return retVal;
	}
	
	@RequestMapping(value = "/repoinfoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepoinfo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		System.out.println("repo url : " + info.get("url"));
		
		retVal.put("result", "success");
		retVal.put("repoinfo", svnUtil.doPrintRepo(info.get("url").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/repohistoryajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepohistory(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		System.out.println("repo url : " + info.get("url"));
		
		svnUtil.doPrintRepoLog(info.get("url").toString());
		
		retVal.put("result", "success");
		
		return retVal;
	}
}
