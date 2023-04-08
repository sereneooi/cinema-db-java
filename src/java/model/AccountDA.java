package model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.text.ParseException;
import javax.swing.*;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.Date;  
import java.util.List;

public class AccountDA {
    private String host = "jdbc:derby://localhost:1527/cinemadb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Account";
    private Connection conn;
    private PreparedStatement stmt;
    
    public AccountDA(){
        createConnection();
    }
    
    public void addAccount(Account acc) throws SQLException, ParseException{
        String sqlStr = "INSERT INTO Account VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        Date birthDt = new SimpleDateFormat("yyyy-MM-dd").parse(acc.getBirthDate());  
        java.sql.Date dateCreated = new java.sql.Date(acc.getDateCreated().getTime());
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, acc.getEmailAddress());
        stmt.setString(2, acc.getName().toUpperCase());
        stmt.setString(3, doHashing(acc.getPassword()));
        stmt.setString(4, acc.getIc());
        stmt.setString(5, String.valueOf(acc.getGender()).toUpperCase());
        stmt.setString(6, acc.getBirthDate());
        stmt.setString(7, acc.getAddress().toUpperCase());
        stmt.setString(8, acc.getContactNo());
        stmt.setString(9, acc.getRole().getRoleId());
        stmt.setDate(10, dateCreated);
        stmt.setDate(11, null); // date modified
        
