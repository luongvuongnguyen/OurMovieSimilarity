<%-- 
    Document   : oms_02_movie_map_details
    Created on : May 29, 2019, 4:25:40 PM
    Author     : VUONG NGUYEN
--%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");//Create connect to database
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
getFromDatabase getMovieInfo = new getFromDatabase();
String movieID = request.getParameter("idmovie");
Vector MovieList = getMovieInfo.get_Movies_MovieMaps(connectionPool, movieID);
Enumeration Enum_MovieList = MovieList.elements();
getMovieInfo movieinfo = new getMovieInfo();
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
        <link rel="stylesheet" href="assets/css/macy.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">
        
        <script src="assets/js/autocomplete/jquery-1.12.4.js"></script>
        
        <script>
          requirejs.config({
              baseUrl: '.'
          });
        </script>
        <link href="assets/css/dashboard.css" rel="stylesheet" />
        <link href="assets/css/hoverbox.css" rel="stylesheet" />
        <script src="assets/js/dashboard.js"></script>       
        
        <!-- Input Mask Plugin -->
        <script src="assets/plugins/input-mask/plugin.js"></script>
        <!-- Auto Complete Plugin -->        
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
</head>
<body>
    <jsp:include page="include_header.jsp" flush="true"/>    
    <main class="main" role="main">        
        <section class="section">
            <div class="container">
                <table>
                    <tr>
                        <td style="text-align: justify;vertical-align:top;width: 110px"><img src="<%=movieinfo.get_Poster(connectionPool, movieID)%>" style="width:100px"></td>
                        <td style="text-align: justify;vertical-align:top;font-size:10pt">
                            <strong><%=movieinfo.get_Title(connectionPool, movieID).toUpperCase()%></strong><br><br>
                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, movieID) %><br>                                                         
                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, movieID) %><br>
                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, movieID) %><br>
                            <strong>PLOT</strong>: <%=movieinfo.get_Plot(connectionPool, movieID) %><br>                            
                        </td>
                    </tr>
                </table>                
            </div>
        </section>
        <section class="section" >            
            <div class="container">                                
                <div id="macy-container">                    
                    <%int i=1;
                        while(Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement(); 
                        double randomDouble = Math.random();randomDouble = randomDouble * 130 + 50;int randomInt = (int) randomDouble;%>
                        <div style="width:<%=randomInt%>px"><img src="<%=tmp_MovieList[5]%>" class="demo-image" style="width:<%=randomInt%>px" > <%=tmp_MovieList[8]%> <br><%=tmp_MovieList[9]%> </div>
                    <%i++;}%>   
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="include_footer.jsp" flush="true"/>   
  <script src="assets/js/macy.js"></script>
    <script>
        var masonry = new Macy({
            container: '#macy-container',
            trueOrder: true,
            waitForImages: true,
            useOwnImageLoader: false,
            debug: true,
            mobileFirst: true,
            columns: 1,
            margin: {
                y: 16,
                x: '1%',
            },
            breakAt: {
                1200: 6,
                940: 5,
                520: 3,
                400: 2
            },
        });
    </script>
</body>
</html>
<%}%>
