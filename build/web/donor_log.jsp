<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="DonationTracking.SQLconnection" %>
            <% String email=request.getParameter("name"); String pass=request.getParameter("pass");
                System.out.println("Check User ID And Password : "+email+pass);

Connection con=SQLconnection.getconnection();
Statement st=con.createStatement();
Statement st1=con.createStatement();

String q1=" SELECT * FROM donor_reg WHERE Mailid='"+email+"'"
+" AND Password='"+pass+"'";

String q2=" SELECT * FROM donor_reg WHERE Mailid='"+email+"'"
+" AND Password='"+pass+"'"
+" AND AccStatus='Active'";

try{
    ResultSet rs1=st1.executeQuery(q1);
    if(rs1.next()){
        System.out.println(" Pass 1"); ResultSet rs=st.executeQuery(q2); if(rs.next()){ System.out.println(" Pass 2");
                session.setAttribute("dname",rs.getString("Name"));
                session.setAttribute("dmail",rs.getString("Mailid")); session.setAttribute("did",rs.getString("id"));
                session.setAttribute("daddress",rs.getString("address"));
                session.setAttribute("dphone",rs.getString("phone"));
                session.setAttribute("panchayat_id",rs.getInt("panchayat_id"));
                response.sendRedirect("donor_home.jsp?Success"); }else{ System.out.println("Pass 3");
                response.sendRedirect("Donor.jsp?not"); } }else{ System.out.println("Pass 4");
                response.sendRedirect("Donor.jsp?Authentication_Failed"); } }catch(Exception ex){ ex.printStackTrace();
                } %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Processing...</title>
                </head>

                <body></body>

                </html>