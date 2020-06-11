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
String search=request.getParameter("search");
getFromDatabase getMovieInfo = new getFromDatabase();
Vector MovieList = getMovieInfo.get_Random_Three_Movie(connectionPool, users.getIduser());
Enumeration Enum_MovieList = MovieList.elements();
Vector AllMovieList = getMovieInfo.get_All_Movie(connectionPool);
Enumeration Enum_AllMovieList = AllMovieList.elements();%>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/>        
        <script>
        $( function() {
            var availableTags = [
                <%while(Enum_AllMovieList.hasMoreElements()){String[] tmp_Enum_AllMovieList = (String[]) Enum_AllMovieList.nextElement();%>
                    "<%=tmp_Enum_AllMovieList[1]%>",                
                <%}%>
            ];
            $( "#autosearch" ).autocomplete({
                source: function(request, response) {
                    var results = $.ui.autocomplete.filter(availableTags, request.term);
                    response(results.slice(0, 20));
                }
            });
        } );
        </script>
    </head>
    <body>
    <div class="page">
        <jsp:include page="include_header.jsp" flush="true"/>
        <div class="page-main">
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-8"><h2>WHAT MOVIE HAVE YOU SEEN?<br><small style="font-size:14pt">If you have not seen any movies, please click "Refresh"</small></h2></div>
                        <div class="col-md-4">
                            <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/searchmovie" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">
                                        <input type="text" class="form-control" placeholder="Search title of movies..." name="titlesearch" id="autosearch" required="">
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                        <a class="btn btn-secondary" href="oms_01_home.jsp?idmovie=0/0/0/0/0&search=true&titlesearch=addnewmovies"><i class="fe fe-plus"></i> Add from IMDB</a>
                                    </span>
                                    <input type="hidden" name="typeofsearch" value="newmovie">                                    
                                </div>
                            </div>
                            </form>
                        </div>                        
                    </div>
                    <%if(search.equals("true")){String titlesearch=request.getParameter("titlesearch");%>
                    <div class="row">
                        <%Vector NewMovieSearch = getMovieInfo.get_NewMoviesSearch(connectionPool, titlesearch) ;
                        Enumeration Enum_NewMovieSearch = NewMovieSearch.elements();int i=0;	
                        while (Enum_NewMovieSearch.hasMoreElements()){String[] tmp_Enum_NewMovieSearch = (String[]) Enum_NewMovieSearch.nextElement();%>
                        <div class="col-md-6 col-xl-4">
                            <div class="card">
                                <div class="card-header"><h3 class="card-title"><%=tmp_Enum_NewMovieSearch[0]%></h3></div>
                                <div class="card-body" align="center">
                                    <div class="hvrbox">
                                        <img src="<%=tmp_Enum_NewMovieSearch[5]%>" class="hvrbox-layer_bottom" style="height:360px"/>
                                        <div class="hvrbox-layer_top">
                                            <div class="hvrbox-text" style="width:95%;font-size: 9pt">
                                                <table class="table table-bordered table-striped" style="width:100%">
                                                    <tr style="height:30px"><td>GENRE</td><td><%=tmp_Enum_NewMovieSearch[2]%></td</tr>                                                                      
                                                    <tr style="height:30px"><td>DIRECTOR</td><td colspan="3"><%=tmp_Enum_NewMovieSearch[3]%></td></tr>
                                                    <tr style="height:60px"><td>ACTOR</td><td colspan="3"><%=tmp_Enum_NewMovieSearch[4]%></td></tr>
                                                </table>                                                
                                            </div>
                                        </div>
                                    </div>                                
                                </div>
                                <div class="card-footer" align="center"><a type="button" class="btn btn-danger" href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=tmp_Enum_NewMovieSearch[6]%>"> Have seen </a></div>
                            </div>
                        </div>
                        <%i++;}%>                        
                    </div>
                    <%if(i==0){String arrayidmovie = request.getParameter("idmovie");%>
                    <div class="row">
                        <div class="col">
                        <div class="alert alert-danger" role="alert">
                            <%if(titlesearch.equals("addnewmovies")){}else{%>
                            No results of movies title for keyword:  <code><%=titlesearch%></code>. 
                            <%}%>
                            If there's a movie that you think should be in the OMS, go ahead and add it.</div>                                        
                        </div>
                    </div>
                        
                    <div class="row">
                        <div class="col-md-6">
                            <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/oms_01_home.jsp" method="get">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    ư
                                    <div class="col">                                        
                                        <input type="url" class="form-control" placeholder="Find the movie you want to add on IMDb and enter its URL" name="idmovie" id="autosearch" pattern="https://www.imdb.com/title/.*"  required >                                        
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                        <input type="hidden" name="search" value="true">  
                                        <input type="hidden" name="titlesearch" value="<%=titlesearch%>">                                          
                                    </span>                                                                      
                                </div>wdawdasdasd
                            </div>
                            </form>
                        </div>
                        <div  class="col-md-6">
                            <input type="text" class="form-control" value="Example of valid IMDb url: https://www.imdb.com/title/tt0114709/" disabled="disabled">                                       
                        </div>  
                    </div>                        
                        <%if(arrayidmovie.equals("0/0/0/0/0")){%>
                            <div class="row">                        
                                <div class="col-lg-6"> </div> 
                                <div class="col-lg-6">
                                    <div class="card">
         ư                               <div class="card-header"><h3 class="card-title">Guidelines</h3></div>
                                        <div class="card-body" style="text-align: justify">
                                        <p>If there's a movie that you think should be in OMS, go ahead and add it!</p>
                                        <p>We'd like you to observe the following guidelines when adding movies to OMS.</p>
                                        <p>
                                        <ul>
                                            <li>The movie must have an entry on the Internet Movie Database (<a href="//imdb.com" target="_blank">IMDb</a>). We need an "official list" of movies in order to help prevent duplicate movie entries, and to provide you with a link to get more information about movies we recommend.</li>
                                            <li>The movie should be widely available (e.g., from video rental services, in theaters, or at stores). It can be frustrating to get recommendations for movies that are obscure and hard to find.</li>
                                            <li>The movie should not be a distant future release. We'd prefer that movies not be added to OMS until within a week of their general release.</p></li>
                                        </ul>
                                        <br><br>    
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%}else{ String[] array = arrayidmovie.split("/");                        
                        String idmovie=array[4];                        
                        String a="http://www.omdbapi.com/?i="+idmovie+"&plot=full&apikey=72b3ca58";
                        URL urlabc = new URL(a);
                        URLConnection conn = urlabc.openConnection();

                        // open the stream and put it into BufferedReader
                        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                        String inputLine="",jsondata="";          
                        String mid_id="",subtitle="",title="",year_release="",genre="",director="",actor="",poster="",plotafterJaccard="",plot=""; 
                        while ((inputLine = br.readLine()) != null) {
                            jsondata=inputLine;
                        }

                        JSONObject obj = new JSONObject(jsondata);
                        mid_id=obj.getString("imdbID");            
                        title = obj.getString("Title"); 
                        year_release=obj.getString("Year");
                        subtitle=obj.getString("Title")+" ("+year_release+")";
                        genre=obj.getString("Genre");
                        director=obj.getString("Director");
                        actor=obj.getString("Actors");
                        poster=obj.getString("Poster");
                        plotafterJaccard="";
                        plot=obj.getString("Plot");
                        String today=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());  
                        insertToDatabase newmovie = new insertToDatabase();
                        newmovie.InsertNewMovies(connectionPool, mid_id, subtitle, title, year_release, genre, director, actor, poster, plotafterJaccard, plot, today);%>
                            <div class="row">                        
                                <div class="col-lg-6"> 
                                    <div class="card">
                                        <div class="card-header"><h3 class="card-title"><%=title%></h3></div>
                                        <div class="card-body" align="center">
                                            <div class="hvrbox">
                                                <img src="<%=poster%>" class="hvrbox-layer_bottom" style="height:260px"/>
                                                <div class="hvrbox-layer_top">
                                                    <div class="hvrbox-text" style="width:95%;font-size: 8pt">
                                                        <table class="table table-bordered table-striped" style="width:100%">
                                                            <tr style="height:30px"><td>GENRE</td><td><%=genre%></td</tr>                                                                      
                                                            <tr style="height:30px"><td>DIRECTOR</td><td colspan="3"><%=director%></td></tr>
                                                            <tr style="height:60px"><td>ACTOR</td><td colspan="3"><%=actor%></td></tr>
                                                        </table>                                                
                                                    </div>
                                                </div>
                                            </div>                                
                                        </div>
                                        <div class="card-footer" align="center"><a type="button" class="btn btn-danger" href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=mid_id%>"> Have seen </a></div>
                                    </div>
                                </div> 
                                <div class="col-lg-6">
                                    <div class="card">
                                        <div class="card-header"><h3 class="card-title">Guidelines</h3></div>
                                        <div class="card-body" style="text-align: justify">
                                        <p>If there's a movie that you think should be in OMS, go ahead and add it!</p>
                                        <p>We'd like you to observe the following guidelines when adding movies to OMS.</p>
                                        <p>
                                        <ul>
                                            <li>The movie must have an entry on the Internet Movie Database (<a href="//imdb.com" target="_blank">IMDb</a>). We need an "official list" of movies in order to help prevent duplicate movie entries, and to provide you with a link to get more information about movies we recommend.</li>
                                            <li>The movie should be widely available (e.g., from video rental services, in theaters, or at stores). It can be frustrating to get recommendations for movies that are obscure and hard to find.</li>
                                            <li>The movie should not be a distant future release. We'd prefer that movies not be added to OMS until within a week of their general release.</p></li>
                                        </ul>
                                        <br><br>    
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%}%>

                        <%}%>
                    <%}else{%>
                    <div class="row">
                        <%while (Enum_MovieList.hasMoreElements()){String[] tmp_MovieList = (String[]) Enum_MovieList.nextElement();%>
                        <div class="col-md-6 col-xl-4">
                            <div class="card">
                                <div class="card-header"><h3 class="card-title"><%=tmp_MovieList[0]%></h3></div>
                                <div class="card-body" align="center">
                                    <div class="hvrbox">
                                        <img src="<%=tmp_MovieList[5]%>" class="hvrbox-layer_bottom" style="height:360px"/>
                                        <div class="hvrbox-layer_top">
                                            <div class="hvrbox-text" style="width:95%;font-size: 9pt">
                                                <table class="table table-bordered table-striped" style="width:100%">
                                                    <tr style="height:30px"><td>GENRE</td><td><%=tmp_MovieList[2]%></td</tr>                                                                      
                                                    <tr style="height:30px"><td>DIRECTOR</td><td colspan="3"><%=tmp_MovieList[3]%></td></tr>
                                                    <tr style="height:60px"><td>ACTOR</td><td colspan="3"><%=tmp_MovieList[4]%></td></tr>
                                                </table>                                                
                                            </div>
                                        </div>
                                    </div>                                
                                </div>
                                <div class="card-footer" align="center"><a type="button" class="btn btn-danger" href="<%=request.getContextPath()%>/submitToDatabase?userID=<%=users.getIduser()%>&action=haveseen&id=<%=tmp_MovieList[6]%>"> Have seen </a></div>
                            </div>
                        </div>
                        <%}%>                        
                    </div>
                    <%}%>
                    <div class="row">
                        <div class="col" align="center">
                            <a href="oms_01_home.jsp?search" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Refresh </a>
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