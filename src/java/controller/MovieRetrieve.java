package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "MovieRetrieve", urlPatterns = {"/MovieRetrieve"})
public class MovieRetrieve extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get value from the form 
        String movieID = request.getParameter("movieIDforRetrieve");
            
        //pass to jsp page through session
            request.getSession().setAttribute("valueOfMovieID",movieID);
            request.getRequestDispatcher("viewMovie.jsp").forward(request, response);
    }
}