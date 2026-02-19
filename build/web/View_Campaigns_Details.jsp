<%@page import="java.sql.ResultSet" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="java.sql.Connection" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
                        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                        <link rel="stylesheet" href="assets/css/owl.carousel.css">
                        <link rel="stylesheet" href="assets/css/style.css">
                        <link rel="stylesheet" href="assets/css/table.css">
                        <script src="assets/js/modernizr-2.6.2.min.js"></script>
                    </head>
                    <% if (request.getParameter("Added") !=null) { %>
                        <script>alert('Campaign Registration Success');</script>
                        <% } %>

                            <body>
                                <% String[] h={ "cid" , "SELECT\u0020*\u0020FROM\u0020campaign\u0020WHERE\u0020cid='"
                                    , "'" , "id" , "campName" , "CampDes" , "Amount" , "AmountCol" , "EndDate"
                                    , "StartDate" , "CampStatus"
                                    , "\u003cb\u0020style='color:red;'\u003eLOCKED\u0020(Goal\u0020Reached)\u003c/b\u003e"
                                    }; %>
                                    <header class="main-header">
                                        <nav class="navbar navbar-static-top">
                                            <div class="navbar-top">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-sm-6 col-xs-12">
                                                            <ul class="list-unstyled list-inline header-contact">
                                                                <li> <i class="fa fa-phone"></i> <a href="tel:">+61
                                                                        123456789 </a> </li>
                                                                <li> <i class="fa fa-envelope"></i> <a
                                                                        href="#">contact@DONATION.org</a> </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-sm-6 col-xs-12 text-right">
                                                            <ul class="list-unstyled list-inline header-social">
                                                                <li> <a href="#"> <i class="fa fa-facebook"></i> </a>
                                                                </li>
                                                                <li> <a href="#"> <i class="fa fa-twitter"></i> </a>
                                                                </li>
                                                                <li> <a href="#"> <i class="fa fa-google"></i> </a>
                                                                </li>
                                                                <li> <a href="#"> <i class="fa fa-youtube"></i> </a>
                                                                </li>
                                                                <li> <a href="#"> <i class="fa fa fa-pinterest-p"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="navbar-main">
                                                <div class="container">
                                                    <div class="navbar-header"><button type="button"
                                                            class="navbar-toggle collapsed" data-toggle="collapse"
                                                            data-target="#navbar" aria-expanded="false"
                                                            aria-controls="navbar"><span class="sr-only">Toggle
                                                                navigation</span><span class="icon-bar"></span><span
                                                                class="icon-bar"></span><span
                                                                class="icon-bar"></span></button><a class="navbar-brand"
                                                            href="Charity_home.jsp">DONATION TRACKING SYSTEM</a></div>
                                                    <div id="navbar" class="navbar-collapse collapse pull-right">
                                                        <ul class="nav navbar-nav">
                                                            <li><a href="Charity_home.jsp">HOME</a></li>
                                                            <li><a class="is-active" href="Add_Campaigns.jsp">Add
                                                                    Campaigns</a></li>
                                                            <li><a href="View_Campaigns_Details.jsp">Campaigns</a></li>
                                                            <li><a href="request_donation.jsp">Request Donation</a></li>
                                                            <li><a href="request_status.jsp">Request Status</a></li>
                                                            <li><a href="CDonations_Details.jsp">Donations</a></li>
                                                            <li><a href="CTransactions.jsp">Transactions</a></li>
                                                            <li><a href="logout.jsp">Logout</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </nav>
                                    </header>
                                    <div class="page-heading text-center">
                                        <div class="container">
                                            <h1 class="page-title">Fundraising Campaign<span class="title-under"></span>
                                            </h1>
                                        </div>
                                    </div>
                                    <div class="main-container">
                                        <div class="container">
                                            <h2>Campaign Details</h2><br>
                                            <table id="customers">
                                                <thead>
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Campaign Name</th>
                                                        <th>Campaign Description</th>
                                                        <th>Campaign Pic</th>
                                                        <th>Amount</th>
                                                        <th>Amount Collected</th>
                                                        <th>End Date</th>
                                                        <th>Registered Date & Time</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% Object ci=session.getAttribute(h[0]); if (ci !=null) { String
                                                        c=ci.toString(); java.sql.Connection conn=null; try {
                                                        conn=DonationTracking.SQLconnection.getconnection(); if (conn
                                                        !=null) { java.sql.Statement st=conn.createStatement();
                                                        java.sql.ResultSet rs=st.executeQuery(h[1] + c + h[2]); while
                                                        (rs.next()) { String id=rs.getString(h[3]); %>
                                                        <tr>
                                                            <td>
                                                                <%=id%>
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[4])%>
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[5])%>
                                                            </td>
                                                            <td><img src="campic.jsp?id=<%=id%>" height="100"
                                                                    width="100">
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[6])%>
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[7])%>
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[8])%>
                                                            </td>
                                                            <td>
                                                                <%=rs.getString(h[9])%>
                                                            </td>
                                                            <td>
                                                                <% double amt=0, col=0; try {
                                                                    amt=Double.parseDouble(rs.getString(h[6])); }
                                                                    catch(Exception e){} try {
                                                                    col=Double.parseDouble(rs.getString(h[7])); }
                                                                    catch(Exception e){} if (col>= amt && amt > 0) {
                                                                    out.print(h[11]);
                                                                    } else {
                                                                    out.print(rs.getString(h[10]));
                                                                    }
                                                                    %>
                                                            </td>
                                                        </tr>
                                                        <% } } } catch (Exception ex) { ex.printStackTrace(); } } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <footer class="main-footer">
                                        <div class="footer-main">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="footer-col">
                                                            <h4 class="footer-title">About us <span
                                                                    class="title-under"></span></h4>
                                                            <div class="footer-content">
                                                                <p>The aim of this project is to develop a system to
                                                                    track
                                                                    donation. The users are admin, donor and charity.
                                                                    This
                                                                    system helps the donors to track their donation.
                                                                    This
                                                                    system consisted 5 modules. Besides that, this
                                                                    system
                                                                    also helps the charity request for donation.
                                                                    Meanwhile,
                                                                    the admin will manage the charity and donors.</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="footer-bottom">
                                            <div class="container text-right">DONATION TRACKING SYSTEM</div>
                                        </div>
                                    </footer>
                                    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                                    <script src="assets/js/bootstrap.min.js"></script>
                                    <script src="assets/js/main.js"></script>
                            </body>

                    </html>