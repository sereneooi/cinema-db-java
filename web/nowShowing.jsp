<%@page import="model.Movie, model.MovieDA, java.util.List, java.util.ArrayList"%>
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

    .header{
    margin-left: 0px;
    padding: 8px;
    text-align: center;
    letter-spacing: 3px;
    font-family: 'mahelisa';
    font-size: 35px;
    background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100));
    color:rgb(63, 30, 99)
    }

    .movie1{
        padding-left: 6px;
        padding-right: 9px;
        padding-top: 10px;
        margin-bottom: 25px;
        height: 380px;     
        position: relative;
        display: flex;
        float: left;
        background: linear-gradient(to bottom, rgb(95, 50, 105), rgb(13, 5, 31));
    }

    .movie2{
        padding-left: 6px;
        padding-right: 10px;
        margin-bottom: 25px;
        height: 380px;
        background: linear-gradient(to bottom, rgb(166, 142, 180), rgb(26, 16, 31));
    }

    .movies img{
    width: 150px;
    height: 230px;
    border-radius: 8px ;
    opacity: 1.0;
    margin-top: 10px;
    margin-left:20px;
    padding-bottom: 5px;
    padding-right: 5px;
    }

    img:hover{
    opacity: 0.5;
    }

    p{
        margin: 0 0 30px 19px;
        font-style: oblique;
        font-size: 18px;
        width:170px;
        height: 20px;
        border: 0px solid transparent;
        border-radius: 4px;
        color: white;
        
    }

    input[type=submit] {
    text-align: center;
    margin: 10px 17px;
    padding-left: 40px;
    padding-right: 40px;
    padding-top: 2px;
    padding-bottom: 5px;
    line-break: 20px;
    background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(92, 79, 126));
    border: none;
    border-radius: 4px;
    color:rgb(255, 255, 255);
    text-align: center;
    font-size: 16px;
    opacity: 0.6;
    transition: 0.5s;  
    }

     input[type=submit]:hover {
    opacity: 1.0;
    color:rgb(123, 68, 160);
    background: linear-gradient(to bottom, rgb(212, 158, 188), rgb(156, 122, 175));
    }

    h2{ color:rgb(90, 33, 128) }

    footer{
    text-align: center;
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

<body onload="displayEmail();"">

    <%@include file="header.jsp"%>
        
        <h1 class="header">~~~~~~~~~~~~~~~~N O W S H O W I N G~~~~~~~~~~~~~~~</h1>

        <article>
        <div class="movies" style="display: flow-root;">
            <% String nowShowing = "MS001";
                           MovieDA movieDA = new MovieDA();
                           ArrayList<Movie> nowShowingList = new ArrayList<Movie>();
                           nowShowingList = movieDA.getStatusRecord(nowShowing);
              %>
      
                <% for(int i = 0; i< nowShowingList.size(); i++){ %>    
                    <div class ="movie1">
                        <div>
                            <img src="<%= nowShowingList.get(i).getMoviePoster() %>">
                            <p ><%= nowShowingList.get(i).getMovieName() %></p>
                            <form action="bookNow.jsp">
                                    <input type="submit" value="Movie Info">
                            </form>
                        </div>
                     </div>
               <% } %>
                
        </div>
        </article>

        <script>
            // search bar function
          var UL = document.getElementById('search-list');
            // hilde the list by default
            UL.style.display = "none";
        </script>

    <!-- footer -->
    <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
</body>
</html>