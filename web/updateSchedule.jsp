<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*;"%>
<%@page import="model.Movie, model.MovieDA"%>
<%@page import="model.Language, model.LanguageDA" %>
<%@page import="model.MovieType, model.MovieTypeDA" %>
<%@page import="model.MovieStatus, model.MovieStatusDA" %>
<%@page import="model.MovieRestriction, model.MovieRestrictionDA" %>
<%@page import="model.Actor, model.ActorDA" %>
<%@page import="java.util.List, java.util.ArrayList" %>
<%@page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<jsp:useBean id="currentUser" scope="session" class="model.Account"/>

<!DOCTYPE html>
<html>
    <head>
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <style>
            html{
    background-image: url(background.png);

        }
        
        @font-face {
        font-family: 'mahelisa';
        src: url(mahelisa.ttf);
        }

        body {
            background-color: #a1a1a1;
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
        }

        h1{
            color: rgb(153, 102, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 30px;
        }

        a{
            text-decoration: none;
            color: rgb(153, 102, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            text-align: center;
            display: inline-block;
        }

        a:active{
            color: rgb(179, 179, 255);
        }
        
        .contentContainer1{
                background-color: #4c4359;
                padding-left: 10px;
                padding-right: 30px;
                height: 575px;
                margin-top: 20px;
                margin-bottom: 20px;
                border-radius: 25px;
        }
        
        .contentContainer2{
                background-color: #cfb4bf;
                margin-top: 60px;
                margin-left: 14px;
                padding-left: 10px;
                padding-right: 30px;
                height: 360px;
                margin-bottom: 20px;
                border-radius: 25px;
                box-shadow: 10px 12px #f2e1e4;
        }
        
        fieldset {
        background-color: #f2e1e4;
        margin-top: 17px;
        font-size: 10px;
        font: bold 1rem sans-serif;
        height: 160px;
        border: 2px solid black;
      }
      
        legend {
        background-color: #f2e1e4;
        border-radius: 10px;
        color: black;
        padding: 5px 10px;
        margin-bottom: 10px;
        }
       

        .large-label {
            display: inline-block;
            font-size: 10px;
            font: bold 1rem sans-serif;
            margin-bottom: 0.5rem;
            padding-left:10px;
      }
            
        input[type=text] {
            width: 40%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }

        input[type=datetime-local] {
            width: 40%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        .showtimes {
            width: 140px;
            margin-left: -18px;
            margin-bottom: 15px;
            display: contents;
            flex-wrap: nowrap;
        }
        
        .showtimes input[type=submit]{
            color:rgb(220, 205, 224);
            margin-left: 13px;
            padding-left: 4px;
            padding-right: 4px;
            margin-left: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            width: 165px;
            height: 46px;
            color:white;
            background: linear-gradient(to bottom, rgb(212, 176, 182), rgb(212, 131, 143));
            border: 2px solid #400e2c;
           
        }

        .showtimes input[type=submit]:hover{
            border: 2px solid #d4c1e0!important;
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121))!important;
        }
        
        .showtimes input[type=submit]:focus{
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
            border: none;
        }
      
       input[type=submit], input[type=reset] {
        background: linear-gradient(to bottom, rgb(187, 166, 222), rgb(69, 28, 138));
        border: 1.5px solid #603f8f;
        border-radius: 5px;
        color: white;
        padding: 12px 28px;
        text-decoration: none;
        margin: 4px 10px;
        cursor: pointer;
      }
      
      input[type=submit]:hover, input[type=reset]:hover {
         opacity: 1.0;
         color:white;
         background: linear-gradient(to bottom, rgb(212, 158, 188), rgb(156, 122, 175));
        }
        

        </style>
    </head>
    
    <body>
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
                        location='./AdminMovieSchedule.jsp';
                    </script>
                    <%
                }
            }
        %>
                <div class="contentContainer1">
                <div class="row">
                 <div class="col1">
                    <a href="index.html"><img style="height: 80px; width: 80px; margin-top: 14px; margin-left: 20px;" src="logo.png" alt="CC Cinema Logo"></a>
                    <a href="index.html"><p><span style="margin-top: -43px; padding-bottom: 30px; margin-left: 20px;" class="title">CC CINEMA</span></a></p>
                    <h1 style="text-align: center; font-family: Georgia, 'Times New Roman', Times, serif; font-size: 25px; color:white; margin-top: -90px; margin-bottom: 30px; letter-spacing: 3px; font-size: 35px;"><u>UPDATE  MOVIE  SHOWTIMES</u></h1>
                 </div>
                </div>
                    
                  <div class="contentContainer2">
                  <div class="col2" style="padding-top: 7px;">
                        
                        <%      
                                String movieID =  request.getParameter("movieIDforUpdate");
                                String movieName = request.getParameter("movieNameforUpdate");
                                MovieScheduleDA movieScheduleDA = new MovieScheduleDA(); 
                                
                                //create arrayList to store object returned from MovieScheduleDA
                                ArrayList<MovieSchedule> scheduledShowTime = new ArrayList<MovieSchedule>();
                                scheduledShowTime = movieScheduleDA.displayShowtimeRecord(movieID);        
                        %>  
                        
                        <p><label class="large-label">Movie ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <input type="text" name="movieIDToUpdate" size="10" value="<%= movieID %>" readonly /></p>
                        
                        <p><label class="large-label">Movie Name:&nbsp;</label>
                                <input type="text" name="movieIDToUpdate" size="10" value="<%= movieName %>" readonly /></p>
                      
               <fieldset>
                   <legend>Select Movie Schedule to be updated:</legend>
                   
                      <div id="movie-showtimes">
                        <div class="showtimes">     
                            <!-- Choose update which showtime to a new showtime -->                   
                            <% for(int j= 0; j< scheduledShowTime.size(); j++){ %>
                            <div style=" position: relative;display: flex; float: left;">
                            <form action="updateShowtime.jsp" method="post">
                                       <input type="hidden"  name="movieScheduleIDforUpdate"  value="<%= scheduledShowTime.get(j).getMovieScheduleID()  %>">
                                       <input type="hidden"  name="movieIDforUpdate"  value="<%= movieID %>">
                                       <input type="hidden"  name="movieNameforUpdate"  value="<%= movieName %>">
                                        <input type="hidden"  name="showtimeToRetrieve"  value="<%= scheduledShowTime.get(j).getShowDate() + " " + scheduledShowTime.get(j).getShowTime() %>">
                                        <input type="submit" class="moviedate" style="margin-right:-3px; border: 2px solid #400e2c;  color:white; background: linear-gradient(to bottom, rgb(212, 176, 182), rgb(212, 131, 143));" value="<%= scheduledShowTime.get(j).getShowDate() + " - " + scheduledShowTime.get(j).getShowTime() %>">
                            
                            </form>
                          </div>
                         <% } %>
                        </div>
                        
                      </div>
              </fieldset>

                  </div>
                </div>
              </div>

                                
        </div>
 
    </body>
</html>

