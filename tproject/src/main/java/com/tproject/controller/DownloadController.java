package com.tproject.controller;

import java.io.File;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DownloadController implements ApplicationContextAware{
	private WebApplicationContext context = null;
	
	@RequestMapping(value = "/download.do")
	public ModelAndView download(@RequestParam("filename") String filename, @RequestParam("filepath") String filepath ) throws Exception {	
		String realFolder = "http://192.168.0.71:8080/controller/svn/repoone"; //파일의 실제(디폴트) 경로(서버의 디폴트 경로)//

		File file = new File(realFolder + filepath + "/" + filename);
		
		//반환되는 값은 이동할 뷰의 이름(Bean에 등록된 id), 모델에 들어갈 Key, Key에 해당하는 Value(Objeect)// 
		return new ModelAndView("downloadView", "downloadFile", file);
	}
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		// TODO Auto-generated method stub
		
	}
}
