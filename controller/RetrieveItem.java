package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RetrieveItem", urlPatterns = {"/RetrieveItem"})
public class RetrieveItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
            HttpSession session = request.getSession();
            List<Theatre> theatreList = (List<Theatre>) session.getAttribute("theatreList");
            Theatre theatre = null;
            
            String theatreIdResult=request.getParameter("id");
            if(theatreIdResult != null || !theatreIdResult.isEmpty()){
                TheatreDA theatreDA = new TheatreDA();
                theatre = theatreDA.retrieveRecord(theatreIdResult);

                session.setAttribute("theatreResult", theatre); 
                response.sendRedirect("UpdateForm.jsp");
                
            }

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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
            HttpSession session = request.getSession();
            List<Theatre> theatreList = (List<Theatre>) session.getAttribute("theatreList");
            Theatre theatre = null;
            
            String theatreIdResult=request.getParameter("theatreId");
             
            TheatreDA theatreDA = new TheatreDA();
            theatre = theatreDA.retrieveRecord(theatreIdResult);
            
            session.setAttribute("theatreResult", theatre); 
            session.setAttribute("noOfSeat", theatre.getTotalSeatCount()); 
            response.sendRedirect("Seat.jsp");

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
