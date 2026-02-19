<%@page import="DonationTracking.SQLconnection" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.io.*" %>
            <% /* 1. Prevent caching */ response.setHeader("Pragma", "no-cache" );
                response.setHeader("Cache-Control", "no-cache" ); response.setDateHeader("Expires", 0); try { /* 2.
                Clear buffer to remove any leading whitespace as images must start with magic bytes */ out.clear();
                out=pageContext.pushBody(); String id=request.getParameter("id"); if (id==null || id.trim().isEmpty()) {
                response.setStatus(400); return; } Connection con=null; Statement stmt=null; ResultSet rs=null; try {
                con=SQLconnection.getconnection(); if (con !=null) { stmt=con.createStatement(); String
                q="SELECT CampPic FROM campaign WHERE id='" + id + "'" ; rs=stmt.executeQuery(q); if (rs.next()) { Blob
                b=rs.getBlob("CampPic"); if (b !=null) { long len=b.length(); byte[] data=b.getBytes(1, (int) len);
                response.setContentType("image/jpeg"); response.setContentLength((int) len); OutputStream
                o=response.getOutputStream(); o.write(data); o.flush(); /* Successful Image Output */ } else {
                response.setStatus(404); } } else { response.setStatus(404); } } } catch (Exception e) {
                response.setStatus(500); e.printStackTrace(); } finally { if (rs !=null) try { rs.close(); } catch
                (Exception e) {} if (stmt !=null) try { stmt.close(); } catch (Exception e) {} if (con !=null) try {
                con.close(); } catch (Exception e) {} } } catch (Exception ex) { /* Top level error */ } %>