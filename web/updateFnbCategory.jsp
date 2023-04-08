<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>

<%
    FnbCategory fnbCategoryObj = new FnbCategory();
    if(request.getAttribute("fnbCategoryObj") != null) {
        fnbCategoryObj = (FnbCategory) request.getAttribute("fnbCategoryObj");
    } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <% 
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if(currentUser == null){ 
                %>
                <script type="text/javascript"> 
                    alert('Please log in your account first.');
                    location='login.jsp';
                </script>
                <%
            }else{
                if(!currentUser.getRole().getRoleId().equals("R0001")){
                    %>
                    <script type="text/javascript"> 
                        alert('<%= currentUser.getName() %>, You are not allow to access this page.');
                        location='./fnbCategory.jsp';
                    </script>
                    <%
                }
            }
        %>
        
        <div class="content">
            <div>
                <ion-icon name="arrow-back-circle-outline" onclick="location.href='fnbCategory.jsp'"></ion-icon>
                <h1>Update Food & Beverages Category</h1>
            </div>

            <form method="post" action="UpdateFnbCategoryController">
                <div>
                    <div class="form-group focused">
                        <label class="form-label" for="fnbCategoryID">FnbCategoryID</label>              
                        <input name="fnbCategoryID" class="form-input" type="text" value="<%= fnbCategoryObj.getFnbCategoryID() %>" readonly />
                        <span class="form-input-required">*</span>
                    </div>

                    <div class="form-group focused">
                        <label class="form-label" for="fnbCategory">FnbCategory</label>
                        <input name="fnbCategory" class="form-input" type="text" value="<%= fnbCategoryObj.getFnbCategory() %>" maxlength="50" autocomplete="off" required />
                        <span class="form-input-required">*</span>
                    </div>

                    <button type="submit" class="modal-btn-update">Update</button>
                </div>
            </form>
        </div>
                        
        <script>
            $('input').focus(function(){
                $(this).parents('.form-group').addClass('focused');
            });

            $('input').blur(function(){
                var inputValue = $(this).val();
                if (inputValue == "") {
                    $(this).removeClass('filled');
                    $(this).parents('.form-group').removeClass('focused');  
                } else {
                    $(this).addClass('filled');
                }
            });  
            
             <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>
                
            <% if(request.getAttribute("successMsg") != null) { %>
                swal(
                    'Success',
                    '<%= request.getAttribute("successMsg") %>' ,
                    'success'
                ) 
            <% } %>
        </script>
                            
    </body>
</html>
