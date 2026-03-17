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
import java.sql.ResultSet;
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
 * @author 
 */
public class donate extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            try {
                HttpSession user = request.getSession(true);
                String cname = request.getParameter("cname");
                String campName = request.getParameter("campName");
                String payment = request.getParameter("payment");
                String amount = request.getParameter("amount");
                String charity_id = request.getParameter("charity_id");
                String campaign_id = request.getParameter("campaign_id");

                Object didObj = user.getAttribute("did");
                Object dnameObj = user.getAttribute("dname");
                if (didObj == null || dnameObj == null) {
                    response.sendRedirect("donor_log.jsp");
                    return;
                }
                String did = didObj.toString();
                String dname = dnameObj.toString();
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

                // Fetch limits
                double donateAmount = Double.parseDouble(amount);
                try {
                    double campaignGoal = 0;
                    double collected = 0;
                    double cMin = 0, cMax = 0;
                    String cMinType = "Number", cMaxType = "Number";
                    double chMin = 0, chMax = 0;
                    String chMinType = "Number", chMaxType = "Number";

                    Statement stLimits = conn.createStatement();
                    ResultSet rsLimits = stLimits.executeQuery(
                            "SELECT c.Amount, c.AmountCol, c.min_donation AS camp_min, c.max_donation AS camp_max, c.min_donation_type AS camp_min_type, c.max_donation_type AS camp_max_type, cr.min_donation AS char_min, cr.max_donation AS char_max, cr.min_donation_type AS char_min_type, cr.max_donation_type AS char_max_type FROM campaign c JOIN charity_reg cr ON c.cid = cr.id WHERE c.id='"
                                    + campaign_id + "'");
                    if (rsLimits.next()) {
                        campaignGoal = rsLimits.getDouble("Amount");
                        collected = rsLimits.getDouble("AmountCol");
                        cMin = rsLimits.getDouble("camp_min");
                        cMax = rsLimits.getDouble("camp_max");
                        cMinType = rsLimits.getString("camp_min_type");
                        cMaxType = rsLimits.getString("camp_max_type");
                        chMin = rsLimits.getDouble("char_min");
                        chMax = rsLimits.getDouble("char_max");
                        chMinType = rsLimits.getString("char_min_type");
                        chMaxType = rsLimits.getString("char_max_type");
                    }

                    double remaining = campaignGoal - collected;
                    double absCMin = "Percentage".equals(cMinType) ? (cMin * campaignGoal / 100) : cMin;
                    double absCMax = "Percentage".equals(cMaxType) ? (cMax * campaignGoal / 100) : cMax;
                    double absChMin = "Percentage".equals(chMinType) ? (chMin * campaignGoal / 100) : chMin;
                    double absChMax = "Percentage".equals(chMaxType) ? (chMax * campaignGoal / 100) : chMax;

                    double effMin = Math.max(absCMin, absChMin);
                    double effMax = Double.MAX_VALUE;
                    if (absCMax > 0)
                        effMax = Math.min(effMax, absCMax);
                    if (absChMax > 0)
                        effMax = Math.min(effMax, absChMax);

                    // Enforce remaining goal
                    if (donateAmount > remaining && campaignGoal > 0) {
                        response.sendRedirect(
                                "donatePage.jsp?id=" + campaign_id + "&LimitError=GoalExceeded&remaining=" + remaining);
                        return;
                    }

                    if (donateAmount < effMin) {
                        response.sendRedirect(
                                "donatePage.jsp?id=" + campaign_id + "&LimitError=MinLimit&min=" + effMin);
                        return;
                    }
                    if (effMax > 0 && donateAmount > effMax && effMax != Double.MAX_VALUE) {
                        response.sendRedirect(
                                "donatePage.jsp?id=" + campaign_id + "&LimitError=MaxLimit&max=" + effMax);
                        return;
                    }
                } catch (Exception limEx) {
                    System.out.println("Limit check failed: " + limEx.getMessage());
                }

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
                    // Update the campaign collected amount
                    Statement stUpdate = conn.createStatement();
                    stUpdate.executeUpdate("UPDATE campaign SET AmountCol = AmountCol + " + donateAmount
                            + " WHERE id = '" + campaign_id + "'");
                    response.sendRedirect("donor_home.jsp?PaymentDone");
                } else {
                    response.sendRedirect("donor_home.jsp?PaymentFailed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("donor_home.jsp?PaymentFailed");
                return;
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
