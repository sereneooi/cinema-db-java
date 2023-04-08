<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.Theatre, java.util.*"%>

<%-- Retrieve the Theatre Object saved in the session --%>
<jsp:useBean id="theatreList" type="List<model.Theatre>" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            <%@ include file="bookingStyle.css"%>
            #popup-Delete-Form-content{
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 30%;
                height: 65%;
                padding: 50px;
                box-shadow: 0 5px 30px rgba(0,0,0, .30);
                background: #fff;
                border-radius: 15px;
            }

        </style>
    </head>
    <body>
        <jsp:include page="TheatreAdminLayout.jsp" />
        
        <%
            List <String> theatreIdArr = new ArrayList<String>();
            if((request.getParameter("theatreId")) != null){
                theatreIdArr.add(request.getParameter("theatreId"));
           }else{
                for(int i = 0; i < theatreList.size(); i++){
                    if(request.getParameter("theatreIdResult["+i+"]") != null){
                        theatreIdArr.add(theatreList.get(i).getTheatreID());
                    }
                }
           }
       %> 
               
      <div id ="popup-Delete-Form">
           <div class="popup-Form-container">
               <div id="popup-Delete-Form-content">
               <form action="DeleteItem" method="POST" >
                   <div class="fafa-icon-container" style="display: flex; justify-content: center; text-align: center; margin-bottom: 40px;">
                        <i class="fas fa-times-circle" aria-hidden="true" style="color: red; font-size: 7em;"></i>
                    </div>
                    
                    <h1 style="text-align: center;">Are You Sure?</h1><br/>
                    <p style="text-align: center;">Do You Really Want to Delete these Record ? This Process Cannot Be Undo.</p>
                        
                    <%session.setAttribute("deleteList",theatreIdArr); %>
                    
                    <input type='submit' name='confirmation' value="Delete" class ="popup-Form-btn"/>
                    <span class ="popup-Form-btn" onclick="window.location='TheatreAdminLayout.jsp'">Close</span></div>
                
            </form>
                    
               </div>
           </div>
       </div> 
                            
        <script>
            var my_modal = document.getElementById('popup-Delete-Form');
            var main_page = document.getElementById('blur');

            function showModal(){
              my_modal.style.display = "block";
            }
            
            // now show automatically after 0.1s
            setTimeout(showModal,100) 
        </script>
    </body>
</html>


 