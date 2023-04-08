package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String password = request.getParameter("psd");
        String rememberMe = request.getParameter("remember");
        String custRoleId = "R0003";
        
        try{
            AccountDA accountDA = new AccountDA();
            Account acc = accountDA.checkLogin(email, password);
            
            if(acc != null){
                acc.setPassword(password);
                
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", acc);
                
                if(rememberMe != null){ // means tick the remember me options
                    Cookie ck1 = new Cookie("LoginEmail", acc.getEmailAddress());
                    response.addCookie(ck1);
                    ck1.setMaxAge(31 * 24 * 60 * 60); // 7 days in seconds
                    
                    Cookie ck2 = new Cookie("LoginPassword", acc.getPassword());
                    response.addCookie(ck2); 
                    ck2.setMaxAge(31 * 24 * 60 * 60);
                }
                
                if(acc.getRole().getRoleId().equals(custRoleId)){
                    response.sendRedirect(request.getContextPath() + "/cinema.jsp");
                }else{
                    response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                }
                
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email or Password incorrect.');");
                out.println("location='login.jsp';");
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
