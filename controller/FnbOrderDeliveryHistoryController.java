package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import model.*;

@WebServlet(name = "FnbOrderDeliveryHistoryController", urlPatterns = {"/FnbOrderDeliveryHistoryController"})
public class FnbOrderDeliveryHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            String fnbOrderID = request.getParameter("id");
            
            FnbOrderDA fnbOrderDA = new FnbOrderDA();
            FnbOrder fnbOrder = fnbOrderDA.getSpecificRecord(fnbOrderID);
            
            FnbOrderLineDA fnbOrderLineDA = new FnbOrderLineDA();
            Object[] fnbOrderLineListObj = fnbOrderLineDA.getRecordByFnbOrderID(fnbOrderID);
            
            request.setAttribute("fnbOrder", fnbOrder);
            request.setAttribute("fnbOrderLineListObj", fnbOrderLineListObj);
            request.getRequestDispatcher("fnbOrderDeliveryHistory.jsp").include(request, response);
            
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
