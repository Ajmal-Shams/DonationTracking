<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="java.sql.Connection" %>
                <%@page import="DonationTracking.SQLconnection" %>
                    <%@page import="java.util.ArrayList" %>

                        <!DOCTYPE html>
                        <html class="no-js">

                        <head>
                            <meta charset="utf-8">
                            <title>DONATION TRACKING SYSTEM</title>
                            <meta name="description" content="">
                            <meta name="viewport" content="width=device-width, initial-scale=1">
                            <!-- Fonts -->
                            <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                                type='text/css'>
                            <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                                type='text/css'>

                            <!-- Bootsrap -->
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
                                                        <li> <i class="fa fa-phone"></i> <a href="tel:">+61 123456789
                                                            </a> </li>
                                                        <li> <i class="fa fa-envelope"></i> <a
                                                                href="#">contact@DONATION.org</a> </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="navbar-main">
                                        <div class="container">
                                            <div class="navbar-header">
                                                <a class="navbar-brand" href="donor_home.jsp">DONATION TRACKING
                                                    SYSTEM</a>
                                            </div>
                                            <div id="navbar" class="navbar-collapse collapse pull-right">
                                                <ul class="nav navbar-nav">
                                                    <li><a href="donor_home.jsp">HOME</a></li>
                                                    <li><a class="is-active" href="Donate.jsp">Donate</a></li>
                                                    <li><a href="Dreqest.jsp">Donation Request</a></li>
                                                    <li><a href="Donation_Status.jsp">Track Donation</a></li>
                                                    <li><a href="DTransactions.jsp">Transactions</a></li>
                                                    <li><a href="logout.jsp">Logout</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </nav>
                            </header>

                            <div class="page-heading text-center">
                                <div class="container ">
                                    <h1 class="page-title">Donate<span class="title-under"></span></h1>
                                    <p class="page-description"></p>
                                </div>
                            </div>

                            <div class="our-team ">
                                <div class="container">
                                    <h2 class="title-style-1">Campaigns <span class="title-under"></span></h2>

                                    <!-- Filter Section -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <form action="DonorViewCampaign.jsp" method="get" class="form-inline"
                                                style="margin-bottom: 20px;">
                                                <div class="form-group">
                                                    <label for="panchayat">Filter by Panchayat: </label>
                                                    <select name="panchayat" class="form-control"
                                                        onchange="this.form.submit()">
                                                        <option value="">All Panchayats</option>
                                                        <% Connection con=null; try { con=SQLconnection.getconnection();
                                                            Statement stP=con.createStatement(); String
                                                            selectedPanchayat=request.getParameter("panchayat");
                                                            ResultSet rsP=stP.executeQuery("SELECT * FROM panchayat");
                                                            while(rsP.next()){ String pId=rsP.getString("id"); String
                                                            pName=rsP.getString("panchayat_name"); String
                                                            selected=(pId.equals(selectedPanchayat)) ? "selected" : "" ;
                                                            %>
                                                            <option value="<%=pId%>" <%=selected%>><%=pName%>
                                                            </option>
                                                            <% } } catch(Exception e) { e.printStackTrace(); } %>
                                                    </select>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="row" style="display: flex; flex-wrap: wrap;">
                                        <% Statement st=null; ResultSet rs=null; try { if (con !=null) {
                                            st=con.createStatement(); String
                                            query="SELECT c.id AS campaign_id, c.*, p.panchayat_name FROM campaign c "
                                            + "JOIN charity_reg cr ON c.cid = cr.id "
                                            + "JOIN panchayat p ON cr.panchayat_id = p.id "
                                            + "WHERE c.CampStatus='Active'" ; String
                                            selectedPanchayat=request.getParameter("panchayat"); if (selectedPanchayat
                                            !=null && !selectedPanchayat.isEmpty()) { query +=" AND cr.panchayat_id = "
                                            + selectedPanchayat; } rs=st.executeQuery(query); java.text.NumberFormat
                                            nf=java.text.NumberFormat.getInstance(); nf.setMaximumFractionDigits(0);
                                            while (rs.next()) { String cId=rs.getString("campaign_id"); int
                                            iTotal=rs.getInt("Amount"); int iAmountCol=rs.getInt("AmountCol"); String
                                            campName=rs.getString("campName"); String
                                            panchayatName=rs.getString("panchayat_name"); String
                                            campDes=rs.getString("CampDes"); int percentage=0; if (iTotal> 0) {
                                            percentage = (int) (((double)iAmountCol / iTotal) * 100);
                                            }
                                            // Cap at 100% for visual sanity
                                            if (percentage > 100) percentage = 100;

                                            // Format Numbers
                                            String fmtAmount = nf.format(iTotal);
                                            String fmtAmountCol = nf.format(iAmountCol);
                                            %>
                                            <div class="col-md-3 col-sm-6" style="margin-bottom: 30px;">
                                                <div class="cause"
                                                    style="height: 100%; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                                                    <img src="GetCampaignImage?id=<%=cId%>" alt="" class="cause-img"
                                                        style="height: 200px; width: 100%; object-fit: cover;">

                                                    <div class="progress cause-progress"
                                                        style="margin: 10px 0; background-color: #e9ecef;">
                                                        <div class="progress-bar progress-bar-success progress-bar-striped active"
                                                            role="progressbar" aria-valuenow="<%=percentage%>"
                                                            aria-valuemin="0" aria-valuemax="100"
                                                            style="width: <%=percentage%>%;">
                                                            <%=percentage%>%
                                                        </div>
                                                    </div>

                                                    <div class="currancy-details" style="padding: 0 15px;">
                                                        <span class="currency-label"
                                                            style="font-weight: bold; color: #5cb85c;">
                                                            Raised: $<%=fmtAmountCol%>
                                                        </span>
                                                        <span class="currency-label pull-right" style="color: #666;">
                                                            Goal: $<%=fmtAmount%>
                                                        </span>
                                                    </div>

                                                    <h4 class="cause-title" style="padding: 0 15px; margin-top: 10px;">
                                                        <a href="#">
                                                            <%=campName%>
                                                        </a>
                                                    </h4>

                                                    <div class="cause-details" style="padding: 0 15px 15px;">
                                                        <p class="text-muted"><small><i class="fa fa-map-marker"></i>
                                                                <%=panchayatName%>
                                                            </small></p>
                                                        <p>
                                                            <%=campDes%>
                                                        </p>
                                                    </div>

                                                    <div class="btn-holder text-center" style="padding-bottom: 20px;">
                                                        <% if (iAmountCol>= iTotal) { %>
                                                            <button class="btn btn-default" disabled
                                                                style="background-color: #f8f9fa; border-color: #ddd; color: #6c757d; cursor: not-allowed; font-weight: bold;">
                                                                GOAL REACHED</button>
                                                            <% } else { %>
                                                                <a href="donatePage.jsp?id=<%=cId%>"
                                                                    class="btn btn-primary">
                                                                    DONATE NOW</a>
                                                                <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } } } catch (Exception ex) { ex.printStackTrace(); } %>
                                    </div>
                                </div>
                            </div>

                            <footer class="main-footer">
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