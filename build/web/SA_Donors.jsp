<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% ArrayList rows=new ArrayList(); String errMsg=null; Connection con=null; try {
                    con=SQLconnection.getconnection(); if (con !=null) { Statement st=con.createStatement(); String
                    sql="SELECT d.*, p.panchayat_name FROM donor_reg d "
                    + "LEFT JOIN panchayat p ON d.panchayat_id = p.id " + "ORDER BY d.id DESC" ; ResultSet
                    rs=st.executeQuery(sql); while (rs.next()) { String[] r=new String[7]; r[0]=rs.getString("id");
                    r[1]=rs.getString("Name"); r[2]=rs.getString("Mailid"); r[3]=rs.getString("Phone");
                    r[4]=rs.getString("Address"); r[5]=rs.getString("panchayat_name"); if (r[5]==null) r[5]="N/A" ;
                    r[6]=rs.getString("Tor"); rows.add(r); } } } catch (Exception ex) { ex.printStackTrace();
                    errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - All Donors</title>
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
                                                <li><a class="is-active" href="SA_Donors.jsp">Donors</a></li>
                                                <li><a href="SA_Charities.jsp">Charities</a></li>
                                                <li><a href="SA_Campaigns.jsp">Campaigns</a></li>
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
                                <h1 class="page-title">All Donors <span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 class="pull-right">Total Donors: <strong>
                                                <%=rows.size()%>
                                            </strong></h4>
                                        <form action="delete_entity.jsp" method="post"
                                            onsubmit="return confirm('Are you sure you want to delete selected donors?');">
                                            <input type="hidden" name="type" value="donor">
                                            <button type="submit" class="btn btn-danger"
                                                style="margin-bottom: 10px;">Delete Selected</button>

                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th><input type="checkbox" onClick="toggle(this)"></th>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Mail Id</th>
                                                        <th>Phone</th>
                                                        <th>Address</th>
                                                        <th>Panchayat</th>
                                                        <th>Registered Date</th>
                                                        <th>Action</th>
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
                                                                            <%=r[5]%>
                                                                        </td>
                                                                        <td>
                                                                            <%=r[6]%>
                                                                        </td>
                                                                        <td>
                                                                            <a href="delete_entity.jsp?type=donor&id=<%=r[0]%>"
                                                                                class="btn btn-danger btn-xs"
                                                                                onclick="return confirm('Delete this donor?')">Delete</a>
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