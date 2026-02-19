package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class adminlog extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");

                Connection con = SQLconnection.getconnection();
                if (con == null) {
                    response.sendRedirect("Admin.jsp?failed");
                    return;
                }

                PreparedStatement ps = con.prepareStatement(
                        "SELECT a.*, p.panchayat_name FROM admin_reg a JOIN panchayat p ON a.panchayat_id = p.id WHERE a.Mailid = ? AND a.Password = ?");
                ps.setString(1, email);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("role", "panchayat_admin");
                    session.setAttribute("admin_id", rs.getInt("id"));
                    session.setAttribute("admin_name", rs.getString("Name"));
                    session.setAttribute("admin_email", rs.getString("Mailid"));
                    session.setAttribute("panchayat_id", rs.getInt("panchayat_id"));
                    session.setAttribute("panchayat_name", rs.getString("panchayat_name"));
                    response.sendRedirect("Admin_home.jsp?success");
                } else {
                    response.sendRedirect("Admin.jsp?failed");
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("Admin.jsp?failed");
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
        return "Panchayat Admin Login Servlet";
    }
}
