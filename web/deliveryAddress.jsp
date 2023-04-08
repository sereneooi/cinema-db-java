<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.format.DateTimeFormatter, java.time.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <%@include file="checkCustomerAccess.jsp"%>
        <style>
            .form {
                width: 1020px;
                margin-left: -30px;
            }
            .header {
                line-height: 50px;
                text-transform: uppercase;
                font-family: 'mahelisa';
                font-size: 50px;
                background: linear-gradient(to bottom, rgb(85, 25, 97), rgb(13, 5, 31));
                color:rgb(194, 158, 201);
                width: 100%;
                letter-spacing: 15px;
                text-align: center;
                word-spacing: 15px;
                margin-bottom: 70px;
            }  
            main {
                margin: auto;
            }
            .modal {
                background: linear-gradient(to top, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);
                color: #FFF;
                width: 55.9rem;
                border-radius: 4px;
                text-align: center;
                padding: 10rem 4rem 4rem 4rem;
                position: relative;
                margin-left: 29px;
            }
            .modal__icon {
                position: absolute;
                top: -3rem;
                left: 39%;
                margin-left: -165px;
                background: linear-gradient(to bottom, #f3e7e9 0%, #e3eeff 300%);
                padding: 3rem 12rem 0 12rem;
                border-radius: 50%;
            }
            p { 
                font-size: 1.5rem; 
            }
            div.form-item{
                position: relative; 
                display: block; 
                margin-bottom: 20px; 
                margin-top: 35px;
            }
            input{
                transition: all .2s ease;
            }
            input.form-style, select.form-style{
                color:#8a8a8a;
                display: block;
                width: 95%;
                height: 44px;
                padding: 5px 15px;
                border:1px solid #ccc;
                -moz-border-radius: 10px;
                -webkit-border-radius: 10px;
                border-radius: 10px;
                -moz-background-clip: padding;
                -webkit-background-clip: padding-box;
                background-clip: padding-box;
                background-color: #fff;
                font-family:'HelveticaNeue','Arial', sans-serif;
                font-size: 105%;
                letter-spacing: .8px;
            }
            select.form-style {
                width: 98.6%;
                height: 56px;
            }
            input:read-only {
                cursor: no-drop;
            }
            div.form-item .form-style:focus{
                outline: none; 
                border: 1px solid #58bff6; 
                color: #58bff6; 
            }
            div.form-item p.formLabel {
                position: absolute;
                left: 15px;
                top: -9px;
                transition: all .4s ease;
                color: #bbb;
            }
            .formTop{
                top: -22px !important; 
                left: 15px; 
                background-color: #fff; 
                font-size: 14px; 
                color: #58bff6 !important;
            }
            .formStatus{
                color: #8a8a8a !important;
            }
            input[type="submit"].login{
                float: right;
                width: 112px;
                height: 37px;
                -moz-border-radius: 19px;
                -webkit-border-radius: 19px;
                border-radius: 19px;
                -moz-background-clip: padding;
                -webkit-background-clip: padding-box;
                background-clip: padding-box;
                background-color: #55b1df;
                border: 1px solid #55b1df;
                border: none;
                color: #fff;
                font-weight: bold;
            }
            input[type="submit"].login:hover{
                background-color: #fff; 
                border: 1px solid #55b1df; 
                color: #55b1df; 
                cursor: pointer;
            }
            input[type="submit"].login:focus{
                outline: none;
            }
        </style>
    </head>
    
    <body>
        <% 
            response.setHeader("Refresh", "900");
            
            if(session.getAttribute("fnbOrder") != null) {
                session.removeAttribute("fnbOrder");
            } 
            if(session.getAttribute("ticketList") != null) {
                session.removeAttribute("ticketList");
            } 
            if(session.getAttribute("fnbOrderLineList") != null) {
                session.removeAttribute("fnbOrderLineList");
            }
            
            
        %>
        
        <%@include file="header.jsp"%>

        <!-- section -->
        <section>
            <form method="post" action="DeliveryAddressController">
                <div class="form">
                    <h1 class="header">Delivery Form</h1>
                    <main>
                        <div class="modal">
                            <div class="modal__icon">
                                <img width="200" src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/256492/cXsiNryL.png" alt="Car">
                            </div>
                                
                            <div class="form-item">
                                <p class="formLabel">Street Address 1<span style="color:#c97272;">*</span></p>
                                <input type="text" name="streetAddress1" class="form-style" autocomplete="off" required />
                            </div>
                            
                            <div class="form-item">
                                <p class="formLabel">Street Address 2 (Optional)</p>
                                <input type="text" name="streetAddress2" class="form-style" autocomplete="off" />
                            </div>
                            
                            <div class="form-item half">
                                <p class="formLabel">Postcode<span style="color:#c97272;">*</span></p>
                                <input type="text" name="postcode" class="form-style" autocomplete="off" onkeypress="return (event.charCode !=8 && event.charCode ==0 || (event.charCode >= 48 && event.charCode <= 57))" minlength="5" maxlength="5" required />
                            </div>
                            
                            <div class="form-item">
                                <p class="formLabel">City<span style="color:#c97272;">*</span></p>
                                <input type="text" name="city" class="form-style" autocomplete="off" required />
                            </div>
                            
                            <div class="form-item">
                                <p class="formLabel formTop">State</p>
                                <input type="text" name="state"class="form-style" value="Pulau Pinang" readonly />
                            </div>
                            
                            <div class="form-item">
                                <p class="formLabel">Delivery Date<span style="color:#c97272;">*</span></p>
                                <input type="date" name="deliveryDate" id="deliveryDate" class="form-style" required />
                            </div>
                            
                            <div class="form-item">
                                <p class="formLabel">Delivery Time<span style="color:#c97272;">*</span></p>
                                <select class="form-style" name="deliveryTime" id="deliveryTime" required >
                                </select>
                            </div>
                            
                            <input type="submit" class="login pull-right" value="Confirm">
                        </div>
                    </main>
                </div>
            </form>
        </section>
        
        <!-- footer -->
        <footer style="margin-top: 30px;">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>
        
        <script>
            $(document).ready(function(){
                var formInputs = $('input[type="text"]');
                
                formInputs.focus(function() {
                    $(this).parent().children('p.formLabel').addClass('formTop');
                    $('div#formWrapper').addClass('darken-bg');
                    $('div.logo').addClass('logo-active');
                });
                
                formInputs.focusout(function() {
                    if ($.trim($(this).val()).length == 0){
                    $(this).parent().children('p.formLabel').removeClass('formTop');
                    }
                    $('div#formWrapper').removeClass('darken-bg');
                    $('div.logo').removeClass('logo-active');
                });
                
                $('p.formLabel').click(function(){
                    $(this).parent().children('.form-style').focus();
                });
            });
            
        <%
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime max = now.plusDays(2);
            LocalDateTime tomorrow = now.plusDays(1);
            int openHour = 10;
            int closeHour = 21;

            if(now.getHour() >= closeHour) {
        %>
                document.getElementById("deliveryDate").setAttribute("value", '<%= df.format(tomorrow) %>');
                document.getElementById("deliveryDate").setAttribute("min", '<%= df.format(tomorrow) %>');
                document.getElementById("deliveryDate").setAttribute("max", '<%= df.format(max) %>');
                $('#deliveryDate').prev().addClass('formTop');
        <%
            } else {
        %>
                document.getElementById("deliveryDate").setAttribute("value", '<%= df.format(now) %>');
                document.getElementById("deliveryDate").setAttribute("min", '<%= df.format(now) %>');
                document.getElementById("deliveryDate").setAttribute("max", '<%= df.format(max) %>');
                $('#deliveryDate').prev().addClass('formTop');
        <% } %>

        <%
            DateTimeFormatter tf = DateTimeFormatter.ofPattern("hh:mm a");
            LocalDateTime todayTime = now.plusMinutes(45);
            LocalDateTime time = LocalDate.now().atTime(10, 0);
            int hour = 0; 
            int counter = 0;

            while(todayTime.getMinute() % 30 != 0) {
                todayTime = todayTime.plusMinutes(1);
            }

        %>
            function updateTimeForToday() {
                <%
                    hour = todayTime.getHour();
                    if(hour < openHour) {
                        todayTime = time;
                        hour = todayTime.getHour();
                    } else { 
                %>
                        $('#deliveryTime').append($('<option></option>').text('Now (30 - 45mins)'));
                <%
                    }
                    while(hour <= closeHour) {
                        if(counter != 0) {
                            todayTime = todayTime.plusMinutes(30); 
                        }
                        if(hour == closeHour && todayTime.getMinute() == 30) {
                            break;
                        }
                %>
                        $('#deliveryTime').append($('<option></option>').text('<%= tf.format(todayTime) %>')); 
                <% 
                        counter++;
                        if(counter % 2 == 0) {
                            hour++;
                        }
                    } 
                %>
            }  

            function updateTimeForTomorrow() {
                <%
                    counter = 0;
                    while(openHour <= closeHour) {
                        if(counter != 0) {
                            time = time.plusMinutes(30);
                        }
                %>
                    $('#deliveryTime').append($('<option></option>').text('<%= tf.format(time) %>')); 
                    <%
                        if(openHour == closeHour) {
                            break;
                        }

                        counter++;
                        if(counter % 2 == 0) {
                            openHour++;
                        }
                    } 
                    %>
            }

            function updateTime() {
                if($('#deliveryDate').val() == '<%= df.format(now) %>') {
                    updateTimeForToday();
                } else {
                    updateTimeForTomorrow();
                }
            }

            $('#deliveryDate').on("change", function() {
                $('#deliveryTime').empty();
                updateTime();
            });

            updateTime();
            $('#deliveryTime').prev().addClass('formTop');
        </script>
    </body>
</html>

