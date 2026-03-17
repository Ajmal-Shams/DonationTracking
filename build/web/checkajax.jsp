<%-- 
    Document   : checkajax
    Created on : Nov 19, 2022, 10:04:34 AM
    Author     : 
--%>


<%@page import="DonationTracking.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%
String email = request.getParameter("mailid").toString();
System.out.println(email);
String data ="";
try{
Connection con=SQLconnection.getconnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from donor_reg where Mailid='"+email+"'");
int count=0;
while(rs.next())
{

count++;
}

if(count>0)
{
data="Email-ID already exists!";
}
else
{
data="You can register now!!!!";
}
out.println(data);
System.out.println(data);
}
catch (Exception e) {
System.out.println(e);
}
%>
