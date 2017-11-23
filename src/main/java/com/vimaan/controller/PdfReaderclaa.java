package com.vimaan.controller;

import com.vimaan.mail.MailService;
import com.vimaan.model.User;
import com.vimaan.model.enums.Authorities;
import com.vimaan.service.AccountService;
import com.vimaan.service.UserService;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Date;

/*import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;

import java.io.IOException;*/

@RequestMapping(value = "/auth")
@Controller
public class PdfReaderclaa {

    @Autowired
    public UserService userService;

    @Autowired
    AccountService accountService;

    @Autowired
    SessionFactory sessionFactory;

    @Autowired
    MailService mailService;

    @Secured({"ROLE_ADMIN", "ROLE_HR"})
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public ModelAndView showRegister() {
        ModelAndView model = new ModelAndView("views/read");
        model.addObject("user", new User());
        model.addObject("authorities", Authorities.values());
        return model;
    }

    @RequestMapping(value = "/savefile", method = RequestMethod.POST)
    @ResponseBody
    String savefile(HttpServletRequest request, HttpServletResponse response) {
       /* User user = new User();
        user.setUsername(request.getParameter("username"));*/
        String status = "";
        try {
            PDDocument document = null;
            document = PDDocument.load(new File("V:\\test.pdf"));
            document.getClass();
            if (!document.isEncrypted()) {
                PDFTextStripperByArea stripper = new PDFTextStripperByArea();
                stripper.setSortByPosition(true);
                PDFTextStripper Tstripper = new PDFTextStripper();
                String st = Tstripper.getText(document);

                int employeecode=st.lastIndexOf("Employee Code :") + 16;
                int location=st.indexOf("Location");

                String empcode=st.substring(employeecode,location).trim();

                status="Success";
            }
        } catch (Exception e) {
            e.printStackTrace();
            status="Failure";
        }


        return status;
    }


    @RequestMapping(value = "/savefile")
    public Object readPdfFile(){

        /*PdfReader reader;*/


        return new Object();
    }
}
