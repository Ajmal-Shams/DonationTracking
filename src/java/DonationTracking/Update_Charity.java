package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Update_Charity extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String cid = request.getParameter("cid");
            String Charityname = request.getParameter("Charityname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String panchayatId = request.getParameter("panchayat_id");
            String min_donation = request.getParameter("min_donation");
            String min_donation_type = request.getParameter("min_donation_type");
            String max_donation = request.getParameter("max_donation");
            String max_donation_type = request.getParameter("max_donation_type");
            String pass = request.getParameter("pass");

            Connection con = SQLconnection.getconnection();
            String sql;
            PreparedStatement ps;

            if (pass != null && !pass.isEmpty()) {
                sql = "UPDATE charity_reg SET CName=?, CMailid=?, CPhone=?, Caddress=?, panchayat_id=?, min_donation=?, max_donation=?, min_donation_type=?, max_donation_type=?, CPassword=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, Charityname);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, address);
                ps.setInt(5, Integer.parseInt(panchayatId));
                ps.setDouble(6,
                        (min_donation != null && !min_donation.isEmpty()) ? Double.parseDouble(min_donation) : 0);
                ps.setDouble(7,
                        (max_donation != null && !max_donation.isEmpty()) ? Double.parseDouble(max_donation) : 0);
                ps.setString(8, min_donation_type != null ? min_donation_type : "Number");
                ps.setString(9, max_donation_type != null ? max_donation_type : "Number");
                ps.setString(10, pass);
                ps.setString(11, cid);
            } else {
                sql = "UPDATE charity_reg SET CName=?, CMailid=?, CPhone=?, Caddress=?, panchayat_id=?, min_donation=?, max_donation=?, min_donation_type=?, max_donation_type=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, Charityname);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, address);
                ps.setInt(5, Integer.parseInt(panchayatId));
                ps.setDouble(6,
                        (min_donation != null && !min_donation.isEmpty()) ? Double.parseDouble(min_donation) : 0);
                ps.setDouble(7,
                        (max_donation != null && !max_donation.isEmpty()) ? Double.parseDouble(max_donation) : 0);
                ps.setString(8, min_donation_type != null ? min_donation_type : "Number");
                ps.setString(9, max_donation_type != null ? max_donation_type : "Number");
                ps.setString(10, cid);
            }

            int i = ps.executeUpdate();
            if (i != 0) {
                response.sendRedirect("Charity_home.jsp?ProfileUpdated");
            } else {
                response.sendRedirect("Charity_home.jsp?UpdateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
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
}
