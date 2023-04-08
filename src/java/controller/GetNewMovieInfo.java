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


@WebServlet(name = "GetNewMovieInfo", urlPatterns = {"/GetNewMovieInfo"})
public class GetNewMovieInfo extends HttpServlet {


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
    
            try{
               //create movie object
               Movie movie = new Movie(movieID, movieName, movieTrailer, moviePosterURL, movieAdsPosterURL, movieSynopsis, durationHour, durationMinutes, availableDate, new MovieStatus(movieStatusID), new MovieType(movieTypeID), new MovieRestriction(movieRestrictionID), new Language(languageID));

                //add new movie record into database
               MovieDA movieDA = new MovieDA();
               movieDA.addMovieRecord(movie);

               //add castList for new added movie
               for(int i=0; i< actorIDList.length; i++){
                   Actor actor = new Actor(actorIDList[i]);
                   CastListDA castListDA = new CastListDA();
                   ArrayList<CastList> actorListing = new ArrayList<CastList>();
                   castListDA.addCastListRecord(nextCastListID(), actor, movieID);
               }             
               
               //pass msg to display it out in successful message
               String successfulMsg = "Movie ID: " + movieID + " has been added to the database.";
               request.getSession().setAttribute("successMsg", successfulMsg);
               request.getSession().setAttribute("actionType", "movie");
               request.getRequestDispatcher("successfulMsg.jsp").forward(request, response);

                }catch(SQLException ex){
                   StackTraceElement[] elements = ex.getStackTrace();
                   
                   //pass msg to display it out in error message
                    String errorMsg = "ERROR: " + ex.toString();
                    request.getSession().setAttribute("failedErorMsg", errorMsg);
                    request.getSession().setAttribute("actionType", "movie");
                    request.getRequestDispatcher("failedMessage.jsp").forward(request, response);
                          
               }finally{
                       out.close();
              }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
    }
    
    //auto increment next castListID;
    public String nextCastListID() throws SQLException{

        //retrive the castListID of the last record
        CastListDA castListDA = new CastListDA();
        String castListID = castListDA.selectLastCastListID ();

        //extract out the string and integer into diff variable
        String codeID = castListID.substring(0, 2);
        String numID = castListID.substring(2);
        
        int numIDInteger = Integer.parseInt(numID);
        int increasedIntID = numIDInteger + 1;
        String increasedStrID = String.valueOf(increasedIntID);
        
        String nextCastListID = codeID + increasedStrID;
        return nextCastListID;
    }
}
