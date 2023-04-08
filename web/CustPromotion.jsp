
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
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

        body {
            background-color: rgb(51, 51, 51);
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
        }
   
        h1 {
           font-size: 50px;
           text-indent: 50px;
           color: rgb(153, 102, 255);
        }

        #promotion {
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
        
        #voucherBtn {
            font-size: xx-large;
            margin: 50px 0px 50px 570px;
            text-align: center;
            color: black;
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            background: linear-gradient(to bottom , rgb(160, 237, 245) , rgb(140, 37, 247));
            padding: 20px;
            border-radius: 20px;
            outline: none;
        }
        #voucherBtn:hover {
            color: white;
        }
        #voucherBtn span{
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.5s;
        }
        #voucherBtn span:after{
            content: '\2964';
            font-size: x-large;
            position: absolute;
            opacity: 0;
            top: -10%;
            right: -20px;
            transition: 0.5s;
        }
        #voucherBtn:hover span{
            padding-right: 30px;
        }
        #voucherBtn:hover span:after {
            opacity: 1;
            right: 2px;
        }
    </style>
    <head>
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%@include file="header.jsp"%>
        <br/>
    <br/>
    <br/>
    <br/>
        <section id="title" style="width:100%">
    <h1 id="promotion">PROMOTIONS</h1>
    </section>
   
        <table  width="100%">
    <tr>
        <td id="MT" style="width: 10%; text-align: center;">
                <h1 style="font-size: 20px;">Movie Tickets</h1>
                <img src="promoTicket.png" alt="ticket" usemap="#movieTickets" />
                <map name="movieTickets" id="movieTickets">
                    <area shape="rect" coords="0,-15,280,250" href="CustPromoMovie.html" alt="tickets"/>
                </map>
            
        </td>
        <td id="F" style="width: 10%; text-align: center;">
            <h1 style="font-size: 20px;">Foods</h1>
            <img src="promoFood.png" alt="food" usemap="#foods" />
            <map name="foods" id="foods">
                <area shape="rect" coords="0,-15,280,250" href="CustPromoFood.html" alt="Foods"/> 
            </map>
        </td>
        
    </tr>  
    
</table>
        <section>           
            <button id="voucherBtn" onclick="location.href='CustPromoVoucher.html'" ><span><b>Voucher Terms and Conditions</b></span></button>  
        </section>
    </body> 
</html>

