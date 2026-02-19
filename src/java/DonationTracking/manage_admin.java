package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class manage_admin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String action = request.getParameter("action");
                Connection con = SQLconnection.getconnection();

                if (con == null) {
                    response.sendRedirect("Manage_Admins.jsp?error=db_failed");
                    return;
                }

                if ("add".equals(action)) {
                    String name = request.getParameter("name");
                    String email = request.getParameter("mailid");
                    String phone = request.getParameter("phone");
                    String password = request.getParameter("password");
                    String panchayatId = request.getParameter("panchayat_id");

                    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    Date date = new Date();
                    String time = dateFormat.format(date);

                    PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO admin_reg (Name, Mailid, Password, Phone, panchayat_id, Tor) VALUES (?, ?, ?, ?, ?, ?)");
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setString(3, password);
                    ps.setString(4, phone);
                    ps.setInt(5, Integer.parseInt(panchayatId));
                    ps.setString(6, time);
                    ps.executeUpdate();
                    response.sendRedirect("SuperAdmin_home.jsp?admin_added");

                } else if ("delete".equals(action)) {
                    String adminId = request.getParameter("admin_id");
                    PreparedStatement ps = con.prepareStatement("DELETE FROM admin_reg WHERE id = ?");
                    ps.setInt(1, Integer.parseInt(adminId));
                    ps.executeUpdate();
                    response.sendRedirect("SuperAdmin_home.jsp?admin_deleted");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("Manage_Admins.jsp?error=exception");
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
        return "Manage Admin Servlet";
    }
}