        stmt.executeUpdate();
    }
    
    public Account getRecord(String emailAddress, String ic) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE upper(EmailAddress) = upper(?) OR Ic = ?";
        
        Account acc = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, emailAddress);
        stmt.setString(2, ic);
        
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            acc = new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified"));
        }
            
        return acc;
    }
    
    public List<Account> getAllStaffRecord(String roleId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE Account.roleId != ?";
                
        List<Account> acc = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, roleId);
        
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            acc.add(new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")));
        }
            
        return acc;
    }
    
    public List<Account> getAllCustomerRecord(String roleId) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE Account.roleId = ?";
                
        List<Account> acc = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, roleId);
        
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            acc.add(new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")));
        }
            
        return acc;
    }
    
    public List<Account> searchStaffRecord(String key, String custId) throws SQLException{
        key = key.toUpperCase();
        
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE (upper(EmailAddress) LIKE ? OR upper(Name) LIKE ? OR "
                + "Ic LIKE ? OR ContactNo LIKE ? OR "
                + "upper(Role.roleId) LIKE ? OR upper(Role.role) LIKE ? OR upper(Gender) LIKE ?)"
                + " AND Account.roleId != ?";
                
        List<Account> acc = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, "%" + key + "%");
        stmt.setString(2, "%" + key + "%");
        stmt.setString(3, "%" + key + "%");
        stmt.setString(4, "%" + key + "%");
        stmt.setString(5, "%" + key + "%");
        stmt.setString(6, "%" + key + "%");
        stmt.setString(7, "%" + key + "%");
        stmt.setString(8, custId);
        
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            acc.add(new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")));
        }
            
        return acc;
    }
    
    public List<Account> searchCustRecord(String key, String custId) throws SQLException{
        key = key.toUpperCase();
        
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE (upper(EmailAddress) LIKE ? OR upper(Name) LIKE ? OR "
                + "Ic LIKE ? OR ContactNo LIKE ? OR "
                + "upper(Role.roleId) LIKE ? OR upper(Role.role) LIKE ? OR upper(Gender) LIKE ?)"
                + " AND Account.roleId = ?";
                
        List<Account> acc = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, "%" + key + "%");
        stmt.setString(2, "%" + key + "%");
        stmt.setString(3, "%" + key + "%");
        stmt.setString(4, "%" + key + "%");
        stmt.setString(5, "%" + key + "%");
        stmt.setString(6, "%" + key + "%");
        stmt.setString(7, "%" + key + "%");
        stmt.setString(8, custId);
        
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            acc.add(new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")));
        }
            
        return acc;
    }
    
    public List<Account> sort(String key, String order) throws SQLException{
        
        String queryStr = "SELECT * FROM " + tableName +
                            " INNER JOIN Role ON Account.roleId = Role.roleId WHERE Account.roleId = 'R0003'" +
                            " ORDER BY " + key + " " + order;
                
        List<Account> acc = new ArrayList<>();
        
        stmt = conn.prepareStatement(queryStr);
        
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            acc.add(new Account(rs.getString("EmailAddress"), rs.getString("Name"), rs.getString("Password"), rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified")));
        }
            
        return acc;
    }
    
    public Account checkLogin(String emailAddress, String password) throws SQLException{
        String queryStr = "SELECT * FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE upper(EmailAddress) = upper(?) AND Password = ?";
        
        Account acc = null;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, emailAddress);
        stmt.setString(2, doHashing(password));
        
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            acc = new Account(rs.getString("EmailAddress"), rs.getString("Name"), password, rs.getString("Ic"), 
                  rs.getString("Gender").charAt(0), rs.getString("BirthDate"), rs.getString("Address"), rs.getString("ContactNo"), 
                  new Role(rs.getString("RoleId"), rs.getString("Role")), rs.getDate("dateCreated"), rs.getDate("dateModified"));
        }
            
        return acc;
    }
  
    public void updateAccount(Account acc) throws SQLException{
        AccountDA accDA = new AccountDA();
        Account accFromDb = accDA.getRecord(acc.getEmailAddress(), "");
        
        if(accFromDb.getName().equals(acc.getName()) && accFromDb.getIc().equals(acc.getIc()) && accFromDb.getGender() == (acc.getGender())
            && accFromDb.getBirthDate().equals(acc.getBirthDate()) && accFromDb.getAddress().equals(acc.getAddress())
            && accFromDb.getContactNo().equals(acc.getContactNo()) && accFromDb.getRole().getRoleId().equals(acc.getRole().getRoleId())){
            throw new IllegalArgumentException("No changes found.");
        }
        
        String sqlStr = "UPDATE Account SET Name = upper(?), Ic = ?, Gender = upper(?), BirthDate = ?, "
                + "Address = upper(?), ContactNo = ?, RoleId = ?, DateModified = ? WHERE upper(EmailAddress) = upper(?)";
        
        java.sql.Date dateModified = new java.sql.Date(acc.getDateModified().getTime());
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(9, acc.getEmailAddress());
        stmt.setString(1, acc.getName().toUpperCase());
        stmt.setString(2, acc.getIc());
        stmt.setString(3, String.valueOf(acc.getGender()).toUpperCase());
        stmt.setString(4, acc.getBirthDate());
        stmt.setString(5, acc.getAddress().toUpperCase());
        stmt.setString(6, acc.getContactNo());
        stmt.setString(7, acc.getRole().getRoleId());
        stmt.setDate(8, dateModified);

        stmt.executeUpdate();
    }
    
    public void updatePassword(Account acc) throws SQLException{
        AccountDA accDA = new AccountDA();
        Account accFromDb = accDA.getRecord(acc.getEmailAddress(), "");
        
        if(accFromDb.getPassword().equals(doHashing(acc.getPassword()))){
            throw new IllegalArgumentException("New password cannot same as the old password.");
        }
        
        String sqlStr = "UPDATE Account SET Password = ?, DateModified = ? WHERE upper(EmailAddress) = upper(?)";
        
        java.sql.Date dateModified = new java.sql.Date(acc.getDateModified().getTime());
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, doHashing(acc.getPassword()));
        stmt.setDate(2, dateModified);
        stmt.setString(3, acc.getEmailAddress());
        
        stmt.executeUpdate();
    }
    
    public void deleteAccount(Account acc) throws SQLException{
        String sqlStr = "DELETE FROM Account WHERE upper(EmailAddress) = upper(?)"; 
        
        stmt = conn.prepareStatement(sqlStr);
        stmt.setString(1, acc.getEmailAddress());
        
        stmt.executeUpdate();
    }
    
    public int getTotalCustomers(String roleId) throws SQLException{
        String queryStr = "SELECT COUNT(emailAddress) FROM " + tableName + " INNER JOIN Role ON Account.roleId = Role.roleId"
                + " WHERE Account.roleId = ?";
                
        int total = 0;
        
        stmt = conn.prepareStatement(queryStr);
        stmt.setString(1, roleId);
        
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            total = rs.getInt(1);
        }
            
        return total;
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
    
    public static String doHashing (String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(password.getBytes());

            byte[] resultByteArray = messageDigest.digest();

            StringBuilder sb = new StringBuilder();
            for (byte b : resultByteArray) {
                sb.append(String.format("%02x", b)); // return in hexadecimal format
            }

            return sb.toString();

        }catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return "";
    }
    
    public static void main(String[] args) throws SQLException {
        new AccountDA();
    }
}
