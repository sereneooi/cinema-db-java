<%@page import="model.*, model.MovieDA, model.CastListDA,  java.util.List, java.util.ArrayList"%>

<!DOCTYPE html>
<html class="background">
    <head>
    
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>

    <style>
     html{
    background-image: url(background.png);
    }

    body {
        background-color: #34273b;
        margin: 0 auto;
        margin-top: 20px;
        width: 100%;
            max-width: 1020px;
        min-width: 800px;
        z-index: -1;
        border-radius: 25px;
    }   
        
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
    color:rgb(63, 30, 99);
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
        margin-top: -5px;
        margin-right: 30px;
        margin-bottom: 5px;
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
        border: 2px solid #3a1d4f;
        background: linear-gradient(to bottom, rgb(143, 115, 179), rgb(114, 82, 133));
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
        border: 2px solid #3a1d4f;
        border: 2px solid #3a1d4f;
        background: linear-gradient(to bottom, rgb(189, 171, 201), rgb(189, 125, 240));
        box-shadow: 0 5px 15px rgba(145, 92, 182, .4);
    }
    
    p.synopsisText {
     max-width: 120%;
     font-size: 18px;
     font-family: 'Times New Roman', Times, serif;
     color: 	white;
    }
    
    .button{
      position: absolute;
      cursor: pointer;
      width: 140px;
      margin: 30px 42px;
      background-color:#610873;
      color: white;
      font: 13pt 'Times New Roman', Times, serif;
      padding: 6px 20px;
      outline: none;
      border: none;
      border-radius: 15px;
      box-shadow: 0px 5px rgba(255, 255, 255, 0.6);
      transition: 0.2s;
      margin-left: 820px;
      margin-top: -4px;
    }
    
    .button:hover{
        background-color:#f5abb4;
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
     <% 
               String movieIDRetrieved = (String)session.getAttribute("valueOfMovieID");
               Movie movieDetailsInfo = new Movie(movieIDRetrieved);
               MovieDA movieInfoDA = new MovieDA();
               movieDetailsInfo = movieInfoDA.getMovieRecord(movieIDRetrieved);
      %>

    <form class="select">
        <label style="color: rgb(153, 102, 255); font-size: 20px; font-family: 'Times New Roman', Times, serif; margin-left: 52px;"></label>
    </form>
        <section id="newMovie1"style="margin-top: 20px;">
            <div class="video">
                <h2 style="text-align: left; padding-left: 15px; font-style: oblique; font-size:25px; padding-top: -7px;
                                  letter-spacing: 1px;color:rgb(171, 148, 224); ">Movie ID: <%= movieIDRetrieved %></h2>
                <img src="<%= movieDetailsInfo.getMoviePoster() %>" style="width:100%; height:350px; margin-top: -1px;"/>
                <form action="GetTrailerAdmin" method="get">
                        <input type="hidden"  name="movieID"  value="<%= movieDetailsInfo.getMovieID() %>">
                        <input type="hidden"  name="movieStatusID"  value="<%= movieDetailsInfo.getMovieStatus().getMovieStatusID() %>">
                        <input type="submit" value="Trailer">
                </form>
            </div>

            <div class="movieInfo">
                
                <%     
                       CastListDA castlistDA = new CastListDA();
                       ArrayList<CastList> actorList = new ArrayList<CastList>();
                       actorList = castlistDA.getCastListRecord(movieIDRetrieved);
               %>
                
                <h1 style="font-style: oblique; font-size: 28px; margin: 0px;"><%= movieDetailsInfo.getMovieName() %></h1>
                <p><img src="<%= movieDetailsInfo.getMovieAdsPoster() %>" class="social" style="width:660px; height: 290px;" />
               <img src="<%= movieDetailsInfo.getMovieRestrict().getRestrictionImage() %>" class="social" style="width:38px; height: 36px; padding-top: 15px;" />
                <p><b><pre style="font-size: 23px; color:rgb(171, 148, 224);"><%= movieDetailsInfo.getMovieType().getMovieTypeDesc() %>   -   <%= movieDetailsInfo.getDuration() %>    -    <%= movieDetailsInfo.getLanguage().getLanguageDesc() %>    -    <%= movieDetailsInfo.getMovieStatus().getMovieStatusDesc()  %> </pre></b></p>
                <!-- Call function to format the date -->
                
                <p style="font-size: 18px;"><pre><b>Available Date   :   </b><% String formattedDate = movieDetailsInfo.dateFormatter(movieDetailsInfo.getAvailableDate()); %><%= formattedDate %> </pre></p>
            <span style="color:white;  font-size: 18px;"><p class="synopsisText"><b>Cast  : </b><% for(int i = 0; i< actorList.size(); i++){ %><%= actorList.get(i).getActor().getActorName() %> / <% } %></span>            
               <p class="synopsisText" style="font-size: 18px; padding-right: 5px;"><b>Synopsis  : </b><%= movieDetailsInfo.getSynopsis() %></p>
            </div>
        </section>
        <section id="text" style="font-family: 'mahelisa'; letter-spacing:15px; font-size:25px; border-radius: 5px;
        margin: 15px 33px 15px 28px; color:rgb(210, 194, 226); background-color: #34273b; height: 50px;">
                <button onclick="location.href='AdminMovie.jsp'" class="button" type="button" >Back</button>
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
    </body>
</html>


