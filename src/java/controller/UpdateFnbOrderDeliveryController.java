package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.*;

@WebServlet(name = "UpdateFnbOrderDeliveryController", urlPatterns = {"/UpdateFnbOrderDeliveryController"})
public class UpdateFnbOrderDeliveryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            FnbOrderDA fnbOrderDA = new FnbOrderDA();
            
            String fnbOrderID = request.getParameter("fnbOrderID");
            String deliveryAddress = request.getParameter("deliveryAddress");
            String deliveryDate = request.getParameter("deliveryDate");
            String deliveryTime = request.getParameter("deliveryTime");
            String deliveryStatus = request.getParameter("deliveryStatus");
            
            SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyyy");
            String deliveryDateTime = myFormat.format(fromUser.parse(deliveryDate)) + " " + deliveryTime;
        
            String successMsg = "Record has been updated successfully";
            
            FnbOrder fnbOrderObj = new FnbOrder(fnbOrderID, deliveryAddress, deliveryDateTime, deliveryStatus);
            fnbOrderDA.updateRecord(fnbOrderObj);
            
            fnbOrderObj = fnbOrderDA.getSpecificRecord(fnbOrderID);
            
            request.setAttribute("successMsg", successMsg);
            request.setAttribute("fnbOrderObj", fnbOrderObj);
            
            request.getRequestDispatcher("updateFnbOrderDelivery.jsp").include(request, response);
        
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
