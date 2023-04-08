<%@page import="model.Movie, model.MovieDA, java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html class="background">
    <head>
    
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="Homestyle.css" rel="stylesheet" type="text/css" />
    <script src="https://kit.fontawesome.com/45084f36b1.js" crossorigin="anonymous"></script>
    <script src="userinfo.js"></script>

    <style>
    .dropdown-content a:hover, .dropdown-content li:hover{
        cursor: pointer;
    }
    @font-face {
    font-family: 'mahelisa';
    src: url(mahelisa.ttf);
    }
    select#movieinfo{
        z-index: -1;
        position: absolute;
        background-color: transparent;
        color: wheat;
        margin: 0px 20px;
        width: 96%;
        padding: 10px 50px;
        border: none;
        outline: none;
        border-radius: 15px;
        cursor: pointer;
        font-size: 13pt;
        appearance: none;
        z-index: 1;
    }
    select#movieinfo option{
      padding: 6px;
      background-color: rgba(0, 0, 0, 0.7);
      font-size: 10pt;
      border-radius: 100px;
      color: white;
    }

    select#movieinfo option:hover{
      background-color: rgb(179, 179, 255);
    }

    select#movieinfo option:active{
      background-color: rgb(153, 187, 255);
    }

    section img{
      width: 180px;
      height: 320px;
      margin-left: 15px;
      border-radius: 20px;
    }
    /* movie picture */
    div#movie-container,#movie-container1{
      position: relative;
      margin-top: 80px;
      padding-left: 20px;
      width: 100%;
    }
   
    #movie-container1{
      display: none;
    }
    div.movie{
      position: relative;
      column-gap: 40px;
      margin-right: 20px;
      margin-top: 40px;
      display: flex;
      float: left;
      height: auto;
    }
    /* End of movie picture */

    /* picture overlapping style */
    .lapping{
        position: absolute;
        bottom: 0;
        width: 77%;
        overflow: hidden;
        padding-top: 200px;
        height: 0%;
        background-color: transparent;
        transition: 1s ease;
        z-index: 1;
        margin-left: -220px;
    }
    .lapping:hover{
      height: 30%;
      background-color: rgba(0, 0, 0, 0.7);
      padding: 0px;
      z-index: 1;
    }
    .lapping input[type=submit]{
      position: absolute;
      cursor: pointer;
      width: 140px;
      margin: 30px 42px;
      background-color:#3a243b;
      color: white;
      font: 13pt 'Times New Roman', Times, serif;
      padding: 6px 20px;
      outline: none;
      border: none;
      border-radius: 15px;
      box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
      transition: 0.4s;
      margin-left: 20px;
    }
    .lapping input[type=submit]:hover{
      background-color: #9277A0;
    }
    .lapping input[type=submit]:active{
      transform: translateY(7px);
      box-shadow: 0px 0px rgba(255, 255, 255, 0.6);
    }
    /* End of picture overlapping style */
    #showbtn{
      position: relative;
      margin: 20px 0px 40px 0px;
      background-color: transparent;
      border: none;
      outline: none;
      font-size: 50px;
      width: 100%;
      color: rgb(179, 179, 255);
      animation: icon 4s infinite;
    }
    button#showbtn h1{
      margin: 0px;
      text-align: center;
      width: 100%;
      font-size: 17pt;
      color: rgb(179, 179, 255);
    }
    @keyframes icon{
      0%   {top: 0px;}
      25%  {top: 20px;}
      50%  {top: 00px;}
      75%  {top: 20px;}
      100% {top: 0px;}
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

        <!-- Header -->
        <%@include file="header.jsp"%>
        
        <%  MovieDA movieDA = new MovieDA();
                ArrayList<Movie> movieSrchList = new ArrayList<Movie>();
                movieSrchList = movieDA.searchMovieRecord();
        %>
        
        <%          String nowShowing = "MS001";
                        ArrayList<Movie> nowShowingList = new ArrayList<Movie>();
                        nowShowingList = movieDA.getStatusRecord(nowShowing);
        %>
        
        <%          String comingSoon = "MS002";
                        ArrayList<Movie> comingSoonList = new ArrayList<Movie>();
                        comingSoonList = movieDA.getStatusRecord(comingSoon);
         %>
<br/>
        <form style="position: relative; margin-top: 0px;" action="GetMovieInfo">
          <i class="fas fa-sort-amount-down-alt" style="color: wheat; font-size: 15pt; display: block; float: right; margin: 10px 60px; z-index: 1;"></i>
            <select id="movieinfo" name="movieID" onchange="this.form.submit()" onmousedown="if(this.options.length>10){this.size=10;}"  onblur="this.size=0;" onchange="this.blur()">
              <option value='' selected >CHOOSE MOVIE</option>
              <optgroup label="Now Showing" style="margin-top: 20px; text-align: center;">
              <% for(int i = 0; i< nowShowingList.size(); i++){ %>
                  <option value="<%= nowShowingList.get(i).getMovieID()%>"><%= nowShowingList.get(i).getMovieName() %></option>
               <% } %>
              </optgroup>
              <optgroup label="Coming Soon" style="margin-top: 20px; text-align: center;">
                  <% for(int i = 0; i< comingSoonList.size(); i++){ %>
                <option value="<%= comingSoonList.get(i).getMovieID()%>"><%= comingSoonList.get(i).getMovieName() %></option>
                <% } %>
              </optgroup>
            </select>
        </form>

  <hr style="margin-top: 50px; width: 90%;"/>

        <section>
          <div id="movie-container">
            <h1 style="background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100)); font-family: 'mahelisa';
            font-size: 40px; color:rgb(63, 30, 99); height: 60px; margin-left: 0px; width: 96%; text-align: center; border-radius: 30px; line-height: 60px;">
            ~~~~~~~~~~~~~N O W S H O W I N G~~~~~~~~~~~~~</h1>
     
             <% for(int i = 0; i< nowShowingList.size(); i++){ %>
            <div class="movie">
              <img src="<%= nowShowingList.get(i).getMoviePoster() %>" />
                <form action="GetMovieInfo" method="get">
                        <input type="hidden"  name="movieID"  value="<%= nowShowingList.get(i).getMovieID() %>">
                        <input type="hidden"  name="movieStatus"  value="<%= nowShowing %>">
                        <div class="lapping" >
                            <input type="submit" value="Movie Info">
                        </div>
               </form>
            </div>
            <% } %>
          </div>
        </section>


        <section style="margin-top: 2590px;">
          <div id="movie-container1">
            <h1 style="background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100)); font-family: 'mahelisa';
            font-size: 40px; height: 60px; margin-left: 0px; width: 96%; text-align: center; border-radius: 30px; 
            color:rgb(63, 30, 99); line-height: 60px; margin-bottom: 0px;">~~~~~~~~~~~~~C O M I N G S O O N~~~~~~~~~~~~~</h1>
                    
             <% for(int i = 0; i< comingSoonList.size(); i++){ %>
            <div class="movie">
              <img src="<%= comingSoonList.get(i).getMoviePoster() %>" />
                <form action="GetMovieInfo" method="get">
                        <input type="hidden"  name="movieID"  value="<%= comingSoonList.get(i).getMovieID() %>">
                        <input type="hidden"  name="movieStatus"  value="<%= comingSoon %>">
                        <div class="lapping" >
                            <input type="submit" value="Movie Info">
                        </div>
               </form>
            </div>
            <% } %>
          </div>

          <div>
            <button onclick="loadmore()" id="showbtn" href="#movie-container1" >&#10225;<h1>Show</h1></button>
          </div>
        </section>

        <script>
          function loadmore() {
            var moreMovie = document.getElementById("movie-container1");
            var btnText = document.getElementById("showbtn");

            if (moreMovie.style.display === "none") {
              moreMovie.style.display = "block";
              btnText.innerHTML = "&#10224<h1>Hide</h1>";
            } else {
              moreMovie.style.display = "none";
              btnText.innerHTML = "&#10225<h1>Show</h1>";
            }
          }

          // search bar function
          var UL = document.getElementById('search-list');
            // hilde the list by default
            UL.style.display = "none";
          </script>
          
        <!-- footer -->
        <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
    </body>
</html>

<!-- <i class="fas fa-arrow-circle-down"> -->