<%-- 
    Document   : test
    Created on : Mar 12, 2019, 2:32:40 PM
    Author     : VUONG NGUYEN
--%>
<%@page import="model.JaccardSimilarity"%>
<%@page import="java.sql.Statement"%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page import="model.getMovieInfo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.simpleconnectionpool"%>
<%@page import="database.iconnectionpool"%>
<%@page import="database.common"%>
<%@page import="model.insertToDatabase"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");
String driver = common.driver,url = common.url,username = common.username,password = common.password;
iconnectionpool connectionPool = (iconnectionpool) application.getAttribute("getMovie");
if (connectionPool == null) {try {Class.forName(driver); } catch (Exception e) {out.println(e);}
connectionPool = new simpleconnectionpool(url, username, password);application.setAttribute("getMovie", connectionPool);}
Connection con=null;
con=connectionPool.getConnection();
String arrayidmovie = request.getParameter("idmovie");
String idmoviehaveseen = request.getParameter("idmoviehaveseen");
getMovieInfo movieinfo = new getMovieInfo();%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="include_header_head.jsp" flush="true"/>
        <style type="text/css">
            #dhtmltooltip{
            position: absolute;
            width: 150px;
            border: 2px solid black;
            padding: 2px;
            background-color: lightyellow;
            visibility: hidden;
            z-index: 100;
            /*Remove below line to remove shadow. Below line should always appear last within this CSS*/
            filter: progid:DXImageTransform.Microsoft.Shadow(color=gray,direction=135);
            }
            #ck-button input {
                position:absolute;
                top:-2000px;
                border-radius:10px;
            }
            #ck-button input:checked + span {
                background-color:#4188c9;
                color:#fff;
            }
        </style>  
    </head>
    <body>
        <div id="dhtmltooltip"></div>
    <script type="text/javascript">

