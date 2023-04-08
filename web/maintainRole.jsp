<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="selectedrole" scope="session" class="model.Role"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <style>
            .content {
                margin-left: 300px;
                min-height: calc(100vh - 60px);
            }
            .mainContainer{
                width: 95%;
                text-align: left;
                border-collapse: separate !important;
                border-spacing: 0;
                box-shadow: 2px 2px 10px #000;
                border-radius: 15px;
            }
            
            .mainContainer tr#customTitleBar > td{
                padding-left: 10px;
                background-color: #504064;
                color: whitesmoke;
                height: 50px;
            }
            
            .mainContainer td{
                background-color: whitesmoke;
                padding-left: 10px;
                line-height: 20px;
                font-size: 14px;
                padding-top: 10px;
                padding-bottom: 10px;
            }
            
            .CustomBtn{
                height: 35px;
                width: 150px;
                cursor: pointer;
                border-radius: 5px;
                font-family: 'Times New Roman', Times, serif;
                font-weight: bold;
                color: #504064;
                display: justify;
            }
            
            .CustomBtn:hover{
                opacity: 80%;
            }
            
            .allIcon{
                cursor: pointer;
            }
            
            tr#titleBar th{
                font-weight: bold;
                font-size: 14px;
                background-color: lightgray;
                padding-left: 10px;
                height: 45px;
            }
            
            table.mainContainer thead > tr:first-child td:first-child {
                border-top-left-radius: 10px;
            }
    
            table.mainContainer thead > tr:first-child td:last-child {
                border-top-right-radius: 10px;
            }
            
            table.mainContainer tbody > tr:last-child td:first-child {
                border-bottom-left-radius: 10px;
            }
    
            table.mainContainer tbody > tr:last-child td:last-child {
                border-bottom-right-radius: 10px;
            }
            
            table.mainContainer tbody > tr:hover td{
                background-color: rgb(217, 217, 217, 0.7);
            }
            
            table.mainContainer tbody > tr td{
                border-bottom: 0.5px solid lightgray;
            }
            
            .sortable{
                cursor: pointer;
            }
            
            div#modal_header{
                display: flex;
                justify-content: space-between;
            }
            
            a.edit{
                text-decoration: none;
                color: rgb(70, 134, 255);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            a.edit:hover{
                color: rgb(70, 134, 255);
                text-decoration: underline;
            }
            
            .button{
                cursor: pointer;
                background-color:#7058a1;
                color: white;
                border: none;
                font-size: large;
                outline: none;
                transition: transform .2s;
                border-radius: 5px;
                width: 100%;
                height: 35px;
            }

            .button:hover{
                opacity: 0.7;
                -ms-transform: scale(1.05);
                -webkit-transform: scale(1.05); 
                transform: scale(1.05); 
            }

            .button:active {
                background-color: #7058a1;
                transform: translateY(2px);
            }
            
            h3, label{
                color: black;
            }
            
            .search {
                width: 100%;
                height: 50px;
                background-color: whitesmoke;
                padding: 10px;
                border-radius: 5px;
            }

            .search-input {
                color: white;
                border: 0;
                outline: 0;
                background: none;
                width: 0;
                margin-top: 5px;
                line-height: 20px;
                transition: width 0.4s linear
            }

            .search .search-input {
                padding: 0 10px;
                width: 100%;
                font-size: 19px;
                color: black;
                transition: width 0.4s linear
            }

            .search-icon {
                height: 34px;
                width: 100px;
                float: right;
                display: flex;
                justify-content: center;
                align-items: center;
                color: #504064;
                border: 2px solid #504064;
                background-color: transparent;
                font-size: 15px;
                bottom: 30px;
                position: relative;
                border-radius: 5px;
                text-decoration: none;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .search-icon:hover {
                background-color: rgb(80, 64, 100);
                color: white;
                -webkit-transition: background-color 200ms linear;
                -ms-transition: background-color 200ms linear;
                transition: background-color 200ms linear;
            }
            
            .asc:after {
                content: '\25B4';
                position: relative;
                left: 2px;
            }
            
            .desc:after {
                content: '\25BE';
                position: relative;
                left: 2px;
            }
        </style>
    </head>
    <body>
        <script>
            function printContent(el){
              var restorepage = document.body.innerHTML;
              var printcontent = document.getElementById(el).innerHTML;
              document.body.innerHTML = printcontent;
              window.print();
              document.body.innerHTML = restorepage;
            }
        </script>
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
            location='adminDashboard.jsp';
        </script>
        <%
    }
}
%>
        <div class="content" align="center"><br/>
            <div class="d-flex justify-content-center px-5">
                <div class="search">
                    <form action="RoleList" method="POST">
                        <input type="text" class="search-input" placeholder="Search..." name="searchField" autocomplete="off"> 
                        <input type="submit" value="Search" name="search" class="search-icon" />
                    </form>
                </div>
            </div><br/><br/>
            <div id="data">
                <table class="mainContainer" border="0">
                    <thead>
                        <tr id="customTitleBar">
                            <td colspan="2">Manage Role</td>
                            <td></td>
                            <td colspan="2" style="padding-right: 20px; width: 20%;">
                                <button type="button" class="CustomBtn" data-bs-toggle="modal" data-bs-target="#createNewRole">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus-fill" viewBox="0 0 16 16">
                                        <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                                        <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
                                    </svg> &nbsp;
                                    Add New Role
                                </button>
                                <div class="modal fade" id="createNewRole" tabindex="-1" aria-labelledby="createNewRoleLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                                            <div class="modal-body">
                                                <div id="modal_header">
                                                    <h3>Add New Role.</h3>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                                                </div>
                                                <br>
                                                <form method="post" action="AddRole">
                                                    <div class="form-floating">
                                                        <input class="form-control" type="text" maxlength="5" name="newRoleId" id="newRoleId" value="${latestRoleId}" readonly/>
                                                        <label for="newRoleId">Role ID</label>
                                                    </div>
                                                    <br>
                                                    <div class="form-floating">
                                                        <input class="form-control" type="text" maxlength="50" placeholder="Manager" name="newRole" id="newRole" value="${roleDesc}" required autofocus/>
                                                        <label for="newRole">Role</label>
                                                        <div><span id="CreateRoleError" style="color: red; font-weight: normal;"></span></div>
                                                    </div>
                                                    <br>
                                                    <input class="button" type="submit" value="Submit" name="submit" />
                                                    <br>
                                                    <div align="center" style="padding-top: 10px;">
                                                        <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr id="titleBar">
                            <th width="7px" class="sortable">No.</th>
                            <th class="sortable">Role Id</th>
                            <th class="sortable">Role</th>
                            <th style="text-align: center;">Actions</th>
                        </tr>
                    </thead>    
                    <tbody>
                    <% 
                        List<Role> roleLists = (List<Role>) session.getAttribute("allRole"); 
                        List<Role> searchRs = (List<Role>) session.getAttribute("searchRsForRole"); 

                        Role roleList = null;
                        boolean found = false;

                        if(searchRs != null){
                            session.removeAttribute("searchRsForRole");
                            roleLists.clear();
                            roleLists.addAll(searchRs);
                            found = true;
                        }else if(roleLists != null){
                            found = true;
                        }

                        if(found){
                            for(int i = 0; i < roleLists.size(); i++){
                                roleList = roleLists.get(i);
                    %>
                        <tr>
                            <td><%= i + 1 %></td>
                            <td style="cursor: pointer;" onclick="location.href='./RoleDetails?selectedRole=<%= roleList.getRoleId() %>';">
                                <%= roleList.getRoleId()%>
                            </td>
                            <td><%= roleList.getRole()%></td>
                            <td width="10%">
                                <div style="display: flex; justify-content: space-around;">
                                    <svg onclick="location.href='./RoleDetails?selectedRole=<%= roleList.getRoleId() %>';" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-pencil-square allIcon" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                                    </svg>
                                    <svg onclick="location.href='./DeleteRole?selectedRole=<%= roleList.getRoleId() %>';" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-trash3-fill allIcon" viewBox="0 0 16 16">
                                        <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5Zm-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5ZM4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5Z"/>
                                    </svg>
                                </div>
                            </td>
                        </tr>
                        <% } 
                        }else{  %>
                        <tr>
                            <td colspan="4" style="text-align: center;"><b>No Record Found</b></td>
                        </tr>                             
                    <%  }   %>
                    </tbody>
                </table>
            </div>
            <br/>
            <input class="button" type="button" value="Print" onclick="printContent('data')" style="height:35px; width: 10%;"/>
            <input class="button" type="button" value="Export" onclick="location.href='./exportLists?page=RoleList';" style="height:35px; width: 10%;"/>
        <div class="modal fade" id="updateRole" tabindex="-1" aria-labelledby="updateRoleLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                    <div class="modal-body">
                        <div id="modal_header">
                            <h3>Edit Role.</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                        </div>
                        <br>
                        <form method="post" action="RoleDetails">
                            <div class="form-floating">
                                <input class="form-control" type="text" maxlength="5" name="roleId" id="roleId" value="${selectedrole.roleId}" readonly/>
                                <label for="roleId">Role ID</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" maxlength="50" placeholder="Manager" name="newUpdateRole" id="newUpdateRole" value="${selectedrole.role}" required autofocus/>
                                <label for="newUpdateRole">Role</label>
                                <div><span id="UpdateRoleError" style="color: red; font-weight: normal;"></span></div>
                            </div>
                            <br>
                            <input class="button" type="submit" value="Submit" name="submit" />
                            <br>
                            <div align="center" style="padding-top: 10px;">
                                <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="deleteRole" tabindex="-1" aria-labelledby="deleteRoleLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                    <div class="modal-body">
                        <div id="modal_header">
                            <h3>Delete role permanently.</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                        </div>
                        <form action="DeleteRole" method="POST" style="padding: 0px;">
                            <input type="hidden" value="${deleteRole}" name="deleteRole">
                            <p>Are you sure you want to delete this role permanently? Data is not able to be recovered once deleted the role.</p>
                            <br>
                            <input class="button" type="submit" value="Delete" name="delete" style="Height:40px; background-color: red;"/>
                            <br>
                            <div align="center" style="padding-top: 10px;">
                                <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="successRoleMsg" class="toast position-fixed bottom-0 end-0  bg-success p-2 text-dark bg-opacity-75 border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <b id="successMsg"></b>
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>        
        <script>
            <%
                if(session.getAttribute("wantUpdate") != null){  
                    session.removeAttribute("wantUpdate"); %>  
                    $(document).ready(function(){
                        $('#updateRole').modal('show');
                    });
            <%  }    
             
                if(session.getAttribute("gotCreateRoleError") != null){  
                    session.removeAttribute("gotCreateRoleError"); %>
                    document.getElementById("CreateRoleError").innerHTML = "This role has been added before. Please enter a new role.";
                    $(document).ready(function(){
                        $('#createNewRole').modal('show');
                    });
            <%  }  
            
                if(session.getAttribute("gotUpdateRoleError") != null){  
                    session.removeAttribute("gotUpdateRoleError"); %>
                    $(document).ready(function(){
                        $('#updateRole').modal('show');
                    });
            <%  }  

                if(session.getAttribute("wantDeleteRole") != null){  
                    session.removeAttribute("wantDeleteRole"); %>
                    $(document).ready(function(){
                        $('#deleteRole').modal('show');
                    });
                    
            <%  }

            if(session.getAttribute("roleAddedSuccess") != null){  
                    session.removeAttribute("roleAddedSuccess"); %>
                    document.getElementById("successRoleMsg").className += " show";
                    document.getElementById("successMsg").innerHTML = "Successfully added a new role.";
                    
            <%  }   %>
        
            $(document).ready(function(){
                var sortOrder = 1; // flag to toggle the sorting order
                function getVal(elm, colIndex){
                    var td = $(elm).children('td').eq(colIndex).text();
                    if(typeof td !== "undefined"){
                        var v = td.toUpperCase();
                        if($.isNumeric(v)){
                                v = parseInt(v,10);
                        }
                        return v;
                    }
                }

                    $(document).on('click', '.sortable', function(){
                        var self = $(this);
                        var colIndex = self.prevAll().length;
                        var o = (sortOrder == 1) ? 'asc' : 'desc'; 
                        sortOrder *= -1; // toggle the sorting order

                        $('.sortable').removeClass('asc').removeClass('desc');
                        self.addClass(o);
                            var tbody = self.closest("table").find("tbody");
                            var tr = tbody.children("tr"); 

                        tr.sort(function(a, b) {
                            var A = getVal(a, colIndex);
                            var B = getVal(b, colIndex);

                            if(A < B) {
                                return -1*sortOrder;
                            }
                            if(A > B) {
                                return 1*sortOrder;
                            }
                            return 0;
                        });

                        $.each(tr, function(index, row) {
                            tbody.append(row);
                        });

                    });

                });
        </script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    </div>
    </body>
</html>
