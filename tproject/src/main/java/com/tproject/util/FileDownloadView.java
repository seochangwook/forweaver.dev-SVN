package com.tproject.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class FileDownloadView extends AbstractView{

	public FileDownloadView(){
		//content type�쓣 吏��젙.//
		setContentType("application/download; utf-8");
		System.out.println("content Type setting success...");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("----------------------------------");
		
		File file = (File)model.get("downloadFile");
		
		System.out.println("downloadfile: " + model.get("downloadFile").toString());
		
		response.setContentType(getContentType());
		System.out.println("Content Type: " + getContentType().toString());
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + java.net.URLEncoder.encode(file.getName(), "UTF-8") + "\";");
		System.out.println("file name: " + file.getName().toString());
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try{
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			
			System.out.println("file downloading...");
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		
		finally{
			if(fis!=null){
				try{
					fis.close();
				}catch(IOException ioe){
					ioe.printStackTrace();
				}
			}
		}
		
		System.out.println("file download success...");
		System.out.println("----------------------------------");
		
		out.flush();
	}
}
