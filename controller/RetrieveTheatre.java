package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RetrieveTheatre", urlPatterns = {"/RetrieveTheatre"})
public class RetrieveTheatre extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
         try{
            HttpSession session = request.getSession();
            TheatreDA theatreDA = new TheatreDA();
            List<Theatre> theatre = theatreDA.retrieveAllRecord();
            int noOfRecord = theatreDA.RecordCount();
            
            request.setAttribute("bean", new Theatre());
            request.setAttribute("theatreList", theatre);
            request.setAttribute("totalNoOfRecord", noOfRecord);
            // Preprocess request: we actually don't need to do any business stuff, so just display JSP.
            request.getRequestDispatcher("./TheatreAdminLayout.jsp").forward(request, response);

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
            TheatreDA theatreDA = new TheatreDA();
            List<Theatre> theatre = theatreDA.retrieveAllRecord();
            int noOfRecord = theatreDA.RecordCount();
            
            session.setAttribute("theatreList", theatre);
            session.setAttribute("totalNoOfRecord", noOfRecord);        
            
            response.sendRedirect("TheatreAdminLayout.jsp");

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
