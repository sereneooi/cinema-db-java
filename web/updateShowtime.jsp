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
                height: 585px;
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
                height: 380px;
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
        
        .showtimes{
            width: 140px; 
            margin-left:-5px;
            margin-bottom: 15px;
            display: flex; 
            flex-wrap: nowrap;
        }
        
        .button{
            color:rgb(220, 205, 224);
            margin-left: 13px;
            padding-left: 5px;
            padding-right: 5px;
            margin-left: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            width: 165px;
            height: 46px;
            color:white;
            background: linear-gradient(to bottom, rgb(212, 176, 182), rgb(212, 131, 143));
            border: 2px solid #400e2c;
           
        }

        .button:hover{
            border: 2px solid #d4c1e0;
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
        }
        
        .button:focus{
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
            border: none;
        }
      
       input[type=submit], input[type=reset] {
        position: absolute;
            cursor: pointer;
            width: 140px;
            margin: 30px 42px;
            background-color:#c48d97;
            color: white;
            font: 13pt 'Times New Roman', Times, serif;
            padding: 6px 20px;
            outline: none;
            border: none;
            border-radius: 15px;
            box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
            transition: 0.2s;
            margin-left: 780px;
            margin-top: 1px;
      }
      
      input[type=submit]:hover, input[type=reset]:hover {
         background-color:#997799;
        }
        

        </style>
    </head>
    
    <body>
        <% 
            Account currentUser = (Account) session.getAttribute("currentUser");
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
                        location='./fnb.jsp';
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
                      
                      <h1 style="text-align: center; font-family: Georgia, 'Times New Roman', Times, serif;  font-size: 18px; color:white; margin-top: 18px; background-color: #c48d97;
                          margin-bottom: 8px; letter-spacing: 2px; padding-top: 5px; padding-bottom: 5px;"><u>MOVIE SHOWTIMES MODIFICATION</u></h1>
                        
                          <form action="GetUpdatedSchedule" method="get">
                        <%      
                                String oldShowtime =  request.getParameter("showtimeToRetrieve");
                                String movieScheduleID = request.getParameter("movieScheduleIDforUpdate");
                                String movieID = request.getParameter("movieIDforUpdate");
                                String movieName = request.getParameter("movieNameforUpdate");
                                    
                        %>  
                        <p><label class="large-label">Movie Schedule ID :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <input type="text" name="movieScheduleIDToUpdate" size="10" value="<%= movieScheduleID %>" readonly /></p>
                        
                        <p><label class="large-label" style="margin-right:77px;">Movie Name :&nbsp;</label>
                                <input type="text" name="movieNameToUpdate" size="10" value="<%= movieName %>" readonly /></p>
                        
                        <p><label class="large-label">Old Movie Showtimes :&nbsp;&nbsp;</label>
                            <input type="text" name="oldShowtimes" size="10" value="<%= oldShowtime %>" readonly /></p>
                      
                        <label class="large-label" for="dateAvailable">New Movie Showtimes :&nbsp;</label>
                                <input type="datetime-local" id="dateAvailable" name="newShowtimes" required><br>
                                
                                <!-- Confirm button -->
                                <input type="hidden"  name="movieIDforUpdate"  value="<%= movieID %>">
                                <input type="submit" class="actionBtn"value="Confirm"><br/>
                  </form> 

                  </div>
                </div>
              </div>

                                
        </div>
 
    </body>
</html>
