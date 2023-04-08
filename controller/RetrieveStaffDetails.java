package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "RetrieveStaffDetails", urlPatterns = {"/RetrieveStaffDetails"})
public class RetrieveStaffDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("selectedEmailAddress");
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            Account acc = accountDA.getRecord(email, "");
            
            if(acc != null){
                session.setAttribute("selectedStaff", acc);
                session.setAttribute("retreieveStf", "True");
                request.setAttribute("oriRole", acc.getRole().getRoleId());
            }
            
            List<Role> roleLists = (List<Role>) session.getAttribute("roleList");

            if(roleLists != null){
                request.setAttribute("rollForUpdateStaffPage", roleLists);
            }
            
        RequestDispatcher rd = request.getRequestDispatcher("/maintainStaff.jsp");
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
        
        String custId = "R0003";
        String search = request.getParameter("searchField");
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            List<Account> acc = accountDA.searchStaffRecord(search, custId);
            
            if(acc != null){
                session.setAttribute("searchRs", acc);
            }
            
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
}
