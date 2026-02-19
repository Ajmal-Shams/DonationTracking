<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% String q="" ; String role=(String) session.getAttribute("role"); Integer pId=(Integer)
                    session.getAttribute("panchayat_id"); /* Security and Filtering with Admin Name Join */ if
                    ("superadmin".equals(role)) {
                    q="SELECT t.*, a.Name as admin_name FROM transaction t LEFT JOIN admin_reg a ON t.panchayat_id = a.panchayat_id WHERE t.donationStatus IN ('Approved', 'Refund')"
                    ; } else if ("panchayat_admin".equals(role) && pId !=null) {
                    q="SELECT t.*, a.Name as admin_name FROM transaction t LEFT JOIN admin_reg a ON t.panchayat_id = a.panchayat_id WHERE t.donationStatus IN ('Approved', 'Refund') AND t.panchayat_id="
                    + pId; } else { /* Fallback / Unauthorized */
                    q="SELECT *, 'N/A' as admin_name FROM transaction WHERE 1=0" ; } ArrayList rows=new ArrayList();
                    String errMsg=null; Connection con=null; try { con=SQLconnection.getconnection(); if (con !=null) {
                    Statement st=con.createStatement(); ResultSet rs=st.executeQuery(q); while (rs.next()) { String[]
                    r=new String[9]; r[0]=rs.getString("Tid"); r[1]=rs.getString("cname");
                    r[2]=rs.getString("campName"); r[3]=rs.getString("dname"); r[4]=rs.getString("payment");
                    r[5]=rs.getString("amount"); r[6]=rs.getString("TofPayement"); /* Paid On */
                    r[7]=rs.getString("donationStatus"); String adminName=rs.getString("admin_name"); if
                    (adminName==null || adminName.isEmpty()) { adminName="System Admin" ; } r[8]=adminName; rows.add(r);
                    } } } catch (Exception ex) { ex.printStackTrace(); errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - History</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
                        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                        <link rel="stylesheet" href="assets/css/style.css">
                        <link rel="stylesheet" href="assets/css/table.css">
                        <script src="assets/js/modernizr-2.6.2.min.js"></script>
                    </head>

                    <body>
                        <header class="main-header">
                            <nav class="navbar navbar-static-top">
                                <div class="navbar-main">
                                    <div class="container">
                                        <div class="navbar-header">
                                            <a class="navbar-brand" href="Admin_home.jsp">DONATION TRACKING SYSTEM</a>
                                        </div>
                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                            <ul class="nav navbar-nav">
                                                <li><a href="Admin_home.jsp">HOME</a></li>
                                                <li><a href="Donations_Details.jsp">Back to Donations</a></li>
                                                <li><a href="logout.jsp">Logout</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </header>

                        <div class="page-heading text-center">
                            <div class="container">
                                <h1 class="page-title">Donation History<span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container">
                            <div class="container">
                                <table id="customers">
                                    <thead>
                                        <tr>
                                            <th>Transaction ID</th>
                                            <th>Charity</th>
                                            <th>Campaign</th>
                                            <th>Donor</th>
                                            <th>Mode</th>
                                            <th>Amount</th>
                                            <th>Paid On</th>
                                            <th>Status</th>
                                            <th>Action By</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (errMsg !=null) { %>
                                            <tr>
                                                <td colspan="9">Error: <%=errMsg%>
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
                                                            <td>
                                                                <%=r[7]%>
                                                            </td>
                                                            <td>
                                                                <%=r[8]%>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                            <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                        <script src="assets/js/bootstrap.min.js"></script>
                        <script src="assets/js/main.js"></script>
                    </body>

                    </html>