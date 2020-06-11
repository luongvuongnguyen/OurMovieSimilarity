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
getMovieInfo movies = new getMovieInfo();
Vector MovieList = getMovieInfo.get_All_Users(connectionPool);
Enumeration Enum_MovieList = MovieList.elements();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta http-equiv="Content-Language" content="en" />
        <meta name="msapplication-TileColor" content="#2d89ef">
        <meta name="theme-color" content="#4188c9">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <link href="img/oms-logo-32-32.png" rel="icon">
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
        <!-- Generated: 2018-04-16 09:29:05 +0200 -->
        <title>OMS | OurMovieSimilarity</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">        
        <script src="assets/js/autocomplete/jquery-1.12.4.js"></script>
        <link href="assets/css/dashboard.css" rel="stylesheet" />
        <style>
            @import url(https://fonts.googleapis.com/css?family=Droid+Sans);
            .loader {
                    position: fixed;
                    left: 0px;
                    top: 0px;
                    width: 100%;
                    height: 100%;
                    z-index: 9999;
                    
            }
        </style>
        <script>
            $(window).load(function(){
                    $('.loader').fadeOut();
            });
        </script>
        <!-- Chart -->
        <script src="chart-js/chart.js"></script>        
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>
        <div class="page-main">                       
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="clear-fix"></div>
                    <div class="row row-cards">
                        <div class="col">
                            <div class="row">
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                        <div class="d-flex align-items-center">
                                            <span class="stamp stamp-md bg-blue mr-3">
                                              <i class="fe fe-layers"></i>
                                            </span>
                                            <div>
                                              <h4 class="m-0"><a href="javascript:void(0)"><%=movies.countMovies(connectionPool)%><small> Movies</small></a></h4>
                                              <small class="text-muted"><%=movies.countMoviesToday(connectionPool)%> new addition today</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                    <div class="d-flex align-items-center">
                                      <span class="stamp stamp-md bg-red mr-3">
                                        <i class="fe fe-users"></i>
                                      </span>
                                      <div>
                                          <h4 class="m-0"><a href="javascript:void(0)"><%=movies.countUsers(connectionPool)%> <small>Members</small></a></h4>
                                        <small class="text-muted"><%=movies.countUsersToday(connectionPool)%> registered today</small>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-6 col-lg-3">
                                <div class="card p-3">
                                  <div class="d-flex align-items-center">
                                    <span class="stamp stamp-md bg-green mr-3">
                                      <i class="fe fe-activity"></i>
                                    </span>
                                    <div>
                                        <h4 class="m-0"><a href="javascript:void(0)"><%=getMovieInfo.MoviesHaveSeenAllUser(connectionPool)%> <small>Have seen movies</small></a></h4>
                                        <small class="text-muted"><%=getMovieInfo.MoviesSimilarityAllUser(connectionPool)%> Similar movies</small>
                                    </div>
                                  </div>
                                </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card p-3">
                                      <div class="d-flex align-items-center">
                                        <span class="stamp stamp-md bg-yellow mr-3">
                                          <i class="fe fe-message-square"></i>
                                        </span>
                                        <div>
                                            <h4 class="m-0"><a href="javascript:void(0)"><%=movies.countTimesofRefreshAllUsers(connectionPool)%> <small>Number of refreshes</small></a></h4>
                                            <small class="text-muted"><%=movies.getUserHighestRefresh(connectionPool)%></small>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                            </div>                                
                            <%int i=0;while(Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement();%>
                            <div class="card">                                
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-3">
                                            <p class="nav-link pr-0 leading-none">                                                
                                            <span class="avatar" style="background-image: url(img/profile/<%=tmp_MovieList[5]%>)">
                                                <%String user = getMovieInfo.Check_User_Status(connectionPool, tmp_MovieList[4]);if(user.equals("1")){;%>
                                                <span class="avatar-status bg-green"></span>
                                                <%}else{%>
                                                <span class="avatar-status"></span>
                                                <%}%>
                                            </span>
                                            <span class="ml-2 d-none d-lg-block">                                                
                                                <span class="text-default"><%=tmp_MovieList[3]%></span>
                                                <small class="text-muted d-block mt-1"><%=tmp_MovieList[2]%></small>
                                            </span>
                                            </p>
                                            <div class="row">
                                                <table class="table table-responsive-sm">
                                                    <tr>
                                                        <td>Movies have seen</td>
                                                        <td>: <%=getMovieInfo.MoviesHaveSeenByUser(connectionPool, tmp_MovieList[4]) %></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Movie similarity</td>
                                                        <td>: <%=getMovieInfo.MoviesSimilarityByUser(connectionPool, tmp_MovieList[4]) %></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            
                                            <a class="btn btn-outline-primary btn-sm" href="oms_08_all_activity_details.jsp?userid=<%=tmp_MovieList[4]%>"><span class="fa fa-user "></span> Show details</a> 
                                        </div>
                                        <div class="col-9">
                                            <canvas id="chartjs-<%=i%>" class="chartjs"  height="80px" width="400"></canvas>
                                            <%getDataToCreateChart newchart = new getDataToCreateChart();
                                            Vector chartbydateofuser = newchart.get_DatesubmitByUser(connectionPool, tmp_MovieList[4]);
                                            Enumeration Enum_chartbydateofuser = chartbydateofuser.elements();String valuedata="";%>
                                            <script>
                                                new Chart(document.getElementById("chartjs-<%=i%>"),{
                                                    "type":"line",
                                                    "data":{
                                                            "labels": 
                                                            [
                                                            <% while(Enum_chartbydateofuser.hasMoreElements()){String[] tmp_chartbydateofuser = (String[]) Enum_chartbydateofuser.nextElement();                                                            
                                                                valuedata = valuedata+newchart.CountMoviesHaveSeenByUser(connectionPool, tmp_MovieList[4], tmp_chartbydateofuser[0])+",";%>
                                                                "<%=tmp_chartbydateofuser[0]%>",
                                                            <%}%>
                                                            ],
                                                            "datasets":[{
                                                                "label":"Movies have seen",
                                                                "data":[<%=valuedata%>],
                                                                "fill":false,
                                                                "borderColor":"rgb(75, 192, 192)",
                                                                "lineTension":0.1
                                                            }]},
                                                    "options":{}
                                                });
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%i++;}%>
                        </div>                          
                    </div>
                    
                                    
                    
                    
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>        
    </div>
    </body>
</html>
<%}%>