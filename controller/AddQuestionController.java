package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.*;

@WebServlet(name = "AddQuestionController", urlPatterns = {"/AddQuestionController"})
public class AddQuestionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            QuestionDA questionDA = new QuestionDA();
            ArrayList<Question> questionList = questionDA.getRecord();

            String questionID = request.getParameter("questionID");
            String question = request.getParameter("question").trim();
            String strActive = request.getParameter("active");
            boolean active = false;
            
            if("on".equals(strActive)) {
                active = true;
            } 

            String successMsg = "Record has been added successfully";

            boolean isValid = true;
            
            // Validate question uniqueness
            for(int i = 0; i < questionList.size(); i++) {
                if(questionList.get(i).getQuestion().toUpperCase().equals(question.toUpperCase())) {
                    isValid = false;
                    String errMsg = "Question requires a unique entry and <br/>\"" + questionList.get(i).getQuestion() + "\" has already existed in the database."; 
                    request.setAttribute("errMsg", errMsg);
                }
            }

            if(isValid) {
                Question questionObj = new Question(questionID, question, active);
                questionObj.setDateCreated();    
                questionDA.insertRecord(questionObj);
                request.setAttribute("successMsg", successMsg);
            }
            
            request.getRequestDispatcher("addQuestion.jsp").include(request, response);  

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
        
    }
}
