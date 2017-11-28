package com.vimaan.controller;

import com.vimaan.mail.MailMessages;
import com.vimaan.mail.MailService;
import com.vimaan.model.Account;
import com.vimaan.model.User;
import com.vimaan.model.enums.Authorities;
import com.vimaan.service.AccountService;
import com.vimaan.service.UserService;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.IOUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import java.io.IOException;

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
        String status = "";


        try {

            PathMatchingResourcePatternResolver loader = new PathMatchingResourcePatternResolver();
            Resource[] resources = loader.getResources("classpath:/payslips/*.zip");
            for (Resource resource : resources) {

                File zip = File.createTempFile(UUID.randomUUID().toString(), "temp");
                FileOutputStream o = new FileOutputStream(zip);
                IOUtils.copy(resource.getInputStream(), o);
                o.close();

                String destination = request.getSession().getServletContext().getRealPath("/resources/payslips/zip");


                try {
                    ZipFile zipFile = new ZipFile(zip);
                    zipFile.extractAll(destination);
                } catch (ZipException e) {
                    e.printStackTrace();
                } finally {
                    /**
                     * delete temp file
                     */
                    zip.delete();
                }


            }



        }
        catch (IOException e)
        {

        }

        /**
         * unizp file from temp by zip4j
         */


        /*try {

            PathMatchingResourcePatternResolver loader = new PathMatchingResourcePatternResolver();
            Resource[] resources = loader.getResources("classpath:/payslips/*.pdf");
            for (Resource resource : resources) {
                // process resource
                PDDocument document = null;
                document = PDDocument.load(new File(resource.getFile().getPath()));
                document.getClass();
                if (!document.isEncrypted()) {
                    PDFTextStripperByArea stripper = new PDFTextStripperByArea();
                    stripper.setSortByPosition(true);
                    PDFTextStripper Tstripper = new PDFTextStripper();
                    String st = Tstripper.getText(document);

                    int employeecode=st.lastIndexOf("Employee Code :") + 16;
                    int location=st.indexOf("Location");

                    String empcode=st.substring(employeecode,location).trim();

                    if(empcode!=null)
                    {
                        Account account = accountService.getUserByEmpcode(empcode);

                        if(account!=null)
                        {
                            int mon=st.indexOf("Salary Slip for the Month of") + 29;
                            int name=st.indexOf("Name");

                            String month=st.substring(mon,name).trim();

                            String message = new MailMessages().payslipMessage(account,month);
                            try {
                                mailService.sendMail("admi@apeiro.us", account.getEmail(),   month + " " + "Pay Slip - " + account.getFirstname() + " " + account.getLastname(), message, resource.getFilename(),resource.getFile().getPath());
                                //status="Pay Slip sent successfully.";
                            } catch (Exception e) {
                                status="Something went wrong on email";
                            }
                            status="Pay Slip sent successfully.";
                        }
                        else
                        {
                            status="User not exists with the employee code " + empcode + " Please check the employee code";
                        }

                    }
                    else
                    {
                        status="Employee Code not exists in PDF. Please check it";
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            status="Failure";
        }*/
        return status;
    }
}
