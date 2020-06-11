<%-- 
    Document   : index
    Created on : Jan 5, 2019, 2:32:02 PM
    Author     : VUONG NGUYEN
--%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
getFromDatabase getMovieInfo = new getFromDatabase();
getUsers getUserInfo = new getUsers();%>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>   
        <script src="assets/js/chart/Chart.js"></script>
        <script src="assets/js/chart/Chart.min.js"></script>
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>
        <div class="page-main">                       
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="clear-fix"></div>
                    <%if(request.getParameter("userid").equals("")){}else{String userid = request.getParameter("userid");%>
                    <div class="row row-cards">
                        <div class="col-4">
                            <div class="card">
                                <div class="card-body p-3 ">
                                    <a href="" class="nav-link pr-0 leading-none">
                                        <span class="avatar" style="background-image: url(img/profile/<%=getUserInfo.getImg(connectionPool, userid)%>)"></span>
                                        <span class="ml-2 d-none d-lg-block">
                                            <span class="text-default"><%=getUserInfo.getUsername(connectionPool, userid) %></span>
                                            <small class="text-muted d-block mt-1"><%=getUserInfo.getEmail(connectionPool, userid) %></small>
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-lg-2">
                            <div class="card">
                                <div class="card-body p-3">
                                    <a href="" class="nav-link pr-0 leading-none">                                        
                                        <span class="ml-2 d-none d-lg-block">
                                            <span class="text-default"><%=getMovieInfo.MoviesHaveSeenByUser(connectionPool, userid) %></span>
                                            <small class="text-muted d-block mt-1">Movies have seen</small>
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-lg-2">
                            <div class="card">
                                <div class="card-body p-3 ">
                                    <a href="" class="nav-link pr-0 leading-none">                                        
                                        <span class="ml-2 d-none d-lg-block">
                                            <span class="text-default"><%=getMovieInfo.MoviesSimilarityByUser(connectionPool, userid) %></span>
                                            <small class="text-muted d-block mt-1">Movie Similarity</small>
                                        </span>
                                    </a>                                  
                                </div>
                            </div>
                        </div>                                                
                    </div>
                                    
                    <div class="row">
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <div id="mynetwork" style="border: 1px solid lightgray;height:460px; overflow: auto">                                        
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>                                                
                                                    <th>#</th>
                                                    <th>Movie have seen</th>
                                                    <th>Movie similarity</th>
                                                    <th>Status</th>
                                                    <th>IP Adress/Datesubmit</th>                                                                                                
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%Vector MovieListUser = getMovieInfo.get_MovieUserHaveSeen(connectionPool, request.getParameter("userid"));
                                                Enumeration Enum_MovieListUser = MovieListUser.elements();
                                                int i=1;
                                                while(Enum_MovieListUser.hasMoreElements()){String[] tmp_MovieListUser = (String[]) Enum_MovieListUser.nextElement();String timesrefresh=" ", valueofits=" ";%>                                                
                                                    <tr>                                                
                                                        <td><%=i%></td>
                                                        <td style="width:300px">
                                                            <%=tmp_MovieListUser[0].toUpperCase()%>
                                                            <table style="width:100%;">
                                                                <tr>
                                                                    <td rowspan="3" width="40%" ><img src="<%=tmp_MovieListUser[5]%>"></td>
                                                                    <td style="font-size:7.5pt"><strong>GENRE</strong>:<%=tmp_MovieListUser[2]%></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size:7.5pt"><strong>DIRECTOR</strong>:<%=tmp_MovieListUser[3]%></td>
                                                                </tr>
                                                                <tr>
                                                                   <td style="font-size:7.5pt"><strong>ACTOR</strong>:<%=tmp_MovieListUser[4]%></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width:300px">
                                                            <%Vector MovieSimilarityList = getMovieInfo.get_MovieSimilarityUserHaveSeen(connectionPool, request.getParameter("userid"), tmp_MovieListUser[6]);
                                                            Enumeration Enum_MovieSimilarityList = MovieSimilarityList.elements();
                                                            while(Enum_MovieSimilarityList.hasMoreElements()){String[] tmp_MovieSimilarityList = (String[]) Enum_MovieSimilarityList.nextElement();%>                                               
                                                            <%=tmp_MovieSimilarityList[0].toUpperCase()%>
                                                            <table style="width:100%;">
                                                                <tr>
                                                                    <td rowspan="3" width="40%" ><img src="<%=tmp_MovieSimilarityList[5]%>"></td>
                                                                    <td style="font-size:7.5pt"><strong>GENRE</strong>:<%=tmp_MovieSimilarityList[2]%></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-size:7.5pt"><strong>DIRECTOR</strong>:<%=tmp_MovieSimilarityList[3]%></td>
                                                                </tr>
                                                                <tr>
                                                                   <td style="font-size:7.5pt"><strong>ACTOR</strong>:<%=tmp_MovieSimilarityList[4]%></td>
                                                                </tr>
                                                            </table>
                                                            <%timesrefresh=tmp_MovieSimilarityList[10];valueofits = tmp_MovieSimilarityList[9];}%>
                                                        </td>
                                                        <td>
                                                            <%if(timesrefresh.equals(" ")){}else{%>
                                                            <p class="btn btn-outline-primary btn-sm"><%=timesrefresh%></p>
                                                            <%}%>
                                                            <%if(valueofits.equals(" ")){}else{String[] arg = valueofits.split("-");String[] title_score=arg[0].split(":");String[] genre_score=arg[1].split(":");String[] director_score=arg[2].split(":");String[] actor_score=arg[3].split(":");String[] plot_score=arg[4].split(":");%>                                                            
                                                            
                                                            <div class="clearfix"><div class="float-left"><strong>Title</strong></div><div class="float-right"><small class="text-muted"><%=getMovieInfo.round(Double.parseDouble(title_score[1]),3)%></small></div></div>
                                                            <div class="progress progress-xs"><div class="progress-bar bg-blue" role="progressbar" style="width: <%=getMovieInfo.round(Double.parseDouble(title_score[1]),3)*100%>%" aria-valuenow="<%=getMovieInfo.round(Double.parseDouble(title_score[1]),3)*100%>" aria-valuemin="0" aria-valuemax="100"></div></div>
                                                            
                                                            <div class="clearfix"><div class="float-left"><strong>Genre</strong></div><div class="float-right"><small class="text-muted"><%=getMovieInfo.round(Double.parseDouble(genre_score[1]),3)%></small></div></div>
                                                            <div class="progress progress-xs"><div class="progress-bar bg-blue" role="progressbar" style="width: <%=getMovieInfo.round(Double.parseDouble(genre_score[1]),3)*100%>%" aria-valuenow="<%=getMovieInfo.round(Double.parseDouble(genre_score[1]),3)*100%>" aria-valuemin="0" aria-valuemax="100"></div></div>
                                                            
                                                            <div class="clearfix"><div class="float-left"><strong>Director</strong></div><div class="float-right"><small class="text-muted"><%=getMovieInfo.round(Double.parseDouble(director_score[1]),3)%></small></div></div>
                                                            <div class="progress progress-xs"><div class="progress-bar bg-blue" role="progressbar" style="width: <%=getMovieInfo.round(Double.parseDouble(director_score[1]),3)*100%>%" aria-valuenow="<%=getMovieInfo.round(Double.parseDouble(director_score[1]),3)*100%>" aria-valuemin="0" aria-valuemax="100"></div></div>
                                                            
                                                            <div class="clearfix"><div class="float-left"><strong>Actor</strong></div><div class="float-right"><small class="text-muted"><%=getMovieInfo.round(Double.parseDouble(actor_score[1]),3)%></small></div></div>
                                                            <div class="progress progress-xs"><div class="progress-bar bg-blue" role="progressbar" style="width: <%=getMovieInfo.round(Double.parseDouble(actor_score[1]),3)*100%>%" aria-valuenow="<%=getMovieInfo.round(Double.parseDouble(actor_score[1]),3)*100%>" aria-valuemin="0" aria-valuemax="100"></div></div>  
                                                            
                                                            <div class="clearfix"><div class="float-left"><strong>Plot</strong></div><div class="float-right"><small class="text-muted"><%=getMovieInfo.round(Double.parseDouble(plot_score[1]),3)%></small></div></div>
                                                            <div class="progress progress-xs"><div class="progress-bar bg-blue" role="progressbar" style="width: <%=getMovieInfo.round(Double.parseDouble(plot_score[1]),3)*100%>%" aria-valuenow="<%=getMovieInfo.round(Double.parseDouble(plot_score[1]),3)*100%>" aria-valuemin="0" aria-valuemax="100"></div></div>
                                                            <%}%>
                                                        </td>
                                                        <td>
                                                            <div class="small text-muted"><%=tmp_MovieListUser[9]%></div>
                                                            <div><%=tmp_MovieListUser[8]%></div>
                                                        </td>
                                                    </tr>
                                                <%i++;}%>
                                            </tbody>
                                         </table>                                        
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col" align="center">
                            <a href="oms_08_all_activity.jsp?userid" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Back </a>
                        </div>                        
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>        
    </div>
    </body>
</html>
<%}%>