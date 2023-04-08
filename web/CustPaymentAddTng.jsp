

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
                        .dropdown-content a:hover, .dropdown-content li:hover{
                cursor: pointer;
            }
            @font-face {
            font-family: 'mahelisa';
            src: url(mahelisa.ttf);
            }
            
            
/*            html{
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
 
#paymenttng {
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
            
 
            /* Credit Card icon */
            #mcicon {
              cursor: pointer;
              width: 170px;
              height: 140px;
              transition: transform .2s;
              margin-top: 0px;
              margin-left: 145px;
            }

            #mcicon:hover {
              transform: scale(1.1); 
            }

            /* Tng icon */
            #tnglogo {
              cursor: pointer;
              width: 130px;
              height: 130px;
              transition: transform .2s;
              margin-top: 0px;
              margin-left: 215px;
            }

            #tnglogo:hover {
              transform: scale(1.1); 
            }

            /* Credit Card radio checked flip function */
            input[type="checkbox"] {
              display: none;
            }

            #cardFlip:checked + .flip {
              transform: rotateY(180deg);
            }

            .flip {
              transition: 0.6s;
              transform-style: preserve-3d;
              position: relative;
            }

            /* Credit Card front and back Style */
            .front, .back {
              padding: 1rem;
              background: url(credit1.png) center/contain no-repeat;
              height: 350px;
              width: 624px;
              border-radius: 15px;
              backface-visibility: hidden;
              position: absolute;
              top: 0;
              left: 0;
            }

            .front {
              z-index: 2;
              transform: rotateY(0deg);
              margin: 0px auto 0px 75px;
            }

            .back {
              transform: rotateY(180deg);
              margin: 0px auto 0px 75px;
            } 

            /* Flip card icon */
            #flipCard {
              cursor: pointer;
              width: 70px;
              height: 70px;
              border-radius: 5px;
              margin-top: 15px;
              margin-left: 740px;
            }

            #flipCard:hover {
              transform: scale(1.1); 
            }

            /* Credit Card style */
            #masterCard {
              margin: 10px;
              width: 140px;
              height: 90px;
              float: right;
            }

            #chip {
              margin: 20px 0px 30px 10px;
              width: 80px;
              height: 80px;
            }

            .cardNumlabel {
              width: 100px;
              color: white;
              margin-top: 10px;
              margin-left: 5px;
            }

            #cardNum1, #cardNum2, #cardNum3, #cardNum4 {
              width: 19%;
              margin: -10px 3px 50px 3px;
              padding: 12px;
              color: #1a3b5d;
              border: 1.5px solid #ced6e0;
              font-family: "Times New Roman", Times, serif;
            }

            input[type="text"], select {
              font-family: "Times New Roman", Times, serif;
              color: #1a3b5d;
              width: 47.9%;
              border-radius: 5px;
              border: 1.5px solid #ced6e0;
              background-color: white;
              font-size: 20px;
              padding: 12px;
              margin-top: 5px;
              margin-right: 30px;
              box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) inset;
            }

            input:focus, select:focus {
              outline: none;
              border: 1.5px solid #ced6e0;
            }

            input[type="text"]:focus:valid, #cardNum1:focus:valid, #cardNum2:focus:valid, #cardNum3:focus:valid, #cardNum4:focus:valid {
              border: 2px solid #4ec07d;
              background: url(correct.png) right/contain no-repeat; 
              background-color: white;
            }

            input[type="text"]:focus:invalid, #cardNum1:focus:invalid, #cardNum2:focus:invalid, #cardNum3:focus:invalid, #cardNum4:focus:invalid {
              border: 2px solid #e96075;
              background: url(wrong.png) right/contain no-repeat; 
              background-color: white;
            }

            ::placeholder {
              font-family: "Times New Roman", Times, serif;
              color: rgba(0, 0, 0, 0.6) 
            }

            select {
              width: 20%;
              margin-right: 3px;
            }

            option {
              color: black;
            }
            
            #label{
                color: rgb(153, 102, 255);
                font-size: 30px;
                font-family: 'Times New Roman', Times, serif;
                margin-left: 60px;
            }

            #namelabel {
              margin-left: 2px;
              color: white;
            }

            #date {
              margin-left: 278px;
              color: white;
            }

            #cvc {
              margin-top: 133px; 
              margin-right: 6px;
              width: 20%;
              padding: 20px;
            }

            #submit {
              border: none;
              padding: 22px 33px;
              border-radius: 5px;
              margin-top: 275px;
              margin-left: 760px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 17px;
            }

            #submit:hover {
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
            }

            #black {
                width: 656px;
                height: 400px;
                margin: -5rem 0px -18rem -1rem;
            }

            p{
              cursor: pointer;
              color: white;
              width: 70px;
              margin-left: 844px;
            }

            /* Tng style */
            .smartphone {
              display: inline-block;
              position: relative;
              width: 370px;
              height: 500px;
              margin: 3rem 0px 0px 200px;
              border: 16px solid white;
              border-top-width: 60px;
              border-bottom-width: 60px;
              border-radius: 36px;
            }

            .smartphone:before {
              content: '';
              display: block;
              width: 60px;
              height: 5px;
              position: absolute;
              top: -30px;
              left: 50%;
              transform: translate(-50%, -50%);
              background: #333;
              border-radius: 10px;
            }

            .smartphone:after {
              content: '';
              display: block;
              width: 35px;
              height: 35px;
              position: absolute;
              left: 50%;
              bottom: -65px;
              transform: translate(-50%, -50%);
              background: #333;
              border-radius: 50%;
            }

            .smartphone .content {
              width: 380px;
              height: 510px;
              margin-left: -5px;
              margin-top: -5px;
              border-radius: 15px;
              background: linear-gradient(to bottom, #FFFFFF, #6DD5FA, #2980B9);  /* Chrome 10-25, Safari 5.1-6 */
              text-align: center;
            }

            #tng {
              margin-top: 10px;
              margin-left: 123px;
              width: 145px;
              height: 150px;
            }

            #default {
              margin-top: 40px;
              width: 80px;
              margin-right: 6px;
              margin-bottom: 10px;
            }

            #phone {
              padding-left: 5px;
              margin-right: -2px;
              width: 230px;
            }

            #num1, #num2, #num3, #num4, #num5, #num6 {
              width: 25px;
              margin-left: -24px;
              text-align: center;
            }

            #num1:focus:valid, #num2:focus:valid, #num3:focus:valid, #num4:focus:valid, #num5:focus:valid, #num6:focus:valid {
              border: 2px solid #4ec07d;
              background: none;
              background-color: white;
            }

            #num1:focus:invalid, #num2:focus:invalid, #num3:focus:invalid, #num4:focus:invalid, #num5:focus:invalid, #num6:focus:invalid {
              border: 2px solid #e96075;
              background: none;
              background-color: white;
            }

            .text {
              text-align: left;
              margin-top: 20px;
              margin-left: 7px;
              font-size: 19px;
            }

            #num1 {
              margin-left: -5px;
            }

            #num6 {
              margin-right: -5px;
            }

            #submit1 {
              margin-top: 85px;
              margin-left: 278px;
              padding: 18px 30px;
              color: black;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              display: block;
              font-size: 17px;
              border: none;
              border-radius: 5px;
            }

            #submit1:hover {
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
            }

            .checkout {
              width: 803px;
              margin: 25px 0px 0px 100px;
            }



        </style> 
    </head>
    <body>
        <!-- Header -->
        <%@include file="header.jsp"%>
        <br/>
        <br/>
        <br/>
        <section id="title" style="width:100%">
            <h1 id="paymenttng">ADD TNG</h1>
        </section>
        
        <section>
            <form action="CustPayment" method="post">
            <label id="label">Promotion Code</label>
            <input class="text" type="text" name="promoCode" size="5" style="width: 100px; height: 30px; margin-top: 5px; margin-left: 30px; margin-bottom: 5px;"/>
            <% if(request.getAttribute("errMsg") != null) { %>
            <div style="color:red; background-color: transparent;padding-left: 100px; margin-top: 10px"><%= request.getAttribute("errMsg") %></div>
            <% } %>
            <div class="checkout">
                <div class="methods">
                    <a href="CustPaymentAdd.jsp"><img id="mcicon" src="msicon.jpg" alt="Master Card" /></a>
                    <a href="CustPaymentAddTng.jsp"><img id="tnglogo" src="tnglogo.png" alt="Touch N Go" /> </a>
                </div>
                
                
                    
                <section class="tngInfo">
                    <div class="smartphone">
                        <div class="content">
                            <div>
                                <img id="tng" src="touchngo.png" alt="Touch N Go Icon" />
                            </div>
                        <div>
                            <input type="text" name="default" id="default" value="MY +60" disabled />
                            <input type="text" name="phone" id="phone" placeholder="Mobile Number" maxlength="10"  required />
                        </div>
                        <div class="text">
                            6-digit PIN
                        </div>
                        <div class="num">
                            <input type="text" name="num1" id="num1" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  required />
                            <input type="text" name="num2" id="num2" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required  />
                            <input type="text" name="num3" id="num3" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required  />
                            <input type="text" name="num4" id="num4" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required  />
                            <input type="text" name="num5" id="num5" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required  />
                            <input type="text" name="num6" id="num6" maxlength="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required  />
                        </div>
                            <input type="hidden" name="pMethod" value="TouchAndGo" />
                            <input type="hidden" name="action" value="add1" />
                        <input id="submit1" type="submit" value="Pay"><!-- onclick="storePayment('Touch N Go');"-->
                        </div>
                    </div>
                </section>
                </form>
            </div>
           </section>
        
        <!-- footer -->
        <footer style="width: 1020px;">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>
    </body>
</html>
