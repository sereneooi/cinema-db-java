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

@WebServlet(name = "AddToFavController", urlPatterns = {"/AddToFavController"})
public class AddToFavController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String page = "food.jsp";
        
        try {
            FnbDA fnbDA = new FnbDA();
            FavItemDA favItemDA = new FavItemDA();
            
            String fnbID = request.getParameter("id");
            String favItemID = "";
            boolean isFnbExist = false;
            
            HttpSession session = request.getSession();
            Account account = (Account)session.getAttribute("currentUser");
            String emailAddress = account.getEmailAddress();

            ArrayList<FavItem> favItemList = favItemDA.getRecordByAccount(emailAddress);
            Fnb fnb = fnbDA.getSpecificRecord(fnbID);

            for(int i = 0; i < favItemList.size(); i++) {
                if(favItemList.get(i).getFnb().getFnbID().equals(fnbID)) {
                    isFnbExist = true;
                    favItemDA.deleteRecord(new FavItem(favItemList.get(i).getFavItemID()));
                    break;
                } 
            }

            if(!isFnbExist) {
                FavItem favItem = new FavItem(FavItem.generateFavItemID(), new Fnb(fnbID), new Account(emailAddress));
                favItemDA.insertRecord(favItem);
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
