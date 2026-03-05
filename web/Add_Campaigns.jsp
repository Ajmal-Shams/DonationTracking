<%-- Document : Add_Campaigns Created on : Nov 18, 2022, 10:22:45 PM Author : Murthi --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html class="no-js">

        <head>
            <meta charset="utf-8">
            <title>DONATION TRACKING SYSTEM</title>
            <meta name="description" content="">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- Fonts -->
            <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
            <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet' type='text/css'>

            <!-- Bootsrap -->
            <link rel="stylesheet" href="assets/css/bootstrap.min.css">

            <!-- Font awesome -->
            <link rel="stylesheet" href="assets/css/font-awesome.min.css">

            <!-- Owl carousel -->
            <link rel="stylesheet" href="assets/css/owl.carousel.css">

            <!-- Template main Css -->
            <link rel="stylesheet" href="assets/css/style.css">

            <!-- Modernizr -->
            <script src="assets/js/modernizr-2.6.2.min.js"></script>


        </head>
        <% if (request.getParameter("Added") !=null) {%>
            <script>alert('Campaign Registration Success ');</script>
            <%} %>

                <body>


                    <header class="main-header">


                        <nav class="navbar navbar-static-top">

                            <div class="navbar-top">

                                <div class="container">
                                    <div class="row">

                                        <div class="col-sm-6 col-xs-12">

                                            <ul class="list-unstyled list-inline header-contact">
                                                <li> <i class="fa fa-phone"></i> <a href="tel:">+61 123456789 </a> </li>
                                                <li> <i class="fa fa-envelope"></i> <a href="#">contact@DONATION.org</a>
                                                </li>
                                            </ul> <!-- /.header-contact  -->

                                        </div>

                                        <div class="col-sm-6 col-xs-12 text-right">

                                            <ul class="list-unstyled list-inline header-social">

                                                <li> <a href="#"> <i class="fa fa-facebook"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-twitter"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-google"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa-youtube"></i> </a> </li>
                                                <li> <a href="#"> <i class="fa fa fa-pinterest-p"></i> </a> </li>
                                            </ul> <!-- /.header-social  -->

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
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>

                                        </button>

                                        <a class="navbar-brand" href="Charity_home.jsp">DONATION TRACKING SYSTEM</a>

                                    </div>

                                    <div id="navbar" class="navbar-collapse collapse pull-right">

                                        <ul class="nav navbar-nav">

                                            <li><a href="Charity_home.jsp">HOME</a></li>
                                            <li><a class="is-active" href="Add_Campaigns.jsp">Add Campaigns</a></li>
                                            <li><a href="View_Campaigns_Details.jsp">Campaigns</a></li>
                                            <li><a href="request_donation.jsp">Request Donation</a></li>
                                            <li><a href="request_status.jsp">Request Status</a></li>
                                            <li><a href="CDonations_Details.jsp">Donations</a></li>
                                            <li><a href="CTransactions.jsp">Transactions</a></li>
                                            <li><a href="logout.jsp">Logout</a></li>

                                        </ul>

                                    </div> <!-- /#navbar -->

                                </div> <!-- /.container -->

                            </div> <!-- /.navbar-main -->


                        </nav>

                    </header> <!-- /. main-header -->

                    <div class="page-heading text-center">

                        <div class="container ">

                            <h1 class="page-title">Add Fundraising Campaign<span class="title-under"></span></h1>
                            <p class="page-description">
                            </p>

                        </div>

                    </div>

                    <div class="main-container  animated">

                        <div class="container">

                            <div class="row" style="margin-left: 300px">

                                <div class="modal-body col-md-8">

                                    <form class="form-donation" action="Add_Campaign" method="post"
                                        enctype="multipart/form-data">

                                        <h3 class="title-style-1 text-center">Fundraising Campaign Details<span
                                                class="title-under"></span> </h3>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label>Campaign Name</label><br>
                                                <input type="text" class="form-control" name="Fname"
                                                    placeholder="Campaign Name*" required="">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label>Campaign Image</label><br>
                                                <input type="file" class="form-control" name="Fpic"
                                                    placeholder="Campaign Pic*" required="">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label>Description</label><br>
                                                <textarea name="Fdes" rows="5" class="form-control"
                                                    placeholder="Description*" required></textarea>
                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="form-group col-md-12">
                                                <label>Amount</label><br>
                                                <input type="number" class="form-control" name="Amount"
                                                    placeholder="Amount Needed??" required="">
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label>Min Donation Per User</label><br>
                                                <input type="number" step="0.01" class="form-control"
                                                    name="min_donation" placeholder="Min Donation (optional)">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label>Min Donation Type</label><br>
                                                <select class="form-control" name="min_donation_type">
                                                    <option value="Number">Fixed Amount ($)</option>
                                                    <option value="Percentage">Percentage of Goal (%)</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label>Max Donation Per User</label><br>
                                                <input type="number" step="0.01" class="form-control"
                                                    name="max_donation" placeholder="Max Donation (optional)">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label>Max Donation Type</label><br>
                                                <select class="form-control" name="max_donation_type">
                                                    <option value="Number">Fixed Amount ($)</option>
                                                    <option value="Percentage">Percentage of Goal (%)</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">

                                            <div class="form-group col-md-12">
                                                <label>End Date</label><br>
                                                <input type="date" class="form-control" name="Fdate" required="">
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <button type="submit" class="btn btn-primary pull-center">Add</button>
                                            </div>

                                        </div>





                                    </form>

                                </div>

                            </div> <!-- /.row -->


                        </div>



                    </div>


                    <footer class="main-footer">

                        <div class="footer-top">

                        </div>


                        <div class="footer-main">
                            <div class="container">

                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="footer-col">

                                            <h4 class="footer-title">About us <span class="title-under"></span></h4>

                                            <div class="footer-content">

                                                <p>
                                                    The aim of this project is to develop a system to track donation.
                                                    The users are admin , donor
                                                    and charity. This system helps the donors to track their donation.
                                                    This system consisted 5
                                                    modules. Besides that, this system also helps the charity request
                                                    for donation. Meanwhile, the
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
                    <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>

                    <!-- Bootsrap javascript file -->
                    <script src="assets/js/bootstrap.min.js"></script>



                    <!-- Template main javascript -->
                    <script src="assets/js/main.js"></script>
                </body>

        </html>