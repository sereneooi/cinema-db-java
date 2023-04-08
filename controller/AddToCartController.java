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

@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "food.jsp";

        try {           
            FnbDA fnbDA = new FnbDA();
            String fnbID = request.getParameter("fnbID");
            String fnbOrderLineID = "";
            boolean isFnbExist = false, isValid = true;

            ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
            Fnb fnb = fnbDA.getSpecificRecord(fnbID);
            String errMsg = "You have reached the maximum quantity available for this item";
            
            HttpSession session = request.getSession();
            
            if(session.getAttribute("fnbOrderLineList") != null) {
                fnbOrderLineList = (ArrayList<FnbOrderLine>) session.getAttribute("fnbOrderLineList");
            } 

            for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                if(fnbOrderLine.getFnb().getFnbID().equals(fnbID)) {
                    isFnbExist = true;
                    if(fnbOrderLine.getQuantity() >= fnb.getFnbStockLeft()) {
                        request.setAttribute("errMsg", errMsg);
                        isValid = false;
                    } else {
                        fnbOrderLine.setQuantity(fnbOrderLine.getQuantity()+1);
                    }
                    break;
                } 
            }

            if(!isFnbExist) {

                if(fnbOrderLineList.size() > 0) {
                    String lastFnbOrderLineID = fnbOrderLineList.get(fnbOrderLineList.size() - 1).getFnbOrderLineID(); 
                    int fnbOrderLineIDInt = Integer.parseInt(lastFnbOrderLineID.substring(3)) + 1;
                    fnbOrderLineID = "FOL" + String.format("%04d", fnbOrderLineIDInt);
                } else {
                    fnbOrderLineID = FnbOrderLine.generateFnbOrderLineID();
                }
                
                FnbOrderLine fnbOrderLine = new FnbOrderLine(fnbOrderLineID, fnb);
                fnbOrderLineList.add(fnbOrderLine);
            }
            
            if(isValid) {
                session.setAttribute("fnbOrderLineList", fnbOrderLineList);
            }
            
            
            if("favourite".equals(request.getParameter("favourite"))) {
                if(session.getAttribute("fnbOrder") == null) {
                    response.sendRedirect("deliveryAddress.jsp");
                }
            }
            
            request.getRequestDispatcher(page).include(request, response);

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
