package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "StaffList", urlPatterns = {"/StaffList"})
public class StaffList extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String custRoleId = "R0003";
        
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            List<Account> staffList = accountDA.getAllStaffRecord(custRoleId);
            
            RoleDA roleDA = new RoleDA();
            List<Role> roleList = roleDA.getAllRecordForStaff(custRoleId);
            
            if(staffList != null){
                session.setAttribute("staffList", staffList);
            }
            
            if(roleList != null){
                session.setAttribute("roleList", roleList);
            }
//            RequestDispatcher rd = request.getRequestDispatcher("/maintainStaff.jsp");
//            rd.forward(request, response);
            response.sendRedirect(request.getContextPath() + "/maintainStaff.jsp");
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
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String custRoleId = "R0003";
        
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            List<Account> staffList = accountDA.getAllStaffRecord(custRoleId);
            
            RoleDA roleDA = new RoleDA();
            List<Role> roleList = roleDA.getAllRecordForStaff(custRoleId);
            
            if(staffList != null){
                session.setAttribute("staffList", staffList);
            }
            
            if(roleList != null){
                session.setAttribute("roleList", roleList);
            }
            RequestDispatcher rd = request.getRequestDispatcher("/maintainStaff.jsp");
            rd.forward(request, response);
//            response.sendRedirect(request.getContextPath() + "/maintainStaff.jsp");
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
}
