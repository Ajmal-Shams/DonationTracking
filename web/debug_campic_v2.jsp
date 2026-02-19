<%@page import="DonationTracking.SQLconnection" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.io.*" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>ImgDb</title>
                </head>

                <body>
                    <h1>Debug v4</h1>
                    <% String id=request.getParameter("id"); out.print("1. ID: ["); out.print(id); out.println("]<br>");

                        if (id==null || id.trim().isEmpty()) {
                        out.println("ERR: ID null<br>");
                        return;
                        }

                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                        out.println("2. Conn...<br>");
                        con = SQLconnection.getconnection();

                        if (con != null) {
                        out.println("OK: DB<br>");
                        } else {
                        out.println("ERR: DB NULL<br>");
                        return;
                        }

                        stmt = con.createStatement();
                        String q = "select CampPic from "
                        + "campaign where id='" + id + "'";
                        out.print("3. Q: ");
                        out.print(q);
                        out.println("<br>");

                        rs = stmt.executeQuery(q);

                        if (rs.next()) {
                        out.print("OK: Row ");
                        out.print(id);
                        out.println("<br>");

                        Blob img = rs.getBlob("CampPic");
                        if (img != null) {
                        long len = img.length();
                        out.print("OK: Blob: ");
                        out.print(len);
                        out.println(" bytes<br>");
                        } else {
                        out.println("ERR: Blob NULL<br>");
                        }
                        } else {
                        out.print("ERR: No row ");
                        out.print(id);
                        out.println("<br>");
                        }

                        } catch (Exception e) {
                        out.println("EX:<br>");
                        e.printStackTrace(new PrintWriter(out));
                        } finally {
                        try{if(rs!=null)rs.close();}catch(Exception e){}
                        try{if(stmt!=null)stmt.close();}catch(Exception e){}
                        try{if(con!=null)con.close();}catch(Exception e){}
                        out.println("5. Done.<br>");
                        }
                        %>
                </body>

                </html>