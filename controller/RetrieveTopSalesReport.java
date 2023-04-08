package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "RetrieveTopSalesReport", urlPatterns = {"/RetrieveTopSalesReport"})
public class RetrieveTopSalesReport extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try{
            HttpSession session = request.getSession();
            TicketDA ticketDA = new TicketDA();
            
            List <Double> grossing = (ArrayList<Double>)ticketDA.topHighestFilms();
            
            List <String> ticket = ticketDA.topHighestFilmsDetails();
            List <Integer> soldQty = ticketDA.topHighestFilmsSold();
            List <Double> gross = ticketDA.topHighestFilms();
            
            session.setAttribute("gross", gross);
            session.setAttribute("soldQty", soldQty);
            session.setAttribute("ticketFilm", ticket);
            response.sendRedirect("topSalesReport.jsp");
            
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
