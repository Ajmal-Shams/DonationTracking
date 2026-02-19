package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class superadminlog extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String name = request.getParameter("name");
                String pass = request.getParameter("pass");
                if (name.equals("SuperAdmin") && pass.equals("SuperAdmin")) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("role", "superadmin");
                    session.setAttribute("superadmin_name", "SuperAdmin");
                    response.sendRedirect("SuperAdmin_home.jsp?success");
                } else {
                    response.sendRedirect("SuperAdmin.jsp?failed");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("SuperAdmin.jsp?failed");
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
        return "Super Admin Login Servlet";
    }
}
