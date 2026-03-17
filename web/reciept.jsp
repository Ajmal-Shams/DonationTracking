<%-- 
    Document   : reciept
    Created on : Nov 21, 2022, 11:46:07 AM
    Author     : 
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DonationTracking.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
                        String tid = request.getParameter("id");
                        String email =session.getAttribute("dmail").toString();
                        String daddress =session.getAttribute("daddress").toString();
                        String dphone =session.getAttribute("dphone").toString();

                        Connection con = SQLconnection.getconnection();
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("Select * from transaction where id='" + tid + "'");
                        rs.next();
                    %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Receipt - <%=rs.getString("Tid")%></title>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.2/css/bootstrap.min.css'><link rel="stylesheet" href="./style.css">
  <link rel="stylesheet" href="assets/receipt/style.css">
</head>
<body onload="window.print()">
<!-- partial:index.partial.html -->
<div class="container">
  <div class="row invoice-header px-3 py-2">
    <div class="col-4">
      <p>Donation Tracking System</p>
      <h1>INVOICE</h1>
    </div>
    <div class="col-4 text-right">
      <p>(011)-123-1243</p>
      <p>info@donationtracking.com</p>
      <p>donationtracking.com</p>
    </div>
    <div class="col-4 text-right">
      <p>Charity :<%=rs.getString("cname")%></p>
      <p>Campaign:<%=rs.getString("campName")%></p>
      <p>Status:<%=rs.getString("donationStatus")%></p>
    </div>
  </div>

  <div class="invoice-content row px-5 pt-5">
    <div class="col-3">
      <h5 class="almost-gray mb-3">Invoiced to:</h5>
      <p class="gray-ish">Name   :<%=rs.getString("dname")%></p>
      <p class="gray-ish">Address:<%=daddress%></p>
      <p class="gray-ish">Phone  :<%=dphone%></p>
    </div>
    <div class="col-3">
      <h5 class="almost-gray">Invoice number:</h5>
      <p class="gray-ish"># <%=rs.getString("Tid")%></p>

      <h5 class="almost-gray">Date & time of payment:</h5>
      <p class="gray-ish"><%=rs.getString("TofPayement")%></p>

    </div>
    <div class="col-6 text-right total-field">
      <h4 class="almost-gray">Invoice Total</h4>
      <h1 class="gray-ish"><%=rs.getString("amount")%><span class="curency">&dollar;</span></h1>
    </div>
  </div>

  <p class="text-center pb-3"><em>This is a computer-generated document. No signature is required</em></p>
</div>
    
<center><a href="donor_home.jsp" class="btn btn-danger">Back</a></center>
<!-- partial -->
<script  src="assets/receipt/script.js"></script>

</body>
</html>
