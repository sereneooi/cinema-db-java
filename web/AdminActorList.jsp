<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*;"%>
<%@page import="model.Actor, model.ActorDA, java.util.List, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
    <head>
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <style>
            .contentContainer{
                margin-left: 300px;
                padding-left: 10px;
                padding-right: 30px;
            }
            
            .col table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                margin-left: 110px;
                width: 80%;
              }
              
              .col th{
                  background-color: #7c698a;
                  border: 2px solid black;
                  text-align: left;
                  padding: 8px;
              }

              .col td {
                border: 2px solid black;
                text-align: left;
                padding: 8px;
                font-size: 18px;
                font-family: "Times New Roman", Times, serif;
              }

              tr:nth-child(even) {
                background-color: #ded5eb;
              }
              
              .actionBtn {
                text-align: center;
                width: 160px;
                margin: 10px 15px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 3px;
                padding-bottom: 6px;
                line-break: 20px;
                background: linear-gradient(to bottom, rgb(192, 174, 207), rgb(85, 71, 97));
                box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
                border: 2px solid black;
                border-radius: 4px;
                color: white;
                text-align: center;
                font-size: 18px;
                opacity: 0.6;
                transition: 0.5s;  
                font-family: "Times New Roman", Times, serif;
              }
              
              .actionBtn p{
                  text-align: center;
                  font-family: "Times New Roman", Times, serif;
              }

              .actionBtn:hover {
                opacity: 1.0;
                color: white;
                background: linear-gradient(to bottom, rgb(212, 158, 188), rgb(156, 122, 175));
                box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
              }
             
              .search-container {
                  padding-right: 85px;
                  float: right;
              }

              input[type=text] {
                  padding: 6px;
                  margin-top: 8px;
                  font-size: 15px;
                  border: 2px solid black;
                  border-radius: 5px;
              }

              .search-container button {
                  float: right;
                  padding: 6px 10px;
                  width: 30px;
                  height: 32px;
                  margin-top: 8px;
                  margin-right: 16px;
                  background: #ddd;
                  font-size: 17px;
                  border: 2px solid black;
                  cursor: pointer;
              }

              .search-container button:hover {
                  background: #ded5eb;
              }
            
            </style>
    </head>
    
    <body>
        <%@include file="AdminLayout.jsp"%>
        
              <% 
                       ActorDA actorDA = new ActorDA();
                       ArrayList<Actor>actorListing = new ArrayList<Actor>();
                       actorListing = actorDA. getActorRecord();
               %>
           
                <div class="contentContainer">
                <div class="row">
                  <div class="col">
                      <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:rgb(63, 30, 99); padding-top: 20px;"><u>Actor Management</u></h1></div>
                  <div class="col">
                      <button onclick="location.href='addActor.jsp'" class="actionBtn" type="button" style="margin-left: 124px; margin-top: 25px;">Add New Actor</button>
                  
                      <div class="search-container">
                        <form action="GetAdminSearchRecord">
                          <input type="text" placeholder="Search Actor ID" name="searchActor" required>
                          <input type="hidden" name="action" value="actor">
                          <input type="image" src="search.png" alt="Submit" style="width:15px; height:15px; margin-top: 8px; margin-left: 5px;">
                        </form>
                      </div>
                  </div>
                    <p style="text-align: right; padding-right: 85px;">Record Fetched: <%= actorListing.size() %> rows </p><br/>
                  <div class="col">
                      <table style="width:300; table-layout: fixed;">
                            <tr>
                              <th style="width:7%;">Actor ID</th>
                              <th style="width:10%;">Actor Name</th>
                              <th style="width:7%; text-align: center;">Actions</th>
                            </tr>
                            <% for(int i = 0; i< actorListing.size(); i++){ %>
                            <tr>
                              <td><%= actorListing.get(i).getActorID() %></td>
                              <td><%= actorListing.get(i).getActorName()%></td>
                              <td style="margin-left: 50px;">
                                  <form action="updateActor.jsp" method="post">
                                                                         <input type="hidden"  name="actorIDforUpdate"  value="<%= actorListing.get(i).getActorID() %>">
                                                                         <input type="hidden"  name="actorNameforUpdate"  value="<%= actorListing.get(i).getActorName() %>">
                                                                         <input type="submit" class="actionBtn"value="Update"><br/>
                                  </form>
                                                           
                                  <form action="confirmActorDeleteMsg.jsp" method="post">
                                                                        <input type="hidden"  name="actorIDforDelete"  value="<%= actorListing.get(i).getActorID() %>">
                                                                       <input type="submit" class="actionBtn"value="Delete"><br/>
                                  </form>   
                              </td>
                            </tr>
                            <% } %>
                          </table>
                  </div>
                  <div class="col" style="height: 50px;"></div>
                </div>
                <div class="row">
                </div>
              </div>

    </body>
</html>
