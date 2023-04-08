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
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            
            <div class="header">
                <h1>Food & Beverages Category</h1>
                <button class="btn-create-new" onclick="location.href='addFnbCategory.jsp'">
                    <span>Create new </span>
                </button>
            </div>
            
            <div class="search__container">
                <form method="post" action="FilterFnbCategoryController">
                    <input class="search__input" type="text" name="keyword" placeholder="Search" autofocus="on" autocomplete="off" />
                    <button type="submit"><ion-icon name="search-outline"></ion-icon></button>
                </form>
            </div>
            
            <div class="body" style="width:100%">
                <table id="example" style="width:100%">
                    <thead>
                        <tr>
                            <th>
                                <form class="sortingForm" method="post" action="SortFnbCategoryController">
                                    <input type="text" name="columnName" value="FnbCategoryID" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>
                                <form class="sortingForm" method="post" action="SortFnbCategoryController">
                                    <input type="text" name="columnName" value="FnbCategory" size="8" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>
                                <form class="sortingForm" method="post" action="SortFnbCategoryController">
                                    <input type="text" name="columnName" value="DateCreated" size="7" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>
                                <form class="sortingForm" method="post" action="SortFnbCategoryController">
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
                            ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
                            int size = fnbCategoryList.size();
                            
                            if(request.getAttribute("filterFnbCategoryList") != null) {
                                fnbCategoryList = (ArrayList<FnbCategory>) request.getAttribute("filterFnbCategoryList");
                            } else if(request.getAttribute("sortFnbCategoryList") != null) {
                                fnbCategoryList = (ArrayList<FnbCategory>) request.getAttribute("sortFnbCategoryList");
                            }
                    
                            // Display row data
                            for(FnbCategory fnbCategory : fnbCategoryList) {
                        %>
                                <tr>
                                    <td><%= fnbCategory.getFnbCategoryID() %></td>
                                    <td><%= fnbCategory.getFnbCategory() %></td>
                                    <td><%= fnbCategory.getDateCreated() %></td>
                                    <td><%= fnbCategory.getDateModified() %></td>
                                    <td>
                                        <form class="open-form-update" method="post" action="GetFnbCategoryController">
                                            <input type="hidden" name="fnbCategoryID" value="<%= fnbCategory.getFnbCategoryID() %>" />
                                            <button class="btn-update">
                                                <ion-icon name="pencil-outline"></ion-icon>
                                            </button>
                                        </form>
                                        <form class="form-delete" method="post" action="DeleteFnbCategoryController">
                                            <input type="hidden" name="fnbCategoryID" value="<%= fnbCategory.getFnbCategoryID() %>" />
                                            <button type="button" class="btn-delete">
                                                <ion-icon name="trash-outline"></ion-icon>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                    <% } %>
                    </tbody>
                </table>
                
                <p>Showing <%= fnbCategoryList.size() %> entries
                    <% if(fnbCategoryList.size() != size) { %>
                            (filtered from <%= size %> total entries)
                    <% } %>  
                </p>
            
            </div>
        </div>
 
        <script>  
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
