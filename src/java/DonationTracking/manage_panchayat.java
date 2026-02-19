package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class manage_panchayat extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String action = request.getParameter("action");
                Connection con = SQLconnection.getconnection();

                if (con == null) {
                    response.sendRedirect("Manage_Panchayats.jsp?error=db_failed");
                    return;
                }

                if ("add".equals(action)) {
                    String panchayatName = request.getParameter("panchayat_name");
                    PreparedStatement ps = con.prepareStatement("INSERT INTO panchayat (panchayat_name) VALUES (?)");
                    ps.setString(1, panchayatName);
                    ps.executeUpdate();
                    response.sendRedirect("SuperAdmin_home.jsp?panchayat_added");

                } else if ("update".equals(action)) {
                    String panchayatId = request.getParameter("panchayat_id");
                    String panchayatName = request.getParameter("panchayat_name");
                    PreparedStatement ps = con.prepareStatement("UPDATE panchayat SET panchayat_name = ? WHERE id = ?");
                    ps.setString(1, panchayatName);
                    ps.setInt(2, Integer.parseInt(panchayatId));
                    ps.executeUpdate();
                    response.sendRedirect("SuperAdmin_home.jsp?panchayat_updated");

                } else if ("delete".equals(action)) {
                    String panchayatId = request.getParameter("panchayat_id");
                    PreparedStatement ps = con.prepareStatement("DELETE FROM panchayat WHERE id = ?");
                    ps.setInt(1, Integer.parseInt(panchayatId));
                    ps.executeUpdate();
                    response.sendRedirect("SuperAdmin_home.jsp?panchayat_deleted");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("Manage_Panchayats.jsp?error=exception");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Manage Panchayat Servlet";
    }
}
