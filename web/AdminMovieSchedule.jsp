<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*;"%>
<%@page import="model.Movie, model.MovieDA, java.util.List, java.util.ArrayList"%>

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
                width: 100%;
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
                font-size: 17px;
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
                font-size: 16px;
                opacity: 0.6;
                transition: 0.5s;  
                font-size: 17px;
                font-family: "Times New Roman", Times, serif;
              }
              
              .actionBtn p{
                  text-align: center;
              }

              .actionBtn:hover {
                opacity: 1.0;
                color: white;
                background: linear-gradient(to bottom, rgb(212, 158, 188), rgb(156, 122, 175));
                box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
              }
              
              .search-container {
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
                                        
              <%       String nowShowing = "MS001";
                           MovieDA movieDA = new MovieDA();
                           ArrayList<Movie> nowShowingList = new ArrayList<Movie>();
                           nowShowingList = movieDA.getStatusRecord(nowShowing);
                %>
           
                <div class="contentContainer">
                <div class="row">
                  <div class="col">
                      <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:rgb(63, 30, 99); padding-top: 20px;"><u>Movie Schedule Management</u></h1></div>
                  <div class="col">
                      <button onclick="location.href='addMovieSchedule.jsp'" class="actionBtn" type="button">Add<br/>Movie Schedule</button>
                      
                    <div class="search-container">
                        <form action="GetAdminSearchRecord">
                          <input type="text" placeholder="Search Movie ID" name="searchMovieSchedule" required>
                          <input type="hidden" name="action" value="movieSchedule">
                          <input type="image" src="search.png" alt="Submit" style="width:15px; height:15px; margin-top: 8px; margin-left: 5px;">
                        </form>
                      </div>
                  </div>
                    <p style="text-align: right; padding-right: 5px;">Record Fetched: <%= nowShowingList.size() %> rows </p><br/>
                  <div class="col">
                      <table style="width:500; table-layout: fixed;">
                            <tr>
                              <th style="width:6%;">Movie ID</th>
                              <th style="width:12%;">Movie Name</th>
                              <th style="width:12%;">Movie Poster</th>
                              <th style="width:17%;">Movie Showtimes (Date - Time)</th>
                              <th style="width:14%; text-align:center;">Actions</th>
                            </tr>
                            <% for(int i = 0; i< nowShowingList.size(); i++){ %>
                            <tr>
                              <td width="2%"><%= nowShowingList.get(i).getMovieID() %></td>
                              <td width="2%"><%= nowShowingList.get(i).getMovieName() %></td>
                              <td width="6%"><img style="height: 230px; width: 160px;" src="<%= nowShowingList.get(i).getMoviePoster() %>"></td>
                              <td width="10%" style="text-align:center;">
                                    <%
                                            MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
                                            ArrayList<MovieSchedule> showtimesList = new ArrayList<MovieSchedule>();
                                            showtimesList = movieScheduleDA.displayShowtimeRecord(nowShowingList.get(i).getMovieID());
                                    %>       
                                            <% for(int j = 0; j<showtimesList.size(); j++){  %>
                                                  <%= showtimesList.get(j).getStrShowDateTime() %><br/><br/>
                                             <% } %>
                                             <br/>
                              </td>
                              <td width="10%"><form action="updateSchedule.jsp" method="post">
                                                                         <input type="hidden"  name="movieIDforUpdate"  value="<%= nowShowingList.get(i).getMovieID() %>">
                                                                         <input type="hidden"  name="movieNameforUpdate"  value="<%= nowShowingList.get(i).getMovieName() %>">
                                                                         <input type="submit" class="actionBtn"value="Update"><br/>
                                                           </form>
                                                           <form action="deleteSchedule.jsp" method="post">
                                                                        <input type="hidden"  name="movieIDforDelete"  value="<%= nowShowingList.get(i).getMovieID() %>">
                                                                        <input type="hidden"  name="movieNameforDelete"  value="<%= nowShowingList.get(i).getMovieName() %>">
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
