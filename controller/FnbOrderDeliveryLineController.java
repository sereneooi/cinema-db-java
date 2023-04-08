package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

@WebServlet(name = "FnbOrderDeliveryLineController", urlPatterns = {"/FnbOrderDeliveryLineController"})
public class FnbOrderDeliveryLineController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            String fnbOrderID = request.getParameter("id");
            
            FnbOrderLineDA fnbOrderLineDA = new FnbOrderLineDA();
            Object[] fnbOrderLineListObj = fnbOrderLineDA.getFullDetailsRecord(fnbOrderID);
            
            FnbOrderDA fnbOrderDA = new FnbOrderDA();
            FnbOrder fnbOrderObj = fnbOrderDA.getSpecificRecord(fnbOrderID);

            request.setAttribute("fnbOrderLineListObj", fnbOrderLineListObj);
            request.setAttribute("fnbOrderObj", fnbOrderObj);
            request.getRequestDispatcher("fnbOrderDelivery.jsp").include(request, response);
            
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
