
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Promotion;
import model.PromotionDA;

@WebServlet(name = "AdminPromoAddDB", urlPatterns = {"/AdminPromoAddDB"})
public class AdminPromoAddDB extends HttpServlet {
    
    private PromotionDA promoDA = new PromotionDA();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String msg = "Promotion successfully added into database.";
        try{
            HttpSession session = request.getSession();
            Promotion promotion = (Promotion) session.getAttribute("promotion");
            promoDA.addRecord(promotion);
            
//            RequestDispatcher rd = request.getRequestDispatcher("AdminPromotion.jsp");
//            rd.include(request, response);
            response.sendRedirect("AdminPromotion.jsp");
        }
        catch (Exception ex){
            
        }
//
//            //<-------------------Successfuly msg (green background)---------------------------------->
//            out.println("<html><head><link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"assets/siteIcon.png\" /></head>");
//            out.println("<style>");
//            out.println("body{background-color:lightgreen;}"
//                    + "#infoIcon{\n"
//                    + "	background-color:green;\n"
//                    + "    color:white;\n"
//                    + "    border-radius:100%;\n"
//                    + "    text-align:center;\n"
//                    + "    font-size:12px;"
//                    + "    padding:5px;\n"
//                    + "}"
//                    + "#infoLog{\n"
//                    + "	background-color: #AAD292;\n"
//                    + "    height:25px;\n"
//                    + "}");
//            out.println("</style>");
//
//            out.println("<body><div id=\"infoLog\">&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"infoIcon\"><i class=\"fa fa-check\"></i></span> &nbsp;&nbsp; " + msg + "</div></body>");
//            out.println("</html>");
//            AdminPromoAddDB refresh = new AdminPromoAddDB();
//            refresh.refreshTable(request, response);
//            RequestDispatcher rd = request.getRequestDispatcher("AdminPromotion.jsp");
//            rd.include(request, response);
//
//
////<-------------------Error msg (red background)---------------------------------->
//        } catch (Exception ex) {
//            out.println("<html>");
//            out.println("<style>");
//            out.println("body{background-color:lightgreen;}"
//                    + "#infoLog{\n"
//                    + "	background-color: #FF8F8F;\n"
//                    + "    height:25px;\n"
//                    + "}");
//            out.println("</style>");
//            out.println(" <body> <div id=\"infoLog\"> ERROR: " + ex.getMessage() + "</div></body>");
//            out.println("</html>");
//
//            RequestDispatcher rd = request.getRequestDispatcher("AdminPromotion.jsp");
//            rd.include(request, response);
//        }
//        
//        out.close();
//    }
//
//    void refreshTable(HttpServletRequest request, HttpServletResponse response) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }
//    
    
        
    

    } 

}
    
