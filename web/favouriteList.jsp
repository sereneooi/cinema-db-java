<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList" %>
<jsp:useBean id="favItemDA" scope="application" class="model.FavItemDA"></jsp:useBean>
<jsp:useBean id="fnbDA" scope="application" class="model.FnbDA"></jsp:useBean>

<!DOCTYPE html>
<html class="background" lang="en">
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
            font-family: 'mahelisa';
            font-size: 50px;
            background: linear-gradient(to bottom, rgb(85, 25, 97), rgb(13, 5, 31));
            color:rgb(194, 158, 201);
            width: 100%;
            letter-spacing: 15px;
            text-align: center;
            word-spacing: 15px;
            margin-bottom: 70px;
            margin-left: 0px;
        }  
        ion-icon[name="arrow-back-circle-outline"] {
            float: left;
            color: white;
            cursor: pointer;
        }
        .table {
            display: table;
            font-size: 20px;
            margin-left: 10px;
            margin-right: 10px;
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
        .cell:nth-of-type(1) {
            text-align: center;
        }
        form > button {
            background: none;
            border: none;
        }
        ion-icon[name="trash-outline"] {
            font-size: 30px;
            cursor: pointer;
            color: #808080;
        }
        /* Add to Cart Button */
        .add-to-cart {
            margin-top: 0px;
            margin-left: 38px;
            border-radius: 50px;
            text-decoration: none;
            text-transform: uppercase;
            display: inline-block;
            padding: 10px 20px;
            color: rgba(255,255,255,0.9);
            background: linear-gradient(-45deg, #ffa63d, #ff3d77, #338aff, #3cf0c5);
            border: none;
            background-size: 600%;
            animation: anime 16s linear infinite;
            box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
            transition: all .3s ease-in-out;
            font-size: 17px;
            cursor: pointer;
        }
        .add-to-cart:active {
            box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
            transform: translateY(1px);
            opacity: 0.8;
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
        .col-sm-12.empty-cart-cls.text-center {
            text-align: center;
        }
        .card-body {
            padding: 30px;
            background-color: transparent
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
        </style>
        
    </head>
    <body>
        <!-- Header -->
        <%@include file="header.jsp"%>
        
        <nav class="nav nav-borders">
            <a class="nav-link" href="fnbOrderDeliveryHistory.jsp" id="ordersNav">Orders</a>
            <a class="nav-link" href="OrderHistory.jsp?page=tickets" id="ticketsNav">Tickets</a>
            <a class="nav-link active" href="favouriteList.jsp" id="favNav">Favourite</a>
        </nav>
        
        <!-- Section -->
        <section>
            <div class="favouriteList">
                <h1 class="header">
                    <% if(session.getAttribute("fnbOrder") != null || session.getAttribute("ticketList") != null) { %>
                        <ion-icon name="arrow-back-circle-outline" onclick="location.href='food.jsp'"></ion-icon>
                    <% } %>
                    Favourite List
                </h1>
                
                <%   
                    FavItem.validateStockAvailability();
                    
                    Account account = (Account) session.getAttribute("currentUser");
                    String emailAddress = account.getEmailAddress();
                    
                    ArrayList<FavItem> favItemList = favItemDA.getRecordByAccount(emailAddress);
                    ArrayList<Fnb> fnbList = fnbDA.getRecord();

                    if(favItemList.size() > 0) {
                %>
                    <div class="table">
                        <div class="row header">
                            <div class="cell" style="width: 5%"></div>
                            <div class="cell" style="width: 10%">PRODUCT</div>
                            <div class="cell" style="width: 30%"></div>
                            <div class="cell" style="width: 15%">PRICE</div>
                            <div class="cell" style="width: 19%"></div>
                        </div>

                        <%
                                for(FavItem favItem : favItemList) {
                                    for(Fnb fnb : fnbList) {
                                        if(favItem.getFnb().getFnbID().equals(fnb.getFnbID())) {
                        %>

                                            <div class="row">
                                                <div class="cell">
                                                    <form method="post" action="DeleteFavController">
                                                        <button type="submit"><ion-icon name="trash-outline"></ion-icon></button>
                                                        <input type="hidden" name="favItemID" value="<%= favItem.getFavItemID() %>" /> 
                                                    </form>
                                                </div>
                                                <div class="cell" style="width: 20%;">
                                                    <img class="cartItemImage" src="img/food/<%= fnb.getFnbImage() %>" style="width: 150px; height: 150px;">
                                                </div>
                                                <div class="cell">
                                                    <%= fnb.getFnbDescription() %>
                                                </div>    
                                                <div class="cell">
                                                    RM <%= String.format("%.2f", fnb.getFnbPrice()) %>
                                                </div>  
                                                <div class="cell">
                                                    <form method="post" action="AddToCartController">  
                                                        <input type="hidden" name="action" value="add" />
                                                        <button type="submit" class="add-to-cart">ADD TO CART</button>
                                                        <input type="hidden" name="fnbID" value="<%= fnb.getFnbID() %>" />
                                                        <input type="hidden" name="favourite" value="favourite" />
                                                    </form>
                                                </div>
                                            </div>
                        <%          }
                                    }
                                } %>
                            </div> 
            <% } else { %>
                        <div class="card-body cart">
                            <div class="col-sm-12 empty-cart-cls text-center"> <img src="img/icon/emptyFavList.png" width="350" height="150" class="img-fluid mb-4 mr-3">
                                <h3><strong>Your Favourite List is Empty</strong></h3>
                                <h4>You haven't saved any items to your favourite list yet</h4> 
                            </div>
                        </div>
            <% } %>
            </div>
        </section>
                
        <!-- footer -->
        <footer>
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>
        
        <script>
            document.addEventListener("DOMContentLoaded",function(){
                window.addEventListener("pagehide",function(a){
                    window.name+="\ue000"+window.pageXOffset+"\ue000"+window.pageYOffset
                });
                if(window.name&&-1<window.name.indexOf("\ue000")){
                    var a=window.name.split("\ue000");
                    3<=a.length&&(window.name=a[0],window.scrollTo(parseFloat(a[a.length-2]),parseFloat(a[a.length-1])))
                }
            });
        </script>
    </body>
</html>
