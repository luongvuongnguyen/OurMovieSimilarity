/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.Statement;

/**
 *
 * @author VUONG NGUYEN
 */
public class delFromDatabase {
    //Delete movie have seen
    public void deleteMovieHaveSeenByUser(iconnectionpool connectionPool, String userID,String MovieID){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            Statement stmt=con.createStatement();                 
            String sql="delete from movie_have_seen where userID='"+userID+"' and moviesID='"+MovieID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Delete movie similarity
    public void deleteMovieSimilarityByUser(iconnectionpool connectionPool, String userID,String MovieID){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            String similarmovie=" ";
            //update have_seen table
            Statement stmt2=con.createStatement();            
            String sql2="update movie_have_seen set similarmovie='"+similarmovie+"' where userID='"+userID+"' and moviesID='"+MovieID+"'";            
            stmt2.executeUpdate(sql2);
            
            //remove from moviesimilarity table
            Statement stmt=con.createStatement(); 
            String sql="delete from moviesimilarity where userID='"+userID+"' and movie1='"+MovieID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
    
    //Delete movie similarity
    public void deleteMovieSimilarity(iconnectionpool connectionPool, String userID,String MovieID){
        try{
            Connection con=null;
            //lay ket noi tu Pool
            con=connectionPool.getConnection();
            String similarmovie=" ";
            //update have_seen table
            Statement stmt2=con.createStatement();            
            String sql2="update movie_have_seen set similarmovie='"+similarmovie+"' where userID='"+userID+"' and moviesID='"+MovieID+"'";            
            stmt2.executeUpdate(sql2);
            
            //remove from moviesimilarity table
            Statement stmt=con.createStatement(); 
            String sql="delete from moviesimilarity where userID='"+userID+"' and movie1='"+MovieID+"'";
            stmt.executeUpdate(sql);            
        }catch(Exception e){}
    }
}
