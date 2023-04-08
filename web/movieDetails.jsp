<%@page import="model.*, model.MovieDA, model.CastListDA,  java.util.List, java.util.ArrayList"%>

<!DOCTYPE html>
<html class="background">
    <head>
    
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="Homestyle.css" rel="stylesheet" type="text/css" />
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
        position: absolute;
        background-color: #000000 ;
        color: rgb(114 114  211);
        margin: -17px 0px 15px 30px;
        width: 94%;
        padding: 10px 50px;
        border: none;
        outline: none;
        border-radius: 15px;
        cursor: pointer;
        font-size: 12pt;
        appearance: none;
        z-index: 1;
    }

    select#movieinfo option{
        padding: 6px;
        background-color: rgba(0, 0, 0, 0.7);
        font-size: 10pt;
        border-radius: 100px;
        z-index: 1;
    }

    select#movieinfo option:hover{
        background-color: rgb(179, 179, 255);
    }

    h1{
    margin-top:25px;
    margin-bottom: 5px;
    margin-left: 30px;
    margin-right: 30px;
    padding: 8px;
    text-align: center;
    font-style: oblique;
    font-size: 25px;
    border-radius: 3px;
    background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(59, 48, 85));
    color:rgb(63, 30, 99)
    }

    pre{
        font-size: 13pt;
        font-family: 'Times New Roman', Times, serif;
        color: white;
    }
    #newMovie1{
        margin-top: 0px;
    }

    section{
        display: flex;
        margin-top: 0px;
        height: 80%;
    }
    .movieInfo{
        padding: 20px;
        margin-top: -40px;
        margin-right: 30px;
        position: relative;
        float: right;
        background-color: black;
        width: 65%;
    }

    .video{
        margin-right: 20px;
        width: 30%;
        height: 100%;
        margin-left: 30px;
        position: relative;
        float: left;
        flex: 1;
    }
    .video a{
        background-color: thistle;
        display: block;
        border-radius: 10px;
        margin-top: 20px;
        padding: 8px 0px ;
        color: black;
        font-size: 12pt;
    }
    input[type=submit]{
        font: 13pt 'Times New Roman', Times, serif;
        color: whitesmoke;
        margin-top: 10px;
        margin-bottom: 5px;
        position: relative;
        vertical-align: middle;
        padding: 9px 5px;
        width: 100%;
        border-radius: 10px;
        border: 1px solid #3a1d4f;
        background: linear-gradient(to bottom, rgb(189, 171, 201), rgb(98, 82, 110));
        box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
    }
    input[type=submit]:hover{
        margin-top: 10px;
        margin-bottom: 5px;
        position: relative;
        vertical-align: middle;
        padding: 9px 5px;
        width: 100%;
        border-radius: 10px;
        border: 1px solid #3a1d4f;
        background: linear-gradient(to bottom, rgb(143, 115, 179), rgb(114, 82, 133));
        box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
    }
    
    p.synopsisText {
     max-width: 120%;
     font-size: 18px;
     font-family: 'Times New Roman', Times, serif;
     color: 	white;
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

    <body>

        <!-- Header -->
        <%@include file="header.jsp"%>
        
         <!-- search bar -->
         <form>
            <div class="searchbar" id="searchbar">
                <input type="search" name="search" id="search" class="search-txt" placeholder="Search" onkeyup="filter();"/>
                <a class="search-btn"> <img src="search.png" alt="search button" style="width: 15px; height: 15px;"></a>
            </div>
            <div class="searchcontainer" id="searchcontainer">    
            <ul id="search-list">
                <!--
              <li><a href="1maleficient.html">Maleficient</a></li>
              <li><a href="2beautyandthebeast.html">Beauty and the beast</a></li>
              <li><a href="3toystory4.html">Toy Story4</a></li>
              <li><a href="4joker.html">Joker</a></li>
              <li><a href="5peninsula.html">Train To Busan : Peninsula</a></li>
              <li><a href="6ironman.html">Iron Man3</a></li>
              <li><a href="7spiderman.html">Spider-Man : The Amazing</a></li>
              <li><a href="8hacker.html">Hacker</a></li>
              <li><a href="9abyss.html">Black Water : Abyss</a></li>
              <li><a href="10dolittle.html">Dolittle</a></li>
              <li><a href="111917.html">1917</a></li>
              <li><a href="12captainamerica.html">Captain America : The Winter Soldier</a></li>
              <li><a href="13thejackinthebox.html">The Jack in The Box</a></li>
              <li><a href="14frozen2.html">Frozen II</a></li>
              <li><a href="15jumaji.html">Jumanji</a></li>
              <li><a href="16lionking.html">The Lion King</a></li>
              <li><a href="17cinderella.html">Cinderella</a></li>
              <li><a href="18thenutcrackerandthefourrealms.html">The Nutcracker and The Fourrealms</a></li>
              <li><a href="19coco.html">Coco</a></li>
              <li><a href="20tenet.html">Tenet</a></li>
              <li><a href="21dora.html">Dora and The Lost City of Gold</a></li>
              <li><a href="22crawl.html">Crawl</a></li>
              <li><a href="23it2.html">IT Chapter2</a></li>
              <li><a href="24incredibles2.html">Incredibles2</a></li>
              <li><a href="25charles.html">Charles</a></li>
              <li><a href="newMovie1.html">Death on the Nile</a></li>
              <li><a href="newMovie2.html">Deliver Us From Evil</a></li>
              <li><a href="newMovie3.html">Black Widow</a></li>
              <li><a href="newMovie4.html">SPIRAL</a></li>
              <li><a href="newMovie5.html">The King's Man</a></li>
              <li><a href="newMovie6.html">The Tunnel</a></li>
              <li><a href="newMovie7.html">Vanguard</a></li>
              <li><a href="newMovie8.html">Jiang Zi Ya</a></li>
              <li><a href="newMovie9.html">Let it Snow</a></li>
              <li><a href="newMovie10.html">77 HeartWarmings</a></li>
              <li><a href="newMovie11.html">In My Heart</a></li>
              <li><a href="newMovie12.html">Monster Run</a></li>
              <li><a href="newMovie13.html">Free Guy</a></li>
              <li><a href="newMovie14.html">Peter Rabbit 2</a></li>
              <li><a href="newMovie15.html">Rumble</a></li>
            </ul>
                -->
          </div>
      </form>
        <!-- End of search bar -->

    <h2 style="text-align: left; padding-left: 32px; font-family: 'mahelisa'; font-size:27px;
    letter-spacing: 5px;color:rgb(171, 148, 224)">COMING SOON~~~~~~MOVIE INFORMATION</h2>

    <form class="select">
        <label style="color: rgb(153, 102, 255); font-size: 20px; font-family: 'Times New Roman', Times, serif; margin-left: 52px;"></label>
    </form>

    <%          
                        String comingSoon = "MS002";
                        MovieDA movieDA = new MovieDA();
                        ArrayList<Movie> comingSoonList = new ArrayList<Movie>();
                        comingSoonList = movieDA.getStatusRecord(comingSoon);
         %>
    <form style="position: relative;">
            <select id="movieinfo" name="movieID" onchange="this.form.submit()" onmousedown="if(this.options.length>10){this.size=10;}"  onblur="this.size=0;" onchange="this.blur()" >
            <option value='none' selected >Choose a movie</option>
            <% for(int i = 0; i< comingSoonList.size(); i++){ %>
                <option value="<%= comingSoonList.get(i).getMovieID()%>"><%= comingSoonList.get(i).getMovieName() %></option>
            <% } %>
        </select>
    </form>
        
        <% 
               String movieIDRetrieved = (String)session.getAttribute("valueOfMovieID");
               Movie movieDetailsInfo = new Movie(movieIDRetrieved);
               MovieDA movieInfoDA = new MovieDA();
               movieDetailsInfo = movieInfoDA.getMovieRecord(movieIDRetrieved);
         %>
        <section id="newMovie1"style="margin-top: 80px;">
            <div class="video">
                <img src="<%= movieDetailsInfo.getMoviePoster() %>" style="width:100%; height:350px; margin-top: -40px;"/>
                <form action="GetMovieTrailer" method="get">
                        <input type="hidden"  name="movieID"  value="<%= movieDetailsInfo.getMovieID() %>">
                        <input type="hidden"  name="movieStatusID"  value="<%= movieDetailsInfo.getMovieStatus().getMovieStatusID() %>">
                        <input type="submit" value="Watch Trailer">
                </form>
            </div>

            <div class="movieInfo">
                
                <%     
                       CastListDA castlistDA = new CastListDA();
                       ArrayList<CastList> actorList = new ArrayList<CastList>();
                       actorList = castlistDA.getCastListRecord(movieIDRetrieved);
               %>
                
                <h1 style="font-style: oblique; font-size: 28px; margin: 0px; color:#422454;"><%= movieDetailsInfo.getMovieName() %></h1>
                <p><img src="<%= movieDetailsInfo.getMovieRestrict().getRestrictionImage() %>" class="social" style="width:38px; height: 36px;" />
                <p><b><pre style="font-size: 23px;"><%= movieDetailsInfo.getMovieType().getMovieTypeDesc() %>   -   <%= movieDetailsInfo.getDuration() %>    -    <%= movieDetailsInfo.getLanguage().getLanguageDesc() %></pre></b></p>
                <!-- Call function to format the date -->
                <p style="font-size: 18px;"><pre><b>Available Date   :   </b><% String formattedDate = movieDetailsInfo.dateFormatter(movieDetailsInfo.getAvailableDate()); %><%= formattedDate %> </pre></p>
            <span style="color:white;  font-size: 18px;"><p class="synopsisText"><b>Cast  : </b><% for(int i = 0; i< actorList.size(); i++){ %><%= actorList.get(i).getActor().getActorName() %> / <% } %></span>            
               <p class="synopsisText" style="font-size: 18px; padding-right: 5px;"><b>Synopsis  : </b><%= movieDetailsInfo.getSynopsis() %></p>
            </div>
        </section>
        <section id="text" style="font-family: 'mahelisa'; letter-spacing:15px; font-size:25px; border-radius: 5px;
        margin: 15px 33px 15px 28px; color:rgb(210, 194, 226); background-color: black; ">
            <marquee><h2><i><b>COMING SOON, PLEASE STAY TUNE !!!</b></i><h2></marquee>
        </section>

        <script>
            function enter(){
                var x = document.getElementById('text').value;
                document.getElementById('comment').value = x;
                document.getElementById('comment').style.backgroundColor = "black";
            }

            var UL = document.getElementById('search-list');
            // hilde the list by default
            UL.style.display = "none";
        </script>
            <!-- footer -->
        <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
    </body>
</html>
