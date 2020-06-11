<%-- 
    Document   : index
    Created on : Jan 5, 2019, 2:32:02 PM
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
Vector MovieList = getMovieInfo.get_MovieUserHaveSeen(connectionPool, users.getIduser()) ;
Enumeration Enum_MovieList = MovieList.elements();%>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>        
                      
        <script src="assets/js/balloontip.js"></script> 
        <link href="assets/css/balloontip.css" rel="stylesheet" />
        <script src="chart-js/d3.js"></script> 
        <script src="chart-js/d3.min.js"></script> 
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
                        <div class="card-body" style="text-align: center">
                            <form class="input-icon my-3 my-lg-0" action="" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">
                                        <input type="text" class="form-control" placeholder="Input title of movies..." name="titlesearch" id="autosearch">
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                    </span>                                                                     
                                </div>
                            </div>
                            </form>
                        </div>
                        </div>
                    </div>                    
                    <div class="row row-cards">
                        <div class="col">
                            <div class="card-body">                                    
                                <%int i=1;
                                while(Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement();%>
                                <a href="oms_02_movie_map_details.jsp?idmovie=<%=tmp_MovieList[6]%>" rel="balloonmovie<%=i%>"><img src="<%=tmp_MovieList[5]%>" style="height:120px;width: 80px;border-bottom: 2px solid whitesmoke"></a>
                                    <div id="balloonmovie<%=i%>" class="balloonstyle">                                                        
                                            <strong><%=tmp_MovieList[1].toUpperCase()%></strong><br><br>                                                                                                                         
                                            <div style="text-align: center"><img src="<%=tmp_MovieList[5]%>" style="width: 200px;border-bottom: 2px solid whitesmoke"></div>
                                            <strong>GENRE</strong>: <%=tmp_MovieList[2]%><br>                                                                
                                            <strong>DIRECTOR</strong>: <%=tmp_MovieList[3]%><br>
                                            <strong>ACTOR</strong>: <%=tmp_MovieList[4]%><br>
                                    </div>
                                <%i++;}%>   
                            </div>
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