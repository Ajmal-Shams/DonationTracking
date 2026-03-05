<%-- Document : donatePage Created on : Nov 19, 2022, 9:00:13 PM Author : Murthi --%>

    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="java.sql.Connection" %>
                <%@page import="DonationTracking.SQLconnection" %>

                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
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

                            <!-- Font awesome -->
                            <link rel="stylesheet" href="assets/css/font-awesome.min.css">

                            <!-- Owl carousel -->
                            <link rel="stylesheet" href="assets/css/owl.carousel.css">

                            <!-- Template main Css -->
                            <link rel="stylesheet" href="assets/css/style.css">
                            <link rel="stylesheet" href="assets/css/table.css">

                            <!-- Modernizr -->
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
                                                    </ul> <!-- /.header-contact  -->

                                                </div>

                                                <div class="col-sm-6 col-xs-12 text-right">

                                                    <ul class="list-unstyled list-inline header-social">

                                                        <li> <a href="#"> <i class="fa fa-facebook"></i> </a> </li>
                                                        <li> <a href="#"> <i class="fa fa-twitter"></i> </a> </li>
                                                        <li> <a href="#"> <i class="fa fa-google"></i> </a> </li>
                                                        <li> <a href="#"> <i class="fa fa-youtube"></i> </a> </li>
                                                        <li> <a href="#"> <i class="fa fa fa-pinterest-p"></i> </a>
                                                        </li>
                                                    </ul> <!-- /.header-social  -->

                                                </div>


                                            </div>
                                        </div>

                                    </div>

                                    <div class="navbar-main">

                                        <div class="container">

                                            <div class="navbar-header">
                                                <button type="button" class="navbar-toggle collapsed"
                                                    data-toggle="collapse" data-target="#navbar" aria-expanded="false"
                                                    aria-controls="navbar">

                                                    <span class="sr-only">Toggle navigation</span>
                                                    <span class="icon-bar"></span>
                                                    <span class="icon-bar"></span>
                                                    <span class="icon-bar"></span>

                                                </button>

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

                                            </div> <!-- /#navbar -->

                                        </div> <!-- /.container -->

                                    </div> <!-- /.navbar-main -->


                                </nav>

                            </header> <!-- /. main-header -->

                            <div class="page-heading text-center">

                                <div class="container ">

                                    <h1 class="page-title">Donation<span class="title-under"></span></h1>
                                    <p class="page-description">
                                    </p>

                                </div>

                            </div>

                            <div class="our-team ">

                                <div class="container">
                                    <div class="row">

                                        <% String dpCid=request.getParameter("id"); Connection con=null; Statement
                                            st=null; ResultSet rs=null; try {
                                            con=DonationTracking.SQLconnection.getconnection();
                                            st=con.createStatement(); String
                                            dpQ="SELECT c.*, cr.min_donation as char_min, cr.max_donation as char_max, cr.min_donation_type as char_min_type, cr.max_donation_type as char_max_type FROM campaign c JOIN charity_reg cr ON c.cid = cr.id WHERE c.id='"
                                            + dpCid + "'" ; rs=st.executeQuery(dpQ); if (rs.next()) { double
                                            total=rs.getDouble("Amount"); double collected=rs.getDouble("AmountCol");
                                            double remaining=total - collected; String
                                            lErr=request.getParameter("LimitError"); if (lErr !=null) lErr=lErr.trim();
                                            String lErrLower=(lErr !=null) ? lErr.toLowerCase() : "" ; boolean
                                            hasError=(lErr !=null && !lErr.isEmpty()); if (total> 0 && collected
                                            >= total && !hasError) {
                                            response.sendRedirect("DonorViewCampaign.jsp?GoalReached"); return; } double
                                            cMin = rs.getDouble("min_donation"); double cMax =
                                            rs.getDouble("max_donation"); String cMinT =
                                            rs.getString("min_donation_type"); String cMaxT =
                                            rs.getString("max_donation_type"); double chMin = rs.getDouble("char_min");
                                            double chMax = rs.getDouble("char_max"); String chMinT =
                                            rs.getString("char_min_type"); String chMaxT =
                                            rs.getString("char_max_type"); if (cMinT == null) cMinT = "Number"; if
                                            (cMaxT == null) cMaxT = "Number"; if (chMinT == null) chMinT = "Number"; if
                                            (chMaxT == null) chMaxT = "Number"; double absCMin =
                                            "Percentage".equals(cMinT) ? (cMin * total / 100) : cMin; double absCMax =
                                            "Percentage".equals(cMaxT) ? (cMax * total / 100) : cMax; double absChMin =
                                            "Percentage".equals(chMinT) ? (chMin * total / 100) : chMin; double absChMax
                                            = "Percentage".equals(chMaxT) ? (chMax * total / 100) : chMax; double effMin
                                            = Math.max(absCMin, absChMin); double effMax = Double.MAX_VALUE; if (absCMax
                                            > 0) effMax = Math.min(effMax, absCMax); if (absChMax > 0) effMax =
                                            Math.min(effMax, absChMax); effMax = Math.min(effMax, remaining); String
                                            dpMn = String.format("%.2f", effMin); String dpMx = (effMax ==
                                            Double.MAX_VALUE) ? "No-Limit" : String.format("%.2f", effMax); String
                                            vCname = rs.getString("cname"); String vCampName = rs.getString("campName");
                                            String vCampDes = rs.getString("CampDes"); String hId = rs.getString("id");
                                            String hCid = rs.getString("cid"); String remStr = String.format("%.2f",
                                            remaining); %>

                                            <div class="row">
                                                <div class="col-md-6 col-md-offset-3">
                                                    <% if (hasError) { %>
                                                        <div class="alert alert-danger"
                                                            style="margin-bottom: 30px; border: 1px solid #ebccd1; border-radius: 4px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); background-color: #f2dede;">
                                                            <div style="padding: 15px;">
                                                                <h4
                                                                    style="margin-top: 0; color: #a94442; font-weight: bold;">
                                                                    <i class="fa fa-exclamation-triangle"></i> Donation
                                                                    Requirement Not Met
                                                                </h4>
                                                                <hr style="border-top-color: #ebccd1; margin: 10px 0;">
                                                                <p style="font-size: 16px; color: #a94442;">
                                                                    <% if (lErrLower.contains("minlimit")) { %>
                                                                        Required Minimum: <strong>$
                                                                            <%=request.getParameter("min")%>
                                                                        </strong>.
                                                                        <% } else if (lErrLower.contains("maxlimit")) {
                                                                            %>
                                                                            Allowed Maximum: <strong>$
                                                                                <%=request.getParameter("max")%>
                                                                            </strong>.
                                                                            <% } else if
                                                                                (lErrLower.contains("goalexceeded")) {
                                                                                %>
                                                                                Remaining Goal: <strong>$
                                                                                    <%=request.getParameter("remaining")%>
                                                                                </strong>. (Your amount exceeds
                                                                                this).
                                                                                <% } else { %>
                                                                                    Please review the donation limits
                                                                                    and try again.
                                                                                    <% } %>
                                                                </p>
                                                                <div style="margin-top: 15px;">
                                                                    <button type="button" class="btn btn-danger"
                                                                        onclick="document.getElementsByName('amount')[0].focus();"
                                                                        style="font-weight: bold; padding: 8px 20px;">TRY
                                                                        AGAIN</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <% } %>
                                                </div>
                                            </div>

                                            <div class="col-md-6 col-md-offset-3">
                                                <form class="form-donation" action="donate" method="post"
                                                    style="padding: 30px; background: #fff; border: 1px solid #eee; border-radius: 8px; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                                                    <h3 class="title-style-1 text-center"
                                                        style="margin-top: 0; margin-bottom: 30px;">Make a Donation
                                                        <span class="title-under"></span>
                                                    </h3>

                                                    <div class="row">
                                                        <div class="form-group col-md-12">
                                                            <label>Charity Name</label>
                                                            <input type="text" class="form-control" name="cname"
                                                                readonly="" value="<%=vCname%>">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-12">
                                                            <label>Campaign Name</label>
                                                            <input type="text" class="form-control" name="campName"
                                                                readonly="" value="<%=vCampName%>">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label style="color: #8a6d3b;">Minimum Allowed</label>
                                                            <input type="text" class="form-control" readonly=""
                                                                value="$<%=dpMn%>"
                                                                style="background-color: #fcf8e3; border: 1px solid #faebcc; font-weight: bold; color: #8a6d3b;">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label style="color: #31708f;">Maximum Allowed</label>
                                                            <input type="text" class="form-control" readonly=""
                                                                value="$<%=dpMx%>"
                                                                style="background-color: #d9edf7; border: 1px solid #bce8f1; font-weight: bold; color: #31708f;">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-12">
                                                            <label>Description</label>
                                                            <textarea name="CampDes" class="form-control" readonly=""
                                                                rows="4" style="resize: none;"><%=vCampDes%></textarea>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" name="charity_id" value="<%=hCid%>">
                                                    <input type="hidden" name="campaign_id" value="<%=hId%>">

                                                    <div class="row" style="margin-top: 15px;">
                                                        <div class="form-group col-md-12">
                                                            <label>Payment Mode</label><br>
                                                            <div
                                                                style="padding: 12px; background: #fefefe; border: 1px solid #ddd; border-radius: 4px;">
                                                                <input type="radio" name="payment" required=""
                                                                    value="Net Banking"> <label
                                                                    style="font-weight: normal; margin-right: 25px;">Net
                                                                    Banking</label>
                                                                <input type="radio" name="payment" required=""
                                                                    value="Credit/Debit"> <label
                                                                    style="font-weight: normal;">Credit/Debit
                                                                    Card</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-top: 15px;">
                                                        <div class="form-group col-md-12">
                                                            <label>Donation Amount (&dollar;)</label>
                                                            <input type="text" class="form-control" name="amount"
                                                                required="" placeholder="Enter amount..."
                                                                style="height: 45px; font-size: 18px;">

                                                            <div class="alert alert-info"
                                                                style="margin-top:20px; border-left: 5px solid #31708f; background-color: #f7fbfc; color: #31708f;">
                                                                <h4 style="margin-top: 0;"><i
                                                                        class="fa fa-info-circle"></i> Donation
                                                                    Guidelines</h4>
                                                                <table class="table"
                                                                    style="margin-bottom: 0; background: transparent;">
                                                                    <tr>
                                                                        <td style="border-top: 0; padding: 5px 0;">
                                                                            <strong>Remaining Goal:</strong>
                                                                        </td>
                                                                        <td
                                                                            style="border-top: 0; padding: 5px 0; text-align: right; font-weight: bold;">
                                                                            $<%=remStr%>
                                                                        </td>
                                                                    </tr>
                                                                    <% if (effMin> 0.01) { %>
                                                                        <tr>
                                                                            <td style="padding: 5px 0;">
                                                                                <strong>Min Required:</strong>
                                                                            </td>
                                                                            <td
                                                                                style="padding: 5px 0; text-align: right; font-weight: bold;">
                                                                                $<%=dpMn%>
                                                                            </td>
                                                                        </tr>
                                                                        <% } if (effMax < Double.MAX_VALUE && effMax>
                                                                            0) { %>
                                                                            <tr>
                                                                                <td style="padding: 5px 0;">
                                                                                    <strong>Max Allowed:</strong>
                                                                                </td>
                                                                                <td
                                                                                    style="padding: 5px 0; text-align: right; font-weight: bold;">
                                                                                    $<%=dpMx%>
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                </table>
                                                                <p style="margin-top: 10px; margin-bottom: 0;"><small
                                                                        style="color: #666;">*Limits are calculated
                                                                        based on both campaign and charity
                                                                        policies.</small></p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-top: 25px;">
                                                        <div class="form-group col-md-12 text-center">
                                                            <button type="submit" class="btn btn-primary btn-lg"
                                                                style="width: 100%; font-weight: bold; text-transform: uppercase;"
                                                                name="donateNow">DONATE NOW</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <% } } catch (Exception e) { e.printStackTrace(); } finally { if (rs !=null)
                                                rs.close(); if (st !=null) st.close(); if (con !=null) con.close(); } %>
                                    </div>
                                </div>
                                <br><br><br>


                                <footer class="main-footer">

                                    <div class="footer-top">

                                    </div>


                                    <div class="footer-main">
                                        <div class="container">

                                            <div class="row">
                                                <div class="col-md-4">

                                                    <div class="footer-col">

                                                        <h4 class="footer-title">About us <span
                                                                class="title-under"></span>
                                                        </h4>

                                                        <div class="footer-content">

                                                            <p>
                                                                The aim of this project is to develop a system to track
                                                                donation. The users are admin , donor
                                                                and charity. This system helps the donors to track their
                                                                donation. This system consisted 5
                                                                modules. Besides that, this system also helps the
                                                                charity
                                                                request for donation. Meanwhile, the
                                                                admin will manage the charity and donors.
                                                            </p>
                                                        </div>

                                                    </div>

                                                </div>

                                                <div class="col-md-4">

                                                </div>


                                                <div class="col-md-4">

                                                    <div class="footer-col">


                                                        <div class="footer-content">
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="clearfix"></div>



                                            </div>


                                        </div>


                                    </div>

                                    <div class="footer-bottom">

                                        <div class="container text-right">
                                            DONATION TRACKING SYSTEM
                                        </div>
                                    </div>

                                </footer> <!-- main-footer -->

                                <!-- jQuery -->
                                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

                                <!-- Bootsrap javascript file -->
                                <script src="assets/js/bootstrap.min.js"></script>



                                <!-- Template main javascript -->
                                <script src="assets/js/main.js"></script>
                        </body>

                        </html>