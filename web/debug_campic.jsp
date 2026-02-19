<%@page import="DonationTracking.SQLconnection" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.io.*" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Image Debugger</title>
                    <style>
                        body {
                            font-family: monospace;
                        }
                    </style>
                </head>

                <body>
                    <h1>Image Debug Log</h1>
                    <% String id=request.getParameter("id"); out.println("<p><strong>1. Received ID parameter:</strong>
                        [" + id + "]</p>");

                        if (id == null || id.trim().isEmpty()) {
                        out.println("<p style='color:red;'>ERROR: ID is null or empty.</p>");
                        return;
                        }

                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                        out.println("<p><strong>2. Attempting Database Connection...</strong></p>");
                        con = SQLconnection.getconnection();

                        if (con != null) {
                        out.println("<p style='color:green;'>SUCCESS: Database connection established.</p>");
                        } else {
                        out.println("<p style='color:red;'>ERROR: Connection object is null!</p>");
                        return;
                        }

                        stmt = con.createStatement();
                        String sql = "select CampPic from campaign where id = '" + id + "'";
                        out.println("<p><strong>3. Executing Query:</strong> " + sql + "</p>");

                        rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                        out.println("<p style='color:green;'>SUCCESS: Row found for ID " + id + ".</p>");

                        Blob image = rs.getBlob("CampPic");
                        if (image != null) {
                        long length = image.length();
                        out.println("<p style='color:green;'>SUCCESS: Blob found. Size: " + length + " bytes.</p>");

                        if (length > 0) {
                        out.println("<p><strong>4. Image content check:</strong> Image exists and has size.</p>");
                        } else {
                        out.println("<p style='color:orange;'>WARNING: Blob exists but is empty (0 bytes).</p>");
                        }
                        } else {
                        out.println("<p style='color:red;'>ERROR: Blob (CampPic column) is NULL.</p>");
                        }
                        } else {
                        out.println("<p style='color:red;'>ERROR: No row found in 'campaign' table for ID " + id + ".
                        </p>");
                        }

                        } catch (Exception e) {
                        out.println("<p style='color:red;'>EXCEPTION THROWN:</p>");
                        out.println("
                        <pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
                        } finally {
                        if(rs != null) try { rs.close(); } catch(Exception e) {}
                        if(stmt != null) try { stmt.close(); } catch(Exception e) {}
                        if(con != null) try { con.close(); } catch(Exception e) {}
                        out.println("<p><strong>5. Resources closed.</strong></p>");
                        }
                        %>
                </body>

                </html>