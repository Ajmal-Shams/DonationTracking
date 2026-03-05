<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>DB Update V2 - Donation Limits</title>
            </head>

            <body>
                <h1>Updating Database Schema for Donation Limits...</h1>
                <% Connection con=SQLconnection.getconnection(); Statement st=con.createStatement(); try { // Add
                    columns to campaign table String[]
                    campaignCols={ "ALTER TABLE campaign ADD COLUMN min_donation DOUBLE DEFAULT 0"
                    , "ALTER TABLE campaign ADD COLUMN max_donation DOUBLE DEFAULT 0"
                    , "ALTER TABLE campaign ADD COLUMN min_donation_type VARCHAR(20) DEFAULT 'Number'"
                    , "ALTER TABLE campaign ADD COLUMN max_donation_type VARCHAR(20) DEFAULT 'Number'" }; for (String
                    sql : campaignCols) { try { st.executeUpdate(sql); out.println("Executed: " + sql + " <br>");
                    } catch (Exception e) {
                    out.println("Skip (exists?): " + e.getMessage() + "<br>");
                    }
                    }

                    // Add columns to charity_reg table
                    String[] charityCols = {
                    "ALTER TABLE charity_reg ADD COLUMN min_donation DOUBLE DEFAULT 0",
                    "ALTER TABLE charity_reg ADD COLUMN max_donation DOUBLE DEFAULT 0",
                    "ALTER TABLE charity_reg ADD COLUMN min_donation_type VARCHAR(20) DEFAULT 'Number'",
                    "ALTER TABLE charity_reg ADD COLUMN max_donation_type VARCHAR(20) DEFAULT 'Number'"
                    };

                    for (String sql : charityCols) {
                    try {
                    st.executeUpdate(sql);
                    out.println("Executed: " + sql + "<br>");
                    } catch (Exception e) {
                    out.println("Skip (exists?): " + e.getMessage() + "<br>");
                    }
                    }

                    out.println("<h3>Database update completed successfully!</h3>");
                    } catch (Exception ex) {
                    out.println("<h3>Error: " + ex.getMessage() + "</h3>");
                    ex.printStackTrace();
                    }
                    %>
            </body>

            </html>