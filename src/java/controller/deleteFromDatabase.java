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
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.delFromDatabase;
import model.getFromDatabase;


/**
 *
 * @author VUONG NGUYEN
 */
public class deleteFromDatabase extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            ServletContext application=getServletContext();            
            iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
               if (connectionPool == null) {
                  try {
                    Class.forName(driver);
                  } catch (Exception e) {
                    out.println(e);
                  }
               connectionPool = new simpleconnectionpool(url, username, password);
               application.setAttribute("getMovie", connectionPool);}
               
            String action=request.getParameter("action");            
            String userID=request.getParameter("userID");           
            delFromDatabase newdelete = new delFromDatabase();
            
            if(action.equals("deleteMovieHaveSeenByUser")){                
                String movieID = request.getParameter("movieID");
                newdelete.deleteMovieHaveSeenByUser(connectionPool, userID, movieID);
                response.sendRedirect("oms_03_listofmoviehaveseen.jsp");
            }
            
            if(action.equals("deleteMovieSimilarity")){                
                String movieID = request.getParameter("movieID");
                String num = request.getParameter("num");                
                newdelete.deleteMovieSimilarityByUser(connectionPool, userID, movieID);
                response.sendRedirect("oms_01_have_seen.jsp?search&num="+num+"&id="+movieID);
            }
            
            if(action.equals("deleteMovieSimilarity2")){                
                String movieID = request.getParameter("movieID");
                String movie2 = request.getParameter("movie2");
                String num = request.getParameter("num");  
                getFromDatabase getcheck = new getFromDatabase();
                
                String check = getcheck.Check_Movie(connectionPool, movieID, userID, movie2);
                
                newdelete.deleteMovieSimilarity(connectionPool, userID, movieID);
                newdelete.deleteMovieSimilarity(connectionPool, userID, movie2);
                
                if(check.equals("0")){
                    response.sendRedirect("oms_01_have_seen.jsp?search&num="+num+"&id="+movieID);}
                if(check.equals("1")){
                    response.sendRedirect("oms_01_have_seen.jsp?search&num="+num+"&id="+movie2);
                }
                
            }
                
                       
            if(action.equals("deleteMovieSimilarityByUser")){                
                String movieID = request.getParameter("movieID");
                newdelete.deleteMovieSimilarityByUser(connectionPool, userID, movieID);
                response.sendRedirect("oms_03_listofmoviehaveseen.jsp");
            }
            
            if(action.equals("delHaveseenMyActivity")){                
                String movieID = request.getParameter("movieID");
                String pages = request.getParameter("pages");
                newdelete.deleteMovieHaveSeenByUser(connectionPool, userID, movieID);
                response.sendRedirect("oms_03_my_activity.jsp?pages="+pages);
            }
            
            if(action.equals("delSimilarMyActivity")){                
                String movieID = request.getParameter("movieID");
                String pages = request.getParameter("pages");
                newdelete.deleteMovieSimilarityByUser(connectionPool, userID, movieID);
                response.sendRedirect("oms_03_my_activity.jsp?pages="+pages);
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
