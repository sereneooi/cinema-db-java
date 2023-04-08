package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLIntegrityConstraintViolationException;
import model.*;

@WebServlet(name = "DeleteQuestionController", urlPatterns = {"/DeleteQuestionController"})
public class DeleteQuestionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String questionID = request.getParameter("questionID");
        
        try {
            QuestionDA questionDA = new QuestionDA();
            String successMsg = "Record has been deleted successfully";

            Question questionObj = new Question(questionID);
            questionDA.deleteRecord(questionObj);
            
            request.setAttribute("successMsg", successMsg);

        } catch(SQLIntegrityConstraintViolationException ex) {
            
            String errMsg = "This record cannot be deleted as \"" + questionID + "\" is in used";    
            request.setAttribute("errMsg", errMsg);
            
        } catch(Exception ex) {
            StackTraceElement[] element = ex.getStackTrace();

            out.println("ERROR: " + ex.toString() + "<br/><br/>");

            for(StackTraceElement e: element) {
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName() + "<br/>");
                out.println("Method Name: " + e.getMethodName() + "<br/>");
                out.println("Line Number: " + e.getLineNumber() + "<br/>");
            }
        }
        
        request.getRequestDispatcher("question.jsp").include(request, response);
        
    }
}
