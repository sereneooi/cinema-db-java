package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "DeliveryAddressController", urlPatterns = {"/DeliveryAddressController"})
public class DeliveryAddressController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            String streetAddress1 = request.getParameter("streetAddress1");
            String streetAddress2 = request.getParameter("streetAddress2");
            String postcode = request.getParameter("postcode");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String address = streetAddress1 + ", ";

            if(!streetAddress2.equals("") && streetAddress2 != null) {
                address += streetAddress2 + ", ";
            } 

            address += postcode + " " + city + ", " + state;

            String deliveryDate = request.getParameter("deliveryDate");
            String deliveryTime = request.getParameter("deliveryTime");
            String deliveryDateTime = deliveryDate + " " + deliveryTime;

            FnbOrder fnbOrder = new FnbOrder(address, deliveryDateTime);
                    
            HttpSession session = request.getSession();
            session.setAttribute("fnbOrder", fnbOrder); 

            response.sendRedirect("food.jsp");
            
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
