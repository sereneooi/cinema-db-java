<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
    <header>
        <table>
            <tr>
                <td><a href="cinema.jsp"><img src="logo.png" alt="CC Cinema" id="logo" name="logo"/></a></td>
                <th rowspan="2">
                    <a href="cinema.jsp" 
                    style="font-family: 'Times New Roman', Times, serif; font-size:50px; 
                    font-variant: small-caps; font-style: italic; text-decoration: none; color: rgb(204, 153, 255); text-align: center;">
                    Cc Cinema</a>
                </th>
                <th colspan="3" style="vertical-align: bottom;">
                    <a href="account.jsp" style="text-decoration: none">
                        <span id="YourAccount" style="color: rgb(204, 153, 255); " name="YourAccount">
                            <%  Account displayUserInfo = (Account) session.getAttribute("currentUser");   
                                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                                if(displayUserInfo == null){ %>
                                    Your Account
                            <% }else{ %>
                                    <%= displayUserInfo.getName() %>
                            <% } %>
                        </span>
                    </a>
                </th>
                <td><a href="account.jsp"><img src="youraccount.png" alt="Your Account" class="acc" style="margin-right: 10px;"/></a></td>
            </tr>
            <tr>
                <td style="font-family: mahelisa; font-size:30px;
                        font-variant: small-caps; font-style: italic; text-decoration: none; color: rgb(204, 153, 255); vertical-align: top; text-align: center;">Cc Cinema</td>
                <td><img src="facebook.png" alt="facebook" id="fb" name="pic" class="social"/></td>
                <td><img src="instagram.png" alt="instagram" id="ins" name="pic" class="social"/></td>
                <td><img src="gmail.png" alt="gmail" id="gmail" name="pic" class="social"/></td>
                <td><img src="whatsapp.png" alt="whatsapp" id="whatsapp" name="pic" class="social" style="margin-right: 10px;"/></td>
            </tr>
        </table>
    </header>
    
    <!-- navigation bar -->
    <nav id="horizontal">
        <ul>
            <li><a href="cinema.jsp" >HOME</a></li>
            <li><a href="movie.jsp" >MOVIES</a></li>
            <!-- dropdown buttonn -->
        <div class="dropdown">
            <li><a class="dropbtn">SHOWTIMES</a></li>
                <div class="dropdown-content" style="text-align: center;">
                    <li><a href="nowShowing.jsp" style="padding: unset;" class="drop-content">Now Showing</a></li>
                    <li><a href="comingSoon.jsp" style="padding: unset;" class="drop-content">Coming Soon</a></li>
                </div> 
        </div>
        <!-- end of dropdown button -->
            <li><a href="CustPromotion.jsp" >PROMOTIONS</a></li>
        <div class="dropdown">
            <li><a class="dropbtn">BOOK NOW</a></li>
            <div class="dropdown-content" style="text-align: center;" id="logout">
                <li><a style="padding: unset;" class="drop-content" href="bookNow.jsp">Movies</a></li>
                <li><a style="padding: unset;" class="drop-content" href="deliveryAddress.jsp">Food & Beverages</a></li>
            </div>
        </div>
        <div class="dropdown">
            <li><a class="dropbtn" href="login.jsp">LOGIN</a></li>
            <div class="dropdown-content" style="text-align: center;" id="logout">
                <li><a style="padding: unset;" class="drop-content" href="logout.jsp">Log Out</a></li>
                <li><a style="padding: unset;" class="drop-content" href="newuser.jsp">Register</a></li>
            </div>
        </div>    
        </ul>
    </nav>
    </body>
</html>
