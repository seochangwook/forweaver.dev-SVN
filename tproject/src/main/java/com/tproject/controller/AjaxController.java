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
		
		String repourl = svnUtil.doMakeRepo(info.get("url").toString());
		
		retVal.put("result", "success");
		retVal.put("repourl", repourl);
		
		return retVal;
	}
	
	@RequestMapping(value = "/repoinfoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepoinfo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		retVal.put("result", "success");
		retVal.put("repoinfo", svnUtil.doPrintRepo(info.get("url").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/repohistoryajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepohistory(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		retVal.put("result", "success");
		retVal.put("loginfolist", svnUtil.doPrintRepoLog(info.get("url").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/repotreeajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> treerepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		retVal.put("result", "success");
		retVal.put("repotreelist", svnUtil.doPrintRepotree(info.get("url").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/filecontentajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> filecontent(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //반환할 타입의 클래스를 선언//
		
		retVal.put("result", "success");
		retVal.put("filecontentinfo", svnUtil.doPrintFilecontent(info.get("url").toString(), info.get("filepath").toString()));
		
		return retVal;
	}
}
