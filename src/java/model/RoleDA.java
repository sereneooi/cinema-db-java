package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

public class RoleDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Role";
    private Connection conn;
    private PreparedStatement stmt;

    public RoleDA(){
        createConnection();
    }

    public void addRole(Role role) throws SQLException{
        String queryStr = "SELECT MAX(roleId) AS LastId FROM " + tableName;
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int newId = Integer.parseInt(rs.getString("LastId").substring(1)) + 1;

            String sqlStr = "INSERT INTO Role VALUES(?, ?)";

            stmt = conn.prepareStatement(sqlStr);
            stmt.setString(1, "R" + String.format("%04d", newId));
            stmt.setString(2, role.getRole().toUpperCase());

            stmt.executeUpdate();
        }
    }
    
    public int getLastId() throws SQLException{
        String queryStr = "SELECT MAX(roleId) AS LastId FROM " + tableName;
        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();
        
        int newId = 0;
        
        if (rs.next()) {
            newId = Integer.parseInt(rs.getString("LastId").substring(1)) + 1;
        }
        
        return newId;
    }

    public Role getRecord(String roleId, String roleName) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " WHERE upper(roleId) = upper(?) OR upper(role) = upper(?)";

        Role role = null;

        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, roleId);
        stmt.setString(2, roleName);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            role = new Role(rs.getString("roleId"), rs.getString("role"));
        }

        return role;
    }
    
    public List<Role> searchRecord(String key) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " WHERE upper(roleId) LIKE ? OR upper(role) LIKE ?";

        List<Role> role = new ArrayList<>();
        key = key.toUpperCase();
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, "%" + key + "%");
        stmt.setString(2, "%" + key + "%");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            role.add(new Role(rs.getString("roleId"), rs.getString("role")));
        }

        return role;
    }
    
    public List<Role> getAllRecord() throws SQLException{
        String queryStr = "SELECT * FROM " + tableName;

        List<Role> role = new ArrayList<>();

        stmt = conn.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            role.add(new Role(rs.getString("roleId"), rs.getString("role")));
        }

        return role;
    }

    public List<Role> getAllRecordForStaff(String custRoleId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " WHERE RoleId != ?";

        List<Role> role = new ArrayList<>();

        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, custRoleId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            role.add(new Role(rs.getString("roleId"), rs.getString("role")));
        }

        return role;
    }

    public void updateRole(Role role) throws SQLException{
        String sqlStr = "UPDATE Role SET role = upper(?) WHERE upper(roleId) = upper(?)";

        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, role.getRole().toUpperCase());
        stmt.setString(2, role.getRoleId().toUpperCase());

        stmt.executeUpdate();
    }

    public void deleteRole(Role role) throws SQLException{
        String sqlStr = "DELETE FROM Role WHERE upper(roleId) = upper(?)";

        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, role.getRoleId());

        stmt.executeUpdate();
    }

    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        new RoleDA();
    }
}
