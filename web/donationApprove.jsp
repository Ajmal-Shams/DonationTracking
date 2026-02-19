<%@page trimDirectiveWhitespaces="true" %>
    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <%@page import="java.sql.Connection" %>
                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
                        <%@page import="java.util.Date" %>
                            <%@page import="java.text.SimpleDateFormat" %>
                                <% String tid=request.getParameter("tid"); String cid=request.getParameter("cid");
                                    String amount=request.getParameter("amount"); String acceptedBy="Unknown" ; Object
                                    superAdmin=session.getAttribute("superadmin_name"); Object
                                    admin=session.getAttribute("admin_name"); if (superAdmin !=null) {
                                    acceptedBy=(String) superAdmin + " (Super Admin)" ; } else if (admin !=null) {
                                    acceptedBy=(String) admin + " (Panchayat Admin)" ; } Connection con=null; try {
                                    con=SQLconnection.getconnection(); if (con==null) {
                                    response.sendRedirect("Donations_Details.jsp?Failed=DBConnectionError"); return; }
                                    Statement st=con.createStatement(); Statement st1=con.createStatement(); Statement
                                    st2=con.createStatement(); String qC="SELECT * FROM campaign WHERE id='" + cid + "'"
                                    ; ResultSet rs=st.executeQuery(qC); if (rs.next()) { int
                                    preValue=rs.getInt("AmountCol"); int totalValve=preValue + Integer.parseInt(amount);
                                    String qU1="UPDATE campaign SET AmountCol='" + totalValve + "' WHERE id='" + cid
                                    + "'" ; int i=st1.executeUpdate(qU1); String
                                    qU2="UPDATE transaction SET donationStatus='Approved' WHERE Tid='" + tid + "'" ;
                                    st2.executeUpdate(qU2); if (i !=0) {
                                    response.sendRedirect("Donations_Details.jsp?Granted"); } else {
                                    response.sendRedirect("Donations_Details.jsp?Failed"); } } else {
                                    response.sendRedirect("Donations_Details.jsp?Failed=CampaignNotFound"); } } catch
                                    (Exception ex) { ex.printStackTrace(); String msg=ex.getMessage() !=null ?
                                    ex.getMessage() : "UnknownError" ; String encodedMsg="Error" ; try {
                                    encodedMsg=java.net.URLEncoder.encode(msg, "UTF-8" ); } catch (Exception encodingEx)
                                    { /* Ignore encoding error */ } response.sendRedirect("Donations_Details.jsp?Failed=" + encodedMsg);
    }
%>