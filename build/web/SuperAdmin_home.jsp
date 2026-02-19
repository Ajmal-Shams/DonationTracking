<%-- Document : SuperAdmin_home Created on : Feb 20, 2026 Author : System --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html class="no-js">

        <head>
            <meta charset="utf-8">
            <title>DONATION TRACKING SYSTEM - Super Admin Home</title>
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

        <% if (request.getParameter("success") !=null) {%>
            <script>alert('Login Success');</script>
            <%}%>
                <% if (request.getParameter("panchayat_added") !=null) {%>
                    <script>alert('Panchayat Added Successfully');</script>
                    <%}%>
                        <% if (request.getParameter("panchayat_updated") !=null) {%>
                            <script>alert('Panchayat Updated Successfully');</script>
                            <%}%>
                                <% if (request.getParameter("panchayat_deleted") !=null) {%>
                                    <script>alert('Panchayat Deleted Successfully');</script>
                                    <%}%>
                                        <% if (request.getParameter("admin_added") !=null) {%>
                                            <script>alert('Panchayat Admin Added Successfully');</script>
                                            <%}%>
                                                <% if (request.getParameter("admin_deleted") !=null) {%>
                                                    <script>alert('Panchayat Admin Deleted Successfully');</script>
                                                    <%}%>

                                                        <body>

                                                            <header class="main-header">
                                                                <nav class="navbar navbar-static-top">
                                                                    <div class="navbar-top">
                                                                        <div class="container">
                                                                            <div class="row">
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <ul
                                                                                        class="list-unstyled list-inline header-contact">
                                                                                        <li> <i class="fa fa-phone"></i>
                                                                                            <a href="tel:">+61 123456789
                                                                                            </a> </li>
                                                                                        <li> <i
                                                                                                class="fa fa-envelope"></i>
                                                                                            <a
                                                                                                href="#">contact@DONATION.org</a>
                                                                                        </li>
                                                                                    </ul>
                                                                                </div>
                                                                                <div
                                                                                    class="col-sm-6 col-xs-12 text-right">
                                                                                    <ul
                                                                                        class="list-unstyled list-inline header-social">
                                                                                        <li> <a href="#"> <i
                                                                                                    class="fa fa-facebook"></i>
                                                                                            </a> </li>
                                                                                        <li> <a href="#"> <i
                                                                                                    class="fa fa-twitter"></i>
                                                                                            </a> </li>
                                                                                        <li> <a href="#"> <i
                                                                                                    class="fa fa-google"></i>
                                                                                            </a> </li>
                                                                                        <li> <a href="#"> <i
                                                                                                    class="fa fa-youtube"></i>
                                                                                            </a> </li>
                                                                                        <li> <a href="#"> <i
                                                                                                    class="fa fa fa-pinterest-p"></i>
                                                                                            </a> </li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="navbar-main">
                                                                        <div class="container">
                                                                            <div class="navbar-header">
                                                                                <button type="button"
                                                                                    class="navbar-toggle collapsed"
                                                                                    data-toggle="collapse"
                                                                                    data-target="#navbar"
                                                                                    aria-expanded="false"
                                                                                    aria-controls="navbar">
                                                                                    <span class="sr-only">Toggle
                                                                                        navigation</span>
                                                                                    <span class="icon-bar"></span>
                                                                                    <span class="icon-bar"></span>
                                                                                    <span class="icon-bar"></span>
                                                                                </button>
                                                                                <a class="navbar-brand"
                                                                                    href="SuperAdmin_home.jsp">DONATION
                                                                                    TRACKING SYSTEM</a>
                                                                            </div>
                                                                            <div id="navbar"
                                                                                class="navbar-collapse collapse pull-right">
                                                                                <ul class="nav navbar-nav">
                                                                                    <li><a class="is-active"
                                                                                            href="SuperAdmin_home.jsp">HOME</a>
                                                                                    </li>
                                                                                    <li><a href="Manage_Panchayats.jsp">Manage
                                                                                            Panchayats</a></li>
                                                                                    <li><a href="Manage_Admins.jsp">Manage
                                                                                            Admins</a></li>
                                                                                    <li><a
                                                                                            href="SA_Donors.jsp">Donors</a>
                                                                                    </li>
                                                                                    <li><a
                                                                                            href="SA_Charities.jsp">Charities</a>
                                                                                    </li>
                                                                                    <li><a
                                                                                            href="SA_Campaigns.jsp">Campaigns</a>
                                                                                    </li>
                                                                                    <li><a
                                                                                            href="SA_Donations.jsp">Donations</a>
                                                                                    </li>
                                                                                    <li><a
                                                                                            href="SA_Transactions.jsp">Transactions</a>
                                                                                    </li>
                                                                                    <li><a href="logout.jsp">Logout</a>
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </nav>
                                                            </header>

                                                            <div class="page-heading text-center">
                                                                <div class="container ">
                                                                    <h1 class="page-title">Super Admin Dashboard <span
                                                                            class="title-under"></span></h1>
                                                                    <p class="page-description"></p>
                                                                </div>
                                                            </div>

                                                            <div class="main-container">
                                                                <div class="container">
                                                                    <div class="row animated" style="margin-top:20px;">
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="Manage_Panchayats.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-primary text-center"
                                                                                    style="padding:30px;">
                                                                                    <i
                                                                                        class="fa fa-university fa-3x"></i>
                                                                                    <h3>Manage Panchayats</h3>
                                                                                    <p>Add, Edit & Delete Panchayats</p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="Manage_Admins.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-success text-center"
                                                                                    style="padding:30px;">
                                                                                    <i
                                                                                        class="fa fa-user-secret fa-3x"></i>
                                                                                    <h3>Manage Admins</h3>
                                                                                    <p>Add & Delete Panchayat Admins</p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="SA_Donors.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-info text-center"
                                                                                    style="padding:30px;">
                                                                                    <i class="fa fa-users fa-3x"></i>
                                                                                    <h3>All Donors</h3>
                                                                                    <p>View Donors Across All Panchayats
                                                                                    </p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row animated">
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="SA_Charities.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-warning text-center"
                                                                                    style="padding:30px;">
                                                                                    <i class="fa fa-heart fa-3x"></i>
                                                                                    <h3>All Charities</h3>
                                                                                    <p>View Charities Across All
                                                                                        Panchayats</p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="SA_Campaigns.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-danger text-center"
                                                                                    style="padding:30px;">
                                                                                    <i class="fa fa-bullhorn fa-3x"></i>
                                                                                    <h3>All Campaigns</h3>
                                                                                    <p>View Campaigns Across All
                                                                                        Panchayats</p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-md-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="SA_Donations.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-primary text-center"
                                                                                    style="padding:30px;">
                                                                                    <i class="fa fa-gift fa-3x"></i>
                                                                                    <h3>All Donations</h3>
                                                                                    <p>View Donation Requests Across All
                                                                                        Panchayats</p>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row animated">
                                                                        <div class="col-md-4 col-md-offset-4"
                                                                            style="margin-bottom:20px;">
                                                                            <a href="SA_Transactions.jsp"
                                                                                style="text-decoration:none;">
                                                                                <div class="panel panel-success text-center"
                                                                                    style="padding:30px;">
                                                                                    <i class="fa fa-exchange fa-3x"></i>
                                                                                    <h3>All Transactions</h3>
                                                                                    <p>View Transactions Across All
                                                                                        Panchayats</p>
                                                                                </div>
                                                                            </a>
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
                                                                                    <h4 class="footer-title">About us
                                                                                        <span
                                                                                            class="title-under"></span>
                                                                                    </h4>
                                                                                    <div class="footer-content">
                                                                                        <p>The aim of this project is to
                                                                                            develop a system to track
                                                                                            donation. The users are
                                                                                            admin, donor and charity.
                                                                                            This system helps the donors
                                                                                            to track their donation.</p>
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
                                                                    <div class="container text-right">DONATION TRACKING
                                                                        SYSTEM</div>
                                                                </div>
                                                            </footer>

                                                            <script
                                                                src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                                                            <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>
                                                            <script src="assets/js/bootstrap.min.js"></script>
                                                            <script src="assets/js/main.js"></script>
                                                        </body>

        </html>