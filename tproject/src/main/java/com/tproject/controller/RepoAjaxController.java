package com.tproject.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.tproject.util.FileDownloadUtil;
import com.tproject.util.SVNUtil;

@Controller
public class RepoAjaxController{
	@Autowired
	SVNUtil svnUtil;
	
	@RequestMapping(value = "/makerepoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> makerepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		String repourl = svnUtil.doMakeRepo(info.get("url").toString());
		
		retVal.put("result", "success");
		retVal.put("repourl", repourl);
		
		return retVal;
	}
	
	@RequestMapping(value = "/repoinfoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepoinfo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("repoinfo", svnUtil.doPrintRepo(
				info.get("url").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/repohistoryajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getrepohistory(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("loginfolist", svnUtil.doPrintRepoLog(
				info.get("url").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/repotreeajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> treerepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("repotreelist", svnUtil.doPrintRepotree(
				info.get("url").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/filecontentajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> filecontent(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("filecontentinfo", svnUtil.doPrintFilecontent(
				info.get("url").toString(), 
				info.get("userid").toString(),
				info.get("userpassword").toString(),
				info.get("filename").toString(), 
				info.get("filepath").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commit(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
	
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommit(
				info.get("repourl").toString(), 
				info.get("commitpath").toString(), 
				info.get("commitlog").toString(), 
				info.get("commitfilename").toString(), 
				info.get("commitfilecontent").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitmodifyajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commitmodify(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitmodify(
				info.get("repourl").toString(), 
				info.get("commitpath").toString(), 
				info.get("commitlog").toString(), 
				info.get("commitfilename").toString(), 
				info.get("originalcontent").toString(),
				info.get("updatecontent").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitdirajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commitdir(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitdir(
				info.get("repourl").toString(), 
				info.get("commitpath").toString(), 
				info.get("commitlog").toString(), 
				info.get("commitfilename").toString(), 
				info.get("commitfilecontent").toString(),
				info.get("commitdirname").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitdeleteajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commitdelete(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitdelete(
				info.get("url").toString(), 
				info.get("deletepath").toString(),
				info.get("commitlog").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/diffajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> diff(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("diffinfo", svnUtil.doDiff(
				info.get("repourl").toString(), 
				Long.parseLong(info.get("revesionone").toString()), 
				Long.parseLong(info.get("revesiontwo").toString())));
		
		return retVal;
	}
	
	@RequestMapping(value = "/lockajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> lock(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		svnUtil.dolock(info.get("url").toString(), info.get("lockfilepath").toString());
		
		retVal.put("result", "success");
		retVal.put("lockinfo", svnUtil.dolock(
				info.get("url").toString(), 
				info.get("lockfilepath").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/unlockajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> unlock(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		svnUtil.dolock(info.get("url").toString(), info.get("lockfilepath").toString());
		
		retVal.put("result", "success");
		retVal.put("lockinfo", svnUtil.dounlock(
				info.get("url").toString(), 
				info.get("unlockfilepath").toString()));
		
		return retVal;
	}
}
