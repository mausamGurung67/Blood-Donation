package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBConenctionUtil;

public class RoleDAO {

    public static String getRoleFromId(int roleId) {
        String query = "SELECT role_name from roles where role_id = ?";
        try (Connection conn = DBConenctionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, roleId);

            ResultSet rs = ps.executeQuery();
            String roleName = "";

            if (rs.next()) {
                roleName = rs.getString("role_name");
            }

            return roleName;
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return "";
    }
}
