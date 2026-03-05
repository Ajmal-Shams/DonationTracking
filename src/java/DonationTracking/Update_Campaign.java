package DonationTracking;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215)
public class Update_Campaign extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id");
            String Fname = request.getParameter("Fname");
            String Fdes = request.getParameter("Fdes");
            String Amount = request.getParameter("Amount");
            String Fdate = request.getParameter("Fdate");
            String min_donation = request.getParameter("min_donation");
            String min_donation_type = request.getParameter("min_donation_type");
            String max_donation = request.getParameter("max_donation");
            String max_donation_type = request.getParameter("max_donation_type");

            InputStream inputStream = null;
            Part filePart = request.getPart("Fpic");
            if (filePart != null && filePart.getSize() > 0) {
                inputStream = filePart.getInputStream();
            }

            Connection conn = SQLconnection.getconnection();
            String sql;
            PreparedStatement statement;

            if (inputStream != null) {
                sql = "UPDATE campaign SET campName=?, CampDes=?, CampPic=?, Amount=?, EndDate=?, min_donation=?, max_donation=?, min_donation_type=?, max_donation_type=? WHERE id=?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, Fname);
                statement.setString(2, Fdes);
                statement.setBlob(3, inputStream);
                statement.setString(4, Amount);
                statement.setString(5, Fdate);
                statement.setDouble(6,
                        (min_donation != null && !min_donation.isEmpty()) ? Double.parseDouble(min_donation) : 0);
                statement.setDouble(7,
                        (max_donation != null && !max_donation.isEmpty()) ? Double.parseDouble(max_donation) : 0);
                statement.setString(8, min_donation_type != null ? min_donation_type : "Number");
                statement.setString(9, max_donation_type != null ? max_donation_type : "Number");
                statement.setString(10, id);
            } else {
                sql = "UPDATE campaign SET campName=?, CampDes=?, Amount=?, EndDate=?, min_donation=?, max_donation=?, min_donation_type=?, max_donation_type=? WHERE id=?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, Fname);
                statement.setString(2, Fdes);
                statement.setString(3, Amount);
                statement.setString(4, Fdate);
                statement.setDouble(5,
                        (min_donation != null && !min_donation.isEmpty()) ? Double.parseDouble(min_donation) : 0);
                statement.setDouble(6,
                        (max_donation != null && !max_donation.isEmpty()) ? Double.parseDouble(max_donation) : 0);
                statement.setString(7, min_donation_type != null ? min_donation_type : "Number");
                statement.setString(8, max_donation_type != null ? max_donation_type : "Number");
                statement.setString(9, id);
            }

            int row = statement.executeUpdate();
            if (row > 0) {
                response.sendRedirect("View_Campaigns_Details.jsp?Updated");
            } else {
                response.sendRedirect("View_Campaigns_Details.jsp?UpdateFailed");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
