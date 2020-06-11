package model;

import database.iconnectionpool;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author VUONG NGUYEN
 */
public class getMovieInfo {
    public String get_Genre(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select genre from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Year_Release(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select year_release from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Title(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select title from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_SubTitle(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select subtitle from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Director(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select director from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer director = new StringBuffer();               
                if(rs.next()){director.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return director.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Actor(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select actor from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Plot(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select plot from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    public String get_Poster(iconnectionpool connectionPools, String movieID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select poster from movies where mid_id='"+movieID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of movies in Database
    public String countMovies(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(mid_id) from movies";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of movies have seen of user in Database
    public String countMoviesHaveSeenofUser(iconnectionpool connectionPools, String userID){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from movie_have_seen where userID='"+userID+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of movies in Database today
    public String countMoviesToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());  
                String sql="select count(mid_id) from movies where dateadd like '%"+today+"%'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of users in Database
    public String countUsers(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(id) from users";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count times of refresh page
    public String countTimesofRefreshAllUsers(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select sum(timesofrefresh) from moviesimilarity where timesofrefresh!=' '";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Highest refresh times of refresh page
    public String getUsername(iconnectionpool connectionPools, String userid){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="SELECT uname FROM users where id='"+userid+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){
                    countmovies.append(rs.getString(1));
                }
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Highest refresh times of refresh page
    public String getUserHighestRefresh(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select timesofrefresh, userid from moviesimilarity order by timesofrefresh desc";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){
                    countmovies.append(getUsername(connectionPools, rs.getString(2))+": "+rs.getString(1)+" times");
                }
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return " ";}
    }
    
    //Count number of users register today
    public String countUsersToday(iconnectionpool connectionPools){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());                           
                //String today = "2019-04-08";
                String sql="select count(id) from users where regdate like '%"+today+"%'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer countmovies = new StringBuffer();               
                if(rs.next()){countmovies.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return countmovies.toString();
            }catch(Exception e){return "0";}
    }
    
    //Count number of movies by years in Database
    public String get_CountNumberofMovies_By_Years(iconnectionpool connectionPools, String year_release){
            try{
                Connection con=null;
                con=connectionPools.getConnection();
                String sql="select count(mid_id) from movies where year_release='"+year_release+"'";            
                Statement stmt=con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);                
                StringBuffer info = new StringBuffer();               
                if(rs.next()){info.append(rs.getString(1));}
                connectionPools.releaseConnection(con);
            return info.toString();
            }catch(Exception e){return " ";}
    }
    
}
