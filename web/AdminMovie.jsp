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
                width: 100px;
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
                font-size: 17px;
                opacity: 0.6;
                transition: 0.5s;  
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
        
              <% 
                       MovieDA movieDA = new MovieDA();
                       ArrayList<Movie>movieListing = new ArrayList<Movie>();
                       movieListing = movieDA.displayMovieRecord();
               %>
           
                <div class="contentContainer">
                <div class="row">
                  <div class="col">
                      <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:rgb(63, 30, 99); padding-top: 20px;"><u>Movie Management</u></h1></div>
                  <div class="col">
                      <button onclick="location.href='addMovie.jsp'" class="actionBtn" type="button">Add Movie</button>
                  
                      <div class="search-container">
                        <form action="GetAdminSearchRecord">
                          <input type="text" placeholder="Search Movie ID" name="searchMovie" required>
                          <input type="hidden" name="action" value="movie">
                          <input type="image" src="search.png" alt="Submit" style="width:15px; height:15px; margin-top: 8px; margin-left: 5px;">
                        </form>
                      </div>
                  </div>
                    <p style="text-align: right; padding-right: 5px;">Record Fetched: <%= movieListing.size() %> rows </p><br/>
                  <div class="col">
                      <table style="width:500; table-layout: fixed;">
                            <tr>
                              <th style="width:6%;">Movie ID</th>
                              <th style="width:10%;">Movie Name</th>
                              <th style="width:14%;">Movie Poster</th>
                              <th style="width:16%;">Casts</th>
                              
                              <th style="width:8%;">Movie Type</th>
                              <th style="width:8%;">Movie Status</th>
                              <th style="width:8%;">Language</th>
                              <th style="width:13%;">Actions</th>
                            </tr>
                            <% for(int i = 0; i< movieListing.size(); i++){ %>
                            <tr>
                              <td><%= movieListing.get(i).getMovieID() %></td>
                              <td><%= movieListing.get(i).getMovieName() %></td>
                              <td><img style="height: 170px; width: 120px;" src="<%= movieListing.get(i).getMoviePoster() %>"></td>
                              <td>
                                  <!--Display Actor Name List -->
                               <% CastListDA castlistDA = new CastListDA();
                                ArrayList<CastList> actorList = new ArrayList<CastList>();
                                actorList = castlistDA.getCastListRecord(movieListing.get(i).getMovieID()); 
                                   for(int j = 0; j< actorList.size(); j++){ %>
                                <%= j+1 + ". "%><%= actorList.get(j).getActor().getActorName() %><br/><br/>
                                <% } %>
                              </td>
                              <!-- Call function to format the date -->
                              
                              <td><%= movieListing.get(i).getMovieType().getMovieTypeDesc() %></td>
                              <td><%= movieListing.get(i).getMovieStatus().getMovieStatusDesc() %></td>
                              <td><%= movieListing.get(i).getLanguage().getLanguageDesc() %></td>
                              <td><form action="GetUpdatedMovie" method="post">
                                                                         <input type="hidden"  name="movieIDforUpdate"  value="<%= movieListing.get(i).getMovieID() %>">
                                                                         <input type="hidden"  name="movieNameforUpdate"  value="<%= movieListing.get(i).getMovieName() %>">
                                                                         <input type="hidden"  name="movieTrailerforUpdate"  value="<%= movieListing.get(i).getMovieTrailer() %>">
                                                                         <input type="hidden"  name="posterURLforUpdate"  value="<%= movieListing.get(i).getMoviePoster() %>">
                                                                         <input type="hidden"  name="adsURLforUpdate"  value="<%= movieListing.get(i).getMovieAdsPoster() %>">
                                                                         <input type="hidden"  name="synopsisForUpdate"  value="<%= movieListing.get(i).getSynopsis() %>">
                                                                         <input type="submit" class="actionBtn"value="Update"><br/>
                                                           </form>
                                                           <form action="MovieRetrieve" method="get">
                                                                       <input type="hidden"  name="movieIDforRetrieve"  value="<%= movieListing.get(i).getMovieID() %>">
                                                                       <input type="submit" class="actionBtn"value="View"><br/>
                                                           </form>
                                                           <form action="confirmMovieDeleteMsg.jsp" method="post">
                                                                        <input type="hidden"  name="movieIDforDelete"  value="<%= movieListing.get(i).getMovieID() %>">
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