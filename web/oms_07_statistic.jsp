<%-- 
    Document   : index
    Created on : Jan 5, 2019, 2:32:02 PM
    Author     : VUONG NGUYEN
--%>
<%@page import="java.util.Enumeration"%>
<%@page import="database.*"%>
<%@page import="java.util.Vector"%>
<%@page import="model.getDataToCreateChart"%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
getDataToCreateChart newchart = new getDataToCreateChart();
Vector chartbydateofuser = newchart.get_DatesubmitByUser(connectionPool, users.getIduser());
Enumeration Enum_chartbydateofuser = chartbydateofuser.elements();
String valuedata="";
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
                            <div class="card">
                                <div class="card-header"><div class="card-title">Statistic</div></div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-3">
                                                                                   
                                        </div>
                                        <div class="col-9">
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                          
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <canvas id="chartjs-0" class="chartjs"  height="80px" width="400"></canvas>
                                        <script>
                                            new Chart(document.getElementById("chartjs-0"),{
                                                "type":"line",
                                                "data":{
                                                        "labels": 
                                                        [
                                                        <% while(Enum_chartbydateofuser.hasMoreElements()){String[] tmp_chartbydateofuser = (String[]) Enum_chartbydateofuser.nextElement();                                                            
                                                            valuedata = valuedata+newchart.CountMoviesHaveSeenByUser(connectionPool, users.getIduser(), tmp_chartbydateofuser[0])+",";%>
                                                            "<%=tmp_chartbydateofuser[0]%>",
                                                        <%}%>
                                                        ],
                                                        "datasets":[{
                                                            "label":"Comments of video",
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
                </div>
            </div>
        </div>
            <jsp:include page="include_footer.jsp" flush="true"/>        
    </div>
    </body>
</html>
<%}%>