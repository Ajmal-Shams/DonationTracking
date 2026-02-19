<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% ArrayList rows=new ArrayList(); String errMsg=null; Connection con=null; try {
                    con=SQLconnection.getconnection(); if (con !=null) { Statement st=con.createStatement(); String
                    sql="SELECT * FROM transaction ORDER BY Tid DESC" ; ResultSet rs=st.executeQuery(sql); while
                    (rs.next()) { String[] r=new String[7]; r[0]=rs.getString("Tid"); r[1]=rs.getString("cname");
                    r[2]=rs.getString("campName"); r[3]=rs.getString("amount"); r[4]=rs.getString("dname");
                    r[5]=rs.getString("donationStatus"); r[6]=rs.getString("TofPayement"); rows.add(r); } } } catch
                    (Exception ex) { ex.printStackTrace(); errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - All Donations</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
                        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                        <link rel="stylesheet" href="assets/css/style.css">
                    </head>

                    <body>
                        <header class="main-header">
                            <nav class="navbar navbar-static-top">
                                <div class="navbar-main">
                                    <div class="container">
                                        <div class="navbar-header">
                                            <a class="navbar-brand" href="SuperAdmin_home.jsp">DONATION TRACKING
                                                SYSTEM</a>
                                        </div>
                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                            <ul class="nav navbar-nav">
                                                <li><a href="SuperAdmin_home.jsp">HOME</a></li>
                                                <li><a href="Manage_Panchayats.jsp">Manage Panchayats</a></li>
                                                <li><a href="Manage_Admins.jsp">Manage Admins</a></li>
                                                <li><a href="SA_Donors.jsp">Donors</a></li>
                                                <li><a href="SA_Charities.jsp">Charities</a></li>
                                                <li><a href="SA_Campaigns.jsp">Campaigns</a></li>
                                                <li><a class="is-active" href="SA_Donations.jsp">Donations</a></li>
                                                <li><a href="SA_Transactions.jsp">Transactions</a></li>
                                                <li><a href="logout.jsp">Logout</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </header>

                        <div class="page-heading text-center">
                            <div class="container">
                                <h1 class="page-title">All Donations <span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Charity Name</th>
                                                    <th>Campaign</th>
                                                    <th>Amount</th>
                                                    <th>Donor Name</th>
                                                    <th>Status</th>
                                                    <th>Date</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (errMsg !=null) { %>
                                                    <tr>
                                                        <td colspan="7">Error: <%=errMsg%>
                                                        </td>
                                                    </tr>
                                                    <% } else { %>
                                                        <% for (int i=0; i < rows.size(); i++) { %>
                                                            <% String[] r=(String[]) rows.get(i); %>
                                                                <tr>
                                                                    <td>
                                                                        <%=r[0]%>
                                                                    </td>
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
                                                                <% } %>
                                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <footer class="main-footer">
                            <div class="footer-bottom">
                                <div class="container text-right">DONATION TRACKING SYSTEM</div>
                            </div>
                        </footer>
                        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                        <script src="assets/js/bootstrap.min.js"></script>
                        <script src="assets/js/main.js"></script>
                    </body>

                    </html>