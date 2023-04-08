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
import model.MovieStatus;
import model.MovieType;

@WebServlet(name = "GetUpdatedMovie", urlPatterns = {"/GetUpdatedMovie"})
public class GetUpdatedMovie extends HttpServlet {

 
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    //write the code to retrieve data from the html form
    String movieID = request.getParameter("newMovieID");
    String movieName = request.getParameter("newMovieName");
    String movieTrailer = request.getParameter("url");
    String moviePoster = request.getParameter("posterImg");
    String movieAdsPoster = request.getParameter("adsImg");
    String moviePosterURL = request.getParameter("posterImgURL");
    String movieAdsPosterURL = request.getParameter("adsImgURL");
    String movieSynopsis = request.getParameter("synopsis");
    int durationHour = Integer.parseInt(request.getParameter("hour"));
    int durationMinutes = Integer.parseInt(request.getParameter("minutes"));
    String availableDate = request.getParameter("dateAvailable");
    String movieStatusID = request.getParameter("newMovieStatus");
    String movieRestrictionID = request.getParameter("newMovieRestriction");
    String movieTypeID = request.getParameter("newMovieType");
    String languageID = request.getParameter("newMovielanguage");      
    String[] actorIDList = request.getParameterValues("newMovieActorList");
    
    String[] oldActorList = request.getParameterValues("oldActorID");
    String[] newActorList = new String[oldActorList.length];
    
    
    for(int i = 0; i < oldActorList.length; i++) {
        newActorList[i] = request.getParameter("newActorID" + i);
    }
             
            try{
               //create movie object
               Movie movie = new Movie(movieID, movieName, movieTrailer, moviePosterURL, movieAdsPosterURL, movieSynopsis, durationHour, durationMinutes, availableDate, new MovieStatus(movieStatusID), new MovieType(movieTypeID), new MovieRestriction(movieRestrictionID), new Language(languageID));

                //update movie record into database
                  MovieDA movieDA = new MovieDA();
                 movieDA.updateMovieRecord(movie);
                 
                CastListDA castListDA = new CastListDA();
                ArrayList<CastList> castListList = castListDA.getCastListRecord(movieID);
                for(int i = 0; i < castListList.size(); i++) {
                    Actor newActor = new Actor(newActorList[i]);
                    castListDA.updateCastListRecord(castListList.get(i).getCastListID(), newActor);
               }
               
       
              //pass msg to display it out in successful message
               String successfulMsg = "Movie ID: " + movieID + " has been updated to the database.";
               request.getSession().setAttribute("successMsg", successfulMsg);
               request.getSession().setAttribute("actionType", "movie");
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
        
        //retrieve value frm form
        String movieID = request.getParameter("movieIDforUpdate");
        String movieName = request.getParameter("movieNameforUpdate");
        String movieTrailer = request.getParameter("movieTrailerforUpdate");
        String moviePoster = request.getParameter("posterURLforUpdate");
        String movieAdsPoster = request.getParameter("adsURLforUpdate");
        String movieSynopsis = request.getParameter("synopsisForUpdate");
        
        //pass value to jsp 
        request.getSession().setAttribute("valueOfMovieID",movieID);
        request.getSession().setAttribute("valueOfMovieName",movieName);
        request.getSession().setAttribute("urlOfMovieTrailer",movieTrailer);
        request.getSession().setAttribute("urlOfMoviePoster",moviePoster);
        request.getSession().setAttribute("urlOfMovieAdsPoster",movieAdsPoster);
        request.getSession().setAttribute("valueOfSynopsis",movieSynopsis);
        request.getRequestDispatcher("updateMovie.jsp").forward(request, response);
      
    }
}