/***********************************************
* Cool DHTML tooltip script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Please keep this notice intact
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

var offsetxpoint=-60 //Customize x offset of tooltip
var offsetypoint=20 //Customize y offset of tooltip
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
if (ie||ns6)
var tipobj=document.all? document.all["dhtmltooltip"] : document.getElementById? document.getElementById("dhtmltooltip") : ""
document.body.appendChild(tipobj)

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function ddrivetip(thetext, thecolor, thewidth){
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
tipobj.innerHTML=thetext
enabletip=true
return false
}
}

function positiontip(e){
if (enabletip){
var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;
//Find out how close the mouse is to the corner of the window
var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20
var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20

var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<tipobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
tipobj.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj.offsetWidth+"px"
else if (curX<leftedge)
tipobj.style.left="5px"
else
//position the horizontal position of the menu where the mouse is positioned
tipobj.style.left=curX+offsetxpoint+"px"

//same concept with the vertical position
if (bottomedge<tipobj.offsetHeight)
tipobj.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj.offsetHeight-offsetypoint+"px"
else
tipobj.style.top=curY+offsetypoint+"px"
tipobj.style.visibility="visible"
}
}

function hideddrivetip(){
if (ns6||ie){
enabletip=false
tipobj.style.visibility="hidden"
tipobj.style.left="-1000px"
tipobj.style.backgroundColor=''
tipobj.style.width=''
}
}

document.onmousemove=positiontip
</script>
        <div class="page">
            <jsp:include page="include_header.jsp" flush="true"/>     
            <div class="page-main">
                <div class="my-3 my-md-5">
                    <div class="container">
                    <div class="row">
                        <div class="col-md-8"><h2>WHAT IS THE MOST SIMILAR MOVIE ?<br><small style="font-size:14pt">If you think one of the movies is similar,, please click "select" and "submit" </small></h2>
                            
                        </div>
                        <div class="col-md-4">
                           
                        </div>                        
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/oms_01_have_seen_suggest.jsp" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">                                        
                                        <input type="url" class="form-control" placeholder="Find the movie you want to add on IMDb and enter its URL" name="idmovie" id="autosearch" pattern="https://www.imdb.com/title/.*"  required >                                        
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                    </span>
                                    <input type="hidden" name="idmoviehaveseen" value="<%=idmoviehaveseen%>">                                    
                                </div>
                            </div>
                            </form>
                        </div>
                        <div  class="col-md-6">
                            <input type="text" class="form-control" value="Example of valid IMDb url: https://www.imdb.com/title/tt0114709/" disabled="disabled">                                       
                        </div>
                    </div>    
                    <%if(arrayidmovie.equals("0/0/0/0/0")){%>                    
                    <div class="row">                        
                        <div class="col-6 col-sm-4 col-lg-2">
                            <div class="card">
                                <div class="card-body p-3 text-center">
                                    <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, idmoviehaveseen)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, idmoviehaveseen)%></a>
                                    </div>                                    
                                    <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, idmoviehaveseen) %>);" ></div>
                                    <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                        <br>
                                        <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, idmoviehaveseen) %><br>                                                         
                                        <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, idmoviehaveseen) %><br>
                                        <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, idmoviehaveseen) %><br><br>
                                    </div>
                                    <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your have seen movie</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-lg-2"> </div>
                        <div class="col-6 col-sm-4 col-lg-2"> </div>
                        <div class="col-lg-6">
                            <div class="card">
                              <div class="card-header">
                                <h3 class="card-title">Guidelines</h3>                                
                              </div>
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
                    <div class="row">
                                <div class="col" align="center">                                
                                    <a href="oms_01_have_seen.jsp?search&num=0&id=<%=idmoviehaveseen%>" type="button" class="btn btn-primary" style="width:150px"> Go back </a>                                    
                                </div>                        
                    </div>
                    <%}else{
                        String[] array = arrayidmovie.split("/");                        
                        String idmovie=array[4];
                        if(idmovie==null){%>
                            Please type again...
                        <%}else{
                        String a="http://www.omdbapi.com/?i="+idmovie+"&plot=full&apikey=72b3ca58";
                        URL urlabc = new URL(a);
                        URLConnection conn = urlabc.openConnection();

                        // open the stream and put it into BufferedReader
                        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
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
                        newmovie.InsertNewMovies(connectionPool, mid_id, subtitle, title, year_release, genre, director, actor, poster, plotafterJaccard, plot, today);
                        JaccardSimilarity calculateJ = new JaccardSimilarity();
                        Double score_title = calculateJ.calculateJaccardSimilarity(movieinfo.get_Title(connectionPool, idmoviehaveseen), title);
                        Double score_genre = calculateJ.calculateJaccardSimilarity(movieinfo.get_Genre(connectionPool, idmoviehaveseen) , genre);
                        Double score_director = calculateJ.calculateJaccardSimilarity(movieinfo.get_Director(connectionPool, idmoviehaveseen), director);
                        Double score_actor = calculateJ.calculateJaccardSimilarity(movieinfo.get_Actor(connectionPool, idmoviehaveseen), actor);
                        Double score_plot = calculateJ.calculateJaccardSimilarity(movieinfo.get_Plot(connectionPool, idmoviehaveseen), plot);
                        String sum_score="title:"+score_title+"-genre:"+score_genre+"-director:"+score_director+"-actor:"+score_actor+"-plot:"+score_plot; %>
                        <form action="<%=request.getContextPath()%>/submitToDatabase" method="post" onsubmit="return validate(this)">
                        <div class="row">                        
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, idmoviehaveseen)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, idmoviehaveseen)%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, idmoviehaveseen) %>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, idmoviehaveseen) %><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, idmoviehaveseen) %><br>
                                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, idmoviehaveseen) %><br><br>
                                        </div>
                                        <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your have seen movie</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=subtitle%> ','white')" onMouseout="hideddrivetip()"><%=title%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=poster%>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=genre%><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=director%><br>
                                            <strong>ACTOR</strong>: <%=actor%><br>
                                            
                                        </div>
                                        <label id="ck-button" style="width:100%;">
                                            <input name="select" value="<%=mid_id%>/<%=sum_score%>" type="radio" style="width:100%">                                        
                                            <span class="btn btn-outline-primary btn-sm" role="button" style="width:100%;">Select</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4 col-lg-2"> </div>                        
                            <div class="col-lg-6">
                                <div class="card">
                                  <div class="card-header">
                                    <h3 class="card-title">Guidelines</h3>                                
                                  </div>
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
                        <div class="row">
                                <div class="col" align="center">                                
                                    <a href="oms_01_have_seen.jsp?search&num=0&id=<%=idmoviehaveseen%>" type="button" class="btn btn-primary" style="width:150px"> Go back </a>
                                    <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                    <input type="hidden" name="movie1" value="<%=idmoviehaveseen%>">
                                    <input type="hidden" name="action" value="moviesimilarity">
                                    <input type="hidden" name="numberrefresh" value="00">
                                    <input href="" type="submit" class="btn btn-danger" style="width:150px" value="Submit">
                                </div>                        
                        </div>
                        </form>
                    <%}}%>
                    </div>
                </div>
            </div>
            <jsp:include page="include_footer.jsp" flush="true"/>          
        </div>
    </body>
</html>
<%}%>