<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
        }

        
        #label{
            color: rgb(153, 102, 255);
            font-size: 30px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 60px;
        }
        
 
        .text {
            width: 100px;
            height: 30px;
            margin-top: 5px;
            margin-left: 20px;
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
        
        #add, #submit, #submit2, #submit3 {
              border: none;
              padding: 22px 33px;
              border-radius: 5px;
              margin-top: 10px;
              margin-left: 600px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 13px;
        }

        #add:hover, #submit:hover, #submit2:hover, #submit3:hover {
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
        }

    </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content" style="margin-left: 300px;">
            <br/>
            <br/>
            <br/>
            <section id="title" style="width:100%">
                <h1 id="promotion">PROMOTION</h1>
            </section>
            <button id="add" onclick="document.location='AdminPromoAdd.jsp'">add</button>

            <form method="post" action="AdminPromo">
                <label id="label">Promotion Code</label>
                <input class="text" type="text" name="promoCode" size="5" required/>
                <div style="color:red; background-color: transparent;padding-left: 100px; margin-top: 10px">${ErrorMessage}</div>
            <p><input id="submit" name="action" type="submit" value="retrieve" />
            <input id="submit2" name="action" type="submit" value="update" />
            <input id="submit3" name="action" type="submit" value="updateStatus" /></p>
            </form>
        </div>
    </body>
</html>
