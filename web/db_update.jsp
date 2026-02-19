<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>DB Update</title>
            </head>

            <body>
                <h1>Updating Database Schema...</h1>
                <% Connection con=SQLconnection.getconnection(); Statement st=con.createStatement(); try { // Add
                    accepted_by column try { st.executeUpdate("ALTER TABLE transaction ADD COLUMN accepted_by
                    VARCHAR(100)"); out.println("Added accepted_by column.<br>");
                    } catch (Exception e) {
                    out.println("accepted_by column might already exist: " + e.getMessage() + "<br>");
                    }

                    // Add accepted_time column
                    try {
                    st.executeUpdate("ALTER TABLE transaction ADD COLUMN accepted_time VARCHAR(50)");
                    out.println("Added accepted_time column.<br>");
                    } catch (Exception e) {
                    out.println("accepted_time column might already exist: " + e.getMessage() + "<br>");
                    }

                    out.println("<h3>Database update completed successfully!</h3>");
                    } catch (Exception ex) {
                    out.println("<h3>Error: " + ex.getMessage() + "</h3>");
                    ex.printStackTrace();
                    }
                    %>
            </body>

            </html>