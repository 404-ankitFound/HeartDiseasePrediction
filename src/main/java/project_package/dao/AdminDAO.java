package project_package.dao;

import project_package.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    public int getTotalUsers() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM users ";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getTotalPredictions() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM history";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getPredictionsLast7Days() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM history WHERE prediction_date >= CURRENT_DATE - INTERVAL '7 days'";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getPredictionsLast30Days() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM history WHERE prediction_date >= CURRENT_DATE - INTERVAL '30 days'";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getUsersLast7Days() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM users WHERE created_at >= CURRENT_DATE - INTERVAL '7 days' ";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getUsersLast30Days() {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM users WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}