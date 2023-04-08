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

@WebServlet(name = "ValidateOtp", urlPatterns = {"/ValidateOtp"})
public class ValidateOtp extends HttpServlet {

    private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = null;
        
        try{
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("currentUser");
            String inputOtp = request.getParameter("otp");
            int otp = (int)session.getAttribute("otp");
            
            request.setAttribute("forgotEmail", acc.getEmailAddress());
            request.setAttribute("OtpBtn", "style=\"cursor:not-allowed\" disabled");
            request.setAttribute("showForgotPass", "show");
            request.setAttribute("emailReadOnly", "readonly");
            request.setAttribute("closeDisable", "disabled");

            if (inputOtp.equals(String.valueOf(otp))) {
                request.setAttribute("typeOfForgotPassColor", "alert-success");
                request.setAttribute("ForgotPassErrorMsg", "Please enter your new password.");
                request.setAttribute("otpValue", inputOtp);
                
                dispatcher = request.getRequestDispatcher("/forgotPassword.jsp");
                dispatcher.forward(request, response);

            }else{
                request.setAttribute("typeOfForgotPassColor", "alert-danger");
                request.setAttribute("ForgotPassErrorMsg", "Incorrect OTP.");
                
                dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                dispatcher.forward(request, response);
            }
        }catch (NumberFormatException ex) {
            request.setAttribute("typeOfForgotPassColor", "alert-danger");
            request.setAttribute("ForgotPassErrorMsg", "Incorrect OTP.");

            dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
            dispatcher.forward(request, response);
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
