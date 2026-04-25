package project_package.dao;

import java.sql.Connection;
import java.sql.*;

import project_package.model.User;
import project_package.util.DBConnection;

public class UserDAO {

    public User login(String userid, String password) {
        User user = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE userid=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, userid);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserid(rs.getString("userid"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean isUserExists(String userid) {
        boolean exists = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE userid = ?";
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
    public boolean registerUser(User user) {
        boolean status = false;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO users(userid, full_name, email, password, role) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getUserid());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}