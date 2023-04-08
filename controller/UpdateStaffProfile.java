package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "UpdateStaffProfile", urlPatterns = {"/UpdateStaffProfile"})
public class UpdateStaffProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String custRoleId = "R0003";
        
        try{
            RoleDA roleDA = new RoleDA();
            AccountDA accDA = new AccountDA();
            List<Role> roleList = roleDA.getAllRecordForStaff(custRoleId);
            Account acc = (Account) session.getAttribute("currentUser");
            acc = accDA.getRecord(acc.getEmailAddress(), "");
            session.setAttribute("currentUser", acc);
            
            if(roleList != null){
                session.setAttribute("allRoleForStaff", roleList);
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("StaffProfile.jsp");
            rd.forward(request, response);
            
        }catch(Exception ex){
            StackTraceElement[] elements = ex.getStackTrace();
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/>");
            }
            
        }finally{
            out.close();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("newemail");
        String name = request.getParameter("newname");
        String icNo = request.getParameter("newic");
        char gender = request.getParameter("gender").charAt(0);
        String date = request.getParameter("birthday");
        String address = request.getParameter("address");
        String telNo = request.getParameter("telNo");
        String role = request.getParameter("role");
        java.util.Date dateModified = new java.util.Date();
        
        HttpSession session = request.getSession();
        
        try{
            Account acc = new Account(email, name, icNo, gender, date, address, telNo, new Role(role), dateModified);
            session.setAttribute("tempUser", acc);
            AccountDA accountDA = new AccountDA();
            accountDA.updateAccount(acc);
            
            IC ic = new IC(icNo, gender, date);
            
            session.removeAttribute("errorForInfo");
            session.removeAttribute("tempUser");
            session.setAttribute("currentUser", acc);
        
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully Updated.');");
            out.println("location='StaffProfile.jsp';");
            out.println("</script>");
            
        }catch(IllegalArgumentException ex){
            request.setAttribute("noChangesMsg", ex.getMessage());
            
            RequestDispatcher rd = request.getRequestDispatcher("StaffProfile.jsp");
            rd.forward(request, response);
            
        }catch(InvalidICException ex){
            request.setAttribute("invalidIcMsg", ex.getMessage());
            
            RequestDispatcher rd = request.getRequestDispatcher("StaffProfile.jsp");
            rd.forward(request,response);
            
        }catch(SQLException ex){
            request.setAttribute("invalidIcMsg", "This ic number has been registered. Please try with another.");
            request.setAttribute("email", "");
            
            RequestDispatcher rd = request.getRequestDispatcher("StaffProfile.jsp");
            rd.forward(request,response);
            
        }catch (Exception ex) {
            StackTraceElement[] elements = ex.getStackTrace();
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/>");
            }
        }finally{
            out.close();
        }
    }
}
