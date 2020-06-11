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
getMovieInfo movieinfo = new getMovieInfo();
%>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>        
        <script language="javascript" type="text/javascript">
            function getFormPages(action){
                document.formpages.action=action;
                document.formpages.submit();}
        </script>
        <script src="assets/js/balloontip.js"></script> 
        <link href="assets/css/balloontip.css" rel="stylesheet" />
    </head>
    <body>    
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>     
        <div class="page-main">                   
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="page-header">
                        <h1 class="page-title">ALL MOVIES</h1>
                        <div class="page-subtitle"><%=movieinfo.countMovies(connectionPool) %> movies in our database</div>
                        <div class="page-options d-flex">                            
                            <div class="input-icon ml-2">
                                <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/searchmovie" method="post">
                                <div class="form-group" >
                                    <div class="row gutters-xs">                                    
                                        <div class="col">
                                            <input type="text" class="form-control" placeholder="Search movies..." name="titlesearch" id="autosearch">
                                        </div>
                                        <span class="col-auto">
                                            <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                        </span>
                                        <input type="hidden" name="typeofsearch" value="allmovie">                                    
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>                    
                    <%if(request.getParameter("search").equals("true")){String titlesearch=request.getParameter("titlesearch"); 
                    Vector NewMovieSearch = getMovieInfo.get_NewMoviesSearch(connectionPool, titlesearch) ;
                    Enumeration Enum_NewMovieSearch = NewMovieSearch.elements();int i=0;%>
                    <div class="row row-cards">                       
                        <%int count=0;while (Enum_NewMovieSearch.hasMoreElements()){String[] tmp_Enum_NewMovieSearch = (String[]) Enum_NewMovieSearch.nextElement();%>                                    
                        <div class="col-6 col-sm-4 col-lg-2">
                            <div class="card">
                                <div class="card-body p-3 text-center" style="height:195px">                                    
                                    <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_Enum_NewMovieSearch[1]%></div>
                                    <a href="" rel="balloonmovie<%=i%>"><div class="h1 m-0" style="height:130px;background-position: center;background-size: cover;background-image: url(<%=tmp_Enum_NewMovieSearch[5]%>);"></div></a>
                                        
                                        <div id="balloonmovie<%=i%>" class="balloonstyle">                                                        
                                            <strong><%=tmp_Enum_NewMovieSearch[1].toUpperCase()%></strong><br><br>                                                                                                                         
                                            <strong>GENRE</strong>: <%=tmp_Enum_NewMovieSearch[2]%><br>                                                                
                                            <strong>DIRECTOR</strong>: <%=tmp_Enum_NewMovieSearch[3]%><br>
                                            <strong>ACTOR</strong>: <%=tmp_Enum_NewMovieSearch[4]%><br>
                                        </div>
                                    <div class="text-muted mb-4" style="height: 1.5em;margin-top: 2px"><a href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=tmp_Enum_NewMovieSearch[6]%>" class="btn btn-outline-primary btn-sm">Have seen</a></div>
                                </div>
                            </div>
                        </div>
                        <%count++;i++;}%>
                    </div>
                    <%if(count==0){%>
                    <div class="row">
                        <div class="col">
                            <div class="alert alert-danger" role="alert">No results of movies for keyword:  <code><%=titlesearch%></code></div>                                        
                        </div>
                    </div>
                    <%}%>
                    <%}else{%>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="pagination">
                                <%String PagesNumber = request.getParameter("pages"); String ItemPerPages="18";
                                int totalPages = Integer.parseInt(movieinfo.countMovies(connectionPool))/Integer.parseInt(ItemPerPages);%>
                                
                                <a href="?search&pages=1" class="page-link"><span class="fe fe-chevrons-left"></span></a>                                
                                <%if(PagesNumber.equals("1")){%>
                                <a href="?search&pages=1" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                <%}else{%>
                                <a href="?search&pages=<%=Integer.parseInt(PagesNumber)-1%>" class="page-link"><span class="fe fe-chevron-left"></span></a>
                                <%}%>
                                
                                <form action="" method="post" onchange="getFormPages('oms_04_allmovie.jsp?search')" name="formpages">
                                <select name="pages" class="form-control custom-select">
                                    <%for(int k=1;k<=totalPages;k++){%>
                                    <option value="<%=k%>" <%if(k==Integer.parseInt(PagesNumber)){out.print("selected");}else{}%>>Page <%=k%> of <%=totalPages%></option>
                                    <%}%>
                                </select>                            
                                </form> 
                                
                                <%if(PagesNumber.equals(totalPages+"")){%>
                                <a href="?search&pages=<%=totalPages%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                <%}else{%>
                                <a href="?search&pages=<%=Integer.parseInt(PagesNumber)+1%>" class="page-link"><span class="fe fe-chevron-right"></span></a>
                                <%}%>
                                <a href="?search&pages=<%=totalPages%>" class="page-link"><span class="fe fe-chevrons-right"></span></a>    
                            </div>
                        </div>
                        <div class="col-md-6">
                            
                        </div>
                    </div>
                    <div class="clear-fix">&nbsp;</div>
                    <div class="row row-cards">                        
                        <%Vector MovieList = getMovieInfo.get_All_Movie_Pagination(connectionPool,PagesNumber,ItemPerPages);
                        Enumeration Enum_MovieList = MovieList.elements();int k=0;
                        while(Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement();%>                         
                        <div class="col-6 col-sm-4 col-lg-2">
                            <div class="card">
                                <div class="card-body p-3 text-center" style="height:195px">                                    
                                    <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=tmp_MovieList[1]%></div>
                                    <a href="" rel="balloonmoviek<%=k%>"><div class="h1 m-0" style="height:130px;background-position: center;background-size: cover;background-image: url(<%=tmp_MovieList[5]%>);" ></div></a>
                                        <div id="balloonmoviek<%=k%>" class="balloonstyle"> 
                                            <strong><%=tmp_MovieList[1]%></strong><br><br>
                                            <strong>GENRE</strong>: <%=tmp_MovieList[2]%><br>                                                                 
                                            <strong>DIRECTOR</strong>: <%=tmp_MovieList[3]%><br>
                                            <strong>ACTOR</strong>: <%=tmp_MovieList[4]%><br>
                                        </div>
                                    <div class="text-muted mb-4" style="height: 1.5em;margin-top: 2px"><a href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=tmp_MovieList[6]%>" class="btn btn-outline-primary btn-sm">Have seen</a></div>
                                </div>
                            </div>
                        </div>
                        <%k++;}%>
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