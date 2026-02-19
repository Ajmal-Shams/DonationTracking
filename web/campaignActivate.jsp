<%-- 
    Document   : campaignActivate
    Created on : Nov 21, 2022, 1:05:56 PM
    Author     : Murthi
--%>

<%@page import="java.sql.Statement"%>
<%@page import="DonationTracking.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    try {
        int i = st.executeUpdate("update campaign set CampStatus='Active' where id='" + id + "'");
        System.out.println("test print==" + id);
        if (i != 0) {

            response.sendRedirect("Campaigns_Details.jsp?Granted");
        } else {

            System.out.println("failed");
            response.sendRedirect("Campaigns_Details.jsp?Failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>
