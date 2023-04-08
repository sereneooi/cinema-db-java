package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet(name = "exportLists", urlPatterns = {"/exportLists"})
public class exportLists extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String page = request.getParameter("page");
        String custRoleId = "R0003";
        HttpSession session = request.getSession();
        
        String filename = System.getProperty("user.home") + "\\Documents\\" + page + ".csv";
   
        try{
            File file = new File(filename);
            if(!file.exists()){
                file.createNewFile();
            }    
            if(!file.canRead()){
                file.setReadable(true);
            }

            if(!file.canWrite()){
                file.setWritable(true);
            }
            
            FileWriter fw = new FileWriter(filename);
            
            if(page.equals("StaffList") || page.equals("CustList")){
                AccountDA accountDA = new AccountDA();
                List<Account> accLists = null;
                
                if(page.equals("StaffList")){
                    accLists = accountDA.getAllStaffRecord(custRoleId);
                    page = "maintainStaff.jsp";
                }else{
                    accLists = accountDA.getAllCustomerRecord(custRoleId);
                    page = "customerRecord.jsp";
                }
                
                if(accLists != null){
                    fw.append("Email");
                    fw.append(',');
                    fw.append("Name");
                    fw.append(',');
                    fw.append("IC No");
                    fw.append(',');
                    fw.append("Gender");
                    fw.append(',');
                    fw.append("Birthday");
                    fw.append(',');
                    fw.append("Contact No");
                    fw.append(',');
                    fw.append("Role");
                    fw.append(',');
                    fw.append("Date Created");
                    fw.append(',');
                    fw.append("Date Modified");
                    fw.append('\n');
                    
                    for(int i = 0; i < accLists.size(); i++){
                        fw.append(accLists.get(i).getEmailAddress());
                        fw.append(',');
                        fw.append(accLists.get(i).getName());
                        fw.append(',');
                        fw.append(accLists.get(i).getIc());
                        fw.append(',');
                        fw.append(accLists.get(i).getGender());
                        fw.append(',');
                        fw.append(accLists.get(i).getBirthDate());
                        fw.append(',');
                        fw.append(accLists.get(i).getContactNo());
                        fw.append(',');
                        fw.append(accLists.get(i).getRole().getRole());
                        fw.append(',');
                        fw.append(accLists.get(i).getDateCreated().toString());
                        fw.append(',');
                        if(accLists.get(i).getDateModified() == null){
                            fw.append("");
                        }else{
                            fw.append(accLists.get(i).getDateModified().toString());
                        }
                        fw.append('\n');
                    }
                }
            }else if(page.equals("RoleList")){
                RoleDA roleDA = new RoleDA();
                List<Role> roleList = roleDA.getAllRecord();
                page = "maintainRole.jsp";
                
                if(roleList != null){
                    fw.append("Role ID");
                    fw.append(',');
                    fw.append("Role");
                    fw.append('\n');
                    for(int i = 0; i < roleList.size(); i++){
                        fw.append(roleList.get(i).getRoleId());
                        fw.append(',');
                        fw.append(roleList.get(i).getRole());
                        fw.append('\n');
                    }
                }
            }
            fw.close();
             
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Successfully Export to the folder: " + filename + "');");
            out.println("location='" + page + "';");
            out.println("</script>");
            
        }catch(FileNotFoundException ex){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + ex.getMessage() + "');");
            out.println("location='" + page + "';");
            out.println("</script>");
          
        }catch(Exception ex){
            
            StackTraceElement[] elements = ex.getStackTrace();
            
            out.println("Error: " + ex.toString() + "<br/>");
            
            for(StackTraceElement e:elements){
                out.println("File Name: " + e.getFileName() + "<br/>");
                out.println("Class Name: " + e.getClassName()+ "<br/>");
                out.println("Method Name: " + e.getMethodName()+ "<br/>");
                out.println("Line Number: " + e.getLineNumber()+ "<br/>");
            }
            
        }finally{
            out.close();
        }
    }
}
