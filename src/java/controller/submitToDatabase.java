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
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.getFromDatabase;
import model.getMovieInfo;
import model.getUsers;
import model.insertToDatabase;

/**
 *
 * @author VUONG NGUYEN
 */
public class submitToDatabase extends HttpServlet {
    
    private static String getClientIp(HttpServletRequest request) {

        String remoteAddr = "";

        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        return remoteAddr;
    }

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
            throws ServletException, IOException, Exception {
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
               
            String action=request.getParameter("action");
            String ipclients=getClientIp(request);        
            String userID=request.getParameter("userID");
            
            insertToDatabase newsubmit = new insertToDatabase();
            getMovieInfo movieinfo = new getMovieInfo();
            getUsers userinfo = new getUsers();
            getFromDatabase datainfo = new getFromDatabase();
            
            if(action.equals("haveseen")){                
                String movieID = request.getParameter("id");
                newsubmit.InsertMovieHaveSeen(connectionPool, userID, movieID, ipclients);
                response.sendRedirect("oms_01_have_seen.jsp?search&num=0&id="+movieID);
            }
            
            if(action.equals("moviesimilarity")){                
                String movie1 = request.getParameter("movie1");
                String movie2="",valueofits="";
                String[] select = request.getParameter("select").split("/");
                movie2=select[0];valueofits=select[1];
                String numberrefresh = request.getParameter("numberrefresh");
                //Submit moviesimilarity to database
                newsubmit.InsertMovieSubmitbyUser(connectionPool, userID, movie1, movie2, valueofits, numberrefresh);              
                response.sendRedirect("oms_01_home.jsp?search");
            }  
            
            if(action.equals("submitexplore")){                
                String movie1 = request.getParameter("movie1");                
                String movie2=request.getParameter("movie2");
                String valueofits=request.getParameter("valueofits");               
                String numberrefresh = "000";
                
                newsubmit.InsertMovieHaveSeen(connectionPool, userID, movie1, ipclients);
                newsubmit.InsertMovieSubmitbyUser(connectionPool, userID, movie1, movie2, valueofits, numberrefresh);                
                response.sendRedirect("oms_06_explore.jsp?movie1="+movie1);
            }  
            
            if(action.equals("updateuser")){                                
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");
                String uname = request.getParameter("uname");
                String pass = request.getParameter("pass");
                newsubmit.UpdateUsers(connectionPool, userID, first_name, last_name, uname, pass);                
                //Remove session and create new session
                sesion.removeAttribute("userlogin");
                String email=request.getParameter("email");
                getFromDatabase newuser = new getFromDatabase();
                container.user sessionuser=newuser.checkLogin(connectionPool, email, pass);
                sesion.setAttribute("userlogin",sessionuser);
                //Call back HTML JSP
                response.sendRedirect("oms_05_profile.jsp?edit=true");
            }
            
            if(action.equals("insertnewmovies")){
                String idmovie = request.getParameter("idmovie");
                String a="http://www.omdbapi.com/?i="+idmovie+"&plot=full&apikey=72b3ca58";
                URL url = new URL(a);
                URLConnection conn = url.openConnection();

                // open the stream and put it into BufferedReader
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));                
                String inputLine, jsondata="";         
                while ((inputLine = br.readLine()) != null) {
                    jsondata=jsondata+inputLine+"";
                }
                
//                String mid_id="",subtitle="",title="",year_release="",genre="",director="",actor="",poster="",plotafterJaccard="",plot="";                
//                newsubmit.InsertNewMovies(connectionPool, mid_id, subtitle, title, year_release, genre, director, actor, poster, plotafterJaccard, plot);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(submitToDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(submitToDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
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
