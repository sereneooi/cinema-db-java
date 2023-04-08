<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList" %>
<jsp:useBean id="fnbCategoryDA" scope="application" class="model.FnbCategoryDA"></jsp:useBean>

<%
    Fnb fnbObj = new Fnb();
    ArrayList<FnbCategory> fnbCategoryList = new ArrayList<FnbCategory>();
    
    if(request.getAttribute("fnbObj") != null) {
        fnbObj = (Fnb) request.getAttribute("fnbObj");
        fnbCategoryList = fnbCategoryDA.getRecord();
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
                        location='./fnb.jsp';
                    </script>
                    <%
                }
            }
        %>

        <div class="content">
            <div>
                <ion-icon name="arrow-back-circle-outline" onclick="location.href='fnb.jsp?fnbObj=<%= fnbObj %>'"></ion-icon>
                <h1>Update Food & Beverages</h1>
            </div>

            <form method="post" action="UpdateFnbController">
                <div>
                    <div class="form-group focused">
                            <label class="form-label" for="fnbID">FnbID</label>              
                            <input name="fnbID" class="form-input" type="text" value="<%= fnbObj.getFnbID() %>" readonly />
                            <span class="form-input-required">*</span>
                        </div>

                         <div class="form-group focused">
                            <label class="form-label" for="fnbImage">FnbImage</label>
                            <input name="fnbImage" class="form-input" type="file" />
                            <span class="form-input-required">*</span>
                        </div>

                        <div class="form-group focused">
                            <label class="form-label" for="fnbDescription">FnbDescription</label>
                            <input name="fnbDescription" class="form-input" type="text" value="<%= fnbObj.getFnbDescription() %>" maxlength="50" autocomplete="off" required />
                            <span class="form-input-required">*</span>
                        </div>

                        <div class="form-group focused">
                            <label class="form-label" for="fnbPrice">FnbPrice (RM)</label>
                            <input name="fnbPrice" class="form-input" type="text" value="<%= String.format("%.2f", fnbObj.getFnbPrice()) %>" onkeypress="return (event.charCode !=8 && event.charCode ==0 || ( event.charCode == 46 || (event.charCode >= 48 && event.charCode <= 57)))" autocomplete="off" required />
                            <span class="form-input-required">*</span>
                        </div>

                        <div class="form-group focused">
                            <label class="form-label" for="fnbStockLeft">FnbStockLeft</label>
                            <input name="fnbStockLeft" class="form-input" type="number" min="1" value="<%= fnbObj.getFnbStockLeft() %>" required />
                            <span class="form-input-required">*</span>
                        </div>

                        <div class="form-group focused">
                            <label class="form-label" for="fnbCategory">FnbCategory</label>
                            <select class="custom-select" name="fnbCategory" required>
                                
                                <% for(int i = 0; i < fnbCategoryList.size(); i++) { %>
                                    <option value="<%= fnbCategoryList.get(i).getFnbCategoryID() %>" 
                                    <% if(fnbCategoryList.get(i).getFnbCategoryID().equals(fnbObj.getFnbCategory().getFnbCategoryID())) { %>
                                                selected
                                    <% } %>
                                            ><%= fnbCategoryList.get(i).getFnbCategory() %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group active focused">
                            <label class="form-label" style="transform: translateY(-160%); z-index: 0;">Active</label>
                            <label class="switch">
                                <input type="checkbox" name="active"
                                <% if(fnbObj.isActive()) { %>
                                         checked />
                                <% } else { %>
                                         />
                                <% } %>
                                    <span class="slider round"></span>
                                </label>
                        </div>

                        <button type="submit" class="modal-btn-update">Update</button>
                    </div>
                </form>
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
