package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

@WebServlet(name = "GetAdminSearchRecord", urlPatterns = {"/GetAdminSearchRecord"})
public class GetAdminSearchRecord extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            
            //get value from the form 
            String searchAction = request.getParameter("action");
            String actorID = request.getParameter("searchActor");            
            String movieID = request.getParameter("searchMovie");
            String nowShwID = request.getParameter("searchMovieSchedule");

            if(searchAction.equals("actor")){
                ActorDA actorDA = new ActorDA();
                Actor actorSearched = actorDA.selectSpecificActorID(actorID);

                request.getSession().setAttribute("specificActor",actorSearched);
                request.getRequestDispatcher("AdminActorSearch.jsp").forward(request, response);
                
            }else if(searchAction.equals("movie")){
                
                MovieDA movieDA = new MovieDA();
                Movie movieSearched = movieDA.getMovieRecord(movieID);
                
                request.getSession().setAttribute("specificMovie", movieSearched);
                request.getRequestDispatcher("AdminMovieSearch.jsp").forward(request, response);
                
            }else if(searchAction.equals("movieSchedule")){
                MovieDA movieDA = new MovieDA();
                Movie nsMovieSearched = movieDA.getMovieRecord(nowShwID);
                
                request.getSession().setAttribute("specificNsMovie", nsMovieSearched);
                request.getRequestDispatcher("AdminMovieScheduleSrch.jsp").forward(request, response);
            }

        } catch(Exception ex) {
            ex.printStackTrace();
        }
    }
}


   