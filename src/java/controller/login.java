/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import database.*;
import model.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author VUONG NGUYEN
 */
public class login extends HttpServlet implements common{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
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
            //get data from login form
            String email=request.getParameter("email").trim();
            String pass=request.getParameter("pass").trim();
            
            //remove previous session
            sesion.removeAttribute("userlogin");
            
            //Check login
            getFromDatabase newuser = new getFromDatabase();
            container.user sessionuser=newuser.checkLogin(connectionPool, email, pass);
            
            //Create new session and input data to
            if(sessionuser!=null){
                sesion.setAttribute("userlogin",sessionuser);                
                insertToDatabase newinsert = new insertToDatabase();
                newinsert.UpdateStatusUser(connectionPool, sessionuser.getIduser(), "1");
                response.sendRedirect("oms_01_home.jsp?search");
                }else{
                response.sendRedirect("oms_login.jsp?login=wrong");
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
