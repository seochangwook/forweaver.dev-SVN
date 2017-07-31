package com.tproject.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
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

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import com.tproject.util.FileDownloadUtil;
import com.tproject.util.SVNUtil;

@Controller
public class RepoAjaxController{
	@Autowired
	SVNUtil svnUtil;
	
	@RequestMapping(value = "/makerepoajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> makerepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("repourl", svnUtil.doMakeRepo(
				info.get("url").toString()));
		
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
	
	@RequestMapping(value = "/addajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> addFile(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
	
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitaddfile(
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
				info.get("updatecontent").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/adddirajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> adddir(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitdir(
				info.get("repourl").toString(), 
				info.get("commitpath").toString(), 
				info.get("commitlog").toString(), 
				info.get("commitfilename").toString(), 
				info.get("commitfilecontent").toString(),
				info.get("commitdirname").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitdeleteajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commitdelete(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.docommitdelete(
				info.get("url").toString(), 
				info.get("deletepath").toString(),
				info.get("commitlog").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
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
		
		retVal.put("result", "success");
		retVal.put("lockinfo", svnUtil.dolock(
				info.get("url").toString(), 
				info.get("lockfilepath").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/unlockajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> unlock(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("lockinfo", svnUtil.dounlock(
				info.get("url").toString(), 
				info.get("unlockfilepath").toString(),
				info.get("userid").toString(),
				info.get("userpassword").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/statusajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> status(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("statusinfo", svnUtil.dostatus(
				info.get("repourl").toString(), 
				info.get("statuspath").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/blameajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> blame(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("blameinfo", svnUtil.doBlame(
				info.get("filerepourl").toString(), 
				Long.parseLong(info.get("startrevesion").toString()), 
				Long.parseLong(info.get("endrevesion").toString())));
		
		return retVal;
	}
	
	@RequestMapping(value = "/updateajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> update(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("updateinfo", svnUtil.doUpdate(
				info.get("repourl").toString(),
				info.get("updaterepo").toString(), 
				Long.parseLong(info.get("updaterevesion").toString())));
		
		return retVal;
	}
	
	@RequestMapping(value = "/commitajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> commit(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("commitinfo", svnUtil.doCommit(
				info.get("commitrepo").toString(), 
				info.get("commitmessage").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/checkoutajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> checkout(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("checkoutinfo", svnUtil.doCheckout(
				info.get("checkoutrepourl").toString(), 
				info.get("checkoutlocalpath").toString(),
				Long.parseLong(info.get("checkoutrevesionone").toString()),
				Long.parseLong(info.get("checkoutrevesiontwo").toString())));
		
		return retVal;
	}
	
	@RequestMapping(value = "/importajax", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> importrepo(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		retVal.put("importinfo", svnUtil.doImport(
				info.get("importlocalpath").toString(), 
				info.get("importdesturl").toString(),
				info.get("importcommitmessage").toString()));
		
		return retVal;
	}
	
	@RequestMapping(value = "/pdfdiffview", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> pdfview(@RequestBody Map<String, Object> info) {	
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("diffinfo", svnUtil.doDiff(
				info.get("repourl").toString(), 
				Long.parseLong(info.get("revesionone").toString()), 
				Long.parseLong(info.get("revesiontwo").toString())));
		
		Document document = new Document();

        try {

            PdfWriter.getInstance(document, new FileOutputStream(new File("/Users/macbook/Desktop/pdf/diffpdf.pdf")));

            //open
            document.open();

            Paragraph p = new Paragraph();
            p.add("This is my paragraph 1");
            p.setAlignment(Element.ALIGN_CENTER);

            document.add(p);

            Paragraph p2 = new Paragraph();
            p2.add("This is my paragraph 2"); //no alignment

            document.add(p2);

            Font f = new Font();
            f.setStyle(Font.BOLD);
            f.setSize(8);

            document.add(new Paragraph(retVal.get("diffinfo").toString(), f));

            //close
            document.close();

            System.out.println("Done");

        } catch (IOException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return retVal;
	}
}
