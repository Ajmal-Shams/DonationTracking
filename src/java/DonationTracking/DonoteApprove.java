/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DonationTracking;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Murthi
 */
public class DonoteApprove extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                HttpSession user = request.getSession(true);
                String cname = request.getParameter("cname");
                String campName = request.getParameter("campName");
                String payment = request.getParameter("payment");
                String amount = request.getParameter("amount");
                String charity_id = request.getParameter("charity_id");
                String campaign_id = request.getParameter("campaign_id");
                String rid = request.getParameter("rid");

                String did = user.getAttribute("did").toString();
                String dname = user.getAttribute("dname").toString();
                Integer panchayatId = (Integer) user.getAttribute("panchayat_id");

                Random RANDOM = new SecureRandom();
                int ACCCNO = 10;
                String letters = "123456789";
                String num = "";
                for (int k = 0; k < ACCCNO; k++) {
                    int index = (int) (RANDOM.nextDouble() * letters.length());
                    num += letters.substring(index, index + 1);
                }
                String Tid = "DTS" + num;

                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
                String time = dateFormat.format(date);
                System.out.println("current Date " + time);
                Connection conn = SQLconnection.getconnection();
                Statement st = conn.createStatement();
                Statement st1 = conn.createStatement();
                String sql = "insert into transaction(Tid, cname, campName, payment, amount, charity_id, campaign_id, did, dname, spentOn, spentFor, TofPayement, donationStatus, panchayat_id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, Tid);
                statement.setString(2, cname);
                statement.setString(3, campName);
                statement.setString(4, payment);
                statement.setString(5, amount);
                statement.setString(6, charity_id);
                statement.setString(7, campaign_id);
                statement.setString(8, did);
                statement.setString(9, dname);
                statement.setString(10, "NA");
                statement.setString(11, "NA");
                statement.setString(12, time);
                statement.setString(13, "Waiting");
                statement.setInt(14, panchayatId != null ? panchayatId : 0);
                int row = statement.executeUpdate();
                if (row > 0) {
                    int i = st1.executeUpdate("update donation_req set reqStatus='Accepted' where id='" + rid + "'");
                    response.sendRedirect("donor_home.jsp?PaymentDone");
                } else {
                    response.sendRedirect("donor_home.jsp?PaymentFailed");
                }
            } catch (Exception e) {
            } finally {
                out.close();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
