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

@WebServlet(name = "FilterFoodCategoryController", urlPatterns = {"/FilterFoodCategoryController"})
public class FilterFoodCategoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "food.jsp";
        
        try {
            FnbDA fnbDA = new FnbDA();
            FnbCategoryDA fnbCategoryDA = new FnbCategoryDA();
            
            String fnbCategoryID = request.getParameter("id");
            String fnbCategory = "";
            ArrayList<Fnb> filterFnbList = new ArrayList<Fnb>();
            
            ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
            for(int i = 0; i < fnbCategoryList.size(); i++) {
                if(fnbCategoryList.get(i).getFnbCategoryID().equals(fnbCategoryID)) {
                    fnbCategory = fnbCategoryList.get(i).getFnbCategory();
                    break;
                }
            }
            
            ArrayList<Fnb> fnbList = fnbDA.getRecord();
            for(Fnb fnb : fnbList) {
                if(fnb.getFnbCategory().getFnbCategory().equals(fnbCategory)) {
                    filterFnbList.add(fnb);
                } 
            }
            
            if(!"all".equals(fnbCategoryID)) {
                request.setAttribute("filterFnbList", filterFnbList);
            }
            
            request.getRequestDispatcher(page).forward(request, response);
            
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
