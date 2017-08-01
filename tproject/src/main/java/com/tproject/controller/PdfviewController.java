package com.tproject.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.tproject.util.PdfView;
import com.tproject.util.SVNUtil;

@Controller
public class PdfviewController {
	@Autowired
	SVNUtil svnUtil;
	@Autowired
	PdfView pdfview;
	
	@RequestMapping(value = "/pdfdiffview", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> pdfview(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("diffinfo", svnUtil.doDiff(
				info.get("repourl").toString(), 
				Long.parseLong(info.get("revesionone").toString()), 
				Long.parseLong(info.get("revesiontwo").toString())));
		
		int pdfviewok = pdfview.pdfviewload(retVal.get("diffinfo").toString(), "/Users/macbook/Desktop/pdf/diffinfo.pdf");
		retVal.put("resultpdf", ""+pdfviewok);
		
		return retVal;
	}
}
