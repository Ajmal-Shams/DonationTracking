<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <% ArrayList pIdList=new ArrayList(); ArrayList pNameList=new ArrayList(); ArrayList pDistList=new ArrayList(); String errMsg=null; boolean
                    dbOk=true; Connection con=null; try { con=SQLconnection.getconnection(); if (con !=null) { Statement
                    st=con.createStatement(); ResultSet rs=st.executeQuery( "SELECT * FROM panchayat ORDER BY district, panchayat_name" );
                    while (rs.next()) { pIdList.add(String.valueOf(rs.getInt("id")));
                    pNameList.add(rs.getString("panchayat_name"));
                    String dist = ""; try { dist = rs.getString("district"); if(dist==null) dist=""; } catch(Exception ex){}
                    pDistList.add(dist); } } else { dbOk=false; } } catch (Exception ex) {
                    ex.printStackTrace(); errMsg=ex.getMessage(); } %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>DONATION TRACKING SYSTEM - Manage Panchayats</title>
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
                        <script>
                            function toggle(source) {
                                checkboxes = document.getElementsByName('ids');
                                for (var i = 0, n = checkboxes.length; i < n; i++) {
                                    checkboxes[i].checked = source.checked;
                                }
                            }
                            function searchTable() {
                                var input = document.getElementById('searchInput').value.toLowerCase();
                                var distFilter = document.getElementById('districtFilter').value;
                                var rows = document.querySelectorAll('#panchayatTable tbody tr');
                                for (var i = 0; i < rows.length; i++) {
                                    var name = rows[i].getAttribute('data-name') || '';
                                    var dist = rows[i].getAttribute('data-district') || '';
                                    var nameMatch = name.toLowerCase().indexOf(input) > -1;
                                    var distMatch = (distFilter === '' || dist === distFilter);
                                    rows[i].style.display = (nameMatch && distMatch) ? '' : 'none';
                                }
                            }
                        </script>
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
                                                <li><a class="is-active" href="Manage_Panchayats.jsp">Manage
                                                        Panchayats</a></li>
                                                <li><a href="Manage_Admins.jsp">Manage Admins</a></li>
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
                                <h1 class="page-title">Manage Panchayats <span class="title-under"></span></h1>
                            </div>
                        </div>

                        <div class="main-container animated">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-8 col-md-offset-2">
                                        <h3>Add New Panchayat</h3>
                                        <form action="manage_panchayat" method="post" class="form-inline">
                                            <input type="hidden" name="action" value="add">
                                            <div class="form-group">
                                                <select class="form-control" name="district" id="addDistrict" required>
                                                    <option value="">-- Select District --</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="panchayat_name"
                                                    placeholder="Panchayat Name" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Add Panchayat</button>
                                        </form>
                                        <hr>
                                        <h3>Existing Panchayats (<%=pIdList.size()%> total)</h3>
                                        <div class="row" style="margin-bottom:15px;">
                                            <div class="col-md-6">
                                                <input type="text" id="searchInput" class="form-control" placeholder="Search panchayat name..." onkeyup="searchTable()">
                                            </div>
                                            <div class="col-md-6">
                                                <select id="districtFilter" class="form-control" onchange="searchTable()">
                                                    <option value="">-- All Districts --</option>
                                                </select>
                                            </div>
                                        </div>
                                        <form action="delete_entity.jsp" method="post"
                                            onsubmit="return confirm('Are you sure you want to delete selected panchayats?');">
                                            <input type="hidden" name="type" value="panchayat">
                                            <button type="submit" class="btn btn-danger"
                                                style="margin-bottom: 10px;">Delete Selected</button>
                                        <table class="table table-bordered table-striped" id="panchayatTable">
                                            <thead>
                                                <tr>
                                                    <th><input type="checkbox" onClick="toggle(this)"></th>
                                                    <th>ID</th>
                                                    <th>District</th>
                                                    <th>Panchayat Name</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (!dbOk) { %>
                                                    <tr>
                                                        <td colspan="6">Database connection failed.</td>
                                                    </tr>
                                                    <% } else if (errMsg !=null) { %>
                                                        <tr>
                                                            <td colspan="6">Error: <%=errMsg%>
                                                            </td>
                                                        </tr>
                                                        <% } else { %>
                                                            <% for (int i=0; i < pIdList.size(); i++) { %>
                                                                <% String pid=(String)pIdList.get(i); %>
                                                                    <% String pname=(String)pNameList.get(i); %>
                                                                        <% String pdist=(String)pDistList.get(i); %>
                                                                        <tr data-name="<%=pname%>" data-district="<%=pdist%>">
                                                                            <td><input type="checkbox" name="ids"
                                                                                    value="<%=pid%>"></td>
                                                                            <td>
                                                                                <%=pid%>
                                                                            </td>
                                                                            <td>
                                                                                <%=pdist%>
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" class="form-control"
                                                                                    name="pname_display"
                                                                                    value="<%=pname%>"
                                                                                    style="width:200px; display:inline;">
                                                                            </td>
                                                                            <td>
                                                                                <form action="manage_panchayat"
                                                                                    method="post"
                                                                                    style="display:inline;">
                                                                                    <input type="hidden" name="action"
                                                                                        value="update">
                                                                                    <input type="hidden"
                                                                                        name="panchayat_id"
                                                                                        value="<%=pid%>">
                                                                                    <input type="hidden"
                                                                                        name="panchayat_name"
                                                                                        value="<%=pname%>">
                                                                                    <input type="hidden"
                                                                                        name="district"
                                                                                        value="<%=pdist%>">
                                                                                    <button type="submit"
                                                                                        class="btn btn-warning btn-sm"
                                                                                        onclick="this.form.panchayat_name.value=this.closest('tr').querySelector('input[type=text]').value;">Update</button>
                                                                                </form>
                                                                            </td>
                                                                            <td>
                                                                                <a href="delete_entity.jsp?type=panchayat&id=<%=pid%>"
                                                                                    class="btn btn-danger btn-sm"
                                                                                    onclick="return confirm('Are you sure you want to delete this panchayat?')">Delete</a>
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
                        <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>
                        <script src="assets/js/bootstrap.min.js"></script>
                        <script src="assets/js/kerala_data.js"></script>
                        <script src="assets/js/main.js"></script>
                        <script>
                            populateDistrictDropdown('addDistrict');
                            populateDistrictDropdown('districtFilter');
                            // Add "All Districts" back as first option for filter
                            var filterSel = document.getElementById('districtFilter');
                            var allOpt = document.createElement('option');
                            allOpt.value = '';
                            allOpt.textContent = '-- All Districts --';
                            filterSel.insertBefore(allOpt, filterSel.firstChild);
                            filterSel.value = '';
                        </script>
                    </body>

                    </html>
