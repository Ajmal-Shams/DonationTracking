<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <% String id=request.getParameter("id"); Connection con=SQLconnection.getconnection(); Statement
                st=con.createStatement(); String q="SELECT * FROM campaign WHERE id" + "='" + id + "'" ; ResultSet
                rs=st.executeQuery(q); String vCampName=null; String vCampDes=null; String vAmount=null; String
                vEndDate=null; double vMinDonation=0; double vMaxDonation=0; String vMinType=null; String vMaxType=null;
                boolean found=false; if (rs.next()) { found=true; vCampName=rs.getString(2); vCampDes=rs.getString(3);
                vAmount=rs.getString(5); vEndDate=rs.getString(6); vMinDonation=rs.getDouble(13);
                vMaxDonation=rs.getDouble(14); vMinType=rs.getString(15); vMaxType=rs.getString(16); } %>
                <!DOCTYPE html>
                <html class="no-js">

                <head>
                    <meta charset="utf-8">
                    <title>Edit Campaign - DONATION TRACKING SYSTEM</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                        type='text/css'>
                    <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet' type='text/css'>
                    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                    <link rel="stylesheet" href="assets/css/style.css">
                    <script src="assets/js/modernizr-2.6.2.min.js"></script>
                </head>

                <body>
                    <header class="main-header">
                        <nav class="navbar navbar-static-top">
                            <div class="navbar-main">
                                <div class="container">
                                    <div class="navbar-header">
                                        <a class="navbar-brand" href="Charity_home.jsp">DONATION TRACKING SYSTEM</a>
                                    </div>
                                    <div id="navbar" class="navbar-collapse collapse pull-right">
                                        <ul class="nav navbar-nav">
                                            <li><a href="Charity_home.jsp">HOME</a></li>
                                            <li><a href="Add_Campaigns.jsp">Add Campaigns</a></li>
                                            <li><a class="is-active" href="View_Campaigns_Details.jsp">Campaigns</a>
                                            </li>
                                            <li><a href="logout.jsp">Logout</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </nav>
                    </header>
                    <div class="page-heading text-center">
                        <div class="container">
                            <h1 class="page-title">Edit Fundraising Campaign<span class="title-under"></span></h1>
                        </div>
                    </div>
                    <div class="main-container">
                        <div class="container">
                            <div class="row" style="margin-left: 200px">
                                <div class="modal-body col-md-8">
                                    <% if (found) { %>
                                        <form class="form-donation" action="Update_Campaign" method="post"
                                            enctype="multipart/form-data">
                                            <input type="hidden" name="id" value="<%=id%>">
                                            <h3 class="title-style-1 text-center">Edit Campaign Details<span
                                                    class="title-under"></span></h3>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <label>Campaign Name</label><br>
                                                    <input type="text" class="form-control" name="Fname"
                                                        value="<%=vCampName%>" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <label>Campaign Image (Leave blank to keep current)</label><br>
                                                    <input type="file" class="form-control" name="Fpic">
                                                    <small>Current: <img src="campic.jsp?id=<%=id%>"
                                                            height="50"></small>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <label>Description</label><br>
                                                    <textarea name="Fdes" rows="5" class="form-control"
                                                        required><%=vCampDes%></textarea>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <label>Amount Goal</label><br>
                                                    <input type="number" class="form-control" name="Amount"
                                                        value="<%=vAmount%>" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Min Donation Per User</label><br>
                                                    <input type="number" step="0.01" class="form-control"
                                                        name="min_donation" value="<%=vMinDonation%>">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Type</label><br>
                                                    <select class="form-control" name="min_donation_type">
                                                        <option value="Number" <% if ("Number".equals(vMinType)) { %>
                                                            selected<% } %>>Fixed Amount ($)</option>
                                                        <option value="Percentage" <% if ("Percentage".equals(vMinType))
                                                            { %>selected<% } %>>Percentage of Goal (%)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Max Donation Per User</label><br>
                                                    <input type="number" step="0.01" class="form-control"
                                                        name="max_donation" value="<%=vMaxDonation%>">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Type</label><br>
                                                    <select class="form-control" name="max_donation_type">
                                                        <option value="Number" <% if ("Number".equals(vMaxType)) { %>
                                                            selected<% } %>>Fixed Amount ($)</option>
                                                        <option value="Percentage" <% if ("Percentage".equals(vMaxType))
                                                            { %>selected<% } %>>Percentage of Goal (%)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <label>End Date</label><br>
                                                    <input type="date" class="form-control" name="Fdate"
                                                        value="<%=vEndDate%>" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <button type="submit" class="btn btn-primary pull-center">Update
                                                        Campaign</button>
                                                </div>
                                            </div>
                                        </form>
                                        <% } else { %>
                                            <p>Campaign not found.</p>
                                            <% } %>
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