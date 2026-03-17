package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class donor_reg extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String fname = request.getParameter("firstName");
                String lname = request.getParameter("lastName");
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String district = request.getParameter("district");
                String panchayatName = request.getParameter("panchayat_name");
                String AccStatus = "Active";
                String Name = fname + " " + lname;

                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
                String time = dateFormat.format(date);

                Connection con = SQLconnection.getconnection();

                // Look up panchayat_id from district + panchayat_name
                int panchayatId = 0;
                if (panchayatName != null && !panchayatName.isEmpty()) {
                    PreparedStatement psLookup = con.prepareStatement(
                            "SELECT id FROM panchayat WHERE district = ? AND panchayat_name = ?");
                    psLookup.setString(1, district != null ? district : "");
                    psLookup.setString(2, panchayatName);
                    ResultSet rsLookup = psLookup.executeQuery();
                    if (rsLookup.next()) {
                        panchayatId = rsLookup.getInt("id");
                    } else {
                        // Auto-insert if not found
                        PreparedStatement psInsert = con.prepareStatement(
                                "INSERT INTO panchayat (district, panchayat_name) VALUES (?, ?)",
                                PreparedStatement.RETURN_GENERATED_KEYS);
                        psInsert.setString(1, district != null ? district : "");
                        psInsert.setString(2, panchayatName);
                        psInsert.executeUpdate();
                        ResultSet keys = psInsert.getGeneratedKeys();
                        if (keys.next()) {
                            panchayatId = keys.getInt(1);
                        }
                    }
                }

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO donor_reg(Name, Mailid, Phone, address, Tor, AccStatus, Password, panchayat_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, Name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, address);
                ps.setString(5, time);
                ps.setString(6, AccStatus);
                ps.setString(7, pass);
                ps.setInt(8, panchayatId);
                int i = ps.executeUpdate();
                if (i != 0) {
                    response.sendRedirect("Donor.jsp?Donor_success");
                } else {
                    response.sendRedirect("Donor.jsp?Donor_failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
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
        return "Short description";
    }
}
