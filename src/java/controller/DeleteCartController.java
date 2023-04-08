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

@WebServlet(name = "DeleteCartController", urlPatterns = {"/DeleteCartController"})
public class DeleteCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "cart.jsp";
        
        String fnbOrderLineID = request.getParameter("fnbOrderLineID");
        ArrayList<FnbOrderLine> fnbOrderLineList = new ArrayList<FnbOrderLine>();
        HttpSession session = request.getSession();
        fnbOrderLineList = (ArrayList<FnbOrderLine>) session.getAttribute("fnbOrderLineList");

        for(int i = 0; i < fnbOrderLineList.size(); i++) {
            if(fnbOrderLineList.get(i).getFnbOrderLineID().equals(fnbOrderLineID)) {
                fnbOrderLineList.remove(i);
                break;
            } 
        }

        session.setAttribute("fnbOrderLineList", fnbOrderLineList);
        request.getRequestDispatcher(page).forward(request, response);
        
    }


}
