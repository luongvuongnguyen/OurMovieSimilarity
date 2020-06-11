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
String search=request.getParameter("search");
getFromDatabase getMovieInfo = new getFromDatabase();
String movieID = request.getParameter("id");
int randnum = Integer.parseInt(request.getParameter("num"));
getMovieInfo movieinfo = new getMovieInfo();
%>
<html>
    <head>
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
                top:-50000px;
                border-radius:10px;
            }
            #ck-button input:checked + span {
                background-color:#4188c9;
                color:#fff;
            }
        </style>     
       <script language="javascript" type="text/javascript">
        var win=null;
        function NewWindow(mypage,myname,w,h,scroll,pos){
        if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
        if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
        else if((pos!="center" && pos!="random") || pos==null){LeftPosition=0;TopPosition=20}
        settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
        win=window.open(mypage,myname,settings);}
        // -->
        </script>
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
                        <div class="col-md-8">
                            <%String checkmoviehaveseen = getMovieInfo.Check_Moviehaveseen(connectionPool, movieID, users.getIduser());%>
                            <h2>WHAT IS THE MOST SIMILAR MOVIE ?<br><small style="font-size:14pt">If you think one of the movies is similar, please click "select" and "submit" </small></h2>                            
                        </div>
                        <div class="col-md-4">
                            <form class="input-icon my-3 my-lg-0" action="<%=request.getContextPath()%>/searchmovie" method="post">
                            <div class="form-group" >
                                <div class="row gutters-xs">                                    
                                    <div class="col">
                                        <input type="text" class="form-control" placeholder="Type title, director, actor of movies" name="titlesearch" id="autosearch" required="">
                                    </div>
                                    <span class="col-auto">
                                        <button class="btn btn-secondary" type="submit"><i class="fe fe-search"></i></button>
                                    </span>
                                    <input type="hidden" name="typeofsearch" value="moviehaveseen">
                                    <input type="hidden" name="movieID" value="<%=movieID%>">
                                    <input type="hidden" name="num" value="<%=randnum%>">
                                </div>
                            </div>
                            </form>
                        </div>                        
                    </div>                   
                    
                    <%if(checkmoviehaveseen.equals("true")){String moviesimilar = getMovieInfo.get_MovieSimilarofUser(connectionPool, movieID, users.getIduser()); %>
                    <form action="<%=request.getContextPath()%>/deleteFromDatabase" method="post" onsubmit="return validate(this)">
                        <div class="row row-cards">
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, movieID)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, movieID)%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, movieID) %>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, movieID) %><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, movieID) %><br>
                                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, movieID) %><br><br>
                                        </div>
                                        <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your have seen movie</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, moviesimilar)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, moviesimilar)%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, moviesimilar) %>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, moviesimilar) %><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, moviesimilar) %><br>
                                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, moviesimilar) %><br><br>
                                        </div>
                                        <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your similar movie</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        You have selected this movie. Do you want to change your selection?<br><br>
                                        <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                        <input type="hidden" name="movieID" value="<%=movieID%>">
                                        <input type="hidden" name="movie2" value="<%=moviesimilar%>">
                                        <input type="hidden" name="num" value="<%=randnum%>">
                                        <input type="hidden" name="action" value="deleteMovieSimilarity2">
                                        <button href="" class="btn btn-primary btn-sm" style="width:100px" type="submit">Yes</button>                                        
                                        <a href="oms_01_home.jsp?search" class="btn btn-danger btn-sm" style="width:100px">No </a>
                                    </div>
                                </div>
                            </div>
                        </div>                        
                    </form>        
                    <%}else{%>
                    <form action="<%=request.getContextPath()%>/submitToDatabase" method="post" onsubmit="return validate(this)">
                    <%if(search.equals("true")){String titlesearch=request.getParameter("titlesearch");int dem=0;%>
                        <div class="row row-cards">
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, movieID)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, movieID)%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, movieID) %>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, movieID) %><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, movieID) %><br>
                                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, movieID) %><br><br>
                                        </div>
                                        <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your have seen movie</button>
                                    </div>
                                </div>
                            </div>                        
                            <%Vector NewMovieSearch = getMovieInfo.get_NewMoviesSearchHaveSean(connectionPool, titlesearch, movieID) ;
                            Enumeration Enum_NewMovieSearch = NewMovieSearch.elements();	
                            while (Enum_NewMovieSearch.hasMoreElements()){String[] tmp_Enum_NewMovieSearch = (String[]) Enum_NewMovieSearch.nextElement();%>
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">                                    
                                            <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                <a href="" onMouseover="ddrivetip('<%=tmp_Enum_NewMovieSearch[0]%> ','white')" onMouseout="hideddrivetip()"><%=tmp_Enum_NewMovieSearch[0]%></a>
                                            </div>
                                            <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=tmp_Enum_NewMovieSearch[5]%>);" ></div>
                                            <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                                <br>
                                                <strong>GENRE</strong>: <%=tmp_Enum_NewMovieSearch[2]%><br>                                                         
                                                <strong>DIRECTOR</strong>: <%=tmp_Enum_NewMovieSearch[3]%><br>
                                                <strong>ACTOR</strong>: <%=tmp_Enum_NewMovieSearch[4]%><br><br>
                                            </div>
                                            <label id="ck-button" style="width:100%;">
                                            <input name="select" value="<%=tmp_Enum_NewMovieSearch[6]%>/<%=tmp_Enum_NewMovieSearch[8]%>" type="radio" style="width:100%" name="">                                        
                                            <span class="btn btn-outline-primary btn-sm" role="button" style="width:100%;">Select</span>
                                            </label>
                                    </div>
                                </div>
                            </div>
                            <%dem++;}%>                            
                            <%if(dem==0){%>
                            <div class="row">
                                <div class="col">
                                <div class="alert alert-danger" role="alert">No results for keywords:  <code><%=titlesearch%></code>.  If there's a movie that you think should be in OMS, please click "Suggest Movie" button</div>                                        
                                </div>
                            </div>
                            <%}%>                            
                        </div>
                        <div class="row">
                            <div class="col" align="center">
                                <a href="oms_01_have_seen.jsp?search&num=<%=randnum+5%>&id=<%=movieID%>" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Refresh </a>
                                <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                <input type="hidden" name="movie1" value="<%=movieID%>">
                                <input type="hidden" name="action" value="moviesimilarity">
                                <input type="hidden" name="numberrefresh" value="<%=randnum%>">
                                <%if(dem==0){}else{%><input href="" type="submit" class="btn btn-danger" style="width:150px" value="Submit"><%}%>
                                <a href="oms_01_have_seen_suggest.jsp?idmovie=0/0/0/0/0&idmoviehaveseen=<%=movieID%>" class="btn btn-outline-warning" style="width:150px">Suggest Movie</a>
                            </div>                        
                        </div> 
                    <%}else{%>
                        <div class="row row-cards">
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">
                                        <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            <a href="" onMouseover="ddrivetip('<%=movieinfo.get_SubTitle(connectionPool, movieID)%> ','white')" onMouseout="hideddrivetip()"><%=movieinfo.get_Title(connectionPool, movieID)%></a>
                                        </div>                                    
                                        <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=movieinfo.get_Poster(connectionPool, movieID) %>);" ></div>
                                        <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                            <br>
                                            <strong>GENRE</strong>: <%=movieinfo.get_Genre(connectionPool, movieID) %><br>                                                         
                                            <strong>DIRECTOR</strong>: <%=movieinfo.get_Director(connectionPool, movieID) %><br>
                                            <strong>ACTOR</strong>: <%=movieinfo.get_Actor(connectionPool, movieID) %><br><br>
                                        </div>
                                        <button href="" class="btn btn-danger btn-sm" style="width:100%" disabled="disabled">Your have seen movie</button>
                                    </div>
                                </div>
                            </div>
                            <%Vector moviesbytitle = getMovieInfo.get_Predict_5Movie(connectionPool, movieID, randnum);
                            Enumeration Enum_moviesbytitle = moviesbytitle.elements();	
                            while (Enum_moviesbytitle.hasMoreElements()){String[] tmp_moviesbytitle = (String[]) Enum_moviesbytitle.nextElement();%>
                            <div class="col-6 col-sm-4 col-lg-2">
                                <div class="card">
                                    <div class="card-body p-3 text-center">                                    
                                            <div class="text-left text-green" style="width: 10em; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                <a href="" onMouseover="ddrivetip('<%=tmp_moviesbytitle[0]%> ','white')" onMouseout="hideddrivetip()"><%=tmp_moviesbytitle[0]%></a>
                                            </div>
                                            <div class="h1 m-0" style="height:240px;background-position: center;background-size: cover;background-image: url(<%=tmp_moviesbytitle[5]%>);" ></div>
                                            <div class="text-muted mb-4" style="font-size: 8pt;height:110px; text-align: left">
                                                <br>
                                                <strong>GENRE</strong>: <%=tmp_moviesbytitle[2]%><br>                                                         
                                                <strong>DIRECTOR</strong>: <%=tmp_moviesbytitle[3]%><br>
                                                <strong>ACTOR</strong>: <%=tmp_moviesbytitle[4]%><br><br>
                                            </div>
                                            <label id="ck-button" style="width:100%;">
                                            <input name="select" value="<%=tmp_moviesbytitle[6]%>/<%=tmp_moviesbytitle[8]%>" type="radio" style="width:100%" name="">                                        
                                            <span class="btn btn-outline-primary btn-sm" role="button" style="width:100%;">Select</span>
                                            </label>
                                    </div>
                                </div>
                            </div>
                            <%}%>                                                 
                        </div>
                        <div class="row">
                            <div class="col" align="center">
                                <a href="oms_01_have_seen.jsp?search&num=<%=randnum+5%>&id=<%=movieID%>" type="button" value=" Refresh " class="btn btn-primary" style="width:150px"> Refresh </a>
                                <input type="hidden" name="userID" value="<%=users.getIduser()%>">
                                <input type="hidden" name="movie1" value="<%=movieID%>">
                                <input type="hidden" name="numberrefresh" value="<%=randnum%>">
                                <input type="hidden" name="action" value="moviesimilarity">
                                <input href="" type="submit" class="btn btn-danger" style="width:150px" value="Submit">
                                <a href="oms_01_have_seen_suggest.jsp?idmovie=0/0/0/0/0&idmoviehaveseen=<%=movieID%>" class="btn btn-outline-warning" style="width:150px">Suggest Movie</a>
                            </div>                        
                        </div>
                    <%}%>        
                    </form>
                    <%}%>
                </div>
            </div>
        </div>
        <jsp:include page="include_footer.jsp" flush="true"/>                        
    </div>
    </body>
</html>
<%}%>