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
import java.util.Arrays;
import java.util.Collections;
import java.util.Vector;

/**
 *
 * @author VUONG NGUYEN
 */
public class getFromDatabase {
    getMovieInfo movieinfo = new getMovieInfo();
    getUsers userinfo = new getUsers();
    getDataToCreateChart usertrend = new getDataToCreateChart();
    //Check login and set Attribute to user; param: email, pass
    public container.user checkLogin(iconnectionpool connectionPools,String email,String pass) {
        Connection con=null;
        try{
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select id,first_name,last_name,email,uname,img,pass,regdate from users where email='"+email+"' and pass='"+pass+"'";
            ResultSet rs=stmt.executeQuery(sql);
            container.user newuser=null;
            if(rs.next()){
                String id=rs.getString(1);
                String first_name=rs.getString(2);
                String last_name=rs.getString(3);                
                String uname=rs.getString(5);
                String img=rs.getString(6);                
                String regdate=rs.getString(8);

                newuser=new container.user();
                
                newuser.setIduser(id);
                newuser.setFirst_name(first_name);
                newuser.setLast_name(last_name);
                newuser.setEmail(email);
                newuser.setUname(uname);
                newuser.setImg(img);
                newuser.setPass(pass);
                newuser.setRegdate(regdate);
            }            
            connectionPools.releaseConnection(con);
            return newuser;
        }catch(Exception e){
            return null;
        }
    }
    
    //Convert double round
    public static double round(double number, int digit){
            if (digit > 0){
               int temp = 1, i;
                for (i = 0; i < digit; i++)
                    temp = temp*10;
                    number = number*temp;
                    number = Math.round(number);
                    number = number/temp;
                    return number;
            }
            else
        return 0.0;
    }
    
    //Check user online; param: iduser
    public String Check_User_Status(iconnectionpool connectionPools, String userID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select userstatus from users where id='"+userID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer userstatus = new StringBuffer();               
                if(rs.next()){userstatus.append(rs.getString(1));}else{userstatus.append("0");}
                connectionPools.releaseConnection(con);
            return userstatus.toString();
            }catch(Exception e){return "0";}
    }
    
    //Check email registered; param: email
    public String Check_Email(iconnectionpool connectionPools, String email){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select * from users where email='"+email+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer check_email = new StringBuffer();               
                if(rs.next()){check_email.append("true");}else{check_email.append("false");}
                connectionPools.releaseConnection(con);
            return check_email.toString();
            }catch(Exception e){return " ";}
    }
    
    //Check movie have seen and select similar movie; param: email
    public String Check_Moviehaveseen(iconnectionpool connectionPools, String movieID, String userID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select * from moviesimilarity where (movie1='"+movieID+"' or movie2='"+movieID+"') and userID='"+userID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer check_movie = new StringBuffer();               
                if(rs.next()){check_movie.append("true");}else{check_movie.append("false");}
                connectionPools.releaseConnection(con);
            return check_movie.toString();
            }catch(Exception e){return "abc";}
    }
    
    //Check movie have seen and select similar movie; param: email
    public String Check_Movie(iconnectionpool connectionPools, String movieID, String userID, String movie2){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select * from moviesimilarity where movie1='"+movieID+"' and userID='"+userID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer check_movie = new StringBuffer();               
                if(rs.next()){check_movie.append("0");}else{
                    String sql2="select * from moviesimilarity where movie1='"+movie2+"' and userID='"+userID+"'";            
                    Statement stmt2=con.createStatement();
                    ResultSet rs2 = stmt2.executeQuery(sql2);
                    if(rs2.next()){check_movie.append("1");}else{
                    check_movie.append("2");}
                }
                connectionPools.releaseConnection(con);
            return check_movie.toString();
            }catch(Exception e){return "4";}
    }
    
    //Check movie have seen and select similar movie; param: email
    public String get_MovieSimilarofUser(iconnectionpool connectionPools, String movieID, String userID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select movie2 from moviesimilarity where movie1='"+movieID+"' and userID='"+userID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer check_movie = new StringBuffer();               
                if(rs.next()){check_movie.append(rs.getString(1));}else{
                    String sql2="select movie1 from moviesimilarity where movie2='"+movieID+"' and userID='"+userID+"'";            
                    Statement stmt2=con.createStatement();
                    ResultSet rs2 = stmt2.executeQuery(sql2);
                    if(rs2.next()){check_movie.append(rs2.getString(1));}
                }
                connectionPools.releaseConnection(con);
            return check_movie.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get movies have seen all users
    public String MoviesHaveSeenAllUser(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from movie_have_seen";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return "0";}
    }
    
    //Get movies have seen by user
    public String MoviesHaveSeenByUser(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from movie_have_seen where userID='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get last submit by user
    public String LastSubmitByUser(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select datesubmit,ipclients from movie_have_seen where userID='"+userid+"' order by datesubmit desc";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get moivesimilarity all user
    public String MoviesSimilarityAllUser(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from moviesimilarity";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return "0";}
    }

    //Get moivesimilarity by user
    public String MoviesSimilarityByUser(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from moviesimilarity where userID='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer counting = new StringBuffer();               
                if(rs.next()){counting.append(rs.getString(1));}else{counting.append("0");}
                connectionPools.releaseConnection(con);
            return counting.toString();
            }catch(Exception e){return " ";}
    }
    
    //Get all movie
    public Vector get_All_Movie(iconnectionpool connectionPools){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select mid_id,subtitle,title,genre,director,actor,poster,plot from movies";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot;
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=rs.getString(2);
                title=rs.getString(3);                
                genre=rs.getString(4);
                director=rs.getString(5);
                actor=rs.getString(6);
                poster=rs.getString(7);                
                plot=rs.getString(8);
                
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get all users
    public Vector get_All_Users(iconnectionpool connectionPools){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select first_name,last_name,email,uname,id,img,groupid from users";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String firts_name,last_name,email,uname,id,img,groupid;
            while(rs.next()){
                firts_name=rs.getString(1);
                last_name=rs.getString(2);
                email=rs.getString(3);
                uname=rs.getString(4);
                id=rs.getString(5);
                img=rs.getString(6);
                groupid=rs.getString(7);
                
                String[] movie_info={firts_name,last_name,email,uname,id,img,groupid};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get random three movie
    public Vector get_Random_Three_Movie(iconnectionpool connectionPools, String userid){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id not in (select moviesID from movie_have_seen where userID='"+userid+"') and year_release > 2012 order by rand() limit 3 ";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot;
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=rs.getString(2);
                title=rs.getString(3);                
                genre=rs.getString(4);
                director=rs.getString(5);
                actor=rs.getString(6);
                poster=rs.getString(7);                
                plot=rs.getString(8);
                
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get all movie and pagiantion
    public Vector get_All_Movie_Pagination (iconnectionpool connectionPools, String PagesNumber, String ItemsPerPages){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();            
            int p=0;
            if(PagesNumber.equals("1")){p=1;}else{p=Integer.parseInt(PagesNumber)*Integer.parseInt(ItemsPerPages);}                     
            String sql="select mid_id,subtitle,title,genre,director,actor,poster,plot from movies order by year_release desc limit "+p+ ","+ItemsPerPages;
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot;
            while(rs.next()){                
                mid_id=rs.getString(1);
                subtitle=rs.getString(2);
                title=rs.getString(3);                
                genre=rs.getString(4);
                director=rs.getString(5);
                actor=rs.getString(6);
                poster=rs.getString(7);                
                plot=rs.getString(8);
                
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get all movie and pagiantion of user
    public Vector get_Activity_User_Pagination (iconnectionpool connectionPools, String PagesNumber, String ItemsPerPages, String userID){
        Vector thongtin=new Vector();
        try{
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();            
            Statement stmt2=con.createStatement();            
            int p=0;
            if(PagesNumber.equals("1")){p=0;}else{p=Integer.parseInt(PagesNumber)*Integer.parseInt(ItemsPerPages);}                     
            String sql="select moviesID,datesubmit,ipclients from movie_have_seen where userID='"+userID+"' order by datesubmit desc limit "+p+ ","+ItemsPerPages;
            ResultSet rs=stmt.executeQuery(sql);
            
            thongtin.clear();
            String subtitle1,title1,genre1,director1,actor1,poster1,mid_id1,plot1,
                   subtitle2=" ",title2=" ",genre2=" ",director2=" ",actor2=" ",poster2=" ",mid_id2=" ",plot2=" ",
                   datesubmithaveseen=" ",datesubmitsimilar=" ",ipclient=" ",valueofits=" "
                    ;
            while(rs.next()){                
                mid_id1=rs.getString(1);
                datesubmithaveseen=rs.getString(2);
                ipclient=rs.getString(3);
                String sql2 = "select movie2,valueofits,datesubmit from moviesimilarity where movie1='"+mid_id1+"' and userID='"+userID+"'";
                ResultSet rs2 = stmt2.executeQuery(sql2);
                if(rs2.next()){
                    mid_id2 = rs2.getString(1);
                    subtitle2=movieinfo.get_SubTitle(connectionPools, mid_id2);
                    title2=movieinfo.get_Title(connectionPools, mid_id2);                
                    genre2=movieinfo.get_Genre(connectionPools, mid_id2);
                    director2=movieinfo.get_Director(connectionPools, mid_id2);
                    actor2=movieinfo.get_Actor(connectionPools, mid_id2);
                    poster2=movieinfo.get_Poster(connectionPools, mid_id2);                
                    plot2=movieinfo.get_Plot(connectionPools, mid_id2);
                    valueofits=rs2.getString(2);
                    datesubmitsimilar = rs2.getString(3);
                }else{subtitle2=title2=genre2=director2=actor2=poster2=plot2=datesubmitsimilar=valueofits=" ";}
                subtitle1=movieinfo.get_SubTitle(connectionPools, mid_id1) ;
                title1=movieinfo.get_Title(connectionPools, mid_id1);                
                genre1=movieinfo.get_Genre(connectionPools, mid_id1);
                director1=movieinfo.get_Director(connectionPools, mid_id1);
                actor1=movieinfo.get_Actor(connectionPools, mid_id1);
                poster1=movieinfo.get_Poster(connectionPools, mid_id1);                
                plot1=movieinfo.get_Plot(connectionPools, mid_id1);
                                    //   0       1       2       3       4       5       6      7       8       9      10      11       12     13       14     15           16                17           18        19
                String[] movie_info={subtitle1,title1,genre1,director1,actor1,poster1,mid_id1,plot1,subtitle2,title2,genre2,director2,actor2,poster2,mid_id2,plot2,datesubmithaveseen,datesubmitsimilar,ipclient,valueofits};
                thongtin.addElement(movie_info);
            }
            connectionPools.releaseConnection(con);
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get movie search for homepage 
    public Vector get_NewMoviesSearch(iconnectionpool connectionPools, String titlesearch){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where title like '%"+titlesearch+"%' or actor like '%"+titlesearch+"%' or director like '%"+titlesearch+"%' order by year_release desc limit 100";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot;
            
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=rs.getString(2);
                title=rs.getString(3);                
                genre=rs.getString(4);
                director=rs.getString(5);
                actor=rs.getString(6);
                poster=rs.getString(7);                
                plot=rs.getString(8);                
                                  
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot};
                thongtin.addElement(movie_info);
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get movie search for havesean page 
    public Vector get_NewMoviesSearchHaveSean(iconnectionpool connectionPools, String titlesearch, String movieID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id!='"+movieID+"' and (title like '%"+titlesearch+"%' or actor like '%"+titlesearch+"%' or director like '%"+titlesearch+"%')";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,sum_score;
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            //Get info of movie have seen
            String title_movie_selected = movieinfo.get_Title(connectionPools, movieID);
            String genre_movie_selected = movieinfo.get_Genre(connectionPools, movieID);
            String director_movie_selected = movieinfo.get_Director(connectionPools, movieID);
            String actor_movie_selected = movieinfo.get_Actor(connectionPools, movieID);
            String plot_movie_selected = movieinfo.get_Plot(connectionPools, movieID);
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=rs.getString(2);
                title=rs.getString(3);                
                genre=rs.getString(4);
                director=rs.getString(5);
                actor=rs.getString(6);
                poster=rs.getString(7);                
                plot=rs.getString(8);
                
                Double score_title = calculateJ.calculateJaccardSimilarity(title_movie_selected, title);
                Double score_genre = calculateJ.calculateJaccardSimilarity(genre_movie_selected, genre);
                Double score_director = calculateJ.calculateJaccardSimilarity(director_movie_selected, director);
                Double score_actor = calculateJ.calculateJaccardSimilarity(actor_movie_selected, actor);
                Double score_plot = calculateJ.calculateJaccardSimilarity(plot_movie_selected, plot);
                
                sum_score="title:"+score_title+"-genre:"+score_genre+"-director:"+score_director+"-actor:"+score_actor+"-plot:"+score_plot;                     
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot,sum_score};
                thongtin.addElement(movie_info);
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get movie user have seen
    public Vector get_MovieUserHaveSeen(iconnectionpool connectionPools, String userID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select moviesID,datesubmit,ipclients from movie_have_seen a where userID='"+userID+"' order by id desc";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,datesubmit, ipclients ;
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=movieinfo.get_SubTitle(connectionPools, mid_id);
                title=movieinfo.get_Title(connectionPools, mid_id);
                genre=movieinfo.get_Genre(connectionPools, mid_id);
                director=movieinfo.get_Director(connectionPools, mid_id);
                actor=movieinfo.get_Actor(connectionPools, mid_id);
                poster=movieinfo.get_Poster(connectionPools, mid_id);                
                plot=movieinfo.get_Plot(connectionPools, mid_id);
                datesubmit=rs.getString(2);
                ipclients=rs.getString(3);                               
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot,datesubmit,ipclients};
                thongtin.addElement(movie_info);
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }    
    
    //Get similarity movies
    public Vector get_MovieSimilarityUserHaveSeen(iconnectionpool connectionPools, String userID, String movieID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select movie2,datesubmit,valueofits,timesofrefresh from moviesimilarity where userID='"+userID+"' and movie1='"+movieID+"'";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,datesubmit,valueofits,timesofrefresh;
            while(rs.next()){
                mid_id=rs.getString(1);
                subtitle=movieinfo.get_SubTitle(connectionPools, mid_id);
                title=movieinfo.get_Title(connectionPools, mid_id);
                genre=movieinfo.get_Genre(connectionPools, mid_id);
                director=movieinfo.get_Director(connectionPools, mid_id);
                actor=movieinfo.get_Actor(connectionPools, mid_id);
                poster=movieinfo.get_Poster(connectionPools, mid_id);                
                plot=movieinfo.get_Plot(connectionPools, mid_id);
                datesubmit=rs.getString(2);
                valueofits=rs.getString(3);
                if(rs.getString(4).equals("00")){timesofrefresh="import IMDB";}else{
                    if(rs.getString(4).equals("000")){timesofrefresh="Explore";}else{
                    timesofrefresh = rs.getString(4) + " refresh";}
                }
                
                String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot,datesubmit,valueofits,timesofrefresh};
                thongtin.addElement(movie_info);
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    
    //Get random 6 similarity movies
    public Vector get_Random6MovieSimilarityUserHaveSeen(iconnectionpool connectionPools, String userID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            
            String sql="select userID, movie1, movie2, datesubmit, valueofits, timesofrefresh from moviesimilarity "
                    + "where userID!="+userID+" and movie1 not in (select movie1 from moviesimilarity where userID="+userID+") order by rand() limit 6";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String 
                id1,subtitle1,title1,genre1,director1,actor1,poster1,plot1,
                id2,subtitle2,title2,genre2,director2,actor2,poster2,plot2,
                userid,datesubmit,valueofits,timesofrefresh,username,email,userimg;
            getUsers userinfo = new getUsers();
            while(rs.next()){
                userid=rs.getString(1);id1=rs.getString(2);id2=rs.getString(3);
                
                //content of movie 1
                subtitle1=movieinfo.get_SubTitle(connectionPools, id1);
                title1=movieinfo.get_Title(connectionPools, id1);
                genre1=movieinfo.get_Genre(connectionPools, id1);
                director1=movieinfo.get_Director(connectionPools, id1);
                actor1=movieinfo.get_Actor(connectionPools, id1);
                poster1=movieinfo.get_Poster(connectionPools, id1);                
                plot1=movieinfo.get_Plot(connectionPools, id1);
                
                //content of movie 2
                subtitle2=movieinfo.get_SubTitle(connectionPools, id2);
                title2=movieinfo.get_Title(connectionPools, id2);
                genre2=movieinfo.get_Genre(connectionPools, id2);
                director2=movieinfo.get_Director(connectionPools, id2);
                actor2=movieinfo.get_Actor(connectionPools, id2);
                poster2=movieinfo.get_Poster(connectionPools, id2);                
                plot2=movieinfo.get_Plot(connectionPools, id2);
                
                //information of user                
                username = userinfo.getUsername(connectionPools, userid);
                email = userinfo.getEmail(connectionPools, userid);
                userimg = userinfo.getImg(connectionPools, userid);
                //information of selection
                datesubmit=rs.getString(4);
                valueofits=rs.getString(5);
                timesofrefresh=rs.getString(6);
                if(rs.getString(6).equals("00")){timesofrefresh="import IMDB";}else{timesofrefresh = rs.getString(6) + " refresh";}
                
                String[] movie_info={id1,subtitle1,title1,genre1,director1,actor1,poster1,plot1,id2,subtitle2,title2,genre2,director2,actor2,poster2,plot2,userid,datesubmit,valueofits,timesofrefresh,username,email,userimg};
                thongtin.addElement(movie_info);
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get predict 30 moives
    public Vector get_Predict_30Movie(iconnectionpool connectionPools, String movieID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String title_movie_selected = movieinfo.get_Title(connectionPools, movieID);
            String genre_movie_selected = movieinfo.get_Genre(connectionPools, movieID);
            String director_movie_selected = movieinfo.get_Director(connectionPools, movieID);
            String actor_movie_selected = movieinfo.get_Actor(connectionPools, movieID);
            String plot_movie_selected = movieinfo.get_Plot(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,sum_score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];            
            int i=0;
            rs.first();
            do{ 
                Double score_title = calculateJ.calculateJaccardSimilarity(title_movie_selected, rs.getString(3));
                Double score_genre = calculateJ.calculateJaccardSimilarity(genre_movie_selected, rs.getString(4));
                Double score_director = calculateJ.calculateJaccardSimilarity(director_movie_selected, rs.getString(5));
                Double score_actor = calculateJ.calculateJaccardSimilarity(actor_movie_selected, rs.getString(6));
                Double score_plot = calculateJ.calculateJaccardSimilarity(plot_movie_selected, rs.getString(8));
                String sumscore = score_title + score_genre + score_director + score_actor + score_plot+"";
                array_score[i] = sumscore+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
                           
            for(int k=0;k<5;k++){
                String[] a = array_score[k].split("-");
                mid_id = a[1];sum_score=a[0];
                String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                Statement stmt_movie_info = con.createStatement();
                ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                if(rs_movie_info.next()){
                    subtitle=rs_movie_info.getString(2);
                    title=rs_movie_info.getString(3);
                    genre=rs_movie_info.getString(4);
                    director=rs_movie_info.getString(5);
                    actor=rs_movie_info.getString(6);
                    poster=rs_movie_info.getString(7);                
                    plot=rs_movie_info.getString(8);

                    String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, sum_score+""};
                    thongtin.addElement(movie_info);               
                }               
            }
        
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get predict 5 moives
    public Vector get_Predict_5Movie(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String sql_info_movie_selected = "select title,genre,director,actor,plot from movies where mid_id='"+movieID+"'";
            Statement stmt1 = con.createStatement();
            ResultSet rs1  = stmt1.executeQuery(sql_info_movie_selected);
            String title_movie_selected="",genre_movie_selected="", director_movie_selected="", actor_movie_selected="", plot_movie_selected="";       
            if(rs1.next()){
                title_movie_selected = rs1.getString(1);
                genre_movie_selected = rs1.getString(2);
                director_movie_selected = rs1.getString(3);
                actor_movie_selected = rs1.getString(4);
                plot_movie_selected = rs1.getString(5);
            }
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id!='"+movieID+"' order by year_release desc limit 3000";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,sum_score;
            
            //Count movies
            //int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[3000];
            int i=0;
            rs.first();
            do{ 
                Double score_title = calculateJ.calculateJaccardSimilarity(title_movie_selected, rs.getString(3));
                Double score_genre = calculateJ.calculateJaccardSimilarity(genre_movie_selected, rs.getString(4));
                Double score_director = calculateJ.calculateJaccardSimilarity(director_movie_selected, rs.getString(5));
                Double score_actor = calculateJ.calculateJaccardSimilarity(actor_movie_selected, rs.getString(6));
                Double score_plot = calculateJ.calculateJaccardSimilarity(plot_movie_selected, rs.getString(8));
                String sumscore = score_title + score_genre + score_director + score_actor + score_plot+"";
                array_score[i] = sumscore+"-"+rs.getString(1)+"-"+score_title+"-"+score_genre+"-"+score_director+"-"+score_actor+"-"+score_plot;     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
            if(randnum==0){
            
            for(int k=0;k<5;k++){
                String[] a = array_score[k].split("-");
                mid_id = a[1];sum_score="title:"+a[2]+"-genre:"+a[3]+"-director:"+a[4]+"-actor:"+a[5]+"-plot:"+a[6];
                String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                Statement stmt_movie_info = con.createStatement();
                ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                if(rs_movie_info.next()){
                    subtitle=rs_movie_info.getString(2);
                    title=rs_movie_info.getString(3);
                    genre=rs_movie_info.getString(4);
                    director=rs_movie_info.getString(5);
                    actor=rs_movie_info.getString(6);
                    poster=rs_movie_info.getString(7);                
                    plot=rs_movie_info.getString(8);

                    String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, sum_score+""};
                    thongtin.addElement(movie_info);               
                }               
            }
            
            }else{
                for(int k=randnum;k<5+randnum;k++){
                    String[] a = array_score[k].split("-");
                    mid_id = a[1];sum_score="title:"+a[2]+"-genre:"+a[3]+"-director:"+a[4]+"-actor:"+a[5]+"-plot:"+a[6];
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, sum_score+""};
                        thongtin.addElement(movie_info);               
                    }               
                }
            }
        
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }
    
    //Get predict moives by title
    public Vector get_Predict_Movie_by_Title(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String title_movie_selected = movieinfo.get_Title(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,title from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];           
            int i=0;
            rs.first();
            do{                                
                array_score[i] = calculateJ.calculateJaccardSimilarity(title_movie_selected, rs.getString(2))+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
                
                String[] a = array_score[randnum].split("-");
                mid_id = a[1];score=a[0];
                if(Double.parseDouble(score)>0.9){
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, score+""};
                        thongtin.addElement(movie_info);               
                    }
                }
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    } 
    
    //Get predict moives by genre
    public Vector get_Predict_Movie_by_Genre(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String genre_movie_selected = movieinfo.get_Genre(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,genre from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];            
            int i=0;
            rs.first();
            do{                                
                array_score[i] = calculateJ.calculateJaccardSimilarity(genre_movie_selected, rs.getString(2))+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
                
                String[] a = array_score[randnum].split("-");
                mid_id = a[1];score=a[0];
                if(Double.parseDouble(score)>0.9){
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, score+""};
                        thongtin.addElement(movie_info);               
                    }                
                }
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    } 
    
    //Get predict moives by director
    public Vector get_Predict_Movie_by_Director(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String director_movie_selected = movieinfo.get_Director(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,director from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];            
            int i=0;
            rs.first();
            do{                               
                array_score[i] = calculateJ.calculateJaccardSimilarity(director_movie_selected, rs.getString(2))+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
                       
                String[] a = array_score[randnum].split("-");
                mid_id = a[1];score=a[0];
                if(Double.parseDouble(score)>0.9){
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, score+""};
                        thongtin.addElement(movie_info);               
                    }                
                }
        
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    } 
    
    //Get predict moives by actor
    public Vector get_Predict_Movie_by_Actor(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String title_movie_selected = movieinfo.get_Actor(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,actor from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];            
            int i=0;
            rs.first();
            do{                                
                array_score[i] = calculateJ.calculateJaccardSimilarity(title_movie_selected, rs.getString(2))+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
            
                String[] a = array_score[randnum].split("-");
                mid_id = a[1];score=a[0];
                if(Double.parseDouble(score)>0.9){
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, score+""};
                        thongtin.addElement(movie_info);               
                    }                
                }                
            
        
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    } 
    
    //Get predict moives by plot
    public Vector get_Predict_Movie_by_Plot(iconnectionpool connectionPools, String movieID, int randnum){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            
            //Get title of movie user selected
            String title_movie_selected = movieinfo.get_Plot(connectionPools, movieID);
            
            //Get title of all movies in database
            Statement stmt = con.createStatement();
            String sql = "select mid_id,plot from movies where mid_id!='"+movieID+"'";
            ResultSet rs = stmt.executeQuery(sql);
            thongtin.clear();
            JaccardSimilarity calculateJ = new JaccardSimilarity();
            String subtitle,title,genre,director,actor,poster,mid_id,plot,score;
            
            //Count movies
            int numberofmovies = Integer.parseInt(movieinfo.countMovies(connectionPools))-1;
            
            //Create new array include score of JaccardSimilarity
            String[] array_score = new String[numberofmovies];            
            int i=0;
            rs.first();
            do{                                
                array_score[i] = calculateJ.calculateJaccardSimilarity(title_movie_selected, rs.getString(2))+"-"+rs.getString(1);     
                i++;
            }while(rs.next());
            
            Arrays.sort(array_score, Collections.reverseOrder());
            
                String[] a = array_score[randnum].split("-");
                mid_id = a[1];score=a[0];
               if(Double.parseDouble(score)>0.9){
                    String sql_movie_info = "select mid_id,subtitle,title,genre,director,actor,poster,plot from movies where mid_id='"+mid_id+"'";
                    Statement stmt_movie_info = con.createStatement();
                    ResultSet rs_movie_info = stmt_movie_info.executeQuery(sql_movie_info);
                    if(rs_movie_info.next()){
                        subtitle=rs_movie_info.getString(2);
                        title=rs_movie_info.getString(3);
                        genre=rs_movie_info.getString(4);
                        director=rs_movie_info.getString(5);
                        actor=rs_movie_info.getString(6);
                        poster=rs_movie_info.getString(7);                
                        plot=rs_movie_info.getString(8);

                        String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot, score+""};
                        thongtin.addElement(movie_info);               
                    }                
                }                
            
        
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    } 
    
    
    //Get movie from database for suggest trend of user
    public Vector get_Movies_MovieMaps(iconnectionpool connectionPools, String movieID){
        Vector thongtin=new Vector();
        try{            
            Connection con=null;
            con=connectionPools.getConnection();
            Statement stmt=con.createStatement();
            String sql="select movie1,movie2,userID,valueofits from moviesimilarity where movie1='"+movieID+"'or movie2='"+movieID+"'";
            ResultSet rs=stmt.executeQuery(sql);
            thongtin.clear();
            String subtitle,title,genre,director,actor,poster,mid_id="",plot,userid, valueofits, username;
            while(rs.next()){
                String movie1=rs.getString(1);
                String movie2=rs.getString(2);                
                if(movie1.equals(movieID)){mid_id=movie2;}else{mid_id=movie1;}
                if(movie2.equals(movieID)){mid_id=movie1;}else{mid_id=movie2;}                
                if(mid_id.equals(movieID)){}else{
                    subtitle=movieinfo.get_SubTitle(connectionPools, mid_id);
                    title=movieinfo.get_Title(connectionPools, mid_id);
                    genre=movieinfo.get_Genre(connectionPools, mid_id);
                    director=movieinfo.get_Director(connectionPools, mid_id);
                    actor=movieinfo.get_Actor(connectionPools, mid_id);
                    poster=movieinfo.get_Poster(connectionPools, mid_id);                
                    plot=movieinfo.get_Plot(connectionPools, mid_id);
                    userid=rs.getString(3);
                    username=userinfo.getUsername(connectionPools, userid);
                    valueofits=rs.getString(4);
                    
                    //calculate score of each selection
                    String[] a = valueofits.split("-");
                    String[] T = a[0].split(":");String[] G = a[1].split(":");String[] D = a[2].split(":");String[] A = a[3].split(":");String[] P = a[4].split(":");
                    Double scoreT = Double.parseDouble(T[1]);Double scoreG = Double.parseDouble(G[1]);Double scoreD = Double.parseDouble(D[1]);Double scoreA = Double.parseDouble(A[1]);Double scoreP = Double.parseDouble(P[1]);
                    
                    Double value=round(scoreT+scoreG+scoreD+scoreA+scoreP,3);
                    
                    
                    //insert to vector
                    String[] movie_info={subtitle,title,genre,director,actor,poster,mid_id,plot,username,value+""};
                    thongtin.addElement(movie_info);                
                }
            }                       
        }catch(Exception e){
            System.out.println(e);
        }
        return thongtin;
    }    
}
