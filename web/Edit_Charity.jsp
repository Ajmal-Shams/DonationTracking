<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page import="java.util.ArrayList" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% Object cidObj=session.getAttribute("cid"); if (cidObj==null) { response.sendRedirect("Charity.jsp");
                    return; } String cid=cidObj.toString(); Connection con=null; Statement st=null; ResultSet rs=null;
                    Statement stP=null; ResultSet rsP=null; ArrayList panchayats=new ArrayList(); String vCName=null,
                    vCMailid=null, vCPhone=null, vCaddress=null; String vPanchayatId="" ; double vMinDonation=0,
                    vMaxDonation=0; String vMinType=null, vMaxType=null; boolean found=false; boolean hasLimits=false;
                    String errMsg=null; try { con=SQLconnection.getconnection(); st=con.createStatement(); String
                    q="SELECT * FROM charity_reg WHERE id='" + cid + "'" ; rs=st.executeQuery(q);
                    stP=con.createStatement(); rsP=stP.executeQuery("SELECT id, district, panchayat_name FROM panchayat ORDER BY district, panchayat_name"); while (rsP.next()) {
                    String[] p={ rsP.getString("id"), rsP.getString("panchayat_name"), rsP.getString("district") != null ? rsP.getString("district") : "" }; panchayats.add(p); } if (rs.next()) { found=true;
                    vCName=rs.getString(2); vCMailid=rs.getString(3); vCPhone=rs.getString(4);
                    vCaddress=rs.getString(5); int colCount=rs.getMetaData().getColumnCount(); if (colCount>= 9) {
                    vPanchayatId = rs.getString(9);
                    if (vPanchayatId == null) vPanchayatId = "";
                    }
                    if (colCount >= 13) {
                    vMinDonation = rs.getDouble(10);
                    vMaxDonation = rs.getDouble(11);
                    vMinType = rs.getString(12);
                    vMaxType = rs.getString(13);
                    }
                    }
                    hasLimits = (vMinType != null);
                    } catch (Exception e) {
                    e.printStackTrace();
                    errMsg = e.getMessage();
                    } finally {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (rsP != null) rsP.close();
                    if (stP != null) stP.close();
                    if (con != null) con.close();
                    }
                    %>
                    <!DOCTYPE html>
                    <html class="no-js">

                    <head>
                        <meta charset="utf-8">
                        <title>Edit Charity Profile - DONATION TRACKING SYSTEM</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet'
                            type='text/css'>
                        <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet'
                            type='text/css'>
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
                                                <li><a href="View_Campaigns_Details.jsp">Campaigns</a></li>
                                                <li><a href="Edit_Charity.jsp">Profile</a></li>
                                                <li><a href="logout.jsp">Logout</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </header>
                        <div class="page-heading text-center">
                            <div class="container">
                                <h1 class="page-title">Edit Charity Profile<span class="title-under"></span></h1>
                            </div>
                        </div>
                        <div class="main-container">
                            <div class="container">
                                <div class="row" style="margin-left: 200px">
                                    <div class="modal-body col-md-8">
                                        <% if (found) { %>
                                            <form action="Update_Charity" method="post" class="contact-form">
                                                <input type="hidden" name="cid" value="<%=cid%>">
                                                <h3 class="title-style-1 text-center">Charity Details<span
                                                        class="title-under"></span></h3>
                                                <div class="row">
                                                    <div class="form-group col-md-12">
                                                        <label>Charity Name</label>
                                                        <input type="text" name="Charityname" class="form-control"
                                                            value="<%=vCName%>" required="">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label>Email</label>
                                                        <input type="text" class="form-control" name="email"
                                                            value="<%=vCMailid%>" required="">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label>Phone</label>
                                                        <input type="text" class="form-control" name="phone"
                                                            value="<%=vCPhone%>" required="">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-12">
                                                        <label>Address</label>
                                                        <input type="text" class="form-control" name="address"
                                                            value="<%=vCaddress%>" required="">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label>District</label>
                                                        <select class="form-control" id="editDistrict" onchange="filterEditPanchayat()">
                                                            <option value="">All Districts</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label>Search Panchayat</label>
                                                        <input type="text" class="form-control" id="editPanchayatSearch" placeholder="Search..." onkeyup="filterEditPanchayat()">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-12">
                                                        <label>Panchayat</label>
                                                        <select class="form-control" name="panchayat_id" id="editPanchayat" required="">
                                                            <% for (int i=0; i < panchayats.size(); i++) { String[]
                                                                p=(String[]) panchayats.get(i); %>
                                                                <option value="<%=p[0]%>" data-district="<%=p[2]%>" <% if
                                                                    (p[0].equals(vPanchayatId)) { %>selected<% } %>>
                                                                        <%=p[1]%> (<%=p[2]%>)
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                    </div>
                                                </div>
                                                <% if (hasLimits) { %>
                                                    <h3 class="title-style-1 text-center">Default Donation Limits<span
                                                            class="title-under"></span></h3>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label>Default Min Donation</label>
                                                            <input type="number" step="0.01" class="form-control"
                                                                name="min_donation" value="<%=vMinDonation%>">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label>Type</label>
                                                            <select class="form-control" name="min_donation_type">
                                                                <option value="Number" <% if ("Number".equals(vMinType))
                                                                    { %>selected<% } %>>Fixed Amount ($)</option>
                                                                <option value="Percentage" <% if
                                                                    ("Percentage".equals(vMinType)) { %>selected<% } %>
                                                                        >Percentage of Goal (%)</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label>Default Max Donation</label>
                                                            <input type="number" step="0.01" class="form-control"
                                                                name="max_donation" value="<%=vMaxDonation%>">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label>Type</label>
                                                            <select class="form-control" name="max_donation_type">
                                                                <option value="Number" <% if ("Number".equals(vMaxType))
                                                                    { %>selected<% } %>>Fixed Amount ($)</option>
                                                                <option value="Percentage" <% if
                                                                    ("Percentage".equals(vMaxType)) { %>selected<% } %>
                                                                        >Percentage of Goal (%)</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <% } %>
                                                        <div class="row">
                                                            <div class="form-group col-md-12">
                                                                <label>Password (Leave blank to keep current)</label>
                                                                <input type="password" class="form-control" name="pass"
                                                                    placeholder="New Password">
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="form-group col-md-12">
                                                                <button type="submit"
                                                                    class="btn btn-primary pull-center">Update
                                                                    Profile</button>
                                                            </div>
                                                        </div>
                                            </form>
                                            <% } else { %>
                                                <p>Charity profile not found.</p>
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
                        <script src="assets/js/kerala_data.js"></script>
                        <script src="assets/js/main.js"></script>
                        <script>
                            (function(){
                                var distSel = document.getElementById('editDistrict');
                                var pSel = document.getElementById('editPanchayat');
                                var districts = {};
                                for(var i=0;i<pSel.options.length;i++){
                                    var d = pSel.options[i].getAttribute('data-district');
                                    if(d) districts[d]=true;
                                }
                                var sorted = Object.keys(districts).sort();
                                for(var j=0;j<sorted.length;j++){
                                    var o=document.createElement('option');
                                    o.value=sorted[j]; o.textContent=sorted[j];
                                    distSel.appendChild(o);
                                }
                                // Auto-select district based on currently selected panchayat
                                var selOpt = pSel.options[pSel.selectedIndex];
                                if(selOpt && selOpt.getAttribute('data-district')){
                                    distSel.value = selOpt.getAttribute('data-district');
                                }
                            })();
                            function filterEditPanchayat(){
                                var dist = document.getElementById('editDistrict').value;
                                var search = document.getElementById('editPanchayatSearch').value.toLowerCase();
                                var pSel = document.getElementById('editPanchayat');
                                for(var i=0;i<pSel.options.length;i++){
                                    var od = pSel.options[i].getAttribute('data-district');
                                    var nm = pSel.options[i].textContent.toLowerCase();
                                    var distMatch = (!dist || od === dist);
                                    var searchMatch = (!search || nm.indexOf(search) > -1);
                                    pSel.options[i].style.display = (distMatch && searchMatch) ? '' : 'none';
                                }
                            }
                        </script>
                    </body>

                    </html>