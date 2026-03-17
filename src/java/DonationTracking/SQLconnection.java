/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DonationTracking;

/**
 *
 * @author 
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class SQLconnection {

    static Connection con;

    /**
     *
     * @return
     */
    public static Connection getconnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/donation?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata",
                    "root", "Ajmal@09");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}