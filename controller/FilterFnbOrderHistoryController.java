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

@WebServlet(name = "FilterFnbOrderHistoryController", urlPatterns = {"/FilterFnbOrderHistoryController"})
public class FilterFnbOrderHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "fnbOrderDeliveryHistory.jsp";
        
        try {
            HttpSession session = request.getSession();
            Account account = (Account)session.getAttribute("currentUser");
            String emailAddress = account.getEmailAddress();
            
            FnbOrderDA fnbOrderDA = new FnbOrderDA();
            ArrayList<FnbOrder> fnbOrderList = fnbOrderDA.getRecordByAccount(emailAddress);
            
            String status = request.getParameter("status");
            
            ArrayList<FnbOrder> filterFnbOrderList = new ArrayList<FnbOrder>();
            for(FnbOrder fnbOrder : fnbOrderList) {
                if(fnbOrder.getDeliveryStatus() != null) {
                    if(status.equalsIgnoreCase("upcoming") && !fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")) {
                        filterFnbOrderList.add(fnbOrder);
                    } else if(status.equalsIgnoreCase("completed") && fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")) {
                        filterFnbOrderList.add(fnbOrder);
                    }
                }
            }

            request.setAttribute("filterFnbOrderList", filterFnbOrderList);
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
