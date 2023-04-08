<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList, java.lang.Math" %>
<jsp:useBean id="fnbCategoryDA" scope="application" class="model.FnbCategoryDA"></jsp:useBean>
<jsp:useBean id="fnbDA" scope="application" class="model.FnbDA"></jsp:useBean>

<% 
    int pageNo = 1;
    if(request.getParameter("pageNo") != null) {
        pageNo = Integer.parseInt((String) request.getParameter("pageNo"));
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
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <style>
            ul.pagination {
                position: relative;
                background: #fff;
                display: flex;
                padding: 6px 20px;
                border-radius: 5px;
                box-shadow: 0 5px 15px rgb(0 0 0 / 10%);
                justify-content: center;
                width: max-content;
                float: right;
                margin-right: 10px;
                margin-bottom: 10px;
            }
            ul.pagination li {
                list-style: none;
                line-height: 30px;
                margin: 0 5px;
            }
            ul.pagination li.pageNumber {
                width: 30px;
                height: 30px;
                line-height: 30px;
                text-align: center;
            }
            ul.pagination li a {
                display: block;
                text-decoration: none;
                color: #383838;
                font-weight: 600;
                border-radius: 50%;
            }
            ul.pagination li.pageNumber:hover a,
            ul.pagination li.pageNumber.active a {
                background: #383838;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            
            <div class="header">
                <h1>Food & Beverages</h1>
                <button class="btn-create-new" onclick="location.href='addFnb.jsp'">
                    <span>Create new </span>
                </button>
            </div>
            
            <div class="search__container">
                <form method="post" action="FilterFnbController">
                    <input class="search__input" type="text" name="keyword" placeholder="Search" autofocus="on" autocomplete="off" />
                    <button type="submit"><ion-icon name="search-outline"></ion-icon></button>
                </form>
            </div>
            
            <div class="body">
                <table id="example" style="width:100%">
                    <thead>
                        <tr>
                            <th style="min-width: 80px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="FnbID" size="2" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>FnbImage</th>
                            <th style="min-width: 150px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="FnbDescription" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 100px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="FnbPrice" size="4" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 130px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="FnbStockLeft" size="8" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 80px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="Active" size="2" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 130px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="FnbCategory" size="8" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 155px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="DateCreated" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 155px;">
                                <form class="sortingForm" method="post" action="SortFnbController">
                                    <input type="text" name="columnName" value="DateModified" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 90px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Display row data
                            ArrayList<Fnb> fnbList = fnbDA.getRecord();
                            int size = fnbList.size();
                            
                            if(request.getAttribute("filterFnbList") != null) {
                                fnbList = (ArrayList<Fnb>) request.getAttribute("filterFnbList");
                                session.setAttribute("fnbList", fnbList);
                            } else if(request.getAttribute("sortFnbList") != null) {
                                fnbList = (ArrayList<Fnb>) request.getAttribute("sortFnbList");
                                session.setAttribute("fnbList", fnbList);
                            } else if(session.getAttribute("fnbList") != null) {
                                fnbList = (ArrayList<Fnb>) session.getAttribute("fnbList");
                            }

                            for (int i = 4 * (pageNo - 1); i < fnbList.size(); i++) {
                                if(i == (pageNo * 4)) {
                                    break;
                                }
                                Fnb fnb = fnbList.get(i);
                        %>
                                <tr>
                                    <td><%= fnb.getFnbID() %></td>
                                    <td><img src="img/food/<%= fnb.getFnbImage() %>" alt="<%= fnb.getFnbDescription() %>" style="width: 100px; height: 100px;" /></td>
                                    <td><%= fnb.getFnbDescription() %></td>
                                    <td>RM <%= String.format("%.2f", fnb.getFnbPrice()) %></td>
                                    <td>
                                        <p 
                                           <% if(fnb.getFnbStockLeft() < 10) { %>
                                                class="lowStock"
                                            <% } %>
                                                ><%= fnb.getFnbStockLeft() %>
                                        </p>
                                    </td>
                                    <td>
                                        <p class=
                                            <% if(fnb.isActive()) { %>
                                                "true">active
                                            <% } else { %>
                                                "false">inactive
                                            <% } %>
                                        </p>
                                    </td>
                                    <td><%= fnb.getFnbCategory().getFnbCategory() %></td>
                                    <td><%= fnb.getDateCreated() %></td>
                                    <td><%= fnb.getDateModified() %></td>
                                    <td>
                                        <form class="open-form-update" method="post" action="GetFnbController">
                                            <input type="hidden" name="fnbID" value="<%= fnb.getFnbID() %>" />
                                            <button class="btn-update">
                                                <ion-icon name="pencil-outline"></ion-icon>
                                            </button>
                                        </form>
                                        <form class="form-delete" method="post" action="DeleteFnbController">
                                            <input type="hidden" name="fnbID" value="<%= fnb.getFnbID() %>" />
                                            <button type="button" class="btn-delete">
                                                <ion-icon name="trash-outline"></ion-icon>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
                                    
            <ul class="pagination">
                <% 
                    int totalPage = (int)Math.ceil(fnbList.size() / 4.0);
                    for(int i = 1; i <= totalPage; i++) {
                %>
                        <li class=
                        <% if(i == pageNo) { %>
                            "pageNumber active"
                        <% } else { %>
                            "pageNumber"
                        <% } %>
                        ><a href="fnb.jsp?pageNo=<%= i %>"><%= i %></a>
                        </li>
                <% } %>
            </ul>
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
                    
            document.addEventListener("DOMContentLoaded",function(){
                window.addEventListener("pagehide",function(a){
                    window.name+="\ue000"+window.pageXOffset+"\ue000"+window.pageYOffset
                });
                if(window.name&&-1<window.name.indexOf("\ue000")){
                    var a=window.name.split("\ue000");
                    3<=a.length&&(window.name=a[0],window.scrollTo(parseFloat(a[a.length-2]),parseFloat(a[a.length-1])))
                }
            });
        </script>
    </body>
</html>
