/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author VUONG NGUYEN
 */
public class getUsers {
    //Get Firstname
    public String getFirstname(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select first_name from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Lastname
    public String getLastname(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select last_name from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get email
    public String getEmail(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select email from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Username
    public String getUsername(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select uname from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Image
    public String getImg(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select img from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Password
    public String getPass(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select pass from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Registration date
    public String getRegdate(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select regdate from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get Group ID
    public String getGroupid(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select groupid from users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer getusers = new StringBuffer();               
                if(rs.next()){
                    getusers.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return getusers.toString();
            }catch(Exception e){return " ";}
    }
    
}
