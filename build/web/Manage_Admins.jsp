<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% ArrayList pIdList=new ArrayList(); ArrayList pNameList=new ArrayList(); ArrayList aIdList=new
                    ArrayList(); ArrayList aNameList=new ArrayList(); ArrayList aMailList=new ArrayList(); ArrayList
                    aPhoneList=new ArrayList(); ArrayList aPanchList=new ArrayList(); String errMsg=null; Connection
                    con=null; try { con=SQLconnection.getconnection(); if (con !=null) { Statement
                    st1=con.createStatement(); ResultSet
                    rs1=st1.executeQuery( "SELECT * FROM panchayat ORDER BY panchayat_name" ); while (rs1.next()) {
                    pIdList.add(String.valueOf(rs1.getInt("id"))); pNameList.add(rs1.getString("panchayat_name")); }
                    Statement st2=con.createStatement(); ResultSet
                    rs2=st2.executeQuery( "SELECT a.*, p.panchayat_name FROM admin_reg a LEFT JOIN panchayat p ON a.panchayat_id = p.id ORDER BY a.id DESC"
                    ); while (rs2.next()) { aIdList.add(rs2.getString("id")); aNameList.add(rs2.getString("Name"));
                    aMailList.add(rs2.getString("Mailid")); aPhoneList.add(rs2.getString("Phone")); String
                    pn=rs2.getString("panchayat_name"); if (pn==null) pn="N/A" ; aPanchList.add(pn); } } } catch
                    (Exception ex) { ex.printStackTrace(); errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - Manage Admins</title>
                        <meta name="description" content="">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
                        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                        <link rel="stylesheet" href="assets/css/owl.carousel.css">
                        <link rel="stylesheet" href="assets/css/style.css">
                        <script src="assets/js/modernizr-2.6.2.min.js"></script>
                    </head>

                    <body>
                        <header class="main-header">
                            <nav class="navbar navbar-static-top">
                                <div class="navbar-top">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-sm-6 col-xs-12">
                                                <ul class="list-unstyled list-inline header-contact">
                                                    <li><i class="fa fa-phone"></i> <a href="tel:">+61 123456789</a>
                                                    </li>
                                                    <li><i class="fa fa-envelope"></i> <a
                                                            href="#">contact@DONATION.org</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6 col-xs-12 text-right">
                                                <ul class="list-unstyled list-inline header-social">
                                                    <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-google"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                                                    <li><a href="#"><i class="fa fa-pinterest-p"></i></a></li>
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
                                                <span class="icon-bar"></span><span class="icon-bar"></span><span
                                                    class="icon-bar"></span>
                                            </button>
                                            <a class="navbar-brand" href="SuperAdmin_home.jsp">DONATION TRACKING
                                                SYSTEM</a>
                                        </div>
                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                            <ul class="nav navbar-nav">
                                                <li><a href="SuperAdmin_home.jsp">HOME</a></li>
                                                <li><a href="Manage_Panchayats.jsp">Manage Panchayats</a></li>
                                                <li><a class="is-active" href="Manage_Admins.jsp">Manage Admins</a></li>
                                                <li><a href="SA_Donors.jsp">Donors</a></li>
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
                                <h1 class="page-title">Manage Panchayat Admins <span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-8 col-md-offset-2">
                                        <h3>Add New Admin</h3>
                                        <form action="manage_admin" method="post">
                                            <input type="hidden" name="action" value="add">
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input type="text" class="form-control" name="name" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="email" class="form-control" name="mailid" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Phone</label>
                                                <input type="text" class="form-control" name="phone" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Password</label>
                                                <input type="password" class="form-control" name="password" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Panchayat</label>
                                                <select class="form-control" name="panchayat_id" required>
                                                    <option value="">Select Panchayat</option>
                                                    <% for (int i=0; i < pIdList.size(); i++) { %>
                                                        <% String xid=(String)pIdList.get(i); %>
                                                            <% String xnm=(String)pNameList.get(i); %>
                                                                <option value="<%=xid%>">
                                                                    <%=xnm%>
                                                                </option>
                                                                <% } %>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Add Admin</button>
                                        </form>
                                        <hr>
                                        <h3>Existing Admins</h3>
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Panchayat</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (errMsg !=null) { %>
                                                    <tr>
                                                        <td colspan="6">Error: <%=errMsg%>
                                                        </td>
                                                    </tr>
                                                    <% } else { %>
                                                        <% for (int i=0; i < aIdList.size(); i++) { %>
                                                            <% String aid=(String)aIdList.get(i); %>
                                                                <% String anm=(String)aNameList.get(i); %>
                                                                    <% String aml=(String)aMailList.get(i); %>
                                                                        <% String aph=(String)aPhoneList.get(i); %>
                                                                            <% String apn=(String)aPanchList.get(i); %>
                                                                                <tr>
                                                                                    <td>
                                                                                        <%=aid%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%=anm%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%=aml%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%=aph%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%=apn%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <form action="manage_admin"
                                                                                            method="post"
                                                                                            style="display:inline;"
                                                                                            onsubmit="return confirm('Delete this admin?');">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="delete">
                                                                                            <input type="hidden"
                                                                                                name="admin_id"
                                                                                                value="<%=aid%>">
                                                                                            <button type="submit"
                                                                                                class="btn btn-danger btn-sm">Delete</button>
                                                                                        </form>
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