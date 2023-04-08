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

@WebServlet(name = "SortFnbOrderDeliveryController", urlPatterns = {"/SortFnbOrderDeliveryController"})
public class SortFnbOrderDeliveryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            FnbOrderDA fnbOrderDA = new FnbOrderDA();

            String columnName = request.getParameter("columnName");
            String order = request.getParameter("order");
            String deliveryDate = request.getParameter("deliveryDate");
            
            SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyyy");
            String reformattedStr = myFormat.format(fromUser.parse(deliveryDate));
            
            ArrayList<FnbOrder> sortFnbOrderList = fnbOrderDA.sortFnbOrder(columnName, order, reformattedStr);
            
            request.setAttribute("reformattedStr", reformattedStr);
            request.setAttribute("sortFnbOrderList", sortFnbOrderList);
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
