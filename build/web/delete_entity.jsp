<%@page import="java.sql.*" %>
    <%@page import="DonationTracking.SQLconnection" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <% String role=(String) session.getAttribute("role"); if (role==null || !role.equals("superadmin")) {
                response.sendRedirect("index.jsp?access_denied"); return; } String type=request.getParameter("type");
                String id=request.getParameter("id"); String[] ids=request.getParameterValues("ids"); // For bulk delete
                if (type !=null && (id !=null || (ids !=null && ids.length> 0))) {
                Connection con = SQLconnection.getconnection();
                Statement st = con.createStatement();
                String table = "";
                String redirectPage = "";

                if (type.equals("donor")) {
                table = "donor_reg";
                redirectPage = "SA_Donors.jsp";
                } else if (type.equals("charity")) {
                table = "charity_reg";
                redirectPage = "SA_Charities.jsp";
                } else if (type.equals("campaign")) {
                table = "campaign";
                redirectPage = "SA_Campaigns.jsp";
                }

                if (!table.isEmpty()) {
                try {
                String sql = "";
                if (ids != null && ids.length > 0) {
                // Bulk Delete
                String idList = "";
                for (int k = 0; k < ids.length; k++) { idList +=ids[k]; if (k < ids.length - 1) { idList +="," ; } }
                    sql="DELETE FROM " + table + " WHERE id IN (" + idList + ")" ; } else { // Single Delete
                    sql="DELETE FROM " + table + " WHERE id=" + id; } int i=st.executeUpdate(sql); if (i> 0) {
                    response.sendRedirect(redirectPage + "?deleted=true");
                    } else {
                    response.sendRedirect(redirectPage + "?deleted=false");
                    }
                    } catch (Exception ex) {
                    ex.printStackTrace();
                    response.sendRedirect(redirectPage + "?error=" + ex.getMessage());
                    }
                    } else {
                    response.sendRedirect("SuperAdmin_home.jsp?error=invalid_type");
                    }
                    } else {
                    response.sendRedirect("SuperAdmin_home.jsp?error=missing_params");
                    }
                    %>