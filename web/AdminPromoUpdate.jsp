
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.PromotionDA"%>
<%@page import="model.Promotion"%>
<% 
    //PromotionDA promoDA = new PromotionDA();
    //Promotion promotion = new Promotion();
    //String promoCode = request.getParameter("promoCode");
    //promotion = promoDA.getRecord(promoCode);
    
    String promoCode = (String) session.getAttribute("promoCode");
    session.setAttribute("promoCode", promoCode);
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

        p{
            color: rgb(153, 102, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 100px;
        }


        #labelwhite{
            color:white;
            font-size: 18px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 60px;
        }


        #labelwhite{
            color:white;
            font-size: 18px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 60px;
        }

        #promotionupdate {
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
        
        #submit, #submit2{
              border: none;
              padding: 10px 10px;
              border-radius: 5px;
              margin-top: 10px;
              margin-left: 10px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 13px;
        }

        #submit:hover, #submit2:hover{
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
        }
            
        #button{
              border: none;
              padding: 10px 10px;
              border-radius: 5px;
              margin-top: 10px;
              margin-left: 100px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 13px;
        }

        #button:hover{
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
        }


    </style>
    </head>
    <body>
        <br/>
        <br/>
        <br/>
        <section id="title" style="width:100%">
            <h1 id="promotionupdate">UPDATE PROMOTIONS</h1>
        </section>
        
        <form method="post" action="AdminPromo" >
            
            <p><label for="promoType" >Promotion Type</label>
                <label id="labelwhite"><input type="radio" id="promoType" name="promoType" value="Movie" />Movie
                <input type="radio" id="promoType" name="promoType" value="Food" />Food </label>  
             
            <p><label>Amount of Promotion</label>
                <input type="text" name="promoAmount" size="5" required/></p>
            <p><input type="checkbox" id="promoStatus" name="promoStatus" >
                <label  for="activate"> Promotion Status Available </label></p>
                <input type="hidden" name="action" value="confirmUpdatePage"/>
            <p id="buttton"><input id="submit" name="action" type="submit" value="update" />
            <input id="submit2"  type="reset" value="reset" /></p>
        </form>

    </body>
</html>
