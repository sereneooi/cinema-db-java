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

@WebServlet(name = "DeleteAccount", urlPatterns = {"/DeleteAccount"})
public class DeleteAccount extends HttpServlet {

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
                session.setAttribute("deleteEmail", acc);
                session.setAttribute("wantDeleteAcc", "True");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/maintainStaff.jsp");
            rd.forward(request, response);
            
//            response.sendRedirect(request.getContextPath() + "/maintainStaff.jsp");
        }catch(SQLException ex){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('You are not allowed to delete this account.');");
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("currentUser");
            
        try{
            if(acc != null){
                if(acc.getRole().getRoleId().equals("R0003")){
                
                    AccountDA accountDA = new AccountDA();
                    accountDA.deleteAccount(acc);

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('You have successfully deleted this account.');");
                    out.println("location='logout.jsp';");
                    out.println("</script>");
                }else{
                    String email = request.getParameter("deleteEmail");
                    AccountDA accountDA = new AccountDA();
                    Account selectedAcc = accountDA.getRecord(email, "");
                    if(selectedAcc != null){
                        accountDA.deleteAccount(selectedAcc);
                        
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('You have successfully deleted this account.');");
                        
                        if(selectedAcc.getEmailAddress().equals(acc.getEmailAddress())){
                            out.println("location='logout.jsp';");
                        }else{
                            out.println("location='./StaffList';");
                        }
                        
                        out.println("</script>");
                    }
                }
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Session Expired. Login again. ');");
                out.println("location='login.jsp';");
                out.println("</script>");
            }
        }catch(SQLException ex){
            if(acc.getRole().getRoleId().equals("R0003")){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You are not allowed to delete your account.');");
                out.println("location='account.jsp';");
                out.println("</script>");
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You are not allowed to delete this account.');");
                out.println("location='./RoleList';");
                out.println("</script>");
            }
            
        }catch(NullPointerException ex){
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/>");
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
