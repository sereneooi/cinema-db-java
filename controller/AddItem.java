package controller;

import model.Account;
import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddItem", urlPatterns = {"/AddItem"})
public class AddItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Theatre
        String theatreId = request.getParameter("theatreId");
        String desc = request.getParameter("theatreDesc");
        String totalSeatCount = request.getParameter("totalSeatCount");
        String theatreClassesId=  request.getParameter("theatreClassesId");
        
        try{
            HttpSession session = request.getSession();            
            Account currentUser = (Account) session.getAttribute("currentUser");
              
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if(currentUser != null){ // if the user does not log out the existing account
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Please log in your account first.');");
                out.println("location='AdminLayout.jsp'");
                out.println("</script>");
            }
            
            ErrorManagement ErrorMgmt = new ErrorManagement();
            String validationMsg = "";  boolean validation = true;

            Theatre theatre = new Theatre();
            validation = ErrorMgmt.primaryKeyValidation(theatre, theatreId);

            if(!validation){
                   validationMsg = "Error Encounted: This input cannot have duplicate data." + theatreId + " have existed in database.";
               }else{
                   validationMsg = "Item " + theatreId + " Added!";
                   theatre = new Theatre(theatreId, desc, Integer.parseInt(totalSeatCount), new TheatreClasses(theatreClassesId));
                   TheatreDA theatreDA = new TheatreDA();
                   theatreDA.addTheatre(theatre);
               }

            session.setAttribute("Object", theatre);
            session.setAttribute("ValidationMessage", validationMsg);                
            session.setAttribute("verificationSucceed", validation);
            response.sendRedirect("AddValidation.jsp");
            
        }catch(SQLException ex){
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
