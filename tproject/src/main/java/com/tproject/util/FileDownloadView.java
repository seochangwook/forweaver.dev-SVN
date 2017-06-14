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
		//content type을 지정.//
		setContentType("application/download; charset=utf-8");
	}
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		File file = (File)model.get("downloadFile");
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + java.net.URLEncoder.encode(file.getName(), "utf-8") + "\";");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try{
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
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
		
		out.flush();
	}
}
