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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.getFromDatabase;
import model.getMovieInfo;
import model.getUsers;

/**
 *
 * @author VUONG NGUYEN
 */
public class sendEmail extends HttpServlet {

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
            throws ServletException, IOException, MessagingException, SQLException {
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
                Connection con=null;
                con=connectionPool.getConnection();
                
                getMovieInfo movieinfo = new getMovieInfo();
                getUsers userinfo = new getUsers();
                getFromDatabase datainfo = new getFromDatabase();
                               
                //Get database to create the messagebody
                StringBuffer emailBody = new StringBuffer();  
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()); 
                
                String sql="select (select poster from movies where mid_id=movie1) as poster_movie1,(select poster from movies where mid_id=movie2) as poster_movie2,(select uname from users where id=userID)as username from moviesimilarity where left(datesubmit,10)='"+today+"'";
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                    emailBody.append("<div style=\"border: 1px solid lightgray;height:350px;width:400px; overflow: auto\"><table style='width:370px'>");
                while(rs.next()){
                    emailBody.append(
                            "<tr>"
                            + "<td>"                            
                            + "<img src='"+rs.getString(1)+"' style='width:180px;'> <img src='"+rs.getString(2)+"'style='width:180px;'>"
                            + "</td>"
                            + "</tr>");
                }
                                    
                    emailBody.append("</table></div><br><div style='width:400px;text-align:justify'>Maybe you will be interesting, please come back to <a href='http://recsys.cau.ac.kr:8084/ourmoviesimilarity' targer='_blank'>OMS system</a> and select your movie similarity</div><br><table style='width:400px;background-color:#8389ab;color:#fff'><tr style='text-align:justify;'><td>"
                            + "This message was sent by <b>OMS System</b>. To make sure you receive our updates, add <b>OMS System</b> to your address book or safe list.<br><br>"
                            +"Copyright © 2018 OMS | OurMovieSimilarity. See our Privacy Policy and Terms of Service"
                            + "</td></tr></table>");
                    
                //Get all user in database                
                Vector UsersList = datainfo.get_All_Users(connectionPool);
                Enumeration Enum_UsersList = UsersList.elements();                
                
                //Send email to user
                while(Enum_UsersList.hasMoreElements()){
                    String[] tmp_UsersList = (String[]) Enum_UsersList.nextElement();                    
                    String toemail = tmp_UsersList[2];                        
                    //Kiem tra group id
                    if(tmp_UsersList[6].equals("1")){
                        StringBuffer emailHeader = new StringBuffer();
                        emailHeader.append(""
                            + "<table style='width:370px;text-align:center'><tr><td><img src=\"http://recsys.cau.ac.kr:8084/ourmoviesimilarity/img/oms-logo-100-100.png\"><br> <strong style=\"font-family:tahoma;font-size:25pt\">OUR</strong><strong style=\"color:#4188c9;font-family:tahoma;font-size:25pt\">MOVIESIMILARITY</strong></td></tr></table>"
                            + "<div style='width:400px;text-align:justify'><h4>Hi, "+tmp_UsersList[3]+"</h4>Some of your friends in our system have some activities about selecting similar movies</div>");                               
                        String bodyofmess = emailHeader.toString()+"<br>"+emailBody.toString();                    
                        model.sendEmail.sendHTML(bodyofmess,toemail);     
                    }
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
        } catch (MessagingException ex) {
            Logger.getLogger(sendEmail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(sendEmail.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (MessagingException ex) {
            Logger.getLogger(sendEmail.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(sendEmail.class.getName()).log(Level.SEVERE, null, ex);
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
