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

@WebServlet(name = "RoleList", urlPatterns = {"/RoleList"})
public class RoleList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String custRoleId = "R0003";
        String from = request.getParameter("page");
        
        HttpSession session = request.getSession();
        
        try{
            RoleDA roleDA = new RoleDA();
            List<Role> roleList = roleDA.getAllRecordForStaff(custRoleId);
            List<Role> roleList2 = roleDA.getAllRecord();
            int total = roleDA.getLastId();
            String lastRoleId = "R" + String.format("%04d", total);
            
            if(roleList != null){
                session.setAttribute("allRoleForStaff", roleList);
                session.setAttribute("allRole", roleList2);
            }
            
//            if(from != null && from.equals("account")){
//                RequestDispatcher rd = request.getRequestDispatcher("/registerStaff.jsp");
//                rd.forward(request, response);
//            }else{
                request.setAttribute("latestRoleId", lastRoleId);
                
                RequestDispatcher rd = request.getRequestDispatcher("/maintainRole.jsp");
                rd.forward(request, response);
//            }
            
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
        
        String key = request.getParameter("searchField"); 
        HttpSession session = request.getSession();
        
        try{
            if(key != null){
                RoleDA roleDA = new RoleDA();
                List<Role> role = roleDA.searchRecord(key);

                if(role != null){
                    session.setAttribute("searchRsForRole", role);
                }

                response.sendRedirect("maintainRole.jsp");
            }else{
                String custRoleId = "R0003";
                String from = request.getParameter("page");

                RoleDA roleDA = new RoleDA();
                List<Role> roleList = roleDA.getAllRecordForStaff(custRoleId);
                List<Role> roleList2 = roleDA.getAllRecord();
                int total = roleDA.getLastId();
                String lastRoleId = "R" + String.format("%04d", total);

                if(roleList != null){
                    session.setAttribute("allRoleForStaff", roleList);
                    session.setAttribute("allRole", roleList2);
                }

                if(from != null){
                    request.setAttribute("latestRoleId", lastRoleId);

                    RequestDispatcher rd = request.getRequestDispatcher("/maintainRole.jsp");
                    rd.forward(request, response);
                }
            }
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
