package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("newemail");
        String name = request.getParameter("newname");
        String password = request.getParameter("npsw");
        String icNo = request.getParameter("newic");
        char gender = request.getParameter("gender").charAt(0);
        String date = request.getParameter("birthday");
        String address = request.getParameter("address");
        String telNo = request.getParameter("telNo");
        String role = request.getParameter("role");
        java.util.Date dateCreated = new java.util.Date();
        
        HttpSession session = request.getSession();
        
        String page = "";
        
        if(role.equals("R0003")){
            page = "newuser.jsp";
        }else{            
            page = "RetrieveRole";
        }
        
        try{
            IC ic = new IC(icNo, gender, date);
            Account acc = new Account(email, name, password, icNo, gender, date, address, telNo, new Role(role), dateCreated, null);
            AccountDA accountDA = new AccountDA();
            accountDA.addAccount(acc);

            session.setAttribute("newRegisteredAcc", acc);

            request.setAttribute("msg", "This account has been created. You can login now.");
            request.setAttribute("showSuccess", "show");
            
            if(role.equals("R0003")){
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request,response);
            }else{            
                RequestDispatcher rd = request.getRequestDispatcher("RetrieveRole");
                rd.forward(request,response);
            }
            
                
        }catch(InvalidICException ex){
            request.setAttribute("msg", ex.getMessage());
            request.setAttribute("show", "show");
            request.setAttribute("email", email);
            request.setAttribute("npsw", password);
            request.setAttribute("address", address);
            request.setAttribute("phoneNo", telNo);
            request.setAttribute("name", name);
            request.setAttribute("birthDate", date);
            session.setAttribute("selectedRole", role);
            
            if(gender == 'F'){
                request.setAttribute("female", "CHECKED");
            }else{
                request.setAttribute("male", "CHECKED");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request,response);
            
        }catch(SQLException ex){
            request.setAttribute("msg", email + ", " + icNo + ", this email or ic number has been registered. Please try with another email address or ic no.");
            request.setAttribute("show", "show");
            request.setAttribute("address", address);
            request.setAttribute("npsw", password);
            request.setAttribute("phoneNo", telNo);
            request.setAttribute("name", name);
            request.setAttribute("birthDate", date);
            session.setAttribute("selectedRole", role);
            
            if(gender == 'F'){
                request.setAttribute("female", "CHECKED");
            }else{
                request.setAttribute("male", "CHECKED");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request,response);
            
        }catch (Exception ex) {
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
