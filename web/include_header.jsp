<%-- 
    Document   : include_header
    Created on : Jan 5, 2019, 9:21:04 PM
    Author     : VUONG NGUYEN
--%>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
            <div class="header py-4">
                <div class="container">
                    <!--//logo-->
                    <div class="d-flex"><a class="header-brand" href="oms_01_home.jsp?search">
                            <img src="img/oms-logo-65-65.png" class="header-brand-img" alt="tabler logo">OUR<strong style="color:#4188c9">MOVIESIMILARITY</strong></a>                        
                    <!-- user information -->
                    <div class="d-flex order-lg-2 ml-auto">
                    <div class="nav-item d-none d-md-flex"><a href="<%=request.getContextPath()%>/logout?userid=<%=users.getIduser()%>" class="btn btn-sm btn-outline-primary">Log out</a></div>
                
                    <div class="dropdown">
                    <a href="oms_05_profile.jsp?edit" class="nav-link pr-0 leading-none">
                        <span class="avatar" style="background-image: url(img/profile/<%=users.getImg()%>)"></span>
                        <span class="ml-2 d-none d-lg-block">
                        <span class="text-default"><%=users.getUname()%></span>
                        <small class="text-muted d-block mt-1"><%=users.getEmail() %></small>
                        </span>
                    </a>
                    </div>
                    </div>
                    <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse"><span class="header-toggler-icon"></span></a>
                    </div>
                </div>
            </div>
            
            <div class="header collapse d-lg-flex p-0" id="headerMenuCollapse" style="-webkit-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);-moz-box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);box-shadow: 0 4px 6px rgba(0, 0, 0, 0.12);">
              <div class="container" >
                <div class="row align-items-center">                  
                  <div class="col-lg order-lg-first">
                    <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
                        <li class="nav-item"><a href="oms_01_home.jsp?search" class="nav-link"><i class="fe fe-home"></i> Home</a></li>
                        <li class="nav-item"><a href="oms_02_movie_map.jsp" class="nav-link"><i class="fe fe-box"></i>My Movie map</a></li>
                        <li class="nav-item"><a href="oms_03_my_activity.jsp?pages=1" class="nav-link"><i class="fe fe-film"></i>My Activity</a></li>
                        <li class="nav-item"><a href="oms_04_all_movie.jsp?search&pages=1" class="nav-link"><i class="fe fe-database"></i> All movies</a></li>
                        <li class="nav-item"><a href="oms_06_explore.jsp" class="nav-link"><i class="fe fe-users"></i>Explore</a></li>
                        <li class="nav-item"><a href="oms_07_statistic.jsp" class="nav-link"><i class="fe fe-bar-chart-2"></i>Statistic</a></li>
                        <%if(users.getIduser().equals("1")||users.getIduser().equals("8")){ %>
                        <li class="nav-item"><a href="oms_08_all_activity.jsp?userid" class="nav-link"><i class="fe fe-bar-chart-2"></i>All Activity</a></li>
                        <%}%>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <div class="loader"></div>        
<%}%>