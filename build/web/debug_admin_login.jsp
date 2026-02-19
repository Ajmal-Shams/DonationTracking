<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Debug Admin Login</title>
        </head>

        <body>
            <h1>Debug Admin Login</h1>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Panchayat ID</th>
                </tr>
                <% try { Connection con=SQLconnection.getconnection(); if (con==null) { out.println("<h3>Connection to
                    DB Failed!</h3>");
                    } else {
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM admin_reg");
                    while (rs.next()) {
                    %>
                    <tr>
                        <td>
                            <%=rs.getString("id")%>
                        </td>
                        <td>
                            <%=rs.getString("Name")%>
                        </td>
                        <td>
                            <%=rs.getString("Mailid")%>
                        </td>
                        <td>
                            <%=rs.getString("Password")%>
                        </td>
                        <td>
                            <%=rs.getString("panchayat_id")%>
                        </td>
                    </tr>
                    <% } } } catch (Exception e) { out.println("Error: " + e.getMessage());
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        %>
    </table>

    <h2>Charity Users (Check if user is actually a charity)</h2>
    <table border=" 1">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                        <% try { Connection con=SQLconnection.getconnection(); Statement st=con.createStatement();
                            ResultSet rs=st.executeQuery("SELECT * FROM charity_reg"); while (rs.next()) { %>
                            <tr>
                                <td>
                                    <%=rs.getString("id")%>
                                </td>
                                <td>
                                    <%=rs.getString("name")%>
                                </td>
                                <td>
                                    <%=rs.getString("email")%>
                                </td>
                            </tr>
                            <% } } catch (Exception e) { out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>