<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*" %>
<jsp:useBean id="fnbOrderDA" scope="application" class="model.FnbOrderDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <%@include file="checkCustomerAccess.jsp"%>
        <style>
        section {
            font-family: cursive;
            min-height: 800px;
            background: linear-gradient(to top, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);
        }
        h1.header {
            line-height: 50px;
            text-transform: uppercase;
            font-size: 50px;
            background: linear-gradient(to bottom, rgb(85, 25, 97), rgb(13, 5, 31));
            color:rgb(194, 158, 201);
            width: 100%;
            text-align: center;
            letter-spacing: 5px;
            word-spacing: 15px;
            margin-left: 0px;
            margin-bottom: 0px;
        } 
        li.orderHistory {
            width: 250px;
            text-align: center;
        }
        li.orderHistory a {
            font-weight: bold;
            color: #a6a6a6!important;
            font-size: 25px!important;
            font-family: cursive!important;
        }
        li.orderHistory.selected a, li.orderHistory a:hover{
            color: #7863b6!important;
        }
        li.orderHistory.selected a::after, li.orderHistory a:hover::after{
            opacity: 1;
            width: 200px!important;
        }
        .order {
            min-height: 160px;
            margin-top: 35px;
            margin-left: 100px;
            margin-right: 100px;
            padding: 20px;
            box-shadow: rgb(0 0 0 / 10%) 0px 4px 12px;
            background: white;
            cursor: pointer;
            border-radius: 20px;
        }
        .order h1 {
            color: black;
            font-family: cursive;
            font-size: 30px;
            margin: 0px;
        }
        .order p {
            font-size: 20px;
        }
        .order span:nth-child(2) {
            margin-left: 50px;
        }
        .order ion-icon {
            margin-right: 5px;
        }
        .order h2 {
            float: right;
            margin-top: -14%;
            font-size: 30px;
        }
        .activeOrder li {
            list-style: none;
            float: right;
            margin-top: -60px;
        }
        .activeOrder button {
            position: relative;
            width: 20px;
            height: 20px;
            background-color: #b3c3a2;
            margin: 0;
            border: 0;
            border-radius: 50%;
            padding: 0;
            outline: 0;
        }
        .activeOrder button:after {
            content: '';
            width: 10px;
            height: 10px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translateX(-50%) translateY(-50%);
            border: 3px solid #b3c3a2;
            border-radius: 50%;
            animation: beacon 2s infinite linear;
            animation-fill-mode: forwards;
        }
        @keyframes beacon {
            0%   { 
              width: 0;
              height: 0;
              opacity: 1;
            }
            25%  { 
              width: 15px;
              height: 15px;
              opacity: 0.7;
            }
            50%  { 
              width: 25px;
              height: 25px;
            }
            75%  { 
              width: 35px;
              height: 35px;
              opacity: 0.5;
            }
            100% { 
              width: 50px;
              height: 50px;
              opacity: 0;
            }
        }
        .my-modal {
            position: fixed;
            background-color: rgba(255, 255, 255, .8);
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            display: none;
            overflow: auto;
            z-index: 1;
        }
        .my-modal-content {
            width: 700px;
            height: 100%;
            text-align: center;
            padding: 2em;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.26), 0 26px 52px rgba(0, 0, 0, 0.26);
            margin: auto;
            position: relative;
            margin-top: 10px;
            margin-bottom: 10px;
            display: table;
        }
        button#js-close {
            position: absolute;
            top: 0;
            right: -10px;
            font-size: 30px;
            transition: all 0.5s ease;
            position: absolute;
            background-color: #a2a2c3;
            padding: 0px 7px;
            margin-top: -9px;
            border-radius: 50%;
            border: 2px solid #fff;
            color: white;
            box-shadow: -3px 1px 6px 0px rgba(0,0,0,0.1);
            cursor: pointer;
        }
        button#js-close:hover {
            background-color: #46466d;
            color: #fff;
        }
        .steps {
            list-style: none;
            margin: 0;
            padding: 0;
            display: table;
            table-layout: fixed;
            width: 100%;
            height:4rem;
        }
        .steps  > .step {
            position: relative;
            display: table-cell;
            text-align: center;
            font-size: 0.875rem;
            color:#6D6875;
        }
        .step:before {
            content: '';
            display: block;
            margin: 0 auto;
            background: #ffffff;
            border:2px solid #e6e6e6;
            color:#e6e6e6;
            width: 3rem;
            height: 3rem;
            text-align: center;
            margin-bottom: -4.2rem;
            line-height: 1.9rem;
            border-radius: 100%;
            position: relative;
            z-index: 1;
            font-weight:700;
            font-size:1rem;
            top: 10px;
        }
        .step:after {
            content: '';
            position: absolute;
            display: block;
            background: #9292b9;
            width: 100%;
            height: 0.125rem;
            top: 2.2rem;
            left: 50%;
        }
        .step:last-child:after {
            display: none;
        }
        .step ion-icon {
            position: absolute;
            margin-top: 35px;
            font-size: 30px;
            margin-left: 22px;
            z-index: 1;
            color: #9292b9;
        }
        .step.is-complete {
            color:#6D6875;
        }
        .step.is-complete:before {
            content: '';
            color: #46466d;
            background: #efeff5;
            border: 2px solid #9292b9;
        }
        .step.is-complete:after {
            background: #9292b9;
        }
        .step.is-active:before {
            color: #FFF;
            border: 2px solid #9292b9;
            background: #9292b9;
        } 
        .step.is-active ion-icon {
            color: white;
        }
        .deliveryInformation {
            margin-top: 40px;
        }
        .deliveryInformation h1 {
            background-color: black;
            color: white;
            font-size: 25px;
            text-align: center;
            margin-top: -25px;
            margin-left: auto;
            margin-right: auto;
            width: 500px;
            font-family: cursive;
            letter-spacing: 2px;
        }
        .deliveryInformation p {
            margin-left: 10px;
            text-align: left;
        }
        .table {
            display: table;
            font-size: 20px;
        }
        .table form {
            display: contents;
        }
        .header {
            font-weight: bold;
        }
        .header .cell {
            border-bottom: 2px solid black;
            padding-bottom: 10px;
        }
        .row {
            display: table-row;
        }
        .cell {
            display: table-cell;
            vertical-align: middle;
            border-bottom: 1px solid black;
        }
        .foodSummary {
            margin-top: 30px;
        }
        .nav-borders .nav-link.active {
            color: #c5ccd6;
            border-bottom-color: #c5ccd6;
        }
        .nav-borders .nav-link {
            color: #69707a;
            border-bottom-width: 0.125rem;
            border-bottom-style: solid;
            border-bottom-color: transparent;
            padding-top: 0.5rem;
            padding-bottom: 0.5rem;
            padding-left: 0;
            padding-right: 0;
            margin-left: 1rem;
            margin-right: 1rem;
        }
        .totalAmount {
            float: right;
            margin-top: -90px;
            font-size: 35px!important;
            font-weight: bold;
        }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="header.jsp"%>
        
        <nav class="nav nav-borders">
            <a class="nav-link active" href="fnbOrderDeliveryHistory.jsp" id="ordersNav">Orders</a>
            <a class="nav-link" href="OrderHistory.jsp?page=tickets" id="ticketsNav">Tickets</a>
            <a class="nav-link" href="favouriteList.jsp" id="favNav">Favourite</a>
        </nav>
        
        <!-- Section -->
        <section>
            <div>
                <h1 class="header">Delivery Order History</h1>
            </div>
            <nav id="horizontal">
                <ul class="menuList">
                    <li class="orderHistory selected">
                        <a href="FilterFnbOrderHistoryController?status=upcoming">Upcoming</a>
                    </li>
                    <li class="orderHistory">
                        <a href="FilterFnbOrderHistoryController?status=completed">Completed</a>
                    </li>
                </ul>
            </nav>
            <div>
                
                <% 
                    Account account = (Account)session.getAttribute("currentUser");
                    String emailAddress = account.getEmailAddress();

                    ArrayList<FnbOrder> fnbOrderList = fnbOrderDA.getUpcomingRecord(emailAddress);
                    
                    if(request.getAttribute("filterFnbOrderList") != null) {
                        fnbOrderList = (ArrayList<FnbOrder>) request.getAttribute("filterFnbOrderList");
                    }
                    
                    for(FnbOrder fnbOrder : fnbOrderList) { 
                %>
                
                        <div class="order" id="js-open" onclick="location.href='FnbOrderDeliveryHistoryController?id=<%= fnbOrder.getFnbOrderID() %>'">
                            <h1 style=
                                <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("Order placed")) { %>
                                        "color: #c3a2a2;">
                                <% } else if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("In the kitchen")) { %>
                                        "color: #c3bba2;">
                                <% } else if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("On the way")) { %>
                                        "color: #b3c3a2;">
                                <% } else { %>
                                        "color: #a2c3c3;">
                                <% } %>
                                <%= fnbOrder.getDeliveryStatus() %>
                                <% if(!fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")) { %>
                                    <div class="activeOrder">
                                        <li>
                                            <button>
                                            </button>
                                        </li>
                                    </div>
                                <% } %>
                            </h1>
                            <p>
                                <span><ion-icon name="calendar-outline"></ion-icon><%= fnbOrder.getDeliveryDateTime().substring(0, 10) %></span>
                                <span><ion-icon name="time-outline"></ion-icon><%= fnbOrder.getDeliveryDateTime().substring(11) %></span>
                            </p>
                            <p><span><ion-icon name="location-outline"></ion-icon><%= fnbOrder.getDeliveryAddress() %></span></p>
                            <p class="totalAmount">RM <%= String.format("%.2f", fnbOrder.getBooking().getPaymentId().getTotalAmount()) %></p>
                        </div>
                <% } %>
            </div>
        </section>
        
        <div class="my-modal">
            <div class="my-modal-content">  
                <% 
                    if(request.getAttribute("fnbOrder") != null) { 
                        FnbOrder fnbOrder = (FnbOrder) request.getAttribute("fnbOrder"); 
                %>
                
                    <ol class="steps">
                        <li class=
                        <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("Order placed")) { %>
                            "step is-active"
                        <% } else { %>
                            "step is-complete"
                        <% } %>
                            ><ion-icon name="clipboard-outline"></ion-icon>
                            Order Placed
                        </li>
                        <li class=
                        <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("In the kitchen")) { %>
                            "step is-active"
                        <% } else { %>
                            "step is-complete"
                        <% } %>
                            ><ion-icon name="restaurant-outline" style="margin-left: 26px;"></ion-icon>
                            In the Kitchen
                        </li> 
                        <li class=
                        <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("On the way")) { %>
                            "step is-active"
                        <% } else { %>
                            "step is-complete"
                        <% } %>
                            ><ion-icon name="car-sport-outline" style="margin-left: 19px;"></ion-icon>
                        On the Way
                        </li> 
                        <li class=
                        <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")) { %>
                            "step is-active"
                        <% } else { %>
                            "step is-complete"
                        <% } %>
                            ><ion-icon name="bag-check-outline" style="margin-left: 13px;"></ion-icon>
                        Delivered
                        </li> 
                    </ol>
                    
                    <button id="js-close" class="btn btn-primary"
                                    
                    <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")) { %>
                            onclick='location.href="FilterFnbOrderHistoryController?status=completed"'
                    <% } %>
                    
                    >x</button>
                    
                    <div class="deliveryInformation" style="border: 5px solid black">
                        <h1>Delivery Information</h1>
                        <p><b>Delivery Address:</b> <%= fnbOrder.getDeliveryAddress() %></p>
                        <p><b>Delivery Date Time:</b> <%= fnbOrder.getDeliveryDateTime() %></p>
                    </div>
                <% } %>
                <div class="foodSummary">
                    
                    <% 
                        if(request.getAttribute("fnbOrderLineListObj") != null) {
                            Object[] fnbOrderLineListObj = (Object[]) request.getAttribute("fnbOrderLineListObj");    
                            ArrayList<FnbOrderLine> fnbOrderLineList = (ArrayList<FnbOrderLine>) fnbOrderLineListObj[0];
                            ArrayList<Fnb> fnbList = (ArrayList<Fnb>) fnbOrderLineListObj[1];
                    %>
                    
                    <div class="table">
                        <div class="row header">
                            <div class="cell" style="width: 9%">PRODUCT</div>
                            <div class="cell" style="width: 25%"></div>
                            <div class="cell" style="width: 20%">QUANTITY</div>
                            <div class="cell" style="width: 20%">PRICE</div>
                            <div class="cell" style="width: 5%"></div>
                        </div>
                        
                        <% for(int  i = 0; i < fnbOrderLineList.size(); i++) { %>       
                                <div class="row">
                                    <div class="cell">
                                        <img class="cartItemImage" src="img/food/<%= fnbList.get(i).getFnbImage() %>" style="width: 150px; height: 150px;">
                                    </div>
                                    <div class="cell">
                                        <%= fnbList.get(i).getFnbDescription() %>
                                    </div>    
                                    <div class="cell">
                                        x<%= fnbOrderLineList.get(i).getQuantity() %>
                                    </div>
                                    <div class="cell">
                                        RM <%= String.format("%.2f", fnbOrderLineList.get(i).calculateFnbSubTotal()) %>
                                    </div>
                                </div>
                        <% } %>
                    </div>
                    <div class="table" style="float: right;">
                        <div class="row">
                            <div class="cell">
                                <strong style="font-size: 25px; margin-right: 20px">Subtotal</strong>
                            </div>
                            <% 
                                double fnbTotal = 0;
                                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                                    fnbTotal += fnbOrderLine.calculateFnbSubTotal();
                                }
                            %>
                            <div class="cell">
                                <span>RM <%= String.format("%.2f", fnbTotal) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="cell">
                                <strong style="font-size: 25px; margin-right: 20px">Delivery Fee</strong>
                            </div>
                            <div class="cell">
                                <span>RM <%= String.format("%.2f", FnbOrder.getDeliveryFee()) %></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="cell">
                                <strong style="font-size: 25px; margin-right: 20px">Total</strong>
                            </div>
                            <div class="cell">
                                <span>RM <%= String.format("%.2f", fnbTotal + FnbOrder.getDeliveryFee()) %></span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
            
        <!-- footer -->
        <footer style="width: 1020px;">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>
        
        <script> 
            <% if(request.getParameter("status") != null) { 
                        if(request.getParameter("status").equalsIgnoreCase("upcoming")) { %>
                            document.getElementsByClassName('orderHistory')[0].classList.add('selected');
                            document.getElementsByClassName('orderHistory')[1].classList.remove('selected');
                <% } else { %>
                            document.getElementsByClassName('orderHistory')[1].classList.add('selected');
                            document.getElementsByClassName('orderHistory')[0].classList.remove('selected');
                <% } 
                    } %>
            document.addEventListener("DOMContentLoaded",function(){
                window.addEventListener("pagehide",function(a){
                    window.name+="\ue000"+window.pageXOffset+"\ue000"+window.pageYOffset
                });
                if(window.name&&-1<window.name.indexOf("\ue000")){
                    var a=window.name.split("\ue000");
                    3<=a.length&&(window.name=a[0],window.scrollTo(parseFloat(a[a.length-2]),parseFloat(a[a.length-1])))
                }
            });
            
            var $body = $('body');
            $('#js-close').on('click',()=> {
                $('.my-modal').fadeOut();
                $body.removeClass('no-scroll');
            });
            
            <% if(request.getAttribute("fnbOrder") != null) { %>
                $('.my-modal').fadeIn();
                $body.addClass('no-scroll');
            <% } %>
                        
        </script>
    </body>
</html>
