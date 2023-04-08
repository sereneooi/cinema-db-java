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

@WebServlet(name = "AddFnbController", urlPatterns = {"/AddFnbController"})
public class AddFnbController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            FnbDA fnbDA = new FnbDA();
            ArrayList<Fnb> fnbList = fnbDA.getRecord();

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

            String successMsg = "Record has been added successfully";

            boolean isValid = true;
            
            // Validate fnb uniqueness
            for(Fnb fnb : fnbList) {
                if(fnb.getFnbDescription().toUpperCase().equals(fnbDescription.toUpperCase())) {
                    isValid = false;
                    String errMsg = "FnbDescription requires a unique entry and <br/>\"" + fnb.getFnbDescription() + "\" has already existed in the database."; 
                    request.setAttribute("errMsg", errMsg);
                }
            }

            if(isValid) {
                Fnb fnbObj = new Fnb(fnbID, fnbImage, fnbDescription, fnbPrice, fnbStockLeft, active, new FnbCategory(fnbCategoryID));
                fnbObj.setDateCreated();    
                fnbDA.insertRecord(fnbObj);
                request.setAttribute("successMsg", successMsg);
            }
            
            HttpSession session = request.getSession();
            session.removeAttribute("fnbList");
            
            request.getRequestDispatcher("addFnb.jsp").include(request, response);  

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
