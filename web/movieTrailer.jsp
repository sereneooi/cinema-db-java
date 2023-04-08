<%@page import="model.*, model.MovieDA, model.CastListDA,  java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <title>CC Cinema</title>
        <style>
            html, body{
                background-color: rgb(0, 0, 0);
                margin: 0;
            }

            table#content{
                border: 2px solid #9966ff;
                border-collapse: collapse;
                background-color: black;
                margin: auto;
                line-height: 40px;
                color: white;
                height: 50px;
            }

            table#container{
                height: 3vh;
                width: 100%;
            }
            .close {
                color: white;
                font-size: 35px;
                font-weight: bold;
                background: transparent;
                border: none;
                float: right;
                }

                .close:hover{
                color: #9966ff;
                cursor: pointer;
                }
        </style>
    </head>

    <body>
        <% 
               String movieIDRetrieved = (String)session.getAttribute("valueOfMovieID");
               String movieStatusRetrieved = (String)session.getAttribute("valueOfStatusID");
               String nowShowingMovie = "MS001";
               String comingSoonMovie = "MS002";
               Movie movieDetailsInfo = new Movie(movieIDRetrieved);
               MovieDA movieInfoDA = new MovieDA();
               movieDetailsInfo = movieInfoDA.getMovieRecord(movieIDRetrieved);
         %>
        <table border="0" id="container">
            <table border="0" style="width: 60%; height: 50%;" id="content">
                <tr>
                    <% if(movieStatusRetrieved.equals(nowShowingMovie)) {%>
                    <td><button onclick="location.href='movieInfo.jsp'" class="close" title="Close Modal">&times;</button></td>
                    <%} else if(movieStatusRetrieved.equals(comingSoonMovie)) {%>
                    <td><button onclick="location.href='movieDetails.jsp'" class="close" title="Close Modal">&times;</button></td>
                    <% } %>
                </tr>
                <tr>
                    <td><iframe  id="videoclick" name="videoclick" width="100%" height="500px" src="<%= movieDetailsInfo.getMovieTrailer() %>" 
                    frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"></iframe>
                    </td>
                </tr>
            </table>
        </table>
    </body>
</html>
