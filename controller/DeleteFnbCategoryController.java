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

@WebServlet(name = "DeleteFnbCategoryController", urlPatterns = {"/DeleteFnbCategoryController"})
public class DeleteFnbCategoryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String fnbCategoryID = request.getParameter("fnbCategoryID");
        
        try {
            FnbCategoryDA fnbCategoryDA = new FnbCategoryDA();
            String successMsg = "Record has been deleted successfully";

            FnbCategory fnbCategoryObj = new FnbCategory(fnbCategoryID);
            fnbCategoryDA.deleteRecord(fnbCategoryObj);
            
            request.setAttribute("successMsg", successMsg);

        } catch(SQLIntegrityConstraintViolationException ex) {
            
            String errMsg = "This record cannot be deleted as \"" + fnbCategoryID + "\" is in used";    
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
        
        request.getRequestDispatcher("fnbCategory.jsp").include(request, response);
        
    }
}
