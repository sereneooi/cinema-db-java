package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "RetrieveCustomerRecord", urlPatterns = {"/RetrieveCustomerRecord"})
public class RetrieveCustomerRecord extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("selectedEmailAddress");
        String custRoleId = "R0003";
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            Account acc = accountDA.getRecord(email, "");
            
            if(acc != null){
                session.setAttribute("selectedCust", acc);
                session.setAttribute("viewCustModal", "True");
            }
                
            response.sendRedirect(request.getContextPath() + "/customerRecord.jsp");
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
            List<Account> acc = accountDA.searchCustRecord(search, custId);
            
            if(acc != null){
                session.setAttribute("searchCust", acc);
            }
            
            response.sendRedirect(request.getContextPath() + "/customerRecord.jsp");
            
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
