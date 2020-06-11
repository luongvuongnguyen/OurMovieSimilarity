/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author VUONG NGUYEN
 */
public class insertToDatabase {
    //Insert users
    public void InsertUsers(iconnectionpool connectionPool, String email,String uname, String pass){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();     
            String datesubmit=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());                        
            String img = "noavatar.jpg";
            String sql="insert into users(first_name,last_name,email,uname,img,pass,regdate)values(N' ',N' ',N'"+email+"',N'"+uname+"',N'"+img+"',N'"+pass+"',N'"+datesubmit+"')";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Insert new movies to OMS system
    public void InsertNewMovies(iconnectionpool connectionPool, String mid_id,String subtitle, String title, String year_release, String genre, String director, String actor, String poster, String plotafterJaccard, String plot, String today){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();                            
            String sql="insert into movies(mid_id,subtitle,title, year_release, genre, director, actor, poster, plotaferJaccard, plot, dateadd)values('"+mid_id+"','"+subtitle.replaceAll("'", "''")+" ','"+title.replaceAll("'", "''")+"','"+year_release+"','"+genre+"','"+director.replaceAll("'", "''")+"','"+actor.replaceAll("'", "''")+"','"+poster+"','1','"+plot.replaceAll("'", "''")+"','"+today+"')";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //update Users
    public void UpdateUsers(iconnectionpool connectionPool,String userID, String first_name,String last_name,String uname,String pass){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();                                       
            String sql="update users set first_name='"+first_name+"',last_name='"+last_name+"',uname='"+uname+"',pass='"+pass+"' where id='"+userID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Insert movie users have seen before
    public void InsertMovieHaveSeen(iconnectionpool connectionPool, String userID, String moviesID, String ipclient){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();  
            //Check database have seen of user
            String sqlcheck = "select * from movie_have_seen where userID='"+userID+"' and (moviesID='"+moviesID+"' or similarmovie='"+moviesID+"')";
            Statement stmtcheck = con.createStatement();
            ResultSet rs = stmtcheck.executeQuery(sqlcheck);
            String sql="";
            
            String datesubmit=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());                        
            if(rs.next()){sql="";}else{sql="insert into movie_have_seen(userID,moviesID,datesubmit,ipclients)values(N'"+userID+"',N'"+moviesID+"',N'"+datesubmit+"',N'"+ipclient+"')";}
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Insert movie which users thinks similarity
    public void InsertMovieSubmitbyUser(iconnectionpool connectionPool, String userID, String movie1, String movie2, String valueofits, String numberrefresh){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();     
            
            String sqlupdate = "update movie_have_seen set similarmovie='"+movie2+"' where userID='"+userID+"' and moviesID='"+movie1+"'";
            Statement stmtupdate = con.createStatement();
            stmtupdate.executeUpdate(sqlupdate);
            
            String datesubmit=new java.text.SimpleDateFormat("yyyy-MM-dd-hh-mm-ss").format(new java.util.Date());
            String timesrefresh="";
            
            if(numberrefresh.equals("00")){timesrefresh="00";}else{
                if(numberrefresh.equals("000")){timesrefresh="000";}else{
                timesrefresh = Integer.parseInt(numberrefresh)/5+"";
                }
            }
            String sql="insert into moviesimilarity (userID,movie1,movie2,datesubmit,valueofits,timesofrefresh)values(N'"+userID+"',N'"+movie1+"',N'"+movie2+"',N'"+datesubmit+"',N'"+valueofits+"',N'"+timesrefresh+"')";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Update Img for User
    public void UpdateImgUser(iconnectionpool connectionPool, String userID, String img){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();   
            
            String sql="update users set img='"+img+"' where id='"+userID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Update Status for User
    public void UpdateStatusUser(iconnectionpool connectionPool, String userID, String status){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();   
            
            String sql="update users set userstatus='"+status+"' where id='"+userID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Update valueofits for moviesimilarity
    public void UpdateValueofIts(iconnectionpool connectionPool, String valueofits, String id){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();   
            
            String sql="update moviesimilarity set valueofits='"+valueofits+"' where id='"+id+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
}
