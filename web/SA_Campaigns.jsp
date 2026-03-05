<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% String[] h={ "id" , "campName" , "CampDes" , "Amount" , "AmountCol" , "CampStatus" , "cname"
                    , "panchayat_name" , "StartDate" , "EndDate" , "N/A"
                    , "SELECT\u0020c.*,\u0020p.panchayat_name\u0020FROM\u0020campaign\u0020c\u0020"
                    , "LEFT\u0020JOIN\u0020panchayat\u0020p\u0020ON\u0020c.panchayat_id\u0020=\u0020p.id\u0020"
                    , "ORDER\u0020BY\u0020c.id\u0020DESC"
                    , "\u003cb\u0020style='color:red;'\u003eLOCKED\u0020(Goal\u0020Reached)\u003c/b\u003e" }; ArrayList
                    rows=new ArrayList(); String errMsg=null; java.sql.Connection con=null; try {
                    con=DonationTracking.SQLconnection.getconnection(); if (con !=null) { java.sql.Statement
                    st=con.createStatement(); java.sql.ResultSet rs=st.executeQuery(h[11] + h[12] + h[13]); while
                    (rs.next()) { String[] r=new String[12]; r[0]=rs.getString(h[0]); r[1]=rs.getString(h[1]);
                    r[2]=rs.getString(h[2]); r[3]=rs.getString(h[3]); r[4]=rs.getString(h[4]); r[5]=rs.getString(h[5]);
                    r[6]=rs.getString(h[6]); r[7]=rs.getString(h[7]); if (r[7]==null) r[7]=h[10];
                    r[8]=rs.getString(h[8]); r[9]=rs.getString(h[9]); try { r[10]=rs.getString("min_donation") + " (" +
                    rs.getString("min_donation_type") + ")" ; r[11]=rs.getString("max_donation") + " (" +
                    rs.getString("max_donation_type") + ")" ; } catch(Exception e2) { r[10]=h[10]; r[11]=h[10]; }
                    rows.add(r); } } } catch (Exception ex) { ex.printStackTrace(); errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - All Campaigns</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
                        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                        <link rel="stylesheet" href="assets/css/style.css">
                        <script>
                            function toggle(source) {
                                checkboxes = document.getElementsByName('ids');
                                for (var i = 0, n = checkboxes.length; i < n; i++) {
                                    checkboxes[i].checked = source.checked;
                                }
                            }
                        </script>
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
                                                <li><a class="is-active" href="SA_Campaigns.jsp">Campaigns</a></li>
                                                <li><a href="SA_Donations.jsp">Donations</a></li>
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
                                <h1 class="page-title">All Campaigns <span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 class="pull-right">Total Campaigns: <strong>
                                                <%=rows.size()%>
                                            </strong></h4>
                                        <form action="delete_entity.jsp" method="post"
                                            onsubmit="return confirm('Are you sure you want to delete selected campaigns?');">
                                            <input type="hidden" name="type" value="campaign">
                                            <button type="submit" class="btn btn-danger"
                                                style="margin-bottom: 10px;">Delete Selected</button>

                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th><input type="checkbox" onClick="toggle(this)"></th>
                                                        <th>ID</th>
                                                        <th>Campaign Name</th>
                                                        <th>Description</th>
                                                        <th>Amount</th>
                                                        <th>Collected</th>
                                                        <th>Status</th>
                                                        <th>Charity</th>
                                                        <th>Min Limit</th>
                                                        <th>Max Limit</th>
                                                        <th>Panchayat</th>
                                                        <th>Start Date</th>
                                                        <th>End Date</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% if (errMsg !=null) { %>
                                                        <tr>
                                                            <td colspan="12">Error: <%=errMsg%>
                                                            </td>
                                                        </tr>
                                                        <% } else { %>
                                                            <% for (int i=0; i < rows.size(); i++) { %>
                                                                <% String[] r=(String[]) rows.get(i); %>
                                                                    <tr>
                                                                        <td><input type="checkbox" name="ids"
                                                                                value="<%=r[0]%>"></td>
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
                                                                            <% double amt=0, col=0; try {
                                                                                amt=Double.parseDouble(r[3]); }
                                                                                catch(Exception e){} try {
                                                                                col=Double.parseDouble(r[4]); }
                                                                                catch(Exception e){} if (col>= amt &&
                                                                                amt > 0) {
                                                                                out.print(h[14]);
                                                                                } else {
                                                                                out.print(r[5]);
                                                                                }
                                                                                %>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[6]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[10]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[11]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[7]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[8]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[9]%>
                                                                        </td>
                                                                        <td>
                                                                            <a href="delete_entity.jsp?type=campaign&id=<%=r[0]%>"
                                                                                class="btn btn-danger btn-xs"
                                                                                onclick="return confirm('Delete this campaign?')">Delete</a>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                                        <% } %>
                                                </tbody>
                                            </table>
                                        </form>
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