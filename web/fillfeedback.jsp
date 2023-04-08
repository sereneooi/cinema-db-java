<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="background">
    <head>

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
            width: 550px;
            height: 450px;
            background-color: black;
            border-radius: 10px;
            padding: 0;
            margin: 0;
            border: 2px solid #9966ff;
            animation: fade 1s ease 1 forwards;
          }

          p {
              font-size: 20px;
              font-family: "Comic Sans MS", cursive, sans-serif;
              color: white;
              text-align: center;
              margin-top: 25px;
              width: 500px;
              margin-left: auto;
              margin-right: auto;
          }

          .confirm button {
            font-size: 20px;
            font-family: "Comic Sans MS", cursive, sans-serif;
            background: transparent;
            border: none;
            color: #9966ff;
            height: 3rem;
            width: 50%;
            position: absolute;
            bottom: 0;
            cursor: pointer;
          }

          #cancel {
            border-top: 1px solid white;
            border-right: 1px solid white;
            left: 0;
            border-radius: 0 0 0 10px;
          }

          #cancel:hover {
            font-weight: bold;
            background: #e96075;
            color: white;
          }

          #confirm {
            border-top: 1px solid white;
            right: 0;
            border-radius: 0 0 10px 0;
          }

          #confirm:hover, #confirm:focus {
            font-weight: bold;
            background: #4ec07d;
            color: white;
          }

          #confirm:focus {
            outline: 0 none;
          }
        </style>
    </head>

    <body>
        <div class="confirm">
            <p><img src="img/feedback/please.gif" alt="Cute Cartoon" width="200px" height="200px" style="margin-top: 35px;" /></p>
            <p>Would you like to spend some time doing a short feedback form?</p>
            <a href=
               <% if(session.getAttribute("fnbOrder") != null) { %>
                    "fnbOrderDeliveryHistory.jsp"
                <% } else { %>
                    "ticket.jsp"
                <% } %>
                ><button id="cancel">No</button></a>
            <a href="feedback.jsp"><button id="confirm" autofocus>Yes</button></a>
        </div>
    </body>
</html>