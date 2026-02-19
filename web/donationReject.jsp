<%-- Document : donationReject Created on : Nov 22, 2022, 9:55:31 AM Author : Murthi --%>

    <%@page import="java.sql.ResultSet" %>
        <%@page import="java.sql.Statement" %>
            <%@page import="DonationTracking.SQLconnection" %>
                <%@page import="java.sql.Connection" %>
                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
                        <%@page import="java.util.Date" %>
                            <%@page import="java.text.SimpleDateFormat" %>
                                <% String tid=request.getParameter("tid"); // Capture user and time String
                                    acceptedBy="Unknown" ; if (session.getAttribute("superadmin_name") !=null) {
                                    acceptedBy=(String) session.getAttribute("superadmin_name") + " (Super Admin)" ; }
                                    else if (session.getAttribute("admin_name") !=null) { acceptedBy=(String)
                                    session.getAttribute("admin_name") + " (Panchayat Admin)" ; } SimpleDateFormat
                                    sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); String acceptedTime=sdf.format(new
                                    Date()); Connection con=SQLconnection.getconnection(); Statement
                                    st=con.createStatement(); Statement st1=con.createStatement(); Statement
                                    st2=con.createStatement(); try { String
                                    updateQuery="update transaction set donationStatus='Refund' where Tid='" + tid + "'"
                                    ; int i=st2.executeUpdate(updateQuery); System.out.println("test print==" + tid);
        if (i != 0) {
            response.sendRedirect(" Donations_Details.jsp?Refund"); } else { System.out.println("failed");
                                    response.sendRedirect("Donations_Details.jsp?Failed"); } } catch (Exception ex) {
                                    ex.printStackTrace(); } %>