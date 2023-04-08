<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>

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
                <ion-icon name="arrow-back-circle-outline" onclick="location.href='question.jsp'"></ion-icon>
                <h1>Add Question</h1>
            </div>

            <form method="post" action="AddQuestionController">
                <div>
                    
                    <div class="form-group focused">
                        <label class="form-label" for="questionID">QuestionID</label>
                        <input name="questionID" class="form-input" type="text" value="<%= Question.generateQuestionID() %>" readonly />
                        <span class="form-input-required">*</span>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="question">Question</label>
                        <input name="question" class="form-input" type="text" maxlength="100" autocomplete="off" required />
                        <span class="form-input-required">*</span>
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
