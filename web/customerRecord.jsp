<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="selectedCust" scope="session" class="model.Account"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
            
            div.long-details{
                font-weight: normal;
                width: 100px;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
                margin: 0; 
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
        <%@include file="checkAccess.jsp"%>
        <div class="content" align="center"><br/>
            <div class="d-flex justify-content-center px-5">
                <div class="search">
                    <form action="RetrieveCustomerRecord" method="POST">
                        <input type="text" class="search-input" placeholder="Search..." name="searchField" autocomplete="off"> 
                        <input type="submit" value="Search" name="search" class="search-icon" />
                    </form>
                </div>
            </div><br/><br/>
            <div id="data">
                <table class="mainContainer" border="0">
                    <thead>
                        <tr id="customTitleBar">
                            <td colspan="9">
                                Customer
                            </td>
                        </tr>
                        <tr id="titleBar">
                            <th width="7px">No</th>
                            <th class="sortable ${iconForSortName}" onclick="location.href='SortCustomerRecord?selectedCol=Name&order=${viewCustSortOrderName}';">Name</th>
                            <th class="sortable ${iconForSortIc}" onclick="location.href='SortCustomerRecord?selectedCol=Ic&order=${viewCustSortOrderIc}';">IC</th>
                            <th class="sortable ${iconForSortPassword}" onclick="location.href='SortCustomerRecord?selectedCol=Password&order=${viewCustSortOrderPassword}';">Password</th>
                            <th class="sortable ${iconForSortGender}" onclick="location.href='SortCustomerRecord?selectedCol=Gender&order=${viewCustSortOrderGender}';">Gender</th>
                            <th class="sortable ${iconForSortAddress}" onclick="location.href='SortCustomerRecord?selectedCol=Address&order=${viewCustSortOrderAddress}';">Address</th>
                            <th class="sortable ${iconForSortContactNo}" onclick="location.href='SortCustomerRecord?selectedCol=ContactNo&order=${viewCustSortOrderContactNo}';">Phone No</th>
                            <th class="sortable ${iconForSortDateCreated}" onclick="location.href='SortCustomerRecord?selectedCol=DateCreated&order=${viewCustSortOrderDateCreated}';">Date Created</th>
                            <th class="sortable ${iconForSortDateModified}" onclick="location.href='SortCustomerRecord?selectedCol=DateModified&order=${viewCustSortOrderDateModified}';">Last Modified</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        AccountDA accountDA = new AccountDA();
                        List<Account> customerLists = accountDA.getAllCustomerRecord("R0003");
                        List<Account> searchRs = (List<Account>) session.getAttribute("searchCust"); 
                        List<Account> display = new ArrayList<Account>();

                        Account custList = null;
                        boolean found = false;

                        if(searchRs != null){
                            session.removeAttribute("searchCust");
                            display.addAll(searchRs);
                            found = true;
                        }else if(display != null){
                            display.addAll(customerLists);
                            found = true;
                        }

                        if(!found){ %>
                            <tr><td colspan="8" style="text-align: center;"><b>No Record Found</b></td></tr>                             
                    <%  }else{
                            for(int i = 0; i < display.size(); i++){
                                String dtModified = "-";
                                custList = display.get(i);

                                if(custList.getDateModified() != null){
                                    dtModified = custList.getDateModified().toString();
                                }
                        %>
                            <tr>
                                <td><%= i + 1 %></td>
                                <td style="font-size: 13px; color: gray; cursor: pointer;" onclick="location.href='./RetrieveCustomerRecord?selectedEmailAddress=<%= custList.getEmailAddress() %>';">
                                    <b style="font-size: 16px; color: black;"><%= custList.getName().toUpperCase() %></b><br/>
                                    <%= custList.getEmailAddress() %>
                                </td>
                                <td><%= custList.getIc() %></td>
                                <td><div class="long-details"><%= custList.getPassword() %></div></td>
                                <td><%= custList.getGender() %></td>
                                <td><div class="long-details"><%= custList.getAddress() %></div></td>
                                <td><%= custList.getContactNo() %></td>
                                <td><%= custList.getDateCreated() %></td>
                                <td><%= dtModified %></td>
                            </tr>
                        <%  }  }%>
                    </tbody>
                </table>
            </div>
            <div class="modal fade" id="info" tabindex="-1" aria-labelledby="infoLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                        <div class="modal-body">
                            <div id="modal_header">
                                <h3>View Info.</h3>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="email" maxlength="30" placeholder="abc@gmail.com" name="newemail" id="newemail" style="cursor: not-allowed;" value="${selectedCust.emailAddress}" readonly/>
                                <label for="newemail">Email Address</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" maxlength="50" placeholder="Lilian" name="newname" id="newname" value="${selectedCust.name}" readonly/>
                                <label for="newname">Name</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" maxlength="14" placeholder="000101-07-0123" name="newic" id="newic" value="${selectedCust.ic}" readonly/>
                                <label for="newic">IC</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" placeholder="Abcd1234" name="password" id="password" value="${selectedCust.password}" readonly/>
                                <label for="password">Password</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" placeholder="F" name="gender" id="gender" value="${selectedCust.gender}" readonly/>
                                <label for="gender">Gender</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="date" name="birthday" id="birthday" value="${selectedCust.birthDate}" readonly/>
                                <label for="birthday">Date of Birth</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" placeholder="1, Taman Sui, P.P" name="address" id="address" value="${selectedCust.address}" readonly/>
                                <label for="address">Address</label>
                            </div>
                            <br>
                            <div class="form-floating">
                                <input class="form-control" type="text" maxlength="14" placeholder="012-3456789" name="telNo" value="${selectedCust.contactNo}" id="telNo" pattern="[0-9]{3}-[0-9]{7,8}" readonly autofocus/>
                                <label for="telNo">Contact No</label>
                            </div>
                            <br/>    
                        </div>
                    </div>
                </div>
            </div>
            <br/>
            <input class="button" type="button" value="Print" onclick="printContent('data')" style="height:35px; width: 10%;"/>
            <input class="button" type="button" value="Export" onclick="location.href='./exportLists?page=CustList';" style="height:35px; width: 10%;"/>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script> 
            <%  
                if(session.getAttribute("viewCustModal") != null){  
                    session.removeAttribute("viewCustModal"); %>
                    $(document).ready(function(){
                        $('#info').modal('show');
                    });  
            <%  }  %>
        </script>
    </body>
</html>
