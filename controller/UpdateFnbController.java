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

@WebServlet(name = "UpdateFnbController", urlPatterns = {"/UpdateFnbController"})
public class UpdateFnbController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            String fnbID = request.getParameter("fnbID");
            String fnbImage = request.getParameter("fnbImage");
            String fnbDescription = request.getParameter("fnbDescription").trim();
            double fnbPrice = Double.parseDouble(request.getParameter("fnbPrice"));
            int fnbStockLeft = Integer.parseInt(request.getParameter("fnbStockLeft"));
            String fnbCategoryID = request.getParameter("fnbCategory");
            String strActive = request.getParameter("active");
            boolean active = false;
            
            if("on".equals(strActive)) {
                active = true;
            } 
            
            FnbDA fnbDA = new FnbDA();
            ArrayList<Fnb> fnbList = fnbDA.getRecord();
            Fnb fnbObj = fnbDA.getSpecificRecord(fnbID);

            String successMsg = "Record has been updated successfully";

            boolean isValid = true;

            // Validate fnb uniqueness
            for(int i = 0; i < fnbList.size(); i++) {
                if(fnbList.get(i).getFnbDescription().toUpperCase().equals(fnbDescription.toUpperCase())) {
                    if(!fnbID.equals(fnbList.get(i).getFnbID())) {
                        isValid = false;
                        String errMsg = "Fnb requires a unique entry and <br>\"" + fnbList.get(i).getFnbDescription() + "\" has already existed in the database.";
                        request.setAttribute("errMsg", errMsg);
                    }
                }
            }

            if(isValid) {
                fnbObj = new Fnb(fnbID, fnbImage, fnbDescription, fnbPrice, fnbStockLeft, active, new FnbCategory(fnbCategoryID));
                fnbObj.setDateModified();
                fnbDA.updateRecord(fnbObj);
                request.setAttribute("successMsg", successMsg);
            }
            
            HttpSession session = request.getSession();
            session.removeAttribute("fnbList");
        
            request.setAttribute("fnbObj", fnbObj);
            request.getRequestDispatcher("updateFnb.jsp").include(request, response);
        
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
