package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "DeleteRole", urlPatterns = {"/DeleteRole"})
public class DeleteRole extends HttpServlet {
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try{
            String roleId = request.getParameter("selectedRole");
            
            HttpSession session = request.getSession();
            request.setAttribute("deleteRole", roleId);
            
            session.setAttribute("wantDeleteRole", "True");
            
            RequestDispatcher rd = request.getRequestDispatcher("/RoleList");
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
        
        try{
            String roleId = request.getParameter("deleteRole");
            
            HttpSession session = request.getSession();
            
            Role role = new Role(roleId);
           
            
            if(role != null){
                RoleDA roleDA = new RoleDA();
                roleDA.deleteRole(role);
                
                session.removeAttribute("wantDeleteRole");
                request.setAttribute("CreateRoleSuccess", "Successfully Deleted.");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You have successfully deleted this role.');");
                out.println("location='./RoleList';");
                out.println("</script>");
            
            }
        }catch(SQLException ex){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You are not allowed to delete this role.');");
            out.println("location='./RoleList';");
            out.println("</script>");
            
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
