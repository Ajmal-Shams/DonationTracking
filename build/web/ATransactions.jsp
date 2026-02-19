<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% String q="SELECT * FROM transaction" +" WHERE panchayat_id=?"; ArrayList rows=new ArrayList(); String
                    errMsg=null; Connection con=null; try{ con=SQLconnection.getconnection(); if(con!=null){ Integer
                    pId=(Integer)session.getAttribute("panchayat_id"); PreparedStatement ps=con.prepareStatement(q);
                    ps.setInt(1,pId!=null?pId:0); ResultSet rs=ps.executeQuery(); while(rs.next()){ String[] r=new
                    String[7]; r[0]=rs.getString("Tid"); r[1]=rs.getString("dname"); r[2]=rs.getString("cname");
                    r[3]=rs.getString("campName"); r[4]=rs.getString("payment"); r[5]=rs.getString("amount");
                    r[6]=rs.getString("TofPayement"); rows.add(r); } } }catch(Exception ex){ ex.printStackTrace();
                    errMsg=ex.getMessage(); } %>
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
                    <%if(request.getParameter("Granted")!=null){%>
                        <script>alert('Charity Account Activated');</script>
                        <%}%>
                            <%if(request.getParameter("Rejected")!=null){%>
                                <script>alert('Charity Account Rejected');</script>
                                <%}%>

                                    <body>
                                        <header class="main-header">
                                            <nav class="navbar navbar-static-top">
                                                <div class="navbar-top">
                                                    <div class="container">
                                                        <div class="row">
                                                            <div class="col-sm-6 col-xs-12">
                                                                <ul class="list-unstyled list-inline header-contact">
                                                                    <li><i class="fa fa-phone"></i> <a href="tel:">+61
                                                                            123456789</a></li>
                                                                    <li><i class="fa fa-envelope"></i> <a
                                                                            href="#">contact@DONATION.org</a></li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-sm-6 col-xs-12 text-right">
                                                                <ul class="list-unstyled list-inline header-social">
                                                                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                                                                    </li>
                                                                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                                                                    </li>
                                                                    <li><a href="#"><i class="fa fa-google"></i></a>
                                                                    </li>
                                                                    <li><a href="#"><i class="fa fa-youtube"></i></a>
                                                                    </li>
                                                                    <li><a href="#"><i
                                                                                class="fa fa-pinterest-p"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="navbar-main">
                                                    <div class="container">
                                                        <div class="navbar-header">
                                                            <a class="navbar-brand" href="Admin_home.jsp">DONATION
                                                                TRACKING SYSTEM</a>
                                                        </div>
                                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                                            <ul class="nav navbar-nav">
                                                                <li><a href="Admin_home.jsp">HOME</a></li>
                                                                <li><a href="Donor_Details.jsp">Donor Details</a></li>
                                                                <li><a href="Charity_Details.jsp">Charity Details</a>
                                                                </li>
                                                                <li><a href="Donations_Details.jsp">Donations</a></li>
                                                                <li><a href="Campaigns_Details.jsp">Campaigns</a></li>
                                                                <li><a class="is-active"
                                                                        href="ATransactions.jsp">Transactions</a></li>
                                                                <li><a href="Graph.jsp">Graph</a></li>
                                                                <li><a href="logout.jsp">Logout</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </nav>
                                        </header>

                                        <div class="page-heading text-center">
                                            <div class="container">
                                                <h1 class="page-title">Transaction Details<span
                                                        class="title-under"></span></h1>
                                            </div>
                                        </div>

                                        <div class="main-container">
                                            <div class="container">
                                                <h2>Transaction Details</h2><br>
                                                <table id="customers">
                                                    <thead>
                                                        <tr>
                                                            <th>Transaction ID</th>
                                                            <th>Donor Name</th>
                                                            <th>Charity Name</th>
                                                            <th>Campaign Name</th>
                                                            <th>Payment Mode</th>
                                                            <th>Donation Amount</th>
                                                            <th>Paid On</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%if(errMsg!=null){%>
                                                            <tr>
                                                                <td colspan="7">Error: <%=errMsg%>
                                                                </td>
                                                            </tr>
                                                            <%}else{%>
                                                                <%for(int i=0;i<rows.size();i++){%>
                                                                    <%String[] r=(String[])rows.get(i);%>
                                                                        <tr>
                                                                            <td><a href="ATrack.jsp" style="color:red">
                                                                                    <%=r[0]%>
                                                                                </a></td>
                                                                            <td>
                                                                                <%=r[1]%>
                                                                            </td>
                                                                            <td>
                                                                                <%=r[2]%>
                                                                            </td>
                                                                            <td>
                                                                                <%=r[3]%>
                                                                            </td>
                                                                            <td>
                                                                                <%=r[4]%>
                                                                            </td>
                                                                            <td>
                                                                                <%=r[5]%>
                                                                            </td>
                                                                            <td>
                                                                                <%=r[6]%>
                                                                            </td>
                                                                        </tr>
                                                                        <%}%>
                                                                            <%}%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <footer class="main-footer">
                                            <div class="footer-top"></div>
                                            <div class="footer-main">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="footer-col">
                                                                <h4 class="footer-title">About us <span
                                                                        class="title-under"></span></h4>
                                                                <div class="footer-content">
                                                                    <p>The aim of this project is to develop a system to
                                                                        track donation.</p>
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
                                        <script
                                            src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                                        <script src="assets/js/bootstrap.min.js"></script>
                                        <script src="assets/js/main.js"></script>
                                    </body>

                    </html>