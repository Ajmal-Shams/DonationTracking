<%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>Register - Charity</title>
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
                                                    <li> <i class="fa fa-phone"></i> <a href="tel:">+61 123456789 </a>
                                                    </li>
                                                    <li> <i class="fa fa-envelope"></i> <a
                                                            href="#">contact@DONATION.org</a> </li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6 col-xs-12 text-right">
                                                <ul class="list-unstyled list-inline header-social">
                                                    <li> <a href="#"> <i class="fa fa-facebook"></i> </a> </li>
                                                    <li> <a href="#"> <i class="fa fa-twitter"></i> </a> </li>
                                                    <li> <a href="#"> <i class="fa fa-google"></i> </a> </li>
                                                    <li> <a href="#"> <i class="fa fa-youtube"></i> </a> </li>
                                                    <li> <a href="#"> <i class="fa fa fa-pinterest-p"></i> </a> </li>
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
                                                <span class="icon-bar"></span>
                                                <span class="icon-bar"></span>
                                                <span class="icon-bar"></span>
                                            </button>
                                            <a class="navbar-brand" href="index.jsp">DONATION TRACKING SYSTEM</a>
                                        </div>
                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                            <ul class="nav navbar-nav">
                                                <li><a href="index.jsp">HOME</a></li>
                                                <li><a href="about.jsp">ABOUT</a></li>
                                                <li class="has-child"><a class="is-active" href="#">Apply</a>
                                                    <ul class="submenu">
                                                        <li class="submenu-item"><a href="donor_reg.jsp">Donor </a></li>
                                                        <li class="submenu-item"><a href="Charity_reg.jsp">Charity </a>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li><a href="contact.jsp">CONTACT</a></li>
                                                <li><a href="login.jsp">LOGIN</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </header>
                        <div class="page-heading text-center">
                            <div class="container zoomIn animated">
                                <h1 class="page-title">Register As Charity<span class="title-under"></span></h1>
                                <p class="page-description">
                                </p>
                            </div>
                        </div>
                        <div class="main-container fadeIn animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-7 col-sm-12 col-form">
                                        <h2 class="title-style-2">Register Form <span class="title-under"></span></h2>
                                        <form action="Charity_reg" method="post" class="contact-form">
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <input type="text" name="Charityname" class="form-control"
                                                        placeholder="Charity Name*" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <input type="text" class="form-control" name="email"
                                                        placeholder="Email*" required="">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <input type="text" class="form-control" name="phone"
                                                        placeholder="Phone*" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <input type="text" class="form-control" name="address"
                                                        placeholder="Address" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>District*</label>
                                                    <select class="form-control" id="districtSel" name="district" required="">
                                                        <option value="">-- Select District --</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Panchayat*</label>
                                                    <input type="text" class="form-control" id="panchayatSearch" placeholder="Search panchayat..." style="margin-bottom:5px;">
                                                    <select class="form-control" id="panchayatSel" name="panchayat_name" required="">
                                                        <option value="">-- Select Panchayat --</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Default Min Donation Per User</label>
                                                    <input type="number" step="0.01" class="form-control"
                                                        name="min_donation" placeholder="Min (Optional)">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Type</label>
                                                    <select class="form-control" name="min_donation_type">
                                                        <option value="Number">Fixed Amount ($)</option>
                                                        <option value="Percentage">Percentage of Goal (%)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Default Max Donation Per User</label>
                                                    <input type="number" step="0.01" class="form-control"
                                                        name="max_donation" placeholder="Max (Optional)">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Type</label>
                                                    <select class="form-control" name="max_donation_type">
                                                        <option value="Number">Fixed Amount ($)</option>
                                                        <option value="Percentage">Percentage of Goal (%)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <input type="password" class="form-control" name="pass"
                                                        placeholder="Password*" required="">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-12">
                                                    <button type="submit" class="btn btn-primary pull-right"
                                                        name="submit">Register</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-4 col-md-offset-1 col-contact">
                                        <h2 class="title-style-2"> DONATION TRACKING SYSTEM <span
                                                class="title-under"></span></h2>
                                        <p>
                                        </p>
                                        <ul class="contact-action">
                                            <li class="location"> <i class="fa fa-map-marker"></i> 123456, street name,
                                                country </li>
                                            <li class="phone"> <i class="fa fa-phone"></i> +61 123456789 </li>
                                            <li class="email"> <i class="fa fa-envelope"></i> contact@DONATION.org </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <footer class="main-footer">
                            <div class="footer-top"></div>
                            <div class="footer-main">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="footer-col">
                                                <h4 class="footer-title">About us <span class="title-under"></span></h4>
                                                <div class="footer-content">
                                                    <p>The aim of this project is to develop a system to track donation.
                                                    </p>
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
                        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                        <script src="assets/js/bootstrap.min.js"></script>
                        <script src="assets/js/kerala_data.js"></script>
                        <script src="assets/js/main.js"></script>
                        <script>
                            setupSearchablePanchayat('districtSel', 'panchayatSearch', 'panchayatSel', '', '');
                        </script>
                    </body>

                    </html>
