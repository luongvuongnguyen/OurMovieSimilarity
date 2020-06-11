<%-- 
    Document   : index
    Created on : Jan 5, 2019, 2:32:02 PM
    Author     : VUONG NGUYEN
--%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.*,model.*,java.util.Vector, java.util.Enumeration,java.sql.*" %>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");
//Create connect to database
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
Connection con=null;
con=connectionPool.getConnection();

getFromDatabase getInfo = new getFromDatabase();
Vector InfoList = getInfo.get_Random6MovieSimilarityUserHaveSeen(connectionPool, users.getIduser());
Enumeration Enum_getInfo = InfoList.elements();%>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/> 
        <script src="assets/js/bootstrap.js"></script>        
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>
        <div class="page-main">                       
            <div class="my-3 my-md-5">
                <div class="container">
                
                    <div class="page-header">
                    <h1 class="page-title">EXPLORE ANOTHER USERS</h1>                    
                    <div class="page-subtitle">1 - 6 of <%=getInfo.MoviesSimilarityAllUser(connectionPool)%> activities<br>
                    </div>
                    <div class="page-options d-flex">                        
                        <div class="input-icon ml-2">
                            <span class="input-icon-addon"><i class="fe fe-search"></i></span>
                            <input type="text" class="form-control w-10" placeholder="Search users">
                        </div>
                    </div>
                    <small>These are the activities of other users. If you agree with them press "Yes" and press "No" to choose another similar movie if you disagree.</small>
                    </div>
                    <div class="row row-cards">
                        <%while (Enum_getInfo.hasMoreElements()){String[] tmp_getInfo = (String[]) Enum_getInfo.nextElement();%>
                        <div class="col-sm-6 col-lg-4">
                            <form action="<%=request.getContextPath()%>/submitToDatabase" method="post" onsubmit="return validate(this)">
                            <div class="card p-3">
                                <div class="row">
                                <div class="col-md-6">
                                    <div class="hvrbox">
                                        <img src="<%=tmp_getInfo[6]%>" class="hvrbox-layer_bottom" style="height:220px"/>
                                        <div class="hvrbox-layer_top">
                                            <div class="hvrbox-text" style="width:95%;font-size: 8pt">                                                        
                                                <strong style="text-align: center;font-size: 10pt"><%=tmp_getInfo[2].toUpperCase()%></strong><br><br>
                                                <strong>GENRE</strong>: <%=tmp_getInfo[3]%><br>                                                                 
                                                <strong>DIRECTOR</strong>: <%=tmp_getInfo[4]%><br>
                                                <strong>ACTOR</strong>: <%=tmp_getInfo[5]%><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="hvrbox">
                                        <img src="<%=tmp_getInfo[14]%>" class="hvrbox-layer_bottom" style="height:220px"/>
                                        <div class="hvrbox-layer_top">
                                            <div class="hvrbox-text" style="width:95%;font-size: 8pt">  
                                                <strong style="text-align: center;font-size: 10pt"><%=tmp_getInfo[10].toUpperCase()%></strong><br><br>
                                                <strong>GENRE</strong>: <%=tmp_getInfo[11]%><br>                                                                 
                                                <strong>DIRECTOR</strong>: <%=tmp_getInfo[12]%><br>
                                                <strong>ACTOR</strong>: <%=tmp_getInfo[13]%><br>
                                            </div>
                                        </div>
                                    </div>            
                                </div> 
                                </div>
                                <div class="d-flex align-items-center px-2">
                                    <div class="avatar avatar-md mr-3" style="background-image: url(img/profile/<%=tmp_getInfo[22]%>)"></div>
                                    <div>
                                        <div><%=tmp_getInfo[20]%></div>
                                        <small class="d-block text-muted"><%=tmp_getInfo[21]%></small>
                                    </div>
                                    <div class="ml-auto text-muted">                                        
                                        <input type="hidden" name="movie1" value="<%=tmp_getInfo[0]%>">
                                        <input type="hidden" name="movie2" value="<%=tmp_getInfo[8]%>">
                                        <input type="hidden" name="action" value="submitexplore">
                                        <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                        <input type="hidden" name="valueofits" value="<%=tmp_getInfo[18]%>">
                                        <button class="btn btn-outline-primary btn-sm" type="submit"><small><i class="fe fe-check"></i>Yes</small></button>
                                        <a class="btn btn-outline-primary btn-sm" href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=tmp_getInfo[0]%>"><small><i class="fe fe-x"></i>No</small></a>
                                    </div>
                                </div>
                            </div>
                            </form>
                        </div>
                        <%}%>
                    </div>
                    <div class="row">
                        <div class="col" align="center">
                            <a href="oms_06_explore.jsp" type="button" value="Explore" class="btn btn-primary" style="width:150px"> Explore </a>
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