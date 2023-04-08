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

@WebServlet(name = "AddRole", urlPatterns = {"/AddRole"})
public class AddRole extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String roleName = request.getParameter("newRole");
        String roleId = request.getParameter("newRoleId");
        
        try{
            HttpSession session = request.getSession();
            RoleDA roleDA = new RoleDA();
            Role role = roleDA.getRecord("", roleName);
            
            if(role != null){
                request.setAttribute("CreateRoleError", "This role has been added before. Please enter a new role.");
                session.setAttribute("gotCreateRoleError", "True");
                request.setAttribute("latestRoleId", roleId);
                
            }else{
                Role newRole = new Role("", roleName);
                roleDA.addRole(newRole);
                session.setAttribute("roleAddedSuccess", "True");
                session.removeAttribute("gotCreateRoleError");
            }
            session.setAttribute("fromRole", "True");
            
//            RequestDispatcher rd = request.getRequestDispatcher("maintainRole.jsp");
//            rd.forward(request, response);
            
//            RequestDispatcher rd = request.getRequestDispatcher("/RoleList");
//            rd.forward(request, response);

             response.sendRedirect("./RoleList");
            
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
