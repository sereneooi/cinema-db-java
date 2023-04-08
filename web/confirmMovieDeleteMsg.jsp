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
        
        input[type=submit]{
        position: relative;
        cursor: pointer;
        width: 140px;
        margin: 10px 42px;
        background-color:#b098b8;
        color: white;
        font: 13pt 'Times New Roman', Times, serif;
        padding: 6px 20px;
        outline: none;
        border: none;
        border-radius: 15px;
        box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
        transition: 0.2s;
        margin-left: 270px;
        margin-top: -120px;
      }
      
      .button{
        cursor: pointer;
        position: relative;
        width: 140px;
        margin: 10px 42px;
        background-color:#b098b8;
        color: white;
        font: 13pt 'Times New Roman', Times, serif;
        padding: 6px 20px;
        outline: none;
        border: none;
        border-radius: 15px;
        box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
        transition: 0.2s;
        margin-left: 530px;
        margin-top: -10px;
      }

        input[type=submit]:hover{
            background-color:#75318c;
        }
        
        .button:hover{
            background-color:#75318c;
        }
        
        .inline {
            display: inline-block; 
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
                        location='./AdminMovie.jsp';
                    </script>
                    <%
                }
            }
        %>
                <div class="contentContainer1">
                    <button onclick="location.href='AdminMovie.jsp'" class="close" title="Close Modal">&times;</button>
                <div class="row">
                     
                     <% 
                         String movieID =  request.getParameter("movieIDforDelete");
                       %>
                     
                    <img style="height: 180px; width: 180px; margin: 28px 10px 40px 365px;" src="https://www.pinclipart.com/picdir/big/559-5592544_question-mark-circle-icon-clipart.png" /><br/>
                    <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:white; letter-spacing: 8px; font-size: 45px; margin-top: -27px; margin-bottom: 5px;">CONFIRM DELETE ?</h1><br/>
                    
                        <button onclick="location.href='AdminMovie.jsp'" class="button" type="button" >No</button>
                    
                        <form action="MovieDelete" method="get" style="margin-top: -34px;">
                                          <input type="hidden"  name="movieIDforDeletion"  value="<%= movieID %>">
                                          <input type="submit" class="actionBtn" value="Yes">                   
                       </form>
                        
                </div>                  
        </div>
 
    </body>
</html>


