package com.tproject.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class FileDownloadUtil extends AbstractView{
	public FileDownloadUtil(){
		setContentType("application/download; charset=utf-8");
	}
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("----------------------------------");
		
		//response.setContentType("text/plain");
		File file = (File)model.get("downloadFile");
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		System.out.println("DownloadView --> file.getPath() : " + file.getPath());
		System.out.println("DownloadView --> file.getName() : " + file.getName());
		System.out.println("DownloadView --> Content-Type: " + response.getContentType());
		
		String userAgent = request.getHeader("User-Agent");
		
		//브라우저가 IE버전인지 확인//
		boolean ie = userAgent.indexOf("MSIE") > -1;
		
		String fileName = null;
		
		if(ie){
			fileName = URLEncoder.encode(file.getName(), "utf-8");
			System.out.println("DownloadView --> file Name: " + fileName);
		}else{
			fileName = new String(file.getName().getBytes("utf-8"));
			System.out.println("DownloadView --> file Name: " + fileName);
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
         
        OutputStream out = response.getOutputStream();
         
        FileInputStream fis = null;
         
        try {
             
            fis = new FileInputStream(file);
             
            FileCopyUtils.copy(fis, out);
             
             
        } catch(Exception e){
             
            e.printStackTrace();
             
        }finally{
             
            if(fis != null){
                 
                try{
                    fis.close();
                }catch(Exception e){}
            }
             
        }// try end;
         
        out.flush();

		System.out.println("----------------------------------");
	}
}
