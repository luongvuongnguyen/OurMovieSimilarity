<%-- 
    Document   : index
    Created on : Jan 5, 2019, 2:32:02 PM
    Author     : VUONG NGUYEN
--%>
<%response.setDateHeader("Expires", 0);response.setHeader("Pragma", "no-cache");if (request.getProtocol().equals("HTTP/1.1")) {response.setHeader("Cache-Control", "no-cache");}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (session.getAttribute("userlogin") == null) {response.sendRedirect("oms_login.jsp?login=false");}else{container.user users = (container.user) session.getAttribute("userlogin");%>
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
            <div class="row">
                <div class="col-lg-12">
                <%if(request.getParameter("edit").equals("true")){%>
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert"></button>
                    Edit Profile success!
                </div>
                <%}%>
                <%if(request.getParameter("edit").equals("false")){%>
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert"></button>
                    Edit Profile fail!
                </div>
                <%}%>
                </div>
            </div>    
            <div class="row">               
                <div class="col-lg-4">
                    <div class="card card-profile">
                        <div class="card-body text-center">
                            <img class="avatar avatar-xxl" src="img/profile/<%=users.getImg()%>">
                            <h3 class="mb-3"><br><%=users.getUname()%></h3>
                            <p class="mb-4"><%=users.getEmail()%></p>
                            <style>
                                .upload-btn-wrapper {
                                    position: relative;
                                    overflow: hidden;
                                    display: inline-block;
                                }
                                .upload-btn-wrapper input[type=file] {
                                    font-size: 100px;
                                    position: absolute;
                                    left: 0;
                                    top: 0;
                                    opacity: 0;
                                }
                            </style>
                            <form action = "<%=request.getContextPath()%>/uploadimg" method = "post" enctype = "multipart/form-data" id="uploadimg">
                                <div class="upload-btn-wrapper">
                                    <button class="btn btn-outline-primary btn-sm"><span class="fa fa-pencil"></span> Change Image</button>
                                    <input type="file" name="myfile" />
                                </div>                                
                            </form>
                            <script>
                                $('#uploadimg input').change(function() {
                                    $(this).closest('#uploadimg').submit();
                                });
                            </script>
                        </div>
                    </div>                    
                </div>                
                <div class="col-lg-8">
                    <form class="card" action="<%=request.getContextPath()%>/submitToDatabase" method="post">
                        <div class="card-body">
                            <h3 class="card-title">Edit Profile</h3>
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="text" class="form-control" disabled="" placeholder="Email" value="<%=users.getEmail()%>">
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-3">
                                    <div class="form-group">
                                      <label class="form-label">Username</label>
                                      <input type="text" class="form-control" placeholder="Username" value="<%=users.getUname()%>" name="uname">
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-4">
                                    <div class="form-group">
                                      <label class="form-label">Password</label>
                                      <input type="password" class="form-control" placeholder="Password" value="<%=users.getPass()%>" name="pass">
                                    </div>
                                </div>                            
                                <div class="col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">First Name</label>
                                        <input type="text" class="form-control" placeholder="First Name" value="<%=users.getFirst_name()%>" name="first_name">
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Last Name</label>
                                        <input type="text" class="form-control" placeholder="Last Name" value="<%=users.getLast_name()%>" name="last_name">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-right">
                            <input type="hidden" value="<%=users.getEmail()%>" name="email">
                            <input type="hidden" value="<%=users.getIduser()%>" name="userID">
                            <input type="hidden" value="updateuser" name="action">
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </div>
                    </form>
                            <br>
                            <form action="<%=request.getContextPath()%>/sendEmail" method="post">
                                <button type="submit" class="btn btn-danger">Send Email to all User</button>
                            </form>
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