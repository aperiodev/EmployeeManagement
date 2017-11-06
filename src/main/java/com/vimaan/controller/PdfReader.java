package com.vimaan.controller;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;

@Controller
public class PdfReader {

    @RequestMapping(value = "/read")
    public Object readPdfFile(){

        try {
            PDDocument document = null;
            document = PDDocument.load(new File("F:\\test.pdf"));
            document.getClass();
            if (!document.isEncrypted()) {
                PDFTextStripperByArea stripper = new PDFTextStripperByArea();
                stripper.setSortByPosition(true);
                PDFTextStripper Tstripper = new PDFTextStripper();
                String st = Tstripper.getText(document);
                System.out.println("Text:" + st);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new Object();
    }
}
