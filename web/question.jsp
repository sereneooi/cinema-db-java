<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList" %>
<jsp:useBean id="questionDA" scope="application" class="model.QuestionDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            
            <div class="header">
                <h1>Feedback Question</h1>
                <button class="btn-create-new" onclick="location.href='addQuestion.jsp'">
                    <span>Create new </span>
                </button>
            </div>
            
            <div class="search__container">
                <form method="post" action="FilterQuestionController">
                    <input class="search__input" type="text" name="keyword" placeholder="Search" autofocus="on" autocomplete="off" />
                    <button type="submit"><ion-icon name="search-outline"></ion-icon></button>
                </form>
            </div>
            
            <div class="body">
                <table id="example"style="width:100%">
                    <thead>
                        <tr>
                            <th style="min-width: 110px;">
                                <form class="sortingForm" method="post" action="SortQuestionController">
                                    <input type="text" name="columnName" value="QuestionID" size="6" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>
                                <form class="sortingForm" method="post" action="SortQuestionController">
                                    <input type="text" name="columnName" value="Question" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 79px;">
                                <form class="sortingForm" method="post" action="SortQuestionController">
                                    <input type="text" name="columnName" value="Active" size="2" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 153px;">
                                <form class="sortingForm" method="post" action="SortQuestionController">
                                    <input type="text" name="columnName" value="DateCreated" size="7" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 153px;">
                                <form class="sortingForm" method="post" action="SortQuestionController">
                                    <input type="text" name="columnName" value="DateModified" size="8" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Display row data
                            ArrayList<Question> questionList = questionDA.getRecord();
                            int size = questionList.size();
                            
                            if(request.getAttribute("filterQuestionList") != null) {
                                questionList = (ArrayList<Question>) request.getAttribute("filterQuestionList");
                            } else if(request.getAttribute("sortQuestionList") != null) {
                                questionList = (ArrayList<Question>) request.getAttribute("sortQuestionList");
                            }
                            
                            for (int i = 0; i < questionList.size(); ++i) {
                                Question question = questionList.get(i);
                        %>
                                <tr>
                                    <td><%= question.getQuestionID() %></td>
                                    <td><%= question.getQuestion() %></td>
                                    <td>
                                        <p class=
                                            <% if(question.isActive()) { %>
                                                "true">active
                                            <% } else { %>
                                                "false">inactive
                                            <% } %>
                                        </p>
                                    </td>
                                    <td><%= question.getDateCreated() %></td>
                                    <td><%= question.getDateModified() %></td>
                                    <td>
                                        <form class="open-form-update" method="post" action="GetQuestionController">
                                            <input type="hidden" name="questionID" value="<%= question.getQuestionID() %>" />
                                            <button class="btn-update">
                                                <ion-icon name="pencil-outline"></ion-icon>
                                            </button>
                                        </form>
                                        <form class="form-delete" method="post" action="DeleteQuestionController">
                                            <input type="hidden" name="questionID" value="<%= question.getQuestionID() %>" />
                                            <button type="button" class="btn-delete">
                                                <ion-icon name="trash-outline"></ion-icon>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                        <% } %>
                    </tbody>
                </table>
                    
                <p>Showing <%= questionList.size() %> entries
                    <% if(questionList.size() != size) { %>
                            (filtered from <%= size %> total entries)
                    <% } %>  
                </p>
                
            </div>
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
            
            <% if(request.getAttribute("successMsg") != null) { %>
                swal(
                    'Success',
                    '<%= request.getAttribute("successMsg") %>' ,
                    'success'
                )
            <% } %>
                
            <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>

            $('#example tbody').on('click', '.btn-delete', function () {
                <% 
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    if(currentUser == null){ 
                %>
                        alert('Please log in your account first.');
                        location='login.jsp';
                <%
                    }else{
                        if(!currentUser.getRole().getRoleId().equals("R0001")){
                %>
                        alert('<%= currentUser.getName() %>, You are not allow to delete this record.');
                <%
                        } else {
                %>
                            swal({
                                title: "Are you sure?", 
                                text: "Do you want to delete? This process cannot be undone", 
                                type: "warning",
                                confirmButtonText: "Delete",
                                showCancelButton: true
                            })
                                .then((result) => {
                                    if (result.value) {
                                        $(this).parent().submit();
                                    } 
                                })
                <%
                        }
                    }
                %>
            });
            
            $('.order').on('click', function () {
                if($(this).find('.asc').css('color') == 'rgb(130, 135, 223)') {
                    $(this).append('<input type="hidden" name="order" value="desc" />');
                } else {
                    $(this).append('<input type="hidden" name="order" value="asc" />');
                }
                $(this).parent().submit();
            });
            
            <% 
                if(request.getParameter("order") != null) {
                    String order = request.getParameter("order");
                    String columnName = request.getParameter("columnName");
                    if("asc".equals(order)) {
            %>
                        let form = document.getElementsByClassName('sortingForm');
                        for(let i = 0; i < form.length; i++) {
                            if(form[i].firstElementChild.value == '<%= columnName %>') {
                                form[i].querySelector('.asc').style.color = 'rgb(130, 135, 223)';
                            } 
                        }
            <% } else { %>
                        let form = document.getElementsByClassName('sortingForm');
                        for(let i = 0; i < form.length; i++) {
                            if(form[i].firstElementChild.value == '<%= columnName %>') {
                                form[i].querySelector('.asc').style.color = 'rgb(217, 217, 217)';
                                form[i].querySelector('.desc').style.color = 'rgb(130, 135, 223)';
                            }
                        }
            <% } 
                } %>
        </script>
    </body>
</html>
