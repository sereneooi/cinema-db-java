
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Promotion" %>
<%
    Promotion promotion = (Promotion) session.getAttribute("promotion");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
                <style>
         .dropdown-content a:hover, .dropdown-content li:hover{
            cursor: pointer;
        }
        @font-face {
        font-family: 'mahelisa';
        src: url(mahelisa.ttf);
        }

        #title{
            width: 100%;
            height: 100px;
        }
        
/*                    
            html{
    background-image: url(background.png);
}
 */
body {
    background-color: rgb(51, 51, 51);
    margin: 0 auto;
    width: 100%;
    max-width: 1020px;
    min-width: 800px;
    z-index: -1;
}
         
h1{
    color: rgb(153, 102, 255);
    font-size: 30px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 60px;
}
         
h3{
    color: rgb(153, 102, 255);
    font-size: 30px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 60px;
}

b{
    color:white;
    font-size: 18px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 60px;
}

p{
    color: rgb(153, 102, 255);
    font-size: 20px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 60px;
}

#btn{
    font-size: 20px;
    margin-left: 40px;
}

#promotion{
    color: rgb(153, 102, 255);
    font-size: 20px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 80px;
}

#labelwhite{
    color:white;
    font-size: 18px;
    font-family: 'Times New Roman', Times, serif;
    margin-left: 60px;
}


.text, .text2 {
              width: 100px;
              height: 30px;
              margin-top: 5px;
              margin-left: 30px;
            }

        #promoconfirmadd {
            text-shadow: 2px 2px 2px pink;
            text-align: center;
            margin-top: -50px;
            background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100));
            font-family: 'mahelisa';
            font-size: 40px; 
            color:rgb(63, 30, 99); 
            text-align: center; 
            border-radius: 30px; 
            line-height: 60px;
        }
        
        
        #submit{
              border: none;
              padding: 10px 10px;
              border-radius: 5px;
              margin-top: 10px;
              margin-left: 40px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 13px;
            }

            #submit:hover{
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
            }
            #back {
            font-size: xx-large;
            margin: 60px 0px 0px 70px;
            text-align: center;
            color: rgb(179, 179, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            background: linear-gradient(60deg, #000000, #404040, #737373,#999999);
            padding: 5px 50px;
            border-radius: 20px;
            outline: none;
        }
        #back:hover {
            color: white;
        }
        #back span{
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.5s;
        }
        #back span:after{
            content: '\00AB';
            position: absolute;
            opacity: 0;
            top: -3%;
            right: -60px;
            transition: 0.5s;
        }
        #back:hover span{
            padding-left: 20px;
        }
        #back:hover span:after {
            opacity: 1;
            right: 60px;
            }


    </style>
    </head>
    <body>
        <br/>
        <br/>
        <br/>
        <section id="title" style="width:100%">
            <h1 id="promoconfirmadd">CONFIRM ADD PROMOTIONS</h1>
        </section>
        <form id="promotion" method="post" action="AdminPromoAddDB">
            <h3>You have entered the following data:</h3>
            <p>Promotion Code: <b><%= promotion.getPromoCode()%></b></p>
            <p>Promotion Type: <b><%= promotion.getPromoType()%></b></p>
            <p>Promotion Amount: <b><%= promotion.getPromoAmount()%></b></p>
            <p>Promotion Status: <b><%= promotion.getPromoStatus()%></b></p>

            <p id="btn"><input id="submit" name="action" type="submit" value="submit" />
<!--            <section>           
                <button id="back" onclick="location.href='AdminPromoAdd.jsp'" ><span>Back</span></button>  
            </section>-->
            <section>
                <button id="back" type="button" name="back" onclick="history.back()"><span>Back</span></button>
            </section>
        </form>
    </body>
</html>
