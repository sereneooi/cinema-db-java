package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "UpdatePassword", urlPatterns = {"/UpdatePassword"})
public class UpdatePassword extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String password = request.getParameter("npsw");
        java.util.Date dateModified = new java.util.Date();
        
        HttpSession session = request.getSession();
        
        try{
            Account acc = (Account) session.getAttribute("currentUser");
            
            acc.setPassword(password);
            acc.setDateModified(dateModified);
            
            AccountDA accountDA = new AccountDA();
            accountDA.updatePassword(acc);
            
            Cookie[] cookie = request.getCookies();
            if (cookie != null) {
                for (Cookie c : cookie) {
                    if (c.getName().equals("LoginPassword")) {
                        c.setValue(password);
                        response.addCookie(c);
                    }
                }
            }
            
            session.removeAttribute("currentUser");
            
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully changed your password.');");
            out.println("location='login.jsp';");
            out.println("</script>");
            
        }catch(IllegalArgumentException ex){
            Account acc = (Account) session.getAttribute("currentUser");
            int otp = (int)session.getAttribute("otp");
            request.setAttribute("forgotEmail", acc.getEmailAddress());
            request.setAttribute("otp", otp);
            request.setAttribute("OtpBtn", "style=\"cursor:not-allowed\" disabled");
            request.setAttribute("emailReadOnly", "readonly");
            request.setAttribute("closeDisable", "disable");
            request.setAttribute("typeOfForgotPassColor", "alert-danger");
            request.setAttribute("showForgotPass", "show");
            request.setAttribute("noChangePassMsg", ex.getMessage());
            
            RequestDispatcher rd = request.getRequestDispatcher("/forgotPassword.jsp");
            rd.forward(request, response);
            
        }catch(NullPointerException ex){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Session Expired. Login again. ');");
            out.println("location='login.jsp';");
            out.println("</script>");
            
        }catch(Exception ex){
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/><br/>");
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
        
        String password = request.getParameter("npsw");
        java.util.Date dateModified = new java.util.Date();
        
        HttpSession session = request.getSession();
        session.setAttribute("errorForChangePass", "True");
        Account acc = (Account) session.getAttribute("currentUser");
        String custId = "R0003", page = "";

        if(acc.getRole().getRoleId().equals(custId)){
            page = "account.jsp";
        }else{
            page = "StaffProfile.jsp";
        }
        
        try{
            acc.setPassword(password);
            acc.setDateModified(dateModified);
            
            AccountDA accountDA = new AccountDA();
            accountDA.updatePassword(acc);
            
            Cookie[] cookie = request.getCookies();
            if (cookie != null) {
                for (Cookie c : cookie) {
                    if (c.getName().equals("LoginPassword")) {
                        c.setValue(password);
                        response.addCookie(c);
                    }
                }
            }
            
            session.setAttribute("currentUser", acc);
            session.removeAttribute("errorForChangePass");
            
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully changed your password.');");
            out.println("location='" + page + "';");
            out.println("</script>");
            
        }catch(IllegalArgumentException ex){
            request.setAttribute("noChangePassMsg", ex.getMessage());
            
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request, response);
            
        }catch(NullPointerException ex){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Session Expired. Login again. ');");
            out.println("location='login.jsp';");
            out.println("</script>");
            
        }catch(Exception ex){
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/><br/>");
            }
        }finally{
            out.close();
        }
    }
}
