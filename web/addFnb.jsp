<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList" %>
<jsp:useBean id="fnbCategoryDA" scope="application" class="model.FnbCategoryDA"></jsp:useBean>

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
        
        <div class="content">
            <div>
                <ion-icon name="arrow-back-circle-outline" onclick="location.href='fnb.jsp'"></ion-icon>
                <h1>Add Food & Beverages</h1>
            </div>

            <form method="post" action="AddFnbController">
                <div>
                    
                    <div>
                        <div class="form-group focused">
                            <label class="form-label" for="fnbID">FnbID</label>
                            <input name="fnbID" class="form-input" type="text" value=<%= Fnb.generateFnbID() %> readonly />
                            <span class="form-input-required">*</span>
                        </div>
                            
                        <div class="form-group focused">
                            <label class="form-label" for="fnbImage">FnbImage</label>
                            <input name="fnbImage" class="form-input filled" type="file" accept="image/png, image/gif, image/jpeg" required />
                            <span class="form-input-required">*</span>
                        </div>
                            
                        <div class="form-group">
                            <label class="form-label" for="fnbDescription">FnbDescription</label>
                            <input name="fnbDescription" class="form-input" type="text" maxlength="50" autocomplete="off" required />
                            <span class="form-input-required">*</span>
                        </div>
                            
                        <div class="form-group">
                            <label class="form-label" for="fnbPrice">FnbPrice (RM)</label>
                            <input name="fnbPrice" class="form-input" type="text" onkeypress="return (event.charCode !=8 && event.charCode ==0 || ( event.charCode == 46 || (event.charCode >= 48 && event.charCode <= 57)))" autocomplete="off" required />
                            <span class="form-input-required">*</span>
                        </div>
                            
                        <div class="form-group">
                            <label class="form-label" for="fnbStockLeft">FnbStockLeft</label>
                            <input name="fnbStockLeft" class="form-input" type="number" min="1" required />
                            <span class="form-input-required">*</span>
                        </div>

                        <div class="form-group focused">
                            <label class="form-label" for="fnbCategory">FnbCategory</label>
                            <select class="custom-select" name="fnbCategory" >
                                
                                <%
                                    ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
                                    for(int i = 0; i < fnbCategoryList.size(); i++) {
                                        out.println("<option value=\"" + fnbCategoryList.get(i).getFnbCategoryID() + "\">" + fnbCategoryList.get(i).getFnbCategory() + "</option>");
                                    }
                                %>
                                
                            </select>
                        </div>
                        
                        <div class="form-group active focused">
                            <label class="form-label" style="transform: translateY(-160%); z-index: 0;">Active</label>
                            <label class="switch">
                                <input type="checkbox" name="active" checked>
                                    <span class="slider round"></span>
                                </label>
                        </div>
                    
                    <button type="submit" class="btn-create">Create</button>
                </div>
            </form>
                            
        </div>
                        
        <script>
            $('input').focus(function(){
                $(this).parents('.form-group').addClass('focused');
            });

            $('input').blur(function(){
                var inputValue = $(this).val();
                if (inputValue == "" && $(this).type() != "file") {
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
