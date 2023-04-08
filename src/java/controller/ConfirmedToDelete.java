package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Actor;
import model.CastList;
import model.CastListDA;
import model.Language;
import model.Movie;
import model.MovieDA;
import model.MovieRestriction;
import model.MovieSchedule;
import model.MovieScheduleDA;
import model.MovieStatus;
import model.MovieType;

@WebServlet(name = "ConfirmedToDelete", urlPatterns = {"/ConfirmedToDelete"})
public class ConfirmedToDelete extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    //write the code to retrieve data from the html form
    String movieScheduleID = request.getParameter("movieScheduleIDforDelete");
    String movieName = request.getParameter("movieNameforDelete");
    String movieShowtime = request.getParameter("movieShowtimeForDelete");
    
            try{
               //create movie schedule object
               MovieSchedule movieSchedule = new MovieSchedule(movieScheduleID);

                //update movie showtimes 
               MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
               movieScheduleDA.deleteMovieSchedule(movieSchedule);

               //pass msg to display it out in successful message
               String successfulMsg = "Movie Schedule: " + movieScheduleID + ", Showtimes: " +  movieShowtime + " has been removed from the database.";
               request.getSession().setAttribute("successMsg", successfulMsg);
               request.getSession().setAttribute("actionType", "movieSchedule");
               request.getRequestDispatcher("successfulMsg.jsp").forward(request, response);

                }catch(SQLException ex){
                   StackTraceElement[] elements = ex.getStackTrace();

                   //pass msg to display it out in error message
                    String errorMsg = "ERROR: " + ex.toString();
                    request.getSession().setAttribute("failedErorMsg", errorMsg);
                    request.getSession().setAttribute("actionType", "movieSchedule");
                    request.getRequestDispatcher("failedMessage.jsp").forward(request, response); 
                    
               }catch(NumberFormatException ex){
                   StackTraceElement[] elements = ex.getStackTrace();

                   //pass msg to display it out in error message
                    String errorMsg = "ERROR: " + ex.toString();
                    request.getSession().setAttribute("failedErorMsg", errorMsg);
                    request.getSession().setAttribute("actionType", "movieSchedule");
                    request.getRequestDispatcher("failedMessage.jsp").forward(request, response); 
                    
               }finally{
                       out.close();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
    }
}

