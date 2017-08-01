package com.tproject.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

@Component
public class PdfView {
	public int pdfviewload(String pdfcontent, String pdffilepath){
		int pdfok = 0;
		
		Document document = new Document();

        try{
        	PdfWriter.getInstance(document, new FileOutputStream(new File(pdffilepath)));

            //open
            document.open();
          
            //문서의 형태를 Paragraph로 지정. 문서를 작성할려면 open된 상태여야하고 끝나면 반드시 close()해준다.//
            Paragraph paragraph1 = new Paragraph();
            paragraph1.add("SVN Diff Info Print");
            paragraph1.setAlignment(Element.ALIGN_CENTER);
            document.add(paragraph1);

            Paragraph paragraph2 = new Paragraph();
            paragraph2.add("<diff info>"); //no alignment
            document.add(paragraph2);

            Font font = new Font();
            font.setStyle(Font.BOLD);
            font.setSize(8);

            document.add(new Paragraph(pdfcontent, font));

            //close
            document.close();
            
            pdfok = 1;

        } catch (IOException e) {
            e.printStackTrace();
            pdfok = 0;
        } catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pdfok = 0;
        } catch(Exception e){
        	e.printStackTrace();
        	pdfok = 0;
        }
		
		return pdfok;
	}
}
