/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import static database.common.driver;
import static database.common.password;
import static database.common.url;
import static database.common.username;
import database.iconnectionpool;
import database.simpleconnectionpool;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import model.getFromDatabase;
import model.insertToDatabase;

/**
 *
 * @author VUONG NGUYEN
 */
public class uploadimg extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DATA_DIRECTORY = "img/profile";
    private static final int MAX_MEMORY_SIZE = 8024 * 8024 * 2;
    private static final int MAX_REQUEST_SIZE = 8024 * 8024;    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter(); 
        // Check that we have a file upload request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        if (!isMultipart) {
            return;
        }

        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Sets the size threshold beyond which files are written directly to
        // disk.
        factory.setSizeThreshold(MAX_MEMORY_SIZE);

        // Sets the directory used to temporarily store files that are larger
        // than the configured size threshold. We use temporary directory for
        // java
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        // constructs the folder where uploaded file will be stored
        String uploadFolder = getServletContext().getRealPath("")
                + File.separator + DATA_DIRECTORY;

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // Set overall request size constraint
        upload.setSizeMax(MAX_REQUEST_SIZE);

        try {
            // Parse the request
            List items = upload.parseRequest(request);
            Iterator iter = items.iterator();
            String fileName="", filePath="";
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    fileName = new File(item.getName()).getName();
                    filePath = uploadFolder + File.separator + fileName;
                    File uploadedFile = new File(filePath);
                    System.out.println(filePath);
                    // saves the file to upload directory
                    item.write(uploadedFile);
                }
            }
            //Connect to Database MySQL
            ServletContext application=getServletContext();    
            HttpSession sesion=request.getSession();
            iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
               if (connectionPool == null) {
                  try {
                    Class.forName(driver);
                  } catch (Exception e) {
                    out.println(e);
                  }
               connectionPool = new simpleconnectionpool(url, username, password);
               application.setAttribute("getMovie", connectionPool);
            }
            request.setCharacterEncoding("utf-8");
            
            
            //Insert data to Database MySQL
            container.user users = (container.user) sesion.getAttribute("userlogin");
            insertToDatabase newsubmit = new insertToDatabase();            
            newsubmit.UpdateImgUser(connectionPool, users.getIduser(), fileName);      
            
            //Remove session and create new session
            
            
            getFromDatabase newuser = new getFromDatabase();
            container.user sessionuser=newuser.checkLogin(connectionPool, users.getEmail(), users.getPass());            
            sesion.setAttribute("userlogin",sessionuser);
            //Call back HTML JSP
            response.sendRedirect("oms_05_profile.jsp?edit=true");

        } catch (FileUploadException ex) {
            throw new ServletException(ex);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }

    }

}