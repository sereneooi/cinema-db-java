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
import model.ActorDA;
import model.CastList;
import model.CastListDA;
import model.Language;
import model.Movie;
import model.MovieDA;

@WebServlet(name = "GetNewActor", urlPatterns = {"/GetNewActor"})
public class GetNewActor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
         response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        //write the code to retrieve data from the html form
        String actorID = request.getParameter("newActorID");
        String actorName = request.getParameter("newActorName");
        
        
        try{
               //create movie schedule object
               Actor actor = new Actor(actorID, actorName);

                //add new actor record into database
               ActorDA actorDA = new ActorDA();
               actorDA.addActor(actor);
    
               //pass msg to display it out in successful message
               String successfulMsg = "Actor ID " + actorID + " has been added to the database.";
               request.getSession().setAttribute("successMsg", successfulMsg);
               request.getSession().setAttribute("actionType", "actor");
               request.getRequestDispatcher("successfulMsg.jsp").forward(request, response);
               

                }catch(SQLException ex){
                   StackTraceElement[] elements = ex.getStackTrace();

                    //pass msg to display it out in error message
                    String errorMsg = "ERROR: " + ex.toString();
                    request.getSession().setAttribute("failedErorMsg", errorMsg);
                    request.getSession().setAttribute("actionType", "actor");
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
