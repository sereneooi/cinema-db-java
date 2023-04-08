package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Dictionary;
import java.util.Hashtable;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "UpdateItem", urlPatterns = {"/UpdateItem"})
public class UpdateItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Theatre Type
        String ClassesId = request.getParameter("ClassesId");
        String Classesdesc = request.getParameter("Classesdesc");
        
        //Theatre
        String theatreId = request.getParameter("theatreId");
        String desc = request.getParameter("theatreDesc");
        String totalSeatCount = request.getParameter("totalSeatCount");
        String theatreClassesId=  request.getParameter("theatreClassesId");
        
        boolean validation = true; String validationMsg = ""; 
        
        try{
                        
            HttpSession session = request.getSession();
            Account currentUser = (Account)session.getAttribute("currentUser");
            
            if(currentUser.getRole().getRoleId().equals("R0001")){
                //Theatre
                Theatre theatre = null;

                if((theatreId != null && !theatreId.isEmpty()) || 
                        (desc != null && !desc.isEmpty()) ||
                        (totalSeatCount != null && !totalSeatCount.isEmpty()) || 
                        (theatreClassesId != null && !theatreClassesId.isEmpty())){

                    validationMsg = "Item " + theatreId + " Updated!";
                    theatre = new Theatre(theatreId, desc, Integer.parseInt(totalSeatCount), new TheatreClasses(theatreClassesId));
                    TheatreDA theatreDA = new TheatreDA();
                    theatreDA.updateTheatre(theatre, theatreId);
                    session.setAttribute("Object", theatre);
                }

                session.setAttribute("ValidationMessage", validationMsg);
                session.setAttribute("verificationSucceed", validation);
                response.sendRedirect("AddValidation.jsp");
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('You are not allow to access this page.');");
                out.println("location='TheatreAdminLayout.jsp';");
                out.println("</script>");
            }
 
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
