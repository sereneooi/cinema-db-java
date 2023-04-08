
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Promotion;
import model.PromotionDA;


@WebServlet(name = "AdminPromo", urlPatterns = {"/AdminPromo"})
public class AdminPromo extends HttpServlet {
    
    private PromotionDA promoDA = new PromotionDA();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.setContentType("text/html");
        //PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        try{
            switch(action){
                case "add":
                    addPromo(request,response);
                    break;
                case "retrieve":
                    retrievePromo(request,response);
                    break;
                case "update":
                    updatePromo(request,response);
                    break;
                case "confirmUpdatePage":
                    confirmUpdatePage(request,response);
                    break;
                case "confirmUpdate":
                    confirmUpdate(request,response);
                    break;
                case "updateStatus":
                    updateStatus(request,response);
                    break;
                case "confirmUpdateStatus":
                    confirmUpdateStatus(request,response);
                    break;

                default:
                    break;
            }
        }
        catch(Exception ex){
               
        }
    }
    
     public void addPromo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html");
         PrintWriter out = response.getWriter();
         
         String promoCode = request.getParameter("promoCode");
         String promoType = request.getParameter("promoType");
         double promoAmount = Double.parseDouble(request.getParameter("promoAmount"));
         String promoStatus = request.getParameter("promoStatus");
         
         try{
             Promotion promoCodeExist = promoDA.getRecord(promoCode);
            HttpSession session = request.getSession();
            session.removeAttribute("ErrorMessage");
            session.removeAttribute("ErrorLengthMessage");
            
             //validate duplicate	
            if(promoCodeExist != null){	
                session.setAttribute("ErrorMessage", "Promotion Code already exist in the database.");	
                	
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromoAdd.jsp");	
                dispatcher.forward(request, response);	
            }

            //validate the length of promoCode
            boolean promoCodeValid = ValidateLength(promoCode);  
                  
            if(promoCodeValid == false){  

                session.setAttribute("ErrorLengthMessage","The length of the Promotion Code must be 5.");
                response.sendRedirect("AdminPromoAdd.jsp");
            }
            
             Promotion promotion = new Promotion(promoCode, promoType, promoAmount, promoStatus);
            
            session. setAttribute("promotion", promotion);
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromoConfirmAdd.jsp");
            dispatcher.forward(request, response);
         
         }catch(Exception ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }            
         
         }
         
     
        out.close();
     }
     
     
     public void retrievePromo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        Promotion promotion = new Promotion();
        String promoCode = request.getParameter("promoCode");

        try{
            
            
            Promotion promoCodeExist = promoDA.getRecord(promoCode);
            if(promoCodeExist == null){
                request.setAttribute("ErrorMessage", "Promotion Code cannot be found in the database.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromotion.jsp");
                dispatcher.forward(request, response);
                
            }
            
            promotion = promoDA.getRecord(promoCode);    
            HttpSession session = request.getSession();
            session.setAttribute("promotion",promotion);

            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromoRetrieve.jsp");
            dispatcher.forward(request, response);
            
            
        }catch(ServletException | IOException ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }        
        }
        out.close();
     }

     
     public void updatePromo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
         
        try{
            String promoCode = request.getParameter("promoCode");
            session.setAttribute("promoCode", promoCode);

            Promotion promotion = promoDA.getRecord(promoCode);
            
            Promotion promoCodeExist = promoDA.getRecord(promoCode);
            if(promoCodeExist == null){
                request.setAttribute("ErrorMessage", "Promotion Code cannot be found in the database.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromotion.jsp");
                dispatcher.forward(request, response);
                
            }
            
            response.sendRedirect("AdminPromoUpdate.jsp");
        }catch(IOException ex){
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }  
        }
        out.close();
     }

     
      public void confirmUpdatePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
         
        HttpSession session = request.getSession();
        String promoCode = (String) session.getAttribute("promoCode");
        
        String promoType = request.getParameter("promoType");
        double promoAmount = Double.parseDouble(request.getParameter("promoAmount"));
        String promoStatus = "Available";
         
        try{
            if(request.getParameter("promoStatus")==null){
                promoStatus = "Unavailable";
            }
            Promotion p = new Promotion(promoCode, promoType, promoAmount, promoStatus);
            session.setAttribute("promotion", p);
            
            response.sendRedirect("AdminPromoConfirmUpdate.jsp");
        }catch(IOException ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }    
        }
        out.close();
    }
      
    public void confirmUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
         
        HttpSession session = request.getSession();
         
        try{
            Promotion p = (Promotion)session.getAttribute("p");
            promoDA.updateRecord(p);
            
            response.sendRedirect("AdminPromotion.jsp");
        }catch(IOException ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }    
        }
        out.close();
    }

    public void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Promotion p = new Promotion();
        
        try{
            String promoCode = request.getParameter("promoCode");
            
            if(promoDA.getRecord(promoCode) != null){
                p = promoDA.getRecord(promoCode);
                session.setAttribute("promotion", p);
            
                response.sendRedirect("AdminPromoConfirmUpdateStatus.jsp");
            }
            else{
                 request.setAttribute("ErrorMessage", "Promotion Code cannot be found in the database.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPromotion.jsp");
                dispatcher.forward(request, response);
            }
           

        }catch(IOException ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }    
        }
        out.close();
    }
    
    public void confirmUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Promotion p = new Promotion();
        
        try{
            p = (Promotion)session.getAttribute("promotion");
            promoDA.updateStatusRecord(p.getPromoCode());
            
            response.sendRedirect("AdminPromotion.jsp");
        }catch(Exception ex){
             StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("ERROR: " + ex.toString() + "<br /><br />") ;
            
            for(StackTraceElement e: elements){
                out.println("File Name: " + e.getFileName() + "<br />");
                out.println("Class Name: " + e.getClassName() + "<br />");
                out.println("Method Name: " + e.getMethodName() + "<br />");
                out.println("Line Number: " + e.getLineNumber() + "<br /><br />");
            }    
        }
        out.close();
    }
    
    public static boolean ValidateLength(String promoCode){
        boolean isValid = true;
        
        //if length of String not equals to 5
        if(isValid == true){  
            if(promoCode.length() !=5){
                isValid = false;
            }
        }
        return isValid;
    }
    

    
    

   
}
