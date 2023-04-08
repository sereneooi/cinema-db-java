<%@page import="model.Movie, model.MovieDA, java.util.List, java.util.ArrayList"%>
<%@page import="model.MovieSchedule, model.MovieScheduleDA"%>
<%@page import="java.text.SimpleDateFormat, java.util.Date"%>
<%@page import="java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html class="background">
    <head>
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="Homestyle.css" rel="stylesheet" type="text/css" />
    <script src="userinfo.js"></script>
    <%@include file="checkCustomerAccess.jsp"%>
    <style>  
    .dropdown-content a:hover, .dropdown-content li:hover{
    cursor: pointer;
    }
    
    @font-face {
      font-family: 'mahelisa';
      src: url(mahelisa.ttf);
      }
      
      .mainTitle h1{
            margin-left: 0px;
            padding: 8px;
            text-align: center;
            letter-spacing: 3px;
            font-family: 'mahelisa';
            font-size: 35px;
            background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100));
            color:rgb(63, 30, 99);
      }
      
        .showtimes{
            width: 140px; 
            margin-left: 23px;
            margin-bottom: 15px;
            display: flex; 
            flex-wrap: nowrap;
        } 

        input[type=submit]{
            color:rgb(220, 205, 224);
            margin-left: 7px;
            padding-left: 2px;
            padding-right: 2px;
            margin-bottom: 20px;
            border-radius: 10px;
            width: 140px;
            height: 50px;
            color:rgb(221, 200, 240);
            background: linear-gradient(to bottom, rgb(70, 9, 128), rgb(142, 109, 161));
        }

        input[type=submit]:hover{
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
            border: 2px solid #d4c1e0;
        }
        
        input[type=submit]:focus{
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
            border: none;
        }

        .moviePic{
            margin-left: 6px;
            margin-right: 15px;
            padding-left: 8px;
            padding-right: 8px;
            border: 2px solid rgb(164, 135, 190);
        }

        .moviePic:hover{
          border: 2px solid yellow;
        }

        .movieDate1:nth-child(even){
            position: absolute;
            background-color: black;
            margin-bottom: 5px;
            margin-left: 267px;
            margin-top: -353px;
            padding-left: 25px;
            padding-top: 0px;
            padding-bottom: 2px;
            width: 708px;
            height: 340px;
        }

        .movieDate1:nth-child(odd){
            position: absolute;
            background-color: rgb(70, 53, 80);
            margin-bottom: 5px;
            margin-left: 267px;
            margin-top: -353px;
            padding-left: 25px;
            padding-top: 0px;
            padding-bottom: 2px;
            width: 708px;
            height: 340px;
        }
        
        .movieDate1:hover{
          border: 2px solid yellow;
        }

        label{
            background-color: rgb(68, 36, 85);
            color:rgb(220, 205, 224);
            border-radius: 5px;
            padding-left: 20px;
            padding-right: 20px;
            padding-top: 3px;
            padding-bottom: 3px;
            margin-top:20px;
            margin-bottom: 20px;
            width:20px;
        }
        button{
          background: linear-gradient(to bottom, rgb(212, 191, 218), rgb(105, 80, 119));
          font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            margin-bottom: 20px;
            margin-left: 10px;
            margin-right:15px;
            border-radius: 5px;
            width:19%;
            height: 80%;
        }

        button:hover{
          background: linear-gradient(to bottom, rgb(143, 123, 180), rgb(118, 72, 136));
          cursor: pointer;
        }
        
        .adsPoster img{
            border-radius: 5px;
            box-shadow: 0 4px 8px 0 rgb(0 0 0 / 20%), 0 6px 20px 0 rgb(0 0 0 / 19%);
        }
        
        .dateSection{
            padding-top:20px;
            margin-top: -27px;
            margin-bottom: 15px;
            background-color: #897e91;
            box-shadow: 2px 2px 25px #8b7a96;
        }
        
        .searchDate{
            padding-bottom: 17px;
        }
        
        .searchDate input[type=image]{
            padding-left: 7px;
        }
        
        input[type=date] {
            width: 30%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        .getInfoBtn input[type=submit]{
            color:white;
            margin-top: -220px;
            margin-left: 577px;
            padding-left: 2px;
            padding-right: 2px;
            border-radius: 10px;
            width: 130px;
            height: 40px;
            color:rgb(221, 200, 240);
            background: linear-gradient(to bottom, rgb(171, 152, 184), rgb(91, 64, 110));
        }
       
        .getInfoBtn input[type=submit]:hover{
            background: linear-gradient(to bottom, rgb(196, 139, 179), rgb(108, 87, 121));
            border: 2px solid black;
        }
        
    </style>
    <script type="text/javascript">
        function goToNewPage()
        {
            var list = document.getElementById("movieinfo");
            if(list.selectedIndex!=0)
            //window.open(url , target)
          location.href(list.thisvalue);
        }
    </script>   
</head>

<body onload="displayEmail();">
    <%@include file="header.jsp"%>
    <section>
        
      <div class="mainTitle">
      <h1>~~~~~~~~~~~~~~~~B O O K   N O W~~~~~~~~~~~~~~~</h1>
      </div>
        
        <div class="dateSection">
        <!-- Get Today's Date -->
            <%  Movie movie = new Movie();
                    //String todayDate = "2022-04-14"; 
                    LocalDate tdyDate = java.time.LocalDate.now();
                    String todayDate = tdyDate.toString();
                    Date dateToday=new SimpleDateFormat("yyyy-MM-dd").parse(todayDate);
            %>    
            
            <div class="searchDate">
        <form action="GetMovieSchedule" method="get">
                <label style="background-color:#897e91; color:white; padding-left: 35px; padding-top: 21px; font-family: Georgia, 'Times New Roman', Times, serif; font-size: 19px;">Search Date:</label>
                <input type="date" id="dateToSearch" name="dateToSearch" min="<%= tdyDate %>" required>
                <input type="hidden" name="dateAction" value="dateFrmSearch"/>
                <input type="image" src="search.png" alt="Submit" style="width:16px; height:16px;">
        </form>
            </div>
        
    <div id="movie-showtimes">
        <div class="showtimes">     
            <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<%= todayDate %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" style="margin-right:-3px;" value="<%= " Today - "%><%= movie.dateFormatter(dateToday) %>"><br/>
            </form>
        <div class="showtimes">
            <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<% String nxtDate = movie.dateIncrement(todayDate); %><%= nxtDate %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" value="<%= movie.getDayOfWeek(nxtDate) + " - "%><%= movie.dateFormatter(nxtDate) %>"><br/>
            </form>
        </div>
        <div class="showtimes">
          <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<% String nxtDate1 = movie.dateIncrement(nxtDate); %><%= nxtDate1 %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" value="<%= movie.getDayOfWeek(nxtDate1) + " - "%><%= movie.dateFormatter(nxtDate1) %>"><br/>
            </form>
        </div>
        <div class="showtimes">
            <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<% String nxtDate2 = movie.dateIncrement(nxtDate1); %><%= nxtDate2 %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" value="<%= movie.getDayOfWeek(nxtDate2) + " - "%><%= movie.dateFormatter(nxtDate2) %>"><br/>
            </form>
        </div>
        <div class="showtimes">
           <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<% String nxtDate3 = movie.dateIncrement(nxtDate2); %><%= nxtDate3 %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" value="<%= movie.getDayOfWeek(nxtDate3) + " - "%><%= movie.dateFormatter(nxtDate3) %>"><br/>
            </form>
        </div>
        <div class="showtimes">
           <form action="GetMovieSchedule" method="get">
                        <input type="hidden"  name="dateToRetrieve"  value="<% String nxtDate4 = movie.dateIncrement(nxtDate3); %><%= nxtDate4 %>">
                        <input type="hidden" name="dateAction" value="dateFrmSelect"/>
                        <input type="submit" class="moviedate" value="<%= movie.getDayOfWeek(nxtDate4) + " - "%><%= movie.dateFormatter(nxtDate4) %>"><br/>
            </form>
        </div>
        </div>
      </div>
            </div>
            
            <h1 style="font-family: mahelisa; font-size:65px; text-align: center; line-height: 0%; text-shadow: 15px 20px 2px black; line-spacing: 30px; padding-top: 50px; margin-left: 2px; padding-bottom: 14px;"><sup>A V A I L A B L E &nbsp;&nbsp;&nbsp;M O V I E S</sup><span style="color:#e2cef0;">&nbsp;&nbsp; T H I S    W E E K</span></h1>
       
      <div id="movie1-showtimes"></div>
      <%  
               MovieScheduleDA movieScheduleDA = new MovieScheduleDA(); 
               ArrayList<Movie> movieShowtimeList = new ArrayList<Movie>();
               movieShowtimeList = movieScheduleDA.getScheduleBetweenTwoDate(todayDate, nxtDate4);
        %>
        
        <% for(int i=0; i<movieShowtimeList.size(); i++){ %>
      
      <div class="moviePic">
          <a target="_self" href="<%= movieShowtimeList.get(i).getMoviePoster() %>" ><img src="<%= movieShowtimeList.get(i).getMoviePoster() %>" width="240px" height="350px" id="movie1" /></a>
      </div>
      
     <div class="movieDate1">
        <h1 style="font-family: Georgia, 'Times New Roman', Times, serif; font-size: 19pt; margin: 0px;"><%= movieShowtimeList.get(i).getMovieName() %></h1>
        <p style="margin-top:2px; font-size: 14px; color:white;">1hour 38minutes</p><br/>
          <input id="time1" type="text" hidden/>
          <input id="movie1" type="text" hidden>
            <p style="color: white; padding-right: 9px; font-size: 16px; margin-top: -20px;"><%= movieShowtimeList.get(i).getSynopsis() %></p>
            <div class = "adsPoster">
                <img src="<%= movieShowtimeList.get(i).getMovieAdsPoster() %>" width="470px" height="205px" id="movie1" />
            </div>
            <div class="getInfoBtn" style="margin:-20px;">
                 <form action="GetMovieInfo" method="get">
                        <input type="hidden"  name="movieID"  value="<%= movieShowtimeList.get(i).getMovieID() %>">
                        <input type="hidden"  name="movieStatus"  value="<%= "MS001" %>">
                        <input type="submit" value="Movie Info">
                 </form>
            </div>
             <br/>
    </div>
            <br/><br/>
             
        <br/>
      <% } %>
    </section>

    <!-- footer -->
    <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
</body>
</html>
