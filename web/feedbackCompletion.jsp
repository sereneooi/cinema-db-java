<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>

        <style>
          *, *:after, *:before {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
          }
          body {
            background: url(img/feedback/cinema.png) no-repeat center fixed; 
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
          }
          @keyframes fade {
            from {
              opacity: 0;
              transform: translate(-50%, -50%) scale(0.8);
            }
            to {
              opacity: 1;
              transform: translate(-50%, -50%) scale(1);
            }
          }
          .confirm {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 500px;
            background: white;
            border-radius: 10px;
            padding: 0;
            margin: 0;
            animation: fade 1s ease 1 forwards;
            box-shadow: 0px 0px 25px 1px #0ff;
          }
          p {
              font-size: 25px;
              font-family: "Comic Sans MS", cursive, sans-serif;
              color: black;
              text-align: center;
          }
          #confirm {
            font-size: 20px;
            font-family: "Comic Sans MS", cursive, sans-serif;
            height: 3rem;
            width: 40%;
            position: absolute;
            bottom: 30px;
            cursor: pointer;
            background: linear-gradient(to top, #1A936F, #85D196);
            border: none;
            color: white;
            margin-left: 125px;
            border-radius: 10px;
          }
          #confirm:hover {
            opacity: 0.8;
          }
         </style>
    </head>

    <body>
        <div class="confirm">
            <p><img src="img/feedback/tq.gif" alt="Cute Cartoon" width="320px" height="280px" style="margin-top: 30px;"/></p>
            <p><b>Thank You!</b></p>
            <p style="font-size: 22px;">Your submission has been received!</p>
            <a href=
               <% if(session.getAttribute("fnbOrder") != null) { %>
                    "fnbOrderDeliveryHistory.jsp"
                <% } else { %>
                    "ticket.jsp"
                <% } %>
                ><button id="confirm">OK</button></a>
        </div>
    </body>
</html>
