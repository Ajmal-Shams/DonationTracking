<%@page import="DonationTracking.SQLconnection,java.sql.*,java.text.SimpleDateFormat,java.util.*" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String[] h=null; try { h=new String[] { "\u003ctr\u003e"
            , "\u003cform\u0020action='requestDonte.jsp'\u0020method='get'\u003e" , "\u003ctd\u0020class='center'\u003e"
            , "\u003cinput\u0020style='background-color:transparent;border:none;color:#000'\u0020name='did'\u0020value='"
            , "'\u0020type='text'\u0020readonly\u003e" , "\u003c/td\u003e"
            , "\u003cinput\u0020style='background-color:transparent;border:none;color:#000'\u0020name='dname'\u0020value='"
            , "\u003cinput\u0020style='background-color:transparent;border:none;color:#000'\u0020name='Phone'\u0020value='"
            , "\u003ctd\u0020class='center'\u0020style='color:" , ";font-weight:bold;'\u003e"
            , "\u003cdiv\u0020class='form-group\u0020col-md-12'\u003e"
            , "\u003cselect\u0020class='form-control'\u0020name='campid'\u0020required\u0020" , "disabled"
            , "\u003e\u003coptgroup\u0020label='Select\u0020the\u0020campaign'\u003e" , "\u003coption\u0020value='"
            , "'\u003e" , "\u003c/option\u003e" , "\u003c/optgroup\u003e\u003c/select\u003e\u003c/div\u003e"
            , "\u003ctd\u003e"
            , "\u003cbutton\u0020type='submit'\u0020class='btn\u0020btn-success'\u0020style='color:white;width:80px;height:40px'\u003eRequest\u003c/button\u003e"
            , "\u003cbutton\u0020type='button'\u0020class='btn\u0020btn-default'\u0020style='width:80px;height:40px'\u0020disabled\u003eLocked\u003c/button\u003e"
            , "\u003c/form\u003e\u003c/tr\u003e" , "SELECT\u0020*\u0020FROM\u0020campaign\u0020WHERE\u0020cid='"
            , "'\u0020AND\u0020CampStatus='Active'" , "SELECT\u0020*\u0020FROM\u0020donor_reg"
            , "SELECT\u0020COUNT(*)\u0020AS\u0020t,MAX(reqTime)\u0020AS\u0020l\u0020FROM\u0020donation_req\u0020WHERE\u0020cid='"
            , "'\u0020AND\u0020did='" , "'" , "yyyy/MM/dd\u0020HH:mm:ss" , "Ready" , "Wait" , "m" , "green" , "orange"
            , "N" , "Y" , "cid" , "Sent" , "Cooldown" , "id" , "nm" , "Name" , "Mailid" , "Phone" , "ml" , "ph" , "ms"
            , "cl" , "lk" , "t" , "l" , "Error:\u0020" , "campName" , "Amount" , "AmountCol" }; Object
            ciObj=session.getAttribute(h[36]); if (ciObj==null) { response.sendRedirect("Charity.jsp"); return; } String
            ci=ciObj.toString(); java.sql.Connection cn=null; java.util.List dn=new java.util.ArrayList();
            java.util.List cp=new java.util.ArrayList(); String sk=request.getParameter(h[37]); String
            sc=request.getParameter(h[38]); cn=SQLconnection.getconnection(); if (cn !=null) { java.sql.Statement
            s1=cn.createStatement(); java.sql.ResultSet r1=s1.executeQuery(h[22] + ci + h[23]); while (r1.next()) {
            double tot=0; double col=0; try { tot=Double.parseDouble(r1.getString(h[53])); } catch(Exception e){} try {
            col=Double.parseDouble(r1.getString(h[54])); } catch(Exception e){} if (tot>0 && col>=tot)
            continue;
            java.util.Map m=new java.util.HashMap();
            m.put(h[39], r1.getString(h[39])); m.put(h[40], r1.getString(h[52])); cp.add(m); }
            java.sql.Statement s2=cn.createStatement(); java.sql.ResultSet r2=s2.executeQuery(h[24]); while (r2.next())
            { java.util.Map d=new java.util.HashMap(); String di=r2.getString(h[39]); d.put(h[39], di); d.put(h[40],
            r2.getString(h[41])); d.put(h[44], r2.getString(h[42])); d.put(h[45], r2.getString(h[43])); String m1=h[29];
            String cl=h[32]; String lk=h[34]; java.sql.Statement s3=cn.createStatement(); java.sql.ResultSet
            r3=s3.executeQuery(h[25] + ci + h[26] + di + h[27]); if (r3.next()) { int rc=r3.getInt(h[49]); String
            lt=r3.getString(h[50]); if (rc> 0 && lt != null && !lt.isEmpty()) {
            java.text.SimpleDateFormat df = new java.text.SimpleDateFormat(h[28]);
            java.util.Date d1 = df.parse(lt);
            long t1 = ((new java.util.Date()).getTime() - d1.getTime()) / (60 * 1000);
            int w1 = 5;
            if (rc == 2) w1 = 10;
            if (rc > 2) w1 = 20;
            if (t1 < (long) w1) { m1=h[30] + (w1 - (int) t1) + h[31]; cl=h[33]; lk=h[35]; } } } d.put(h[46], m1);
                d.put(h[47], cl); d.put(h[48], lk); dn.add(d); } } %>
                <!DOCTYPE html>
                <html class="no-js">

                <head>
                    <meta charset="utf-8">
                    <title>DONATION TRACKING SYSTEM</title>
                    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
                    <link rel="stylesheet" href="assets/css/style.css">
                    <link rel="stylesheet" href="assets/css/table.css">
                </head>

                <body>
                    <% if (sk !=null) { out.print("\u003cscript\u003ealert('Sent\u0020OK');\u003c/script\u003e"); } if
                        (sc !=null) { out.print("\u003cscript\u003ealert('Wait\u0020" + sc
                        + "\u0020m');\u003c/script\u003e" ); } %>
                        <header class="main-header">
                            <nav class="navbar navbar-static-top">
                                <div class="navbar-main">
                                    <div class="container">
                                        <div class="navbar-header"><a class="navbar-brand"
                                                href="Charity_home.jsp">DONATION TRACKING SYSTEM</a></div>
                                        <div id="navbar" class="navbar-collapse collapse pull-right">
                                            <ul class="nav navbar-nav">
                                                <li><a href="Charity_home.jsp">HOME</a></li>
                                                <li><a href="View_Campaigns_Details.jsp">Campaigns</a></li>
                                                <li><a class="is-active" href="request_donation.jsp">Request
                                                        Donation</a></li>
                                                <li><a href="request_status.jsp">Request Status</a></li>
                                                <li><a href="logout.jsp">Logout</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </header>
                        <div class="page-heading text-center">
                            <div class="container">
                                <h1 class="page-title">Request Donation<span class="title-under"></span></h1>
                            </div>
                        </div>
                        <div class="main-container">
                            <div class="container">
                                <h2>Donor Details</h2><br>
                                <table id="customers">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Mail Id</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Select Campaign</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (dn !=null) { for (Object o : dn) { java.util.Map d=(java.util.Map) o;
                                            out.print(h[0] + h[1]); out.print(h[2] + h[3] + d.get(h[39]) + h[4] + h[5]);
                                            out.print(h[2] + h[6] + d.get(h[40]) + h[4] + h[5]); out.print(h[2] +
                                            d.get(h[44]) + h[5]); out.print(h[2] + h[7] + d.get(h[45]) + h[4] + h[5]);
                                            out.print(h[8] + d.get(h[47]) + h[9] + d.get(h[46]) + h[5]); out.print(h[2]
                                            + h[10] + h[11]); if (d.get(h[48]).equals(h[35])) { out.print(h[12]); }
                                            out.print(h[13]); if (cp !=null) { for (Object co : cp) { java.util.Map
                                            c=(java.util.Map) co; out.print(h[14] + c.get(h[39]) + h[15] + c.get(h[40])
                                            + h[16]); } } out.print(h[17] + h[5] + h[18]); if
                                            (d.get(h[48]).equals(h[34])) { out.print(h[19]); } else { out.print(h[20]);
                                            } out.print(h[5] + h[21]); } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <footer class="main-footer">
                            <div class="footer-bottom">
                                <div class="container text-right">DONATION TRACKING SYSTEM</div>
                            </div>
                        </footer>
                        <script src="assets/js/bootstrap.min.js"></script>
                        <script src="assets/js/main.js"></script>
                </body>

                </html>
                <% } catch (Exception e) { if (h !=null) out.print(h[51] + e.getMessage()); else out.print("Error: " + e.getMessage());
    e.printStackTrace();
}
%>