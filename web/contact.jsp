<%-- Document : contact Created on : Mar 06, 2026 Author : Anjaly --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html class="no-js">

        <head>
            <meta charset="utf-8">
            <title>Contact Us - DONATION TRACKING SYSTEM</title>
            <meta name="description"
                content="Get in touch with the Donation Tracking System team. We're here to help donors and charities.">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- Fonts -->
            <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
            <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet' type='text/css'>

            <!-- Bootstrap -->
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

        <body>

            <header class="main-header">

                <nav class="navbar navbar-static-top">

                    <div class="navbar-top">

                        <div class="container">
                            <div class="row">

                                <div class="col-sm-6 col-xs-12">

                                    <ul class="list-unstyled list-inline header-contact">
                                        <li> <i class="fa fa-phone"></i> <a href="tel:">+61 123456789 </a> </li>
                                        <li> <i class="fa fa-envelope"></i> <a href="#">contact@DONATION.org</a> </li>
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

                                <a class="navbar-brand" href="index.jsp">DONATION TRACKING SYSTEM</a>

                            </div>

                            <div id="navbar" class="navbar-collapse collapse pull-right">

                                <ul class="nav navbar-nav">
                                    <li><a href="index.jsp">HOME</a></li>
                                    <li><a href="about.jsp">About Us</a></li>
                                    <li><a class="is-active" href="contact.jsp">Contact Us</a></li>
                                    <li><a href="SuperAdmin.jsp">Super Admin</a></li>
                                    <li><a href="Admin.jsp">Admin</a></li>
                                    <li><a href="Charity.jsp">Charity</a></li>
                                    <li><a href="Donor.jsp">Donor</a></li>
                                </ul>

                            </div> <!-- /#navbar -->

                        </div> <!-- /.container -->

                    </div> <!-- /.navbar-main -->

                </nav>

            </header> <!-- /. main-header -->


            <!-- Page Heading -->
            <div class="page-heading text-center">
                <div class="container">
                    <h1 class="page-title">Contact Us <span class="title-under"></span></h1>
                    <p class="page-description">We'd love to hear from you. Reach out to us anytime!</p>
                </div>
            </div>


            <!-- Contact Info Cards -->
            <div class="section-home animated">
                <div class="container">
                    <div class="row">

                        <div class="col-md-4 col-sm-6">
                            <div class="contact-info-card text-center">
                                <div class="contact-card-icon">
                                    <i class="fa fa-map-marker"></i>
                                </div>
                                <h4 class="contact-card-title">Our Office</h4>
                                <p>123 Donation Street<br>Melbourne, Victoria 3000<br>Australia</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-6">
                            <div class="contact-info-card text-center">
                                <div class="contact-card-icon">
                                    <i class="fa fa-phone"></i>
                                </div>
                                <h4 class="contact-card-title">Call Us</h4>
                                <p>Phone: +61 123456789<br>Toll Free: 1800-DONATE<br>Mon - Fri: 9:00 AM - 6:00 PM</p>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-12">
                            <div class="contact-info-card text-center">
                                <div class="contact-card-icon">
                                    <i class="fa fa-envelope"></i>
                                </div>
                                <h4 class="contact-card-title">Email Us</h4>
                                <p>General: contact@DONATION.org<br>Support: support@DONATION.org<br>Partnerships:
                                    partners@DONATION.org</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Contact Form + Map Section -->
            <div class="section-home animated">
                <div class="container">
                    <div class="row">

                        <!-- Contact Form -->
                        <div class="col-md-6">
                            <h2 class="title-style-2">Send us a Message <span class="title-under"></span></h2>

                            <form class="contact-form" id="contactForm">

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <input type="text" class="form-control" name="fullName"
                                            placeholder="Your Full Name *" required>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <input type="email" class="form-control" name="email" placeholder="Your Email *"
                                            required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <input type="text" class="form-control" name="phone" placeholder="Your Phone">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <select class="form-control" name="subject">
                                            <option value="">Select Subject</option>
                                            <option value="general">General Inquiry</option>
                                            <option value="donation">Donation Query</option>
                                            <option value="charity">Charity Registration</option>
                                            <option value="technical">Technical Support</option>
                                            <option value="feedback">Feedback</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <textarea cols="30" rows="6" class="form-control" name="message"
                                            placeholder="Your Message *" required></textarea>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <button type="button" class="btn btn-primary" onclick="submitContactForm()">
                                            <i class="fa fa-paper-plane"></i> SEND MESSAGE
                                        </button>
                                    </div>
                                </div>

                                <div class="alert alert-success" id="contactSuccess" style="display:none;">
                                    <i class="fa fa-check-circle"></i> Thank you for your message! We will get back to
                                    you within 24 hours.
                                </div>

                            </form>

                        </div>

                        <!-- Map -->
                        <div class="col-md-6">
                            <h2 class="title-style-2">Find Us <span class="title-under"></span></h2>
                            <div class="contact-map">
                                <iframe
                                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3151.835434509198!2d144.9537353!3d-37.8162791!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad65d4c2b349649%3A0xb6899234e561db11!2sMelbourne%20VIC%2C%20Australia!5e0!3m2!1sen!2sin!4v1709712000000!5m2!1sen!2sin"
                                    width="100%" height="350" style="border:0; border-radius:0;" allowfullscreen=""
                                    loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                                </iframe>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- FAQ Section -->
            <div class="section-home faq-section animated">
                <div class="container">
                    <h2 class="title-style-1">Frequently Asked Questions <span class="title-under"></span></h2>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">

                            <div class="panel-group" id="faqAccordion" role="tablist" aria-multiselectable="true">

                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="faq1Head">
                                        <h4 class="panel-title">
                                            <a role="button" data-toggle="collapse" data-parent="#faqAccordion"
                                                href="#faq1" aria-expanded="true" aria-controls="faq1">
                                                <i class="fa fa-question-circle"></i> How do I register as a Donor?
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="faq1" class="panel-collapse collapse in" role="tabpanel"
                                        aria-labelledby="faq1Head">
                                        <div class="panel-body">
                                            To register as a donor, click on the "Donor" link in the top navigation
                                            menu. You'll be directed
                                            to the registration page where you can create your account by providing your
                                            personal details,
                                            email address, and a password. Once registered, you can start making
                                            donations right away.
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="faq2Head">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse"
                                                data-parent="#faqAccordion" href="#faq2" aria-expanded="false"
                                                aria-controls="faq2">
                                                <i class="fa fa-question-circle"></i> How can a Charity register on this
                                                platform?
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="faq2" class="panel-collapse collapse" role="tabpanel"
                                        aria-labelledby="faq2Head">
                                        <div class="panel-body">
                                            Charities can register by clicking the "Charity" link in the navigation
                                            menu. Fill in the
                                            organization details, contact information, and required documents. After
                                            submission, the admin
                                            will review and verify your charity before it is activated on the platform.
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="faq3Head">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse"
                                                data-parent="#faqAccordion" href="#faq3" aria-expanded="false"
                                                aria-controls="faq3">
                                                <i class="fa fa-question-circle"></i> Can I track my donation after
                                                making it?
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="faq3" class="panel-collapse collapse" role="tabpanel"
                                        aria-labelledby="faq3Head">
                                        <div class="panel-body">
                                            Yes! Once you've made a donation, you can track its status through the
                                            "Track Donation" feature
                                            available in your donor dashboard. You'll see updates about the donation's
                                            approval status,
                                            and transaction history including receipts.
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="faq4Head">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse"
                                                data-parent="#faqAccordion" href="#faq4" aria-expanded="false"
                                                aria-controls="faq4">
                                                <i class="fa fa-question-circle"></i> How does the donation request
                                                process work?
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="faq4" class="panel-collapse collapse" role="tabpanel"
                                        aria-labelledby="faq4Head">
                                        <div class="panel-body">
                                            Charities can submit donation requests through the platform, which are then
                                            reviewed by the
                                            admin. Once approved, these requests become visible to donors. Donors can
                                            browse through all
                                            available requests and choose which ones to support. The admin tracks all
                                            requests and
                                            donations for transparency.
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="faq5Head">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse"
                                                data-parent="#faqAccordion" href="#faq5" aria-expanded="false"
                                                aria-controls="faq5">
                                                <i class="fa fa-question-circle"></i> Is my personal information safe?
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="faq5" class="panel-collapse collapse" role="tabpanel"
                                        aria-labelledby="faq5Head">
                                        <div class="panel-body">
                                            Absolutely. We take data privacy seriously. All personal information is
                                            stored securely,
                                            and we do not share your data with third parties. Our system follows
                                            standard security
                                            practices to ensure your information remains confidential and protected.
                                        </div>
                                    </div>
                                </div>

                            </div> <!-- /#faqAccordion -->

                        </div>
                    </div>
                </div>
            </div>


            <!-- Footer -->
            <footer class="main-footer">

                <div class="footer-top"></div>

                <div class="footer-main">
                    <div class="container">

                        <div class="row">
                            <div class="col-md-4">

                                <div class="footer-col">

                                    <h4 class="footer-title">About us <span class="title-under"></span></h4>

                                    <div class="footer-content">
                                        <p>
                                            The aim of this project is to develop a system to track donation. The users
                                            are admin, donor
                                            and charity. This system helps the donors to track their donation. This
                                            system consisted 5
                                            modules. Besides that, this system also helps the charity request for
                                            donation. Meanwhile, the
                                            admin will manage the charity and donors.
                                        </p>
                                    </div>

                                </div>

                            </div>

                            <div class="col-md-4">
                                <div class="footer-col">
                                    <h4 class="footer-title">Quick Links <span class="title-under"></span></h4>
                                    <div class="footer-content">
                                        <ul class="list-unstyled" style="font-size:14px;">
                                            <li style="margin-bottom:8px;"><a href="index.jsp"><i
                                                        class="fa fa-angle-right"></i> Home</a></li>
                                            <li style="margin-bottom:8px;"><a href="about.jsp"><i
                                                        class="fa fa-angle-right"></i> About Us</a></li>
                                            <li style="margin-bottom:8px;"><a href="contact.jsp"><i
                                                        class="fa fa-angle-right"></i> Contact Us</a></li>
                                            <li style="margin-bottom:8px;"><a href="Donor.jsp"><i
                                                        class="fa fa-angle-right"></i> Become a Donor</a></li>
                                            <li style="margin-bottom:8px;"><a href="Charity.jsp"><i
                                                        class="fa fa-angle-right"></i> Register Charity</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">

                                <div class="footer-col">
                                    <h4 class="footer-title">Contact Info <span class="title-under"></span></h4>
                                    <div class="footer-content">
                                        <p><i class="fa fa-map-marker"></i> 123 Donation Street, Melbourne, Australia
                                        </p>
                                        <p><i class="fa fa-phone"></i> +61 123456789</p>
                                        <p><i class="fa fa-envelope"></i> contact@DONATION.org</p>
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


            <!-- Scripts -->
            <!-- jQuery -->
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
            <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>

            <!-- Bootstrap javascript file -->
            <script src="assets/js/bootstrap.min.js"></script>

            <!-- Template main javascript -->
            <script src="assets/js/main.js"></script>

            <!-- Contact Form Script -->
            <script>
                function submitContactForm() {
                    var name = $('input[name="fullName"]').val();
                    var email = $('input[name="email"]').val();
                    var message = $('textarea[name="message"]').val();

                    if (name && email && message) {
                        $('#contactSuccess').fadeIn();
                        $('#contactForm')[0].reset();
                        setTimeout(function () {
                            $('#contactSuccess').fadeOut();
                        }, 5000);
                    } else {
                        alert('Please fill in all required fields (Name, Email, and Message).');
                    }
                }
            </script>

        </body>

        </html>