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
import java.util.Vector;

/**
 *
 * @author VUONG NGUYEN
 */
public class getDataToCreateChart {
    //Get datesubmit of user
    public Vector get_DatesubmitByUser(iconnectionpool connectionPools, String iduser){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select distinct(left(datesubmit,10))as datesubmit from moviesimilarity where userid='"+iduser+"'";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String datesubmit;
            while(rs.next()){
                datesubmit=rs.getString(1);            
                
                String[] movie_info={datesubmit};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get count number of movie have seen of user by datesubmit
    public String CountMoviesHaveSeenByUser(iconnectionpool connectionPools, String userid, String datesubmit){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from movie_have_seen where userID='"+userid+"' and left(datesubmit,10)='"+datesubmit+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get all movie and pagiantion of user
    public Vector get_Trend_of_User (iconnectionpool connectionPools, String userID){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();           
            
            String sql="select valueofits from moviesimilarity where userID='"+userID+"'";
            ResultSet rs=stmt.executeQuery(sql);
            
            thongtin.clear();
            String valueofits;Double sum_title=0.0,sum_genre=0.0,sum_director=0.0,sum_actor=0.0,sum_plot=0.0;
            int i=0;
            while(rs.next()){                
                valueofits=rs.getString(1);
                
                String[] arg = valueofits.split("-");
                String[] title_score=arg[0].split(":");
                String[] genre_score=arg[1].split(":");
                String[] director_score=arg[2].split(":");
                String[] actor_score=arg[3].split(":");
                String[] plot_score=arg[4].split(":");
                sum_title = getFromDatabase.round(sum_title+Double.parseDouble(title_score[1]),1);
                sum_genre = getFromDatabase.round(sum_genre+Double.parseDouble(genre_score[1]),1);
                sum_director = getFromDatabase.round(sum_director+Double.parseDouble(director_score[1]),1);
                sum_actor = getFromDatabase.round(sum_actor+Double.parseDouble(actor_score[1]),1);
                sum_plot = getFromDatabase.round(sum_plot+Double.parseDouble(plot_score[1]),1);
                i++;
            }
            String[] movie_info={sum_title+"",sum_genre+"",sum_director+"",sum_actor+"",sum_plot+"",i+""};
            thongtin.addElement(movie_info);
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    public String getTrendofUser(iconnectionpool connectionPools, String userID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                Statement stmt=con.createStatement(); 
                String sql="select valueofits from moviesimilarity where userID='"+userID+"'";
                ResultSet rs=stmt.executeQuery(sql);
                String valueofits;Double sum_title=0.0,sum_genre=0.0,sum_director=0.0,sum_actor=0.0,sum_plot=0.0;
                while(rs.next()){                
                    valueofits=rs.getString(1);

                    String[] arg = valueofits.split("-");
                    String[] title_score=arg[0].split(":");
                    String[] genre_score=arg[1].split(":");
                    String[] director_score=arg[2].split(":");
                    String[] actor_score=arg[3].split(":");
                    String[] plot_score=arg[4].split(":");
                    sum_title = getFromDatabase.round(sum_title+Double.parseDouble(title_score[1]),1);
                    sum_genre = getFromDatabase.round(sum_genre+Double.parseDouble(genre_score[1]),1);
                    sum_director = getFromDatabase.round(sum_director+Double.parseDouble(director_score[1]),1);
                    sum_actor = getFromDatabase.round(sum_actor+Double.parseDouble(actor_score[1]),1);
                    sum_plot = getFromDatabase.round(sum_plot+Double.parseDouble(plot_score[1]),1);
                }               
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return " ";}
    }
}
