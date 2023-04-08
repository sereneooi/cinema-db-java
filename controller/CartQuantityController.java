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

@WebServlet(name = "CartQuantityController", urlPatterns = {"/CartQuantityController"})
public class CartQuantityController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "cart.jsp";
        
        try {
            FnbDA fnbDA = new FnbDA();
            String fnbOrderLineID = request.getParameter("fnbOrderLineID");
            ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
            
            String errMsg = "You have reached the maximum quantity available for this item";
            boolean isValid = true;

            HttpSession session = request.getSession();
            fnbOrderLineList = (ArrayList<FnbOrderLine>) session.getAttribute("fnbOrderLineList");

            if("increase".equals(request.getParameter("action"))) {

                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                    if(fnbOrderLine.getFnbOrderLineID().equals(fnbOrderLineID)) {
                        Fnb fnb = fnbDA.getSpecificRecord(fnbOrderLine.getFnb().getFnbID());
                        if(fnbOrderLine.getQuantity() >= fnb.getFnbStockLeft()) {
                            request.setAttribute("errMsg", errMsg);
                            isValid = false;
                        } else {
                            fnbOrderLine.setQuantity(fnbOrderLine.getQuantity()+1);
                            fnbOrderLine.calculateFnbSubTotal();
                        }
                        break;
                    } 
                }

            } else if("decrease".equals(request.getParameter("action"))) {

                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                    if(fnbOrderLine.getFnbOrderLineID().equals(fnbOrderLineID)) {
                        if(fnbOrderLine.getQuantity() == 1) {
                            break;
                        }

                        fnbOrderLine.setQuantity(fnbOrderLine.getQuantity()-1);
                        fnbOrderLine.calculateFnbSubTotal();
                        break;
                    } 
                }

            }       
                    
            if(isValid) {
                session.setAttribute("fnbOrderLineList", fnbOrderLineList);
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
