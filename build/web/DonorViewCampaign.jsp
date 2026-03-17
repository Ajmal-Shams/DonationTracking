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
                                                <% Connection con=null; String selectedPanchayat=request.getParameter("panchayat"); String selectedDistrict=request.getParameter("district"); %>
                                                <div class="form-group" style="margin-right:10px;">
                                                    <label>District: </label>
                                                    <select name="district" id="campDistrictFilter" class="form-control" onchange="filterCampPanchayat(); this.form.submit();">
                                                        <option value="">All Districts</option>
                                                        <% try { con=SQLconnection.getconnection();
                                                            Statement stD=con.createStatement();
                                                            ResultSet rsD=stD.executeQuery("SELECT DISTINCT district FROM panchayat WHERE district != '' ORDER BY district");
                                                            while(rsD.next()){ String dName=rsD.getString("district");
                                                            String dSel=(dName.equals(selectedDistrict)) ? "selected" : ""; %>
                                                            <option value="<%=dName%>" <%=dSel%>><%=dName%></option>
                                                            <% } } catch(Exception e) { e.printStackTrace(); } %>
                                                    </select>
                                                </div>
                                                <div class="form-group" style="margin-right:10px;">
                                                    <label>Panchayat: </label>
                                                    <select name="panchayat" id="campPanchayatFilter" class="form-control"
                                                        onchange="this.form.submit()">
                                                        <option value="">All Panchayats</option>
                                                        <% try { if(con==null) con=SQLconnection.getconnection();
                                                            Statement stP=con.createStatement();
                                                            String pQuery="SELECT * FROM panchayat";
                                                            if(selectedDistrict!=null && !selectedDistrict.isEmpty()) pQuery+=" WHERE district='"+selectedDistrict.replace("'","''")+"'";
                                                            pQuery+=" ORDER BY district, panchayat_name";
                                                            ResultSet rsP=stP.executeQuery(pQuery);
                                                            while(rsP.next()){ String pId=rsP.getString("id"); String
                                                            pName=rsP.getString("panchayat_name");
                                                            String pDist=""; try{ pDist=rsP.getString("district"); if(pDist==null) pDist=""; }catch(Exception ex){}
                                                            String selected=(pId.equals(selectedPanchayat)) ? "selected" : "" ;
                                                            %>
                                                            <option value="<%=pId%>" <%=selected%>><%=pName%><% if(!pDist.isEmpty()){ %> (<%=pDist%>)<% } %>
                                                            </option>
                                                            <% } } catch(Exception e) { e.printStackTrace(); } %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" id="campSearchInput" placeholder="Search panchayat..." onkeyup="searchCampPanchayat()">
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="row" style="display: flex; flex-wrap: wrap;">
                                        <% Statement st=null; ResultSet rs=null; try { if (con !=null) {
                                            st=con.createStatement(); String
                                            query="SELECT c.id AS campaign_id, c.*, cr.min_donation AS char_min, cr.max_donation AS char_max, cr.min_donation_type AS char_min_type, cr.max_donation_type AS char_max_type, p.panchayat_name FROM campaign c LEFT JOIN charity_reg cr ON c.cid = cr.id LEFT JOIN panchayat p ON cr.panchayat_id = p.id WHERE c.CampStatus='Active'"
                                            ; String sP=request.getParameter("panchayat"); if (sP !=null &&
                                            !sP.isEmpty()) { query +=" AND cr.panchayat_id = " + Integer.parseInt(sP); }
                                            String sCharityId=request.getParameter("id"); if (sCharityId !=null &&
                                            !sCharityId.isEmpty()) { query +=" AND cr.id = " + Integer.parseInt(sCharityId); }
                                            String sDist=request.getParameter("district"); if (sDist !=null &&
                                            !sDist.isEmpty()) { query +=" AND p.district = '" + sDist.replace("'","''") + "'"; }
                                            rs=st.executeQuery(query); java.text.NumberFormat
                                            nf=java.text.NumberFormat.getInstance(); nf.setMinimumFractionDigits(2);
                                            nf.setMaximumFractionDigits(2); while (rs.next()) { String
                                            cId=rs.getString("campaign_id"); double iT=rs.getDouble("Amount"); double
                                            iAC=rs.getDouble("AmountCol"); double rem=iT - iAC; String
                                            cNm=rs.getString("campName"); String pNm=rs.getString("panchayat_name");
                                            String cDs=rs.getString("CampDes"); int pct=(iT> 0) ? (int)((iAC / iT) *
                                            100) : 0; if (pct > 100) pct = 100; %>
                                            <div class="col-md-3 col-sm-6" style="margin-bottom: 30px;">
                                                <div class="cause"
                                                    style="height: 100%; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; display: flex; flex-direction: column;">
                                                    <img src="GetCampaignImage?id=<%=cId%>" alt="" class="cause-img"
                                                        style="height: 180px; width: 100%; object-fit: cover;">
                                                    <div class="progress cause-progress"
                                                        style="margin: 10px 15px; background-color: #f0f0f0; border-radius: 10px; height: 12px;">
                                                        <div class="progress-bar progress-bar-primary progress-bar-striped active"
                                                            role="progressbar" aria-valuenow="<%=pct%>"
                                                            aria-valuemin="0" aria-valuemax="100"
                                                            style="width: <%=pct%>%; line-height: 12px; font-size: 10px; font-weight: bold;">
                                                            <%=pct%>%
                                                        </div>
                                                    </div>
                                                    <div class="info-block"
                                                        style="padding: 0 15px; margin-bottom: 10px;">
                                                        <div
                                                            style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                                                            <span style="color: #444; font-size: 12px;">Raised:
                                                                <strong>$<%=nf.format(iAC)%></strong></span>
                                                            <span style="color: #777; font-size: 12px;">Goal: <strong>$
                                                                    <%=nf.format(iT)%></strong></span>
                                                        </div>
                                                        <div
                                                            style="background: #e7f3fe; padding: 5px 10px; border-radius: 4px; text-align: center;">
                                                            <span
                                                                style="color: #31708f; font-size: 13px; font-weight: bold;">Remaining:
                                                                $<%=nf.format(rem)%></span>
                                                        </div>
                                                    </div>
                                                    <h4 class="cause-title"
                                                        style="padding: 0 15px; margin: 5px 0; min-height: 44px;"><a
                                                            href="#" style="color: #333; transition: color 0.3s;">
                                                            <%=cNm%>
                                                        </a></h4>
                                                    <div class="cause-details" style="padding: 0 15px; flex-grow: 1;">
                                                        <p class="text-muted" style="margin-bottom: 8px;"><small><i
                                                                    class="fa fa-map-marker"
                                                                    style="color: #d9534f;"></i>
                                                                <%=pNm%>
                                                            </small></p>
                                                        <% double eMn=0; double eMx=Double.MAX_VALUE; try { double
                                                            cMn=rs.getDouble("min_donation"); double
                                                            cMx=rs.getDouble("max_donation"); String
                                                            cMT=rs.getString("min_donation_type"); String
                                                            cXT=rs.getString("max_donation_type"); double
                                                            hMn=rs.getDouble("char_min"); double
                                                            hMx=rs.getDouble("char_max"); String
                                                            hMT=rs.getString("char_min_type"); String
                                                            hXT=rs.getString("char_max_type"); if (cMT==null)
                                                            cMT="Number" ; if (cXT==null) cXT="Number" ; if (hMT==null)
                                                            hMT="Number" ; if (hXT==null) hXT="Number" ; double
                                                            aMn="Percentage" .equals(cMT)?(cMn*iT/100):cMn; double
                                                            aMx="Percentage" .equals(cXT)?(cMx*iT/100):cMx; double
                                                            bMn="Percentage" .equals(hMT)?(hMn*iT/100):hMn; double
                                                            bMx="Percentage" .equals(hXT)?(hMx*iT/100):hMx;
                                                            eMn=Math.max(aMn, bMn); if (aMx>0) eMx=Math.min(eMx, aMx);
                                                            if (bMx>0) eMx=Math.min(eMx, bMx); eMx=Math.min(eMx, rem); }
                                                            catch (Exception elim) { elim.printStackTrace(); } if (eMn >
                                                            0.01 || (eMx < Double.MAX_VALUE && eMx> 0)) { %>
                                                                <div
                                                                    style="background: #fdf6ec; border-left: 3px solid #f0ad4e; padding: 5px 8px; border-radius: 0 4px 4px 0; margin-bottom: 15px; font-size: 11px;">
                                                                    <strong style="color: #8a6d3b;">Donation
                                                                        Limits:</strong><br>
                                                                    <% if (eMn> 0.01) { %> <span
                                                                            style="display:inline-block; min-width: 60px;">Min:</span>
                                                                        <strong>$<%=nf.format(eMn)%></strong><br>
                                                                        <% } if (eMx < Double.MAX_VALUE && eMx> 0) { %>
                                                                            <span
                                                                                style="display:inline-block; min-width: 60px;">Max:</span>
                                                                            <strong>$<%=nf.format(eMx)%></strong>
                                                                            <% } %>
                                                                </div>
                                                                <% } %>
                                                                    <p
                                                                        style="font-size: 13px; line-height: 1.4; color: #666; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;">
                                                                        <%=cDs%>
                                                                    </p>
                                                    </div>
                                                    <div class="btn-holder text-center" style="padding: 15px;">
                                                        <% if (iAC>= iT) { %> <button class="btn btn-default btn-block"
                                                                disabled
                                                                style="background-color: #eee; color: #999; border: none; font-weight: bold; border-radius: 4px;">GOAL
                                                                REACHED</button>
                                                            <% } else { %> <a href="donatePage.jsp?id=<%=cId%>"
                                                                    class="btn btn-primary btn-block"
                                                                    style="font-weight: bold; border-radius: 4px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">DONATE
                                                                    NOW</a>
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
                            <script>
                                function searchCampPanchayat(){
                                    var input = document.getElementById('campSearchInput').value.toLowerCase();
                                    var sel = document.getElementById('campPanchayatFilter');
                                    for(var i=1;i<sel.options.length;i++){
                                        var txt = sel.options[i].textContent.toLowerCase();
                                        sel.options[i].style.display = txt.indexOf(input) > -1 ? '' : 'none';
                                    }
                                }
                            </script>
                        </body>

                        </html>