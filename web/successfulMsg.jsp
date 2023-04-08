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
                background-color: #34273b;
                padding-top: -15px;
                padding-left: 10px;
                padding-right: 30px;
                height: 440px;
                border-radius: 3px;
                margin-top: 80px;
        }
        
        .row{
                background-color: #4c4359;
                margin-left: 14px;
                padding-left: 20px;
                padding-right: 40px;
                margin-bottom: 15px;
                height: 360px;
                border-radius: 3px;
        }
        
        /* The Close Button (x) */
        .close {
          color: white;
          font-size: 35px;
          font-weight: bold;
          background: transparent;
          border: none;
          outline: none;
          padding-top: 2px;
          margin-left: 960px;
        }

        .close:hover{
          color: #9966ff;
          cursor: pointer;
        }
           
        </style>
    </head>
    
    <body>
                <div class="contentContainer1">
                    
                    <% String retrievedMsg = (String)session.getAttribute("successMsg"); 
                            String action = (String)session.getAttribute("actionType"); 
                     %>
                     
                     <% if (action.equals("movie")) {%>
                    <button onclick="location.href='AdminMovie.jsp'" class="close" title="Close Modal">&times;</button>
                    <% } else if (action.equals("movieSchedule")) {%>
                    <button onclick="location.href='AdminMovieSchedule.jsp'" class="close" title="Close Modal">&times;</button>
                    <% } else if (action.equals("actor")) {%>
                    <button onclick="location.href='AdminActorList.jsp'" class="close" title="Close Modal">&times;</button>
                    <% } %>
                <div class="row">
                 <div class="col1">
                    <img style="height: 185px; width: 185px; margin: 28px 10px 40px 365px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flat_tick_icon.svg/768px-Flat_tick_icon.svg.png" /><br/>
                    <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:white; letter-spacing: 8px; font-size: 45px; margin-top: -27px;">Successful !</h1><br/>
                    <p style="text-align: center; font-family: Times New Roman, Times, serif; font-size:20px; color: #e2d3e6; margin-top: -27px;"><%= retrievedMsg %></p>
                 </div>
                </div>
              </div>                    
        </div>
 
    </body>
</html>
