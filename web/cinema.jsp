<%@page import="model.Movie, model.MovieDA, java.util.List, java.util.ArrayList"%>
<%@page import="model.MovieSchedule, model.MovieScheduleDA"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat, java.util.Date"%>
<%@page import="java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html class="background">
    <head>
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="Homestyle.css" rel="stylesheet" type="text/css" />
    <link href="layout.css" rel="stylesheet" type="text/css" />
    
    <style>
    .dropdown-content a:hover, .dropdown-content li:hover{
        cursor: pointer;
    }
    @font-face {
    font-family: 'mahelisa';
    src: url(mahelisa.ttf);
    }
    #myVideo{
      position: relative;
      right: 0;
      bottom: 0;
      width: 100%;
      min-width: 100%; 
      min-height: 100%;
    }
    
    .discoverBtn {
      position: absolute;
      cursor: pointer;
      width: 170px;
      margin: 30px 42px;
      background-color:#3a243b;
      color: white;
      font: 13pt 'Times New Roman', Times, serif;
      padding: 8px 20px;
      outline: none;
      border: none;
      border-radius: 15px;
      box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
      transition: 0.4s;
      margin-left: 20px;
    }
    
    .discoverBtn:hover{
      background-color: #9277A0;
    }
    
    </style>    
</head>
    <body >
        <!-- header -->
        <%@include file="header.jsp"%>
        <% 
               //get today's date && calculation to get next week's date
               LocalDate dateOfToday = LocalDate.now();
               LocalDate dateNextWeek = dateOfToday.plusWeeks(1);
               
               //turn LocalDate to String format
               String strDateTdy = dateOfToday.toString();
               String strDateNxtWeek = dateNextWeek.toString();
               
               MovieDA trendingMovieDA = new MovieDA();
               MovieScheduleDA scheduleDA = new MovieScheduleDA();
               
               //get movieid of trending movie THIS WEEK
               String trendingMovieID = scheduleDA.displayTrendingTrailer(strDateTdy, strDateNxtWeek);
               
               //pass the id into movieDA to get more information of this specific movie ID
               Movie trendingMovie = new Movie(trendingMovieID);
               trendingMovie = trendingMovieDA.getMovieRecord(trendingMovieID);
         %>
           
        <!-- fist div -->
        <div>
          <div style="position: absolute; z-index: 1; margin-top: 310px; width: 67%;">
              <h1 style=" background-color: rgba(0, 0, 0, 0.5); padding: 20px 0px 0px 4px; 
                  font: 25pt Impact, Charcoal, sans-serif; width: 104%; text-align: left;  margin: 99px 0px 0px 0px; color: #d4b3ff;" >&emsp;TRENDING MOVIE THIS WEEK &#8594; <span style="color: #ffb5ce;"><%= trendingMovie.getMovieName()%></span></h1>
              <h3 style="background-color: rgba(0, 0, 0, 0.5); padding: 20px 5px; padding-left: 40px; font-size: 10pt; color: white; text-align: left; margin-top: 0px; width: 99.2%"><%= trendingMovie.getSynopsis() %><span><a style="font-size: 12pt; color: white; " href="nowShowing.jsp">&emsp;&emsp;&emsp;<u>View more</u></a></span></h3>
          </div>
          
          
        <iframe  id="videoclick" name="videoclick" width="100%" height="540px" src="<% String autoPlayVid = trendingMovie.getMovieTrailer() + "?autoplay=1&mute=1&loop=1&controls=0"; %><%= autoPlayVid %>" 
                    frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" ></iframe>
      </div>
    <!-- End of first div -->

      <!-- second div -->
        <section class="outer" style="height: 430px;">
            <div class="caption1" style="width:35%; float: left; margin: 50px; margin-top: 56px; margin-left: -32px;">
                <h1 style="font-family: mahelisa; font-size:59px; text-align: center; line-height: 0%; text-shadow: 10px 7px 0px black; line-spacing: 9px;">M o v i e s<sub></sub></h1>
                <h1 style="font-family: mahelisa; font-size:59px; text-align: center; line-height: 0%; text-shadow: -10px 7px 5px black; line-spacing: 9px; padding-left: 16px;">C o m i n g &nbsp; S o o n</h1>
                <h1 style="font-family: mahelisa; font-size:57px; text-align: right; line-height: 0%; text-shadow: 15px 20px 2px black; line-spacing: 20px; padding-top: 26px; margin-left: 2px; color: #d4b3ff;"><sup>N E X T &nbsp; M O N T H</sup></h1>
              </div>
            
              <!-- first slideshow -->      
            <div id="slider" style="padding-top: 26px; padding-bottom: 29px;">
                <input type="radio" name="slider" id="s1">
                <input type="radio" name="slider" id="s2">
                <input type="radio" name="slider" id="s3" checked>
                <input type="radio" name="slider" id="s4">
                <input type="radio" name="slider" id="s5">
                <!--Display coming soon movie NEXT MONTH  -->
                <% 
                        //get currentMonth and nextMonth 
                        Calendar cal = Calendar.getInstance();
                        int currentMonth = cal.get(Calendar.MONTH) + 1;
                        int nextMonth = cal.get(Calendar.MONTH) + 2;
                    
                        MovieDA csMovieDA = new MovieDA();
                        ArrayList<Movie> comingSoonMovie = new ArrayList<Movie>();
                        comingSoonMovie = csMovieDA.displayNxtMonthComingSoonList (nextMonth);
                %>
                <% for(int i = 0; i< comingSoonMovie .size(); i++){  
                        
                        MovieDA comingMovieDA = new MovieDA();
                        Movie comingMovieInfo = comingMovieDA.getMovieListingRecord(comingSoonMovie.get(i).getMovieID());
             
                %>

                <label for="<%= "s" + (i+1) %>" id="<%= "slide" + (i+1) %>">
                    <img src="<%= comingMovieInfo.getMoviePoster()%>" height="100%" width="100%">
                </label>
                
    
                <% } %>  
                <div class="home-container">
                  <button onclick="location.href='comingSoon.jsp'" target="_self" type="button" class="discoverBtn" style="margin-top: 280px;margin-left:90px; background-color: #5b4166; color:white;">Discover Now</button>
                </div>  
            </div>

            
            <!-- End of first slideshow -->
        </section>
        <!-- End of first div -->

        <!-- second slideshow -->
        <section class="outer1" >
          <!-- title -->
            <div style="width: 100%; margin-bottom: 10px; ">
                <h1 style="text-align: center; margin: 0px; font-size: 25pt;"><span style="color: rgb(204, 102, 153); font-family: mahelisa; line-spacing: 10px;">T O P &nbsp; 6 &nbsp; M O V I E S</span> in Cc Cinema <span style="color: rgb(204, 102, 153); font-family: mahelisa; line-spacing: 10px;">T H I S &nbsp;&nbsp; M O N T H</span></h1>
                <p style="text-align: center; margin: 0px; color: #a088bf;"> Available now at Movie Cinema & Theatre</p>
                <a href="movie.jsp" style="width: 90%; text-align: right; font-size: 14pt; color:#a088bf;"><u>View all</u></a>
            </div>
          <!-- End of title -->
   
          
          
          <!--Display Top 6 Movies THIS MONTH  -->
          <%        MovieScheduleDA movieScheduleDA = new MovieScheduleDA();
                        ArrayList<Movie> popularMovieList = new ArrayList<Movie>();
                        popularMovieList = movieScheduleDA.displayMostPopularMovie(currentMonth);
            %>
            <% for(int i = 0; i< popularMovieList.size(); i++) {  
                        
                        MovieDA popularMovieDA = new MovieDA();
                        Movie popularMovieInfo = popularMovieDA.getMovieListingRecord(popularMovieList.get(i).getMovieID());
             
                %>
      
          <!-- the picture of slideshow -->
          <% if(i == 0) { %>
            <div class="container anima">
        <% } %>
                <div class="movieslide anima">  
                  <div class="numbertext"><%= (i+1) + " / 6" %></div>
                  <img src="<%= popularMovieInfo.getMovieAdsPoster() %>" style="width:100%; height: 300px;">
                </div>
                <% } %>
                
       
                    <!-- next button and previous button for second slideshow -->
                        <a class="prev-btn" onclick="plusSlides(-1)"><</a>
                        <a class="next-btn" onclick="plusSlides(1)">></a>
                      <!-- End of next button and previous button for second slideshow -->

                      <!-- caption of second slideshow -->
                        <div class="caption">
                          <p id="text"></p>
                        </div>
                      <!-- End of caption of slideshow -->     
                
      
               
              <% for(int i = 0; i< popularMovieList.size(); i++) {  
                        
                        MovieDA popularMovieDA = new MovieDA();
                        Movie popularMovieInfo = popularMovieDA.getMovieListingRecord(popularMovieList.get(i).getMovieID());
             
                %>
                <!-- demo of second slideshow -->
                <% if(i == 0) { %>
                <div class="row">
                <% } %>
                  <div class="column">
                    <img class="smallwindow" src="<%= popularMovieInfo.getMovieAdsPoster() %>" style="width:100%; height: 100px;" onclick="currentSlide(i+1)" alt="<%= popularMovieInfo.getMovieName() %>">
                  </div>
              <% } %>
                </div>
                <!-- End of demo of second slideshow -->


            </div>
         
       
          <!-- End of the picture of slideshow -->
        </section>
      <!-- End of second div -->

      <!-- function of second div -->
        <script type="text/javascript">
            var index = 1;
            showSlides(index);
            
            function plusSlides(n) {
              showSlides(index += n);
            }
            
            function currentSlide(n) {
              showSlides(index = n);
            }
            
            function showSlides(n) {
              var i;
              var slides = document.getElementsByClassName("movieslide");
              var demo = document.getElementsByClassName("smallwindow");
              var captions = document.getElementById("text");
              if (n > slides.length) 
              {
                  index = 1
            }
              if (n < 1) {index = slides.length}
              for (i = 0; i < slides.length; i++) {
                  slides[i].style.display = "none";
              }
              for (i = 0; i < demo.length; i++) {
                demo[i].className = demo[i].className.replace(" active", "");
              }
              slides[index-1].style.display = "block";
              demo[index-1].className += " active";
              captions.innerHTML = demo[index-1].alt;
            }

            var UL = document.getElementById('search-list');
            // hilde the list by default
            UL.style.display = "none";
        </script>
      <!-- End of function of second div -->

        <!-- footer -->
        <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
        <!-- End of footer -->
    </body>
</html>
