package DonationTracking;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetCampaignImage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID");
            return;
        }

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        OutputStream out = response.getOutputStream();

        try {
            con = SQLconnection.getconnection();
            String sql = "SELECT CampPic FROM campaign WHERE id = ?";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("CampPic");
                if (blob != null) {
                    byte[] imageData = blob.getBytes(1, (int) blob.length());
                    response.setContentType("image/jpeg");
                    response.setContentLength(imageData.length);
                    out.write(imageData);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Campaign not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        } finally {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {
                }
            if (stmt != null)
                try {
                    stmt.close();
                } catch (SQLException e) {
                }
            if (con != null)
                try {
                    con.close();
                } catch (SQLException e) {
                }
            if (out != null)
                try {
                    out.close();
                } catch (IOException e) {
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
        return "Serves campaign images";
    }
}
