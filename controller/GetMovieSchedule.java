package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Movie;
import model.MovieScheduleDA;

@WebServlet(name = "GetMovieSchedule", urlPatterns = {"/GetMovieSchedule"})
public class GetMovieSchedule extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //get value from the form 
        String searchedDate = request.getParameter("dateToSearch");
        String retrievedDate = request.getParameter("dateToRetrieve");
        String action = request.getParameter("dateAction");
        
        Movie movie = new Movie();
        
        if(action.equals("dateFrmSearch")){
            try{
                String dateOfShowtimes = searchedDate;
                Date dateOldFormat=new SimpleDateFormat("yyyy-MM-dd").parse(dateOfShowtimes); 
                //set the format of date to dd MMMM yyyy
                SimpleDateFormat DateFor = new SimpleDateFormat("dd MMMM yyyy");
                String formattedShowDate = DateFor.format(dateOldFormat);
                
               //create movie object
               ArrayList<Movie> movieShowList = new ArrayList<Movie>();

               MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
               movieShowList = movieScheduleDA.getShowtimeRecord(searchedDate);
               
               //pass to jsp
               request.getSession().setAttribute("matchedShowtimeList",movieShowList);
               request.getSession().setAttribute("dateNtFormatted", dateOfShowtimes);
               request.getSession().setAttribute("showtimeDate", formattedShowDate);
               request.getRequestDispatcher("movieSchedule.jsp").forward(request, response);
               
            }catch(SQLException ex){
                   StackTraceElement[] elements = ex.getStackTrace();

                   out.println("ERROR: " + ex.toString() + "<br /><br />") ;

                   for(StackTraceElement e: elements){
                       out.println("File Name: " + e.getFileName() + "<br />");
                       out.println("Class Name: " + e.getClassName() + "<br />");
                       out.println("Method Name: " + e.getMethodName() + "<br />");
                       out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
                   }            
            } catch (ParseException ex) {
                Logger.getLogger(GetMovieSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                       out.close();
             }
               
        }else if(action.equals("dateFrmSelect")){
                try{
                String dateOfShowtimes = retrievedDate;
                Date dateOldFormat=new SimpleDateFormat("yyyy-MM-dd").parse(dateOfShowtimes); 
                //set the format of date to dd MMMM yyyy
                SimpleDateFormat DateFor = new SimpleDateFormat("dd MMMM yyyy");
                String formattedShowDate = DateFor.format(dateOldFormat);
                    
               //create movie object
               ArrayList<Movie> movieShowList = new ArrayList<Movie>();

               MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
               movieShowList = movieScheduleDA.getShowtimeRecord(retrievedDate);
               
               //pass to jsp
               request.getSession().setAttribute("matchedShowtimeList", movieShowList);
               request.getSession().setAttribute("dateNtFormatted", dateOfShowtimes);
               request.getSession().setAttribute("showtimeDate", formattedShowDate);
               request.getRequestDispatcher("movieSchedule.jsp").forward(request, response);
               
            }catch(SQLException ex){
                   StackTraceElement[] elements = ex.getStackTrace();

                   out.println("ERROR: " + ex.toString() + "<br /><br />") ;

                   for(StackTraceElement e: elements){
                       out.println("File Name: " + e.getFileName() + "<br />");
                       out.println("Class Name: " + e.getClassName() + "<br />");
                       out.println("Method Name: " + e.getMethodName() + "<br />");
                       out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
                   }            
               } catch (ParseException ex) {
                Logger.getLogger(GetMovieSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                       out.close();
             }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
