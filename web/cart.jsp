<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*, java.time.*, java.time.format.*" %>
<jsp:useBean id="seatDA" scope="application" class="model.SeatDA"></jsp:useBean>
<jsp:useBean id="ticketTypeDA" scope="application" class="model.TicketTypeDA"></jsp:useBean>
    
<%  boolean isFnbOrderInSession = false; 
        FnbOrder fnbOrder = new FnbOrder();
        
        if(session.getAttribute("fnbOrder") != null) {
            isFnbOrderInSession = true;
            fnbOrder = (FnbOrder) session.getAttribute("fnbOrder");
        } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <%@include file="checkCustomerAccess.jsp"%>
        
        <style>
        section {
            font-family: cursive;
            min-height: 800px;
            background: linear-gradient(to top, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);
            display: table;
            width: 100%;
        }
        h1.header {
            line-height: 50px;
            text-transform: uppercase;
            font-size: 50px;
            background: linear-gradient(to bottom, rgb(85, 25, 97), rgb(13, 5, 31));
            color:rgb(194, 158, 201);
            width: 100%;
            letter-spacing: 15px;
            text-align: center;
            word-spacing: 15px;
            margin-bottom: 70px;
            margin-left: 0px;
            margin-top: 0px;
        } 
        ion-icon[name="arrow-back-circle-outline"] {
            float: left;
            color: white;
            cursor: pointer;
        }
        /* Cart Food Product */
        .foodSummary {
            margin-top: 40px;
            padding: 10px;
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
        .ticketSummary, .foodSummary, .deliveryInformation {
            margin-left: 10px;
            margin-right: 10px;
        }
        .foodSummary {
            min-height: 262px;
        }
        .ticketSummary h1, .deliveryInformation h1 {
            background-color: black;
            color: white;
            font-size: 35px;
            text-align: center;
            margin-top: -25px;
            margin-left: auto;
            margin-right: auto;
            width: 800px;
            font-family: cursive;
            letter-spacing: 2px;
            margin-bottom: 0px;
        }
        .ticketSummary p {
            margin-left: 10px;
        }
        /* The design of number input tag */
        input[type=number] {
            -webkit-appearance: textfield;
            -moz-appearance: textfield;
            appearance: textfield;
            background-color: black;
            color: white;
        }
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
        }
        .number-input {
            display: inline-flex;
        }
        .number-input,
        .number-input * {
            box-sizing: border-box;
        }
        .number-input button {
            outline: none;
            -webkit-appearance: none;
            background-color: #cdb1f1;
            border: none;
            align-items: center;
            justify-content: center;
            width: 3em;
            cursor: pointer;
            margin: 0;
            position: relative;
        }
        .number-input button:before,
        .number-input button:after {
            display: inline-block;
            position: absolute;
            content: '';
            width: 1em;
            height: 2px;
            background-color: white;
            transform: translate(-50%, -50%);
        }
        .number-input button.plus:after {
            transform: translate(-50%, -50%) rotate(90deg);
        }
        .number-input input[type=number] {
            max-width: 4rem;
            padding: .5rem;
            border: none;
            border-width: 0 2px;
            font-size: 1em;
            height: 2em;
            font-weight: bold;
            text-align: center;
            background: white;
            color: black;
        }
        .delete {
            color: white;
            background-color: #EB5757;
            border: none;
            border-radius: .3em;
            font-weight: bold;
            padding: 10px;
            font-size: 17px;
            cursor: pointer;
        }
        .delete:hover {
            background-color: #CC4C4C;
        }
        .cartTotal {
            float: right;
            top: 30px;
        }
        .col-sm-12.empty-cart-cls.text-center {
            text-align: center;
        }
        .card-body {
            padding: 30px;
            background-color: transparent
        }
        .button {
            display: inline-block;
            border-radius: 4px;
            background-color: #cdb1f1;
            border: none;
            color: #FFFFFF;
            text-align: center;
            font-size: 15px;
            padding: 10px;
            width: 125px;
            transition: all 0.5s;
            cursor: pointer;
            margin: 5px;
            margin-right: 10px;
        }
        .button span {
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.5s;
        }
        .button span:after {
            content: '\00bb';
            position: absolute;
            opacity: 0;
            top: 0;
            right: -20px;
            transition: 0.5s;
        }
        .button:hover span {
            padding-right: 25px;
        }
        .button:hover span:after {
            opacity: 1;
            right: 0;
        } 
        .checkout {
            width: 100%;
            float: right;
            text-align: right;
            margin-top: 70px;
        }
        .ticketSummary .table {
            margin: 0 auto;
            text-align: center;
        }
        .ticketSummary .cell {
            border-bottom: none;
        }
        .ticketSummary .table:nth-of-type(2) .cell {
            padding-left: 20px;
            padding-right: 20px;
        }
        .ticketSummary .row {
            line-height: 0px;
        }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="header.jsp"%>
        
        <!-- Section -->
        <section>
            <div class="cart">
                <div class="cartContent">
                    <section class="orderSummary">
                        <h1 class="header">
                            <ion-icon name="arrow-back-circle-outline" onclick="location.href='food.jsp'"></ion-icon>
                            Order Summary
                        </h1>
                        
                        <% 
                            if(isFnbOrderInSession) { 
                        %>
                        
                                <div class="deliveryInformation" style="border: 5px solid black">
                                    <h1>Delivery Information</h1>
                                    <p><b>Delivery Address:</b> <%= fnbOrder.getDeliveryAddress() %></p>
                                    <p><b>Delivery Date Time:</b> <%= fnbOrder.getDeliveryDateTime() %></p>
                                </div>
                                
                        <% 
                            } else { 
                                MovieSchedule movieScheduleDetails = (MovieSchedule)session.getAttribute("movieScheduleDetails");
                                List<Ticket> ticketList = (List<Ticket>) session.getAttribute("ticketList"); 

                                LocalDateTime showDateTime = movieScheduleDetails.getShowDateTime();

                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm a");
                                String formatDateTime = showDateTime.format(formatter);
                        %>
                                    
                                <div class="ticketSummary" style="border: 5px solid black;display: table;width: 97%;">
                                    <h1 class="movieInformation"><%= movieScheduleDetails.getMovie().getMovieName() %></h1>
                                    <div class="table">
                                        <div class="row">
                                            <div class="cell">
                                                <p>
                                                    <b><ion-icon name="watch-outline" style="font-size: 30px"></ion-icon></ion-icon></b>
                                                    <span><%= formatDateTime %></span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="cell">
                                                <p>
                                                    <b><ion-icon name="tv-outline" style="font-size: 30px"></ion-icon></b>
                                                    <span><%= movieScheduleDetails.getTheatre().getTheatreDesc() %></span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="cell">
                                                <p>
                                                    <b><img src="img/icon/seat.png" alt="Seat Icon" height="30px" /></b> 
                                                    <span>
                                                        <% 
                                                            for(int i = 0; i < ticketList.size(); i++) { 
                                                                Seat seat = seatDA.retrieveRecord(ticketList.get(i).getSeatId().getSeatId());
                                                        %>
                                                                    <%= seat.getSeatNo() %>   
                                                            <%  
                                                                if(i != ticketList.size() - 1) { 
                                                            %>
                                                                    ,
                                                        <% 
                                                                    }
                                                            } 
                                                        %>
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="table">
                                        <div class="row">
                                            <% 
                                                List<TicketType> ticketTypeList = ticketTypeDA.retrieveAllRecordIf();
                                                for(int i = 0; i < ticketTypeList.size(); i++) {
                                                    TicketType ticketType = ticketTypeList.get(i);
                                            %>
                                                    <div class="cell">
                                                        <p><b><%= ticketType.getTicketTypeDesc() %></b> </p>
                                                    </div>
                                        <% } %>
                                        </div>
                                        <div class="row">
                                            <%
                                                int[] count = new int[ticketTypeList.size()];
                                                for(int i = 0; i < ticketTypeList.size(); i++) {
                                                    for(int j = 0; j < ticketList.size(); j++) {  
                                                        if(ticketList.get(j).getTicketType().getTicketTypeId().equals(ticketTypeList.get(i).getTicketTypeId())) {
                                                            count[i] ++;
                                                        }
                                                    }
                                                }
                                                
                                                for(int i = 0; i < count.length; i++) {
                                            %>
                                                    <div class="cell">
                                                        <p><b><%= count[i] %></b> </p>
                                                    </div>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="table" style="float: right; margin-bottom: 30px; margin-top: 30px;">
                                        <div class="row">
                                            <div class="cell" style="padding-right: 0px;">
                                                <strong style="font-size: 25px; margin-right: 20px">Subtotal</strong>
                                            </div>
                                            <div class="cell" style="padding-right: 10px;">
                                                <span><%= session.getAttribute("movieTotalPrice") %> </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        <% } %>
                        
                        <%
                            if(session.getAttribute("fnbOrderLineList") != null) {
                                ArrayList<FnbOrderLine> fnbOrderLineList = (ArrayList<FnbOrderLine>)session.getAttribute("fnbOrderLineList");
                                if(fnbOrderLineList.size() > 0) {
                        %>
                                    <div class="foodSummary">
                                        <div class="table">
                                            <div class="row header">
                                                <div class="cell" style="width: 9%">PRODUCT</div>
                                                <div class="cell" style="width: 25%"></div>
                                                <div class="cell" style="width: 20%">QUANTITY</div>
                                                <div class="cell" style="width: 20%">PRICE</div>
                                                <div class="cell" style="width: 5%"></div>
                                            </div>

                                            <%
                                                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                                                    Fnb fnb = fnbOrderLine.getFnb();
                                            %>

                                                    <div class="row">
                                                            <div class="cell">
                                                                <img class="cartItemImage" src="img/food/<%= fnb.getFnbImage() %>" style="width: 150px; height: 150px;">
                                                            </div>
                                                            <div class="cell">
                                                                <%= fnb.getFnbDescription() %>
                                                            </div>    
                                                            <div class="cell">
                                                                <form method="post" action="CartQuantityController">
                                                                    <div class="number-input">
                                                                        <button onclick="this.parentNode.querySelector('input[type=number]').stepDown();" class="minus"></button>
                                                                        <input class="quantity" type="number" min="1" max="<%= fnb.getFnbStockLeft() %>" value="<%= fnbOrderLine.getQuantity() %>" readonly />
                                                                        <button onclick="this.parentNode.querySelector('input[type=number]').stepUp();" class="plus"></button>
                                                                        <input type="hidden" name="scrollPosition" />
                                                                    </div>
                                                                    <input type="hidden" name="fnbOrderLineID" id="fnbOrderLineID" value="<%= fnbOrderLine.getFnbOrderLineID() %>"/>
                                                                </form>
                                                            </div>
                                                            <div class="cell">
                                                                <p>RM <%= String.format("%.2f", fnbOrderLine.calculateFnbSubTotal()) %></p>
                                                            </div>
                                                            <div class="cell"> 
                                                                <form method="post" action="DeleteCartController">
                                                                    <button type=button" class="btn delete">Delete</button>
                                                                    <input type="hidden" name="scrollPosition" />
                                                                    <input type="hidden" name="fnbOrderLineID" id="fnbOrderLineID" value="<%= fnbOrderLine.getFnbOrderLineID() %>"/>
                                                                </form>
                                                            </div>
                                                        </form>
                                                    </div>                 
                                            <% } %>       
                                        </div>

                                        <% 
                                                double fnbTotal = 0;
                                                for(FnbOrderLine fnbOrderLine : fnbOrderLineList) {
                                                    fnbTotal += fnbOrderLine.calculateFnbSubTotal();
                                                }
                                        %>
                                        
                                        <div class="table" style="float: right;">
                                            <div class="row">
                                                <div class="cell">
                                                    <strong style="font-size: 25px; margin-right: 20px">Subtotal</strong>
                                                </div>
                                                <div class="cell">
                                                    <span>RM <%= String.format("%.2f", fnbTotal) %></span>
                                                </div>
                                            </div>
                                                
                                            <% if(isFnbOrderInSession) { %>
                                                <div class="row">
                                                    <div class="cell">
                                                        <strong style="font-size: 25px; margin-right: 20px">Delivery Fee</strong>
                                                    </div>
                                                    <div class="cell">
                                                        <span>RM <%= String.format("%.2f", FnbOrder.getDeliveryFee()) %></span>
                                                    </div>
                                                </div>
                                            <% } %>
                                            
                                            <div class="row">
                                                <div class="cell">
                                                    <strong style="font-size: 25px; margin-right: 20px">Total</strong>
                                                </div>
                                                <div class="cell">
                                                    <span>RM 
                                                        <% 
                                                            double total = 0;
                                                            if(isFnbOrderInSession) { 
                                                               total =  fnbTotal + FnbOrder.getDeliveryFee();
                                                            } else {
                                                                double movieTotalPrice = Double.parseDouble(((String) session.getAttribute("movieTotalPrice")).substring(2));
                                                                total = fnbTotal + movieTotalPrice;
                                                            }
                                                            session.setAttribute("totalAmount", total);
                                                        %>
                                                            <%= String.format("%.2f", total) %>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <% } else { 
                                            if(isFnbOrderInSession) {
                                %>
                                                <div class="card-body cart">
                                                    <div class="col-sm-12 empty-cart-cls text-center"> <img src="img/icon/emptyCart.png" width="350px" height="200px" style="margin-left: 75px;" class="img-fluid mb-4 mr-3">
                                                        <h3><strong>Your Cart is Empty</strong></h3>
                                                        <h4>Once you add something to your cart - it will appear here</h4> 
                                                    </div>
                                                </div>
                                <%      }
                                        }
                                } %>  
                        
                        <% 
                            int size = 0;
                            if(session.getAttribute("fnbOrderLineList") != null) {
                                size = ((ArrayList<FnbOrderLine>) session.getAttribute("fnbOrderLineList")).size();
                            }
                                if(isFnbOrderInSession && size == 0) { 
                        %>
                        <% } else { %>
                            <div class="checkout">
                                <a href="CustPaymentAdd.jsp"><button class="button" style="vertical-align:middle"><span>Checkout </span></button>
                            </div>
                        <% } %>
                    </section>
                </div>
            </div>
        </section>
        
        <!-- footer -->
        <footer style="width: 1020px;">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>
        
        <script>
            $(".minus").on("click", function() {
                $(this).append('<input type="hidden" name="action" value="decrease" />');
            });
            
            $(".plus").on("click", function() {
                $(this).append('<input type="hidden" name="action" value="increase" />');
            });
            
            document.addEventListener("DOMContentLoaded",function(){
                window.addEventListener("pagehide",function(a){
                    window.name+="\ue000"+window.pageXOffset+"\ue000"+window.pageYOffset
                });
                if(window.name&&-1<window.name.indexOf("\ue000")){
                    var a=window.name.split("\ue000");
                    3<=a.length&&(window.name=a[0],window.scrollTo(parseFloat(a[a.length-2]),parseFloat(a[a.length-1])))
                }
            });
            
            <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>
        </script>
    </body>
</html>
