package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.SendFailedException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "ForgotPassword", urlPatterns = {"/ForgotPassword"})
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("emailAdd");
        String sender = "officialcccinema@gmail.com";
        String senderPassword = "cccinema1234";
        
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        HttpSession mySession = request.getSession();

        // sending otp
        Random rand = new Random();
        otpvalue = rand.nextInt(1255650);

        try {
            AccountDA accountDA = new AccountDA();
            Account acc = accountDA.getRecord(email, "");
            
            if(acc != null){
                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//                props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//                props.put("mail.smtp.ssl.protocols", "TLSv1.2");
                Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(sender, senderPassword);                                                                                                                                                                // password here
                    }
                });

                // compose message
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(sender));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("CC Cinema: Reset Your Password");
                message.setText("A request has been received to change the password for your CC Cinema account. \nYour OTP is: " + otpvalue + "\n\nThank you.");
                // send message
                Transport.send(message);

                request.setAttribute("typeOfForgotPassColor", "alert-success");
                request.setAttribute("ForgotPassErrorMsg", "Please check on your email (" + email + ") to get the OTP.");
                request.setAttribute("showForgotPass", "show");
                request.setAttribute("forgotEmail", email);
                request.setAttribute("OtpBtn", "style=\"cursor:not-allowed\" disabled");
                request.setAttribute("emailReadOnly", "readonly");
                request.setAttribute("closeDisable", "disabled");
                mySession.setAttribute("otp", otpvalue); 
                mySession.setAttribute("currentUser", acc);
                
                dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                dispatcher.forward(request, response);

            }else{
                request.setAttribute("typeOfForgotPassColor", "alert-danger");
                request.setAttribute("ForgotPassErrorMsg", "This email has not been registered yet.");
                request.setAttribute("showForgotPass", "show");

                RequestDispatcher rd = request.getRequestDispatcher("/forgotPassword.jsp");
                rd.forward(request,response);
            }
                
        }catch (SendFailedException ex){
            request.setAttribute("typeOfForgotPassColor", "alert-danger");
            request.setAttribute("ForgotPassErrorMsg", "Sorry. Sender side email goes wrong. ");
            request.setAttribute("showForgotPass", "show");
            
            RequestDispatcher rd = request.getRequestDispatcher("/forgotPassword.jsp");
            rd.forward(request,response);
            
        }catch (Exception ex){
            //request.setAttribute("typeOfForgotPassColor", "alert-danger");
            //request.setAttribute("ForgotPassErrorMsg", "Sorry. Sender side email goes wrong. ");
            //request.setAttribute("showForgotPass", "show");
            
            //RequestDispatcher rd = request.getRequestDispatcher("/forgotPassword.jsp");
            //rd.forward(request,response);
            
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br/><br/>");
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Clas Name: " + e.getClassName() + "<br/>");
                out.println("Method Name: " + e.getMethodName() + "<br/>");
                out.println("Line Name: " + e.getLineNumber() + "<br/>");
            }
            
        }finally{
            out.close();
        }
    }
}
