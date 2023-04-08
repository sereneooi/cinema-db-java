package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "SortItem", urlPatterns = {"/SortItem"})
public class SortItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Theatre
        String theatreSorting = request.getParameter("sortTheatre");
        
        try{
            HttpSession session = request.getSession();
            
            //Theatre       
            TheatreDA theatreDA = new TheatreDA();
             List<Theatre> theatre = null;

            if(theatreSorting.equals("theatreClassesDesc")){
                theatre = theatreDA.sortingForeignKeyRecord(theatreSorting);
            }else{
                theatre = theatreDA.sortingRecord(theatreSorting);
            }

            session.setAttribute("theatreList", theatre);
            session.setAttribute("totalNoOfRecord", theatre.size());

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
