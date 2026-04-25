package project_package.dao;

import project_package.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PredictionDAO {

    public boolean hasPredictedToday(String userid) {
        boolean exists = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT 1 FROM history WHERE userid=? AND prediction_date=CURRENT_DATE";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userid);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                exists = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    public void savePrediction(String userid, String age, String bp, String chol, String result) {

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO history(userid, prediction_date, age, resting_bp, cholesterol, prediction_result) VALUES (?, CURRENT_DATE, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userid);
            ps.setInt(2, Integer.parseInt(age));
            ps.setInt(3, Integer.parseInt(bp));
            ps.setInt(4, Integer.parseInt(chol));
            ps.setInt(5, Integer.parseInt(result));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ResultSet getUserHistory(String userid) {
        ResultSet rs = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM history WHERE userid=? ORDER BY prediction_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userid);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
}