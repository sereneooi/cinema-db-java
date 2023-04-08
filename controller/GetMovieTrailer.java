package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GetMovieTrailer", urlPatterns = {"/GetMovieTrailer"})
public class GetMovieTrailer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get value from the form 
        String movieID = request.getParameter("movieID");
        String movieStatusID = request.getParameter("movieStatusID");
        
        request.getSession().setAttribute("valueOfMovieID",movieID);
        request.getSession().setAttribute("valueOfStatusID",movieStatusID);
        request.getRequestDispatcher("movieTrailer.jsp").forward(request, response);
    }
}
  