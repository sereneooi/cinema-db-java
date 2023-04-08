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

@WebServlet(name = "SortCustomerRecord", urlPatterns = {"/SortCustomerRecord"})
public class SortCustomerRecord extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String selectedCol = request.getParameter("selectedCol");
        String order = request.getParameter("order");
        String custRoleId = "R0003";
        HttpSession session = request.getSession();
        
        try{
            AccountDA accountDA = new AccountDA();
            
            if(!selectedCol.equals("") && selectedCol != null){
                if(!order.equals("DESC")){
                    order = "ASC";
                    request.setAttribute("viewCustSortOrder" + selectedCol, "DESC");
                    request.setAttribute("iconForSort" + selectedCol, "desc");
                }else{
                    request.setAttribute("viewCustSortOrder" + selectedCol, "ASC");
                    request.setAttribute("iconForSort" + selectedCol, "asc");
                }
                
                List<Account> acc = accountDA.sort(selectedCol, order);
                if(acc != null){
                    session.setAttribute("searchCust", acc);
                }
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/customerRecord.jsp");
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
}
