package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.*;

@WebServlet(name = "FeedbackFormController", urlPatterns = {"/FeedbackFormController"})
public class FeedbackFormController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            FeedbackFormDA feedbackFormDA = new FeedbackFormDA();
            QuestionDA questionDA = new QuestionDA();
            FeedbackResponseDA feedbackResponseDA = new FeedbackResponseDA();
            
            HttpSession session = request.getSession();
            Booking booking = (Booking) session.getAttribute("booking");
            
            String bookingID = booking.getBookingId();

            FeedbackForm feedbackForm = new FeedbackForm(FeedbackForm.generateFeedbackFormID(), new Booking(bookingID));
            feedbackForm.setFeedbackDateTime();
            
            feedbackFormDA.insertRecord(feedbackForm);
            
            ArrayList<Question> questionList = questionDA.getRecord();          
            for(int i = 0; i < questionList.size(); i++) {
                if(questionList.get(i).isActive()) {
                    int rating = Integer.parseInt(request.getParameter("rating[" + i + "]"));
                    FeedbackResponse feedbackResponse = new FeedbackResponse(FeedbackResponse.generateFeedbackResponseID(), new Question(questionList.get(i).getQuestionID()), new FeedbackForm(feedbackForm.getFeedbackFormID()), rating);
                    feedbackResponseDA.insertRecord(feedbackResponse);
                }
            }
            
            response.sendRedirect("feedbackCompletion.jsp");
            
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
