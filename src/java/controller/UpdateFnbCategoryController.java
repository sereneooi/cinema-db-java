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

@WebServlet(name = "UpdateFnbCategoryController", urlPatterns = {"/UpdateFnbCategoryController"})
public class UpdateFnbCategoryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            String fnbCategoryID = request.getParameter("fnbCategoryID");
            String fnbCategory = request.getParameter("fnbCategory").trim();
            
            FnbCategoryDA fnbCategoryDA = new FnbCategoryDA();
            ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
            FnbCategory fnbCategoryObj = fnbCategoryDA.getSpecificRecord(fnbCategoryID);

            String successMsg = "Record has been updated successfully";

            boolean isValid = true;

            // Validate fnbCategory uniqueness
            for(int i = 0; i < fnbCategoryList.size(); i++) {
                if(fnbCategoryList.get(i).getFnbCategory().toUpperCase().equals(fnbCategory.toUpperCase())) {
                    if(!fnbCategoryID.equals(fnbCategoryList.get(i).getFnbCategoryID())) {
                        isValid = false;
                        String errMsg = "FnbCategory requires a unique entry and <br/>\"" + fnbCategoryList.get(i).getFnbCategory() + "\" has already existed in the database."; 
                        request.setAttribute("errMsg", errMsg);
                    }
                }
            }

        if(isValid) {
            fnbCategoryObj = new FnbCategory(fnbCategoryID, fnbCategory);
            fnbCategoryObj.setDateModified();
            fnbCategoryDA.updateRecord(fnbCategoryObj);
            request.setAttribute("successMsg", successMsg);
        }
        
        request.setAttribute("fnbCategoryObj", fnbCategoryObj);

        request.getRequestDispatcher("updateFnbCategory.jsp").include(request, response);
        
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
