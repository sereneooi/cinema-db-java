<%-- 
    Document   : CustTransactionSuccess
    Created on : Apr 12, 2022, 11:05:39 PM
    Author     : Acer
--%>

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
/*
          body {
            background: url(cinema.png) no-repeat center fixed; 
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
          }*/
          body {
            background-color: rgb(51, 51, 51);
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
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
            top: 54%;
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
              font-size: 30px;
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

          h2 {
            position: relative;
            font-family: "Comic Sans MS", cursive, sans-serif;
            text-transform: uppercase;
            font-size: 2em;
            letter-spacing: 4px;
            overflow: hidden;
            background: linear-gradient(-45deg, #ffa63d, #ff3d77, #338aff, #3cf0c5);
            background-size: 600%;
            animation: anime 16s linear infinite;
            -webkit-background-clip: text;
            -webkit-text-fill-color: rgba(255, 255, 255, 0);
            margin-top: 15px; 
          }

          @keyframes anime {
            0% {
              background-position: 0% 50%;
            }
            50% {
              background-position: 100% 50%;
            }
            100% {
              background-position: 0% 50%;
            }
          }

          marquee{
                  transition-duration: 1s;
                  width: 680px;
                  margin-left: 300px;
                  margin-right: 100px;
              }
        </style>
    </head>
  
        <body>
        <div class="confirm">
            <p><img src="yes.gif" alt="Cute Cartoon" width="300px" height="300px" style="margin-top: 30px;"/></p>
            <p>Transaction successful!!!</p>  
            <a href="fillfeedback.jsp"><button id="confirm">OK</button></a>
        </div>
        <marquee><h2><i>Thank You For Your Support!!!</i></h2></marquee>
    </body>

</html>
