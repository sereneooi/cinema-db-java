package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "RoleDetails", urlPatterns = {"/RoleDetails"})
public class RoleDetails extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String rId = request.getParameter("selectedRole");
        
        HttpSession session = request.getSession();
        
        try{
            RoleDA roleDA = new RoleDA();
            Role role = roleDA.getRecord(rId, "");
            
            if(role != null){
                session.setAttribute("selectedrole", role);
                session.setAttribute("wantUpdate", "True");
            }
            
            response.sendRedirect(request.getContextPath() + "/RoleList");
            
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
        
        String roleId = request.getParameter("roleId");
        String roleDesc = request.getParameter("newUpdateRole");
        
        HttpSession session = request.getSession();
        
        try{
            RoleDA roleDA = new RoleDA();
            Role role = new Role(roleId, roleDesc);
            Role role2 = roleDA.getRecord("", roleDesc);
            
            if(role2 != null){
                session.setAttribute("gotUpdateRoleError", "True");
                request.setAttribute("latestRoleId", roleId);
                
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Duplicated Role Name.');");
                out.println("location='./RoleList';");
                out.println("</script>");
                
            }else{
                request.getSession().removeAttribute("gotUpdateRoleError");
                roleDA.updateRole(role);
                session.setAttribute("selectedrole", role);
                request.setAttribute("CreateRoleSuccess", "Successfully Updated.");
                request.setAttribute("showSuccess", "show");
                
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Successfully Updated.');");
                out.println("location='./RoleList';");
                out.println("</script>");
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
