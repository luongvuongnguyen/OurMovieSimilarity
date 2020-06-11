<%-- 
    Document   : oms_login
    Created on : Feb 18, 2019, 3:06:01 PM
    Author     : VUONG NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include_header_head.jsp" flush="true"/> 
        <script src="assets/js/bootstrap.js"></script>        
    </head>
    <body>
    <div class="page">
        <div class="header py-4">
                <div class="container">
                    <!--//logo-->
                    <div class="d-flex"><a class="header-brand" href="oms_01_home.jsp?search">
                            <img src="img/oms-logo-65-65.png" class="header-brand-img" alt="tabler logo">OUR<strong style="color:#4188c9">MOVIESIMILARITY</strong></a>                        
                    <!-- user information -->
                    <div class="d-flex order-lg-2 ml-auto">                    
                
                        <div class="dropdown">

                        </div>
                        <div class="nav-item d-none d-md-flex"><a href="oms_register.jsp?reg" class="btn btn-sm btn-outline-primary">Sign up</a></div>
                    </div>
                    <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse"><span class="header-toggler-icon"></span></a>
                    </div>
                </div>
        </div>
                        
        <div class="page-main">                       
            <div class="my-3 my-md-5">
                <div class="container">
                    <div class="clear-fix"><br></div>
                    <div class="clear-fix"><br></div>
                    <div class="clear-fix"><br></div>
                 <div class="row">
                    <div class="col-md-6">
                        <div class="alert alert-primary" role="alert">
                          <i class="fe fe-package"></i> OurMovieSimilarity (OMS) connect the person who likes movies so much.
                        </div>
                        <div class="alert alert-secondary" role="alert">
                          <i class="fe fe-thumbs-up"></i> Collect data from a user to train our system more exactly.
                        </div>
                        <div class="alert alert-success" role="alert">
                          <i class="fe fe-database"></i> Base on Java Web Application (Java Server Pages) and MVC model, save and share data by using MySQL server.
                        </div>
                        <div class="alert alert-info" role="alert">
                          <i class="fe fe-cloud"></i> Using IMDB database (get through www.omdbapi.com).
                        </div>
                        <div class="alert alert-warning" role="alert" style="text-align: justify">
                          <i class="fe fe-user"></i> OurMovieSimilarity (OMS) helps you find movies which you think similar and then, recommends other movies for you to watch. OMS is run by KEL (Knowledge Engineering Labotary) at Chung-Ang University. By using OMS, you will help us develop new experimental tools and interfaces for data exploration.
                        </div>
                        <div class="alert alert-danger" role="alert">
                          <i class="fe fe-layers"></i> OurMovieSimilarity (OMS) is non-commercial.
                        </div>                                                                 
                    </div>
                    <div class="col-md-6">
                        <%if(request.getParameter("login").equals("wrong")){%>
                        <div class="alert alert-warning alert-dismissible">
                            <button type="button" class="close" data-dismiss="alert"></button>
                            Email or Password wrong
                        </div>
                        <%}%>
                        <%if(request.getParameter("login").equals("true")){%>
                        <div class="alert alert-success alert-dismissible">
                            <button type="button" class="close" data-dismiss="alert"></button>
                            Your account has been created. Type your email and password to sign in
                        </div>
                        <%}%>
                        <form class="card" action="<%=request.getContextPath()%>/login" method="post">
                            <div class="card-body p-6">
                                <div class="card-title"><b>LOGIN</b></div>
                              <div class="form-group">
                                <label class="form-label">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="email">
                              </div>
                              <div class="form-group">
                                <label class="form-label">
                                  Password                        
                                </label>
                                <input type="password" class="form-control" id="exampleInputPassword1" name="pass">
                              </div>                    
                              <div class="form-footer">
                                <button type="submit" class="btn btn-primary btn-block">Sign in</button>
                              </div>
                            </div>
                        </form>
                        <div class="text-center text-muted">
                            Don't have account yet? <a href="oms_register.jsp?reg">Sign up</a>
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
