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
//Create connect to database
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
Connection con=null;
con=connectionPool.getConnection();
getFromDatabase getMovieInfo = new getFromDatabase();
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
        <script src="assets/js/balloontip.js"></script> 
        <link href="assets/css/balloontip.css" rel="stylesheet" />
        <script language="javascript" type="text/javascript">
            function getFormPages(action){
                document.formpages.action=action;
                document.formpages.submit();}
        </script>
        
        
    </head>
    <body>    
    <div class="page">
        <div class="page-main">
            <jsp:include page="include_header.jsp" flush="true"/>
            
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="page-header">
                        <h1 class="page-title">
                        MY ACTIVITY
                        </h1>
                    </div>
                    
            <div class="row row-cards">
                <div class="col-lg-12">
                    <div class="pagination">
                        <%String PagesNumber = request.getParameter("pages"); String ItemPerPages="4";
                        int totalPages = Integer.parseInt(movieinfo.countMoviesHaveSeenofUser(connectionPool, users.getIduser()))/Integer.parseInt(ItemPerPages);%>                                
                        <a href="?pages=1" class="page-link"><span class="fe fe-chevrons-left"></span></a>                                
                        <%if(PagesNumber.equals("1")){%>
                            <a href="?pages=1" class="page-link"><span class="fe fe-chevron-left"></span></a>
                        <%}else{%>
                            <a href="?pages=<%=Integer.parseInt(PagesNumber)-1%>" class="page-link"><span class="fe fe-chevron-left"></span></a>
                        <%}%>                                
                        <form action="" method="post" onchange="getFormPages('oms_03_my_activity.jsp')" name="formpages">
                            <select name="pages" class="form-control custom-select">
                                <%for(int k=1;k<=totalPages;k++){%>
                                <option value="<%=k%>" <%if(k==Integer.parseInt(PagesNumber)){out.print("selected");}else{}%>>Page <%=k%> of <%=totalPages%></option>
                                <%}%>
                            </select>                            
                        </form>                                 
                        <%if(PagesNumber.equals(totalPages+"")){%>
                            <a href="?pages=<%=totalPages%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                        <%}else{%>
                            <a href="?pages=<%=Integer.parseInt(PagesNumber)+1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                        <%}%>
                        <a href="?pages=<%=totalPages%>" class="page-link"><span class="fe fe-chevrons-right"></span></a> 
                    </div>
                    <div class="clear-fix">Total: <%=movieinfo.countMoviesHaveSeenofUser(connectionPool, users.getIduser()) %> activities.<br></div>
                </div>
                <div class="col-lg-9">                
                    <div class="card">                    
                        <table class="table card-table table-hover table-vcenter">
                            <%Vector MovieList = getMovieInfo.get_Activity_User_Pagination(connectionPool, PagesNumber, ItemPerPages, users.getIduser());
                            Enumeration Enum_MovieList = MovieList.elements();int i=1;
                            while(Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement();%> 
                            <tr>                                
                                <td><a href="" rel="balloonmovie1<%=i%>"><img src="<%=tmp_MovieList[5]%>" alt="" style="width:80px;"></a>
                                <div id="balloonmovie1<%=i%>" class="balloonstyle"><b><%=tmp_MovieList[0].toUpperCase()%></b><br><b>Genre</b>: <%=tmp_MovieList[2]%><br><b>Director</b>: <%=tmp_MovieList[3]%><br><b>Actor</b>: <%=tmp_MovieList[4]%></div>
                                </td>
                                <td>
                                    <%if(tmp_MovieList[13].equals(" ")){}else{%>
                                    <div id="balloonmovie2<%=i%>" class="balloonstyle"><b><%=tmp_MovieList[8].toUpperCase()%></b><br><b>Genre</b>: <%=tmp_MovieList[10]%><br><b>Director</b>: <%=tmp_MovieList[11]%><br><b>Actor</b>: <%=tmp_MovieList[12]%></div>    
                                    <a href="" rel="balloonmovie2<%=i%>"><img src="<%=tmp_MovieList[13]%>" alt="" style="width:80px;"></a>
                                    <%}%>
                                </td>
                                <td>
                                    <%if(tmp_MovieList[19].equals(" ")){}else{String[] arg = tmp_MovieList[19].split("-");String[] title_score=arg[0].split(":");String[] genre_score=arg[1].split(":");String[] director_score=arg[2].split(":");String[] actor_score=arg[3].split(":");String[] plot_score=arg[4].split(":");%>                                                            

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
                                <td class="text-right text-muted d-none d-md-table-cell text-nowrap">
                                    <b>Date submit movie have seen</b><br>
                                    <%=tmp_MovieList[16]%><br>
                                    <%if(tmp_MovieList[17].equals(" ")){%><br><br><%}else{%>
                                    <b>Date submit similar movie</b><br>
                                    <%=tmp_MovieList[17]%><br>
                                    <%}%>
                                    <b>Ip address</b><br>
                                    <%=tmp_MovieList[18]%>
                                </td>                            
                                <td class="text-right">
                                    <%if(tmp_MovieList[17].equals(" ")){%>
                                    <form action="<%=request.getContextPath()%>/submitToDatabase">
                                        <input type="hidden" name="userID" value="<%=users.getIduser()%>"> 
                                        <input type="hidden" name="action" value="haveseen">
                                        <input type="hidden" name="id" value="<%=tmp_MovieList[6]%>">                                    
                                        <button type="submit" class="btn btn-primary btn-sm"><i class="fe fe-eye"></i> Select</button>
                                    </form>
                                    <br> 
                                    <form action="<%=request.getContextPath()%>/deleteFromDatabase">
                                        <input type="hidden" name="userID" value="<%=users.getIduser()%>"> 
                                        <input type="hidden" name="pages" value="<%=PagesNumber%>">
                                        <input type="hidden" name="movieID" value="<%=tmp_MovieList[6]%>">
                                        <input type="hidden" name="action" value="delHaveseenMyActivity">
                                        <button type="submit" class="btn btn-danger btn-sm"><i class="fe fe-trash-2"></i> Delete</button>
                                    </form> 
                                    <%}else{%>
                                    <form action="<%=request.getContextPath()%>/deleteFromDatabase">
                                        <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                        <input type="hidden" name="pages" value="<%=PagesNumber%>">
                                        <input type="hidden" name="movieID" value="<%=tmp_MovieList[6]%>">
                                        <input type="hidden" name="action" value="delSimilarMyActivity">
                                        <button type="submit" class="btn btn-danger btn-sm"><i class="fe fe-trash-2"></i> Delete</button>
                                    </form>
                                    <%}%>
                                </td>
                            </tr>
                            <%i++;}%>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="row">
                        <div class="col-md-6 col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Trend of selection</h5>
                                </div>
                                <div class="card-body" style="height:250px">
                                    <canvas id="chartjs" class="chartjs"  height="300px"></canvas>
                                            <%getDataToCreateChart newchart = new getDataToCreateChart();
                                            Vector trendofuser = newchart.get_Trend_of_User(connectionPool, users.getIduser());
                                            Enumeration Enum_trendofuser = trendofuser.elements();String valuedata="";%>
                                            <script>
                                                new Chart(document.getElementById("chartjs"),{
                                                    "type":"line",
                                                    "data":{
                                                            "labels": 
                                                            ["T","G","D","A","P",],
                                                            "datasets":[{
                                                                "label":"Score",
                                                                "data":[
                                                                    <% while(Enum_trendofuser.hasMoreElements()){String[] tmp_trendofuser = (String[]) Enum_trendofuser.nextElement();%>
                                                                        "<%=tmp_trendofuser[0]%>","<%=tmp_trendofuser[1]%>","<%=tmp_trendofuser[2]%>","<%=tmp_trendofuser[3]%>","<%=tmp_trendofuser[4]%>",
                                                                    <%}%>],
                                                                "fill":true,
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
            </div>            
        </div>
            <jsp:include page="include_footer.jsp" flush="true"/>       
    </div>
    </body>
</html>
<%}%>