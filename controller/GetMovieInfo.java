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

@WebServlet(name = "GetMovieInfo", urlPatterns = {"/GetMovieInfo"})
public class GetMovieInfo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            //get value from the form 
            String movieID = request.getParameter("movieID");
            String movieStatusID = "";
            MovieDA movieDA = new MovieDA();
            Movie movie = movieDA.getMovieRecord(movieID);
            if(request.getParameter("movieStatus") == null) {
                movieStatusID = movie.getMovieStatus().getMovieStatusID();
            } else {
                movieStatusID = request.getParameter("movieStatus");
            }
            String nowShowingMovie = "MS001";
            String comingSoonMovie = "MS002";

            if(movieStatusID.equals(nowShowingMovie)){

                request.getSession().setAttribute("valueOfMovieID",movieID);
                request.getRequestDispatcher("movieInfo.jsp").forward(request, response);

             }else if (movieStatusID.equals(comingSoonMovie)){

                request.getSession().setAttribute("valueOfMovieID",movieID);
                request.getRequestDispatcher("movieDetails.jsp").forward(request, response);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        }
    }
}