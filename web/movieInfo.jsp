<%@page import="model.*, model.MovieDA, model.CastListDA,  java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html class="background">
    <head>

    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="Homestyle.css" rel="stylesheet" type="text/css" />
    <link href="movie_info_style.css" rel="stylesheet" type="text/css" />
    <script src="https://kit.fontawesome.com/45084f36b1.js" crossorigin="anonymous"></script>
    <script src="userinfo.js"></script>

    <style>
        pre{
        font-size: 13pt;
        font-family: 'Times New Roman', Times, serif;
        color: 	whitesmoke;
        }
        /* animation for pre move tp left */
        @keyframes toright{
            from { left: -1000px; }
            to { left: -20px; }
        }
        select#movieinfo{
            position: absolute;
            background-color: black;
            color: white;
            margin: 20px 20px;
            width: 96%;
            padding: 10px 50px;
            border: none;
            outline: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 13pt;
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

        select#movieinfo option:active{
          background-color: rgb(153, 187, 255);
        }

        h1{
            margin-top:25px;
            margin-bottom: 5px;
            margin-left: 30px;
            margin-right: 30px;
            padding: 8px 2px;
            text-align: center;
            font-style: oblique;
            font-size: 25px;
            border-radius: 3px;
            background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(59, 48, 85));
            color:rgb(63, 30, 99);
            border-top-right-radius: 100px;
            width: 90%;
            }

        section{
            display: flex;
        }
        .movieInfo{
            padding: 20px;
            margin-right: 30px;
            position: relative;
            float: right;
            border-top-right-radius: 100px;
            background-color: black;
            width: 60%;
            box-shadow: 5px 5px 30px rgb(191, 128, 255);
            overflow: hidden;
        }
        .video img{
            box-shadow: 10px -10px 30px rgb(77, 121, 255);
            border-radius: 10px;
        }
        .video{
            background-color: transparent;
            margin-right: 20px;
            width: 30%;
            height: 90%;
            margin-left: 30px;
            position: relative;
            float: left;
            flex: 1;
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
        background: linear-gradient(to bottom, rgb(143, 115, 179), rgb(114, 82, 133));
         box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
    }

        /* animation for button */
        button.trailer{
            cursor: pointer;
            box-shadow: 10px -10px 30px rgb(77, 121, 255);
            margin-top: 15px;
            position: relative;
            vertical-align: middle;
            padding: 7px 5px;
            width: 100%;
            border-radius: 10px;
            z-index: 0;
            outline: none;
            color: rgb(255, 255, 255);
            font-size: medium;
            margin-bottom: 10px;
        }

        button.trailer:before {
            content: '';
            background: linear-gradient(45deg, #ff0000, #ff7300, #fffb00, #48ff00, #00ffd5, #002bff, #7a00ff, #ff00c8, #ff0000);
            position: absolute;
            top: -2px;
            left:-2px;
            background-size: 400%;
            z-index: -1;
            filter: blur(5px);
            width: calc(100% + 4px);
            height: calc(100% + 4px);
            animation: glowing 20s linear infinite;
            opacity: 1;
            transition: opacity .3s ease-in-out;
            border-radius: 10px;
        }

        button.trailer:active {
            color: white
        }

        button.trailer:active:after {
            background: black;
        }

        button.trailer:after {
            z-index: -1;
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: black;
            left: 0;
            top: 0;
            border-radius: 10px;
        }

        @keyframes glowing {
            0% { background-position: 0 0; }
            50% { background-position: 400% 0; }
            100% { background-position: 0 0; }
        }

        .move{
            position: absolute;
            animation-name: toright;
            animation-duration: 2s;
        }

        /* button */
        .info-container{
            position: relative;
            width: 100%;
            height: 380px;
            border: 1px solid white;
        }
        .info-btn{
            width: 25%; 
            float: right;
            border: none;
            cursor: pointer;
            background-color:	 rgb(77, 77, 255);
            font: 13pt 'Times New Roman', Times, serif;
            padding: 5px 30px;
            outline: none;
            border: none;
            border-radius: 15px;
            box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
            transition: 0.4s;
            opacity: 1;
            animation: changecolor 3s infinite;
        }
        .info-btn:hover{
            background-color:	rgb(128, 128, 255)
        }
        .info-btn:active{
            transform: translateY(7px);
            box-shadow: 0px 0px rgba(255, 255, 255, 0.6);
        }
        
        .info-btn{
            width: 25%; 
            float: right;
            border: none;
            cursor: pointer;
            background-color:	 rgb(77, 77, 255);
            font: 13pt 'Times New Roman', Times, serif;
            padding: 5px 30px;
            outline: none;
            border: none;
            border-radius: 15px;
            box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
            transition: 0.4s;
            opacity: 1;
            animation: changecolor 3s infinite;
        }
        .info-btn:hover{
            background-color:	rgb(128, 128, 255)
        }
        .info-btn:active{
            transform: translateY(7px);
            box-shadow: 0px 0px rgba(255, 255, 255, 0.6);
        }
        
        input[type=button]{
            cursor: pointer;
            box-shadow: 10px -10px 30px rgb(176, 155, 189);
            background-color:	rgb(123, 83, 145);
            margin-top: 15px;
            position: relative;
            vertical-align: middle;
            padding: 7px 5px;
            width: 110%;
            border-radius: 10px;
            z-index: 0;
            outline: none;
            color: rgb(255, 255, 255);
            font-size: medium;
            margin-bottom: 10px;
        }
        input[type=button]:hover{
            background-color:	rgb(184, 162, 189);
        }
        @keyframes changecolor {
            from {background-image: linear-gradient(90deg, red, yellow);}
            to {background-image: linear-gradient(90deg, purple, white);}
        }

        textarea#text{
            background-color: black;
            border: 1px dashed whitesmoke;
            color: whitesmoke;
            outline: none;
            margin: 40px 30px 20px 30px;
            border-radius: 10px;
            resize: none;
            width: 93.2%;
        }

        ::-webkit-input-placeholder { /* Edge */
            color: white;
        }

        :-ms-input-placeholder { /* Internet Explorer */
            color: white;
        }

        ::placeholder {
            color: rgb(114 114  211);
            font-size: 13pt;
        }

    .dropdown-content a:hover, .dropdown-content li:hover{
        cursor: pointer;
    }
    @font-face {
    font-family: 'mahelisa';
    src: url(mahelisa.ttf);
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

        <!-- header -->
        <%@include file="header.jsp"%>
        <!-- End of navigation bar -->

        <!-- search bar -->
        <form>
            <div class="searchbar" id="searchbar">
                <input type="search" name="search" id="search" class="search-txt" placeholder="Search" onkeyup="filter();"/>
                <a class="search-btn"> <img src="search.png" alt="search button" style="width: 15px; height: 15px;"></a>
            </div>
            <div class="searchcontainer" id="searchcontainer">    
            <ul id="search-list">
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
          </div>
      </form>
        <!-- End of search bar -->

        <br/>

            <form class="select">
                <h2 style="text-align: left; margin-top: 0px; margin-bottom: 10px; padding-left: 32px; font-family: 'mahelisa'; font-size:30px; letter-spacing: 6px;color:rgb(171, 148, 224)">
                > <ins>MOVIE INFORMATION</ins></h2>
            </form>

            <%      String nowShowing = "MS001";
                        MovieDA movieDA = new MovieDA();
                        ArrayList<Movie> nowShowingList = new ArrayList<Movie>();
                        nowShowingList = movieDA.getStatusRecord(nowShowing);
            %>

            <form style="position: relative; margin-top: 0px;">
                    <select id="movieinfo" name="movieID" onchange="this.form.submit()" onmousedown="if(this.options.length>10){this.size=10;}"  onblur="this.size=0;" onchange="this.blur()" >
                    <option value='none' selected >Choose a movie</option>
                    <% for(int i = 0; i< nowShowingList.size(); i++){ %>
                  <option value="<%= nowShowingList.get(i).getMovieID()%>"><%= nowShowingList.get(i).getMovieName() %></option>
                    <% } %>
                </select>
            </form>
        
        <% 
               String movieIDRetrieved = (String)session.getAttribute("valueOfMovieID");
               Movie movieDetailsInfo = new Movie(movieIDRetrieved);
               MovieDA movieInfoDA = new MovieDA();
               movieDetailsInfo = movieInfoDA.getMovieRecord(movieIDRetrieved);
         %>
         

        <section style="margin-top: 100px;">
            <div class="video">
                <a target="_self" href="<%= movieDetailsInfo.getMoviePoster() %>" ><img src="<%= movieDetailsInfo.getMoviePoster() %>"  width="110%" height="370px" style="margin-left: 3px; margin-bottom: 6px;"/></a>
                <form action="GetMovieTrailer" method="get">
                        <input type="hidden"  name="movieID"  value="<%= movieDetailsInfo.getMovieID() %>">
                        <input type="hidden"  name="movieStatusID"  value="<%= movieDetailsInfo.getMovieStatus().getMovieStatusID() %>">
                        <input type="submit" value="Watch Trailer">
                </form>
            </div>
        <%     
                       CastListDA castlistDA = new CastListDA();
                       ArrayList<CastList> actorList = new ArrayList<CastList>();
                       actorList = castlistDA.getCastListRecord(movieIDRetrieved);
        %>
                        
            <div class="movieInfo">
                <div class="move">
                    <h1 style="font-style: oblique; font-size: 28px; margin: 0px; color:#422454;"><b><%= movieDetailsInfo.getMovieName() %></b></h1>
                    <p><img style="width:38px; height: 36px;" src="<%= movieDetailsInfo.getMovieRestrict().getRestrictionImage() %>" class="social"/><pre  style="font-size: 23px;"><b><%= movieDetailsInfo.getMovieType().getMovieTypeDesc() %>   -   <%= movieDetailsInfo.getDuration() %>    -    <%= movieDetailsInfo.getLanguage().getLanguageDesc() %></b></pre></p>
                     <p><pre  style="font-size: 18px;"><b>Available Date   :   </b><% String formattedDate = movieDetailsInfo.dateFormatter(movieDetailsInfo.getAvailableDate()); %><%= formattedDate %> </pre></p>
                    <span style="color:white; font-size: 18px;"><p class="synopsisText"><b>Cast  : </b><% for(int i = 0; i< actorList.size(); i++){ %><%= actorList.get(i).getActor().getActorName() %> / <% } %></span>
                    <p class="synopsisText" style="font-size: 18px; padding-right: 5px;"><b>Synopsis  : </b><%= movieDetailsInfo.getSynopsis() %></p>
                </div>
            </div>
        </section>
                
                <div style="width: 20%; float: right; border: none; margin-top: 11px; margin-right: -25px;">
                    <form action="MovieScheduling" method="get">
                        <input type="hidden"  name="movieID"  value="<%= movieDetailsInfo.getMovieID() %>">
                        <input type="hidden"  name="movieStatusID"  value="<%= movieDetailsInfo.getMovieStatus().getMovieStatusID() %>">
                        <input type="button" style="width: 70%;" onclick="location.href='bookNow.jsp'" value="Book Now">
                </form>
                </div>
                       
        <form class="text">
            <textarea id="text" name="text" rows="8" cols="131" placeholder="  YOU CAN TYPE YOUR COMMENT HERE ! !"></textarea>
            <button type="button" class="trailer" onclick="enter();" 
            style="position: relative; width: 15%; float: right; margin-top: 0px; margin-right: 30px;" >Comment</button>
        </form>
                        
        <input id="comment" name="comment" 
        style="width: 94%; height: 80px; margin: 10px 30px; background-color: transparent; border: none; outline: none; color: white; border-radius: 10px;" />

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
        <footer style="margin-top: 15px;">&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
    </body>
</html>
