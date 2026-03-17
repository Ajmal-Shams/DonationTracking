<%-- 
    Document   : donation_updateCode
    Created on : Nov 21, 2022, 4:23:50 PM
    Author     : 
--%>

<%@page import="java.sql.Statement"%>
<%@page import="DonationTracking.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String spentFor = request.getParameter("spentFor");
    String spentOn = request.getParameter("spentOn");
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    try {
        int i = st.executeUpdate("update transaction set spentFor='"+spentFor+"',spentOn='"+spentOn+"' where Tid='" + id + "'");
        System.out.println("test print==" + id);
        if (i != 0) {

            response.sendRedirect("CDonations_Details.jsp?Updated");
        } else {

            System.out.println("failed");
            response.sendRedirect("Campaigns_Details.jsp?Failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>
