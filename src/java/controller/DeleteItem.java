package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ErrorManagement;
import model.*;
import java.util.ArrayList;

@WebServlet(name = "DeleteItem", urlPatterns = {"/DeleteItem"})
public class DeleteItem extends HttpServlet {

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try{
                        
            HttpSession session = request.getSession();
            
            Account currentUser = (Account)session.getAttribute("currentUser");
            
            if(currentUser.getRole().getRoleId().equals("R0001")){
            List<String> theatreList = (List<String>) session.getAttribute("deleteList");
            List <String> theatreNullChecking = new ArrayList<>();
            theatreNullChecking.addAll(theatreList);
            
            TheatreDA theatreDA = new TheatreDA();
            Theatre theatre = new Theatre();
            
            int totalRecord = theatreDA.RecordCount();
            
            List<Theatre> checkFkTheatreList = theatreDA.checkForeignKeyConstraint();
            List<String> ableToDeleteTheatreList = new ArrayList<>();
            String validationMsg = ""; String unableDeleteId = ""; boolean validation = true;

            //check is the theatreId is foreign view of the child table
            for(int i = 0; i < theatreList.size(); i++){
                for(int j = 0; j < checkFkTheatreList.size(); j++){
                    if(theatreList.get(i).equals(checkFkTheatreList.get(j).getTheatreID())){
                        ableToDeleteTheatreList.add(theatreList.get(i));
                        theatreList.remove(i);
                    }
                }
            }
            
            //Delete all when user click on the delete button but no check on checkbox
            if(theatreNullChecking == null  || theatreNullChecking.isEmpty()){
                if(checkFkTheatreList.size() == totalRecord){
                    for(int i = 0; i < checkFkTheatreList.size(); i++){
                        theatreDA.deleteTheatre(checkFkTheatreList.get(i).getTheatreID());
                   }
                    validationMsg = "Your Record was Deleted Sucessful!";
                    session.setAttribute("ValidationMessage", validationMsg);                
                    session.setAttribute("verificationSucceed", validation);
                }else{
                    validation=false;
                    validationMsg = "Unable to Delete Foreign Key Constraint Column" + unableDeleteId + ".";
                    session.setAttribute("ValidationMessage", validationMsg);                
                    session.setAttribute("verificationSucceed", validation);
                }
            }else{

                if((theatreList != null  && !theatreList.isEmpty())){
                    validation=false;
                    for(int i = 0; i < theatreList.size(); i++){unableDeleteId = " " + theatreList.get(i);}
                    validationMsg = "Unable to Delete Foreign Key Constraint Column" + unableDeleteId + ".";
                    session.setAttribute("ValidationMessage", validationMsg);                
                    session.setAttribute("verificationSucceed", validation);

                }else{

                    for(int i = 0; i < ableToDeleteTheatreList.size(); i++){
                        theatreDA.deleteTheatre(ableToDeleteTheatreList.get(i));
                   }
                    validationMsg = "Your Record was Deleted Sucessful!";
                    session.setAttribute("ValidationMessage", validationMsg);                
                    session.setAttribute("verificationSucceed", validation);
                }
            }
            session.setAttribute("Object", theatre);
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
