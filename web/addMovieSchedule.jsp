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
                background-color: #c0b1cc;
                margin-top: 60px;
                margin-left: 14px;
                padding-left: 10px;
                padding-right: 30px;
                height: 360px;
                margin-bottom: 20px;
                border-radius: 25px;
                box-shadow: 10px 12px #efe6fc;
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
                <div class="contentContainer1">
                <div class="row">
                 <div class="col1">
                    <a href="index.html"><img style="height: 80px; width: 80px; margin-top: 14px; margin-left: 20px;" src="logo.png" alt="CC Cinema Logo"></a>
                    <a href="index.html"><p><span style="margin-top: -43px; padding-bottom: 30px; margin-left: 20px;" class="title">CC CINEMA</span></a></p>
                    <h1 style="text-align: center; font-family: 'mahelisa'; font-size: 25px; color:white; margin-top: -90px; margin-bottom: 30px; letter-spacing: 8px; font-size: 45px;"><u>ADD MOVIE SHOWTIMES</u></h1>
                 </div>
                </div>
                    
                  <div class="contentContainer2">
                  <div class="col2" style="padding-top: 7px;">
                      <form action="GetNewSchedule" method="get">
                            <% MovieSchedule movieSchedule = new MovieSchedule(); %>
                            <p><label class="large-label">Movie Schedule ID :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <input type="text" name="newMovieScheduleID" size="10" value="<%= movieSchedule.nextMovieScheduleID() %>" readonly /></p>
                            
                            <!--To load MovieName of NOW SHOWING movie option from database -->
                            <% String movieStatus = "MS001";
                                  MovieDA movieDA = new MovieDA();
                                  ArrayList<Movie> movieList = new ArrayList<Movie>();
                                  movieList = movieDA.getStatusRecord(movieStatus) ; %>
                            <p><label class="large-label">Now Showing Movie : &nbsp;&nbsp;</label>
                                <select class="select" name="scheduleMovieID" style="width: 40%; padding: 8px 15px; margin: 8px 0; box-sizing: border-box; border: 2px solid black; border-radius: 3px;" required>
                                    <% for(int j= 0; j< movieList.size(); j++){ %>
                                    <option style="width: 40%; padding: 8px 15px; margin: 8px 0;" value = "<%= movieList.get(j).getMovieID() %>"><%= movieList.get(j).getMovieName() %></option>
                                     <% } %>
                                </select></p>
                                
                                <label class="large-label" for="dateAvailable" style="padding-right: 33px;">Movie Showtimes :</label>
                                <input type="datetime-local" id="dateAvailable" name="dateAvailable"><br>
                      
                            
                            <!--To load Theatre option from database -->
                            <% TheatreDA theatreDA = new TheatreDA();
                                  List<Theatre> theatreList = theatreDA.retrieveAllRecord(); %>
                            <p><label class="large-label" style="padding-right: 110px;">Theatre :</label>
                                <select class="select" name="scheduledTheatre" style="width: 40%; padding: 8px 15px; margin: 8px 0; box-sizing: border-box; border: 2px solid black; border-radius: 3px;" required>
                                    <% for(int j= 0; j<  theatreList.size(); j++){ %>
                                    <option style="width: 40%; padding: 8px 15px; margin: 8px 0;" value = "<%=  theatreList.get(j).getTheatreID() %>"><%= theatreList.get(j).getTheatreDesc() %></option>
                                     <% } %>
                                </select></p>
                            
                            <p><input type="submit" value="Submit" />
                                <input type="reset" value="Reset" /></p>
                        </form>
                  </div>
                </div>
              </div>

                                
        </div>
 
    </body>
</html>
