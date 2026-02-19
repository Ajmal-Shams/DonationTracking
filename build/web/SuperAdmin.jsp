<%-- Document : SuperAdmin Created on : Feb 20, 2026 Author : System --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html class="no-js">

        <head>
            <meta charset="utf-8">
            <title>DONATION TRACKING SYSTEM - Super Admin</title>
            <meta name="description" content="">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
            <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet' type='text/css'>
            <link rel="stylesheet" href="assets/css/bootstrap.min.css">
            <link rel="stylesheet" href="assets/css/font-awesome.min.css">
            <link rel="stylesheet" href="assets/css/owl.carousel.css">
            <link rel="stylesheet" href="assets/css/style.css">
            <script src="assets/js/modernizr-2.6.2.min.js"></script>
        </head>

        <% if (request.getParameter("failed") !=null) {%>
            <script>alert('Authentication Failed - Incorrect Username or Password');</script>
            <%}%>

                <body>

                    <header class="main-header">
                        <nav class="navbar navbar-static-top">
                            <div class="navbar-top">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-12">
                                            <ul class="list-unstyled list-inline header-contact">
                                                <li> <i class="fa fa-phone"></i> <a href="tel:">+61 123456789 </a> </li>
                                                <li> <i class="fa fa-envelope"></i> <a href="#">contact@DONATION.org</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-6 col-xs-12 text-right">
                                            <ul class="list-unstyled list-inline header-social">
                                                <li> <a href="#"> <i class="fa fa-facebook"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-twitter"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-google"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-youtube"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa fa-pinterest-p"></i> </a> </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="navbar-main">
                                <div class="container">
                                    <div class="navbar-header">
                                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                                            data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                            <span class="sr-only">Toggle navigation</span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                        </button>
                                        <a class="navbar-brand" href="index.jsp">DONATION TRACKING SYSTEM</a>
                                    </div>
                                    <div id="navbar" class="navbar-collapse collapse pull-right">
                                        <ul class="nav navbar-nav">
                                            <li><a href="index.jsp">HOME</a></li>
                                            <li><a class="is-active" href="SuperAdmin.jsp">Super Admin</a></li>
                                            <li><a href="Admin.jsp">Admin</a></li>
                                            <li><a href="Charity.jsp">Charity</a></li>
                                            <li><a href="Donor.jsp">Donor</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </header>

                    <div class="page-heading text-center">
                        <div class="container ">
                            <h1 class="page-title">Super Admin Login<span class="title-under"></span></h1>
                            <p class="page-description"></p>
                        </div>
                    </div>

                    <div class="main-container animated">
                        <div class="container">
                            <div class="row">
                                <div class="h-100 d-flex align-items-center justify-content-center">
                                    <form action="superadminlog" method="post">
                                        <center>
                                            <div class="row">
                                                <div class="form-group pull-center">
                                                    <input type="text" name="name" class="form-control"
                                                        placeholder="Username*" required style="width: 250px">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group pull-center">
                                                    <input type="password" name="pass" class="form-control"
                                                        placeholder="Password*" required style="width: 250px">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-primary pull-center">Login</button>
                                            </div>
                                        </center>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <footer class="main-footer">
                        <div class="footer-top"></div>
                        <div class="footer-main">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="footer-col">
                                            <h4 class="footer-title">About us <span class="title-under"></span></h4>
                                            <div class="footer-content">
                                                <p>
                                                    The aim of this project is to develop a system to track donation.
                                                    The users are admin, donor
                                                    and charity. This system helps the donors to track their donation.
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4">
                                        <div class="footer-col">
                                            <div class="footer-content"></div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="footer-bottom">
                            <div class="container text-right">
                                DONATION TRACKING SYSTEM
                            </div>
                        </div>
                    </footer>

                    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                    <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>
                    <script src="assets/js/bootstrap.min.js"></script>
                    <script src="assets/js/main.js"></script>
                </body>

        </html>