/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import static database.common.driver;
import static database.common.password;
import static database.common.url;
import static database.common.username;
import database.iconnectionpool;
import database.simpleconnectionpool;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.getFromDatabase;
import model.insertToDatabase;

/**
 *
 * @author VUONG NGUYEN
 */
public class searchmovie extends HttpServlet {    
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
               application.setAttribute("getMovie", connectionPool);}
            
            String typeofsearch = request.getParameter("typeofsearch");
                        
            if(typeofsearch.equals("moviehaveseen")){   
                //Get paprameter from input searching
                String movieID=request.getParameter("movieID");                                       
                String titlesearch = request.getParameter("titlesearch");
                String randnum = request.getParameter("num");
                response.sendRedirect("oms_01_have_seen.jsp?search=true&titlesearch="+titlesearch+"&num="+randnum+"&id="+movieID);
                //response.sendRedirect("oms_01_movie_have_seen.jsp?id="+movieID+"&search=true&titlesearch="+titlesearch);
            }
            
            if(typeofsearch.equals("newmovie")){   
                //Get paprameter from input searchuing                                                  
                String titlesearch = request.getParameter("titlesearch");
                response.sendRedirect("oms_01_home.jsp?idmovie=0/0/0/0/0&search=true&titlesearch="+titlesearch);
            }
            
            if(typeofsearch.equals("allmovie")){   
                //Get paprameter from input searchuing                                                  
                String titlesearch = request.getParameter("titlesearch");
                response.sendRedirect("oms_04_all_movie.jsp?search=true&titlesearch="+titlesearch);
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
