<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList, java.time.format.DateTimeFormatter, java.time.*"%>
<jsp:useBean id="fnbCategoryDA" scope="application" class="model.FnbCategoryDA"></jsp:useBean>
<jsp:useBean id="fnbDA" scope="application" class="model.FnbDA"></jsp:useBean>
<jsp:useBean id="favItemDA" scope="application" class="model.FavItemDA"></jsp:useBean>

<!DOCTYPE html>
<html class="background" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="foodStyle.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <%--@include file="checkCustomerAccess.jsp"--%>
    </head>
    
    <body>
        <!-- Header -->
        <%@include file="header.jsp"%>
        
        <!-- Section -->
        <section> 
            <div class="hexagon-menu clear">
                <div class="hexagon-item">
                    <div class="hex-item">
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                    <div class="hex-item">
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                    <a class="hex-content" href="FilterFoodCategoryController?id=all">
                        <span class="hex-content-inner">
                            <span class="icon">
                                <i class="fa fa-universal-access"></i>
                            </span>
                            <span class="title">All</span>
                        </span>
                        <svg viewBox="0 0 173.20508075688772 200" height="200" width="174" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M86.60254037844386 0L173.20508075688772 50L173.20508075688772 150L86.60254037844386 200L0 150L0 50Z" fill="rgb(13, 5, 31)"></path></svg>
                    </a>
                </div>
                
                <% 
                    ArrayList<FnbCategory> fnbCategoryList = fnbCategoryDA.getRecord();
                    int counter = 8;
                    
                    for(FnbCategory fnbCategory : fnbCategoryList) {
                        if(counter < 5) {
                            if(counter == 4) {      
                %>
                                <div class="hexagon-item even-line" style="margin-left:56px">
                    <% } else { %>
                                <div class="hexagon-item even-line">
                    <% }
                                counter--;
                                if(counter == 0) {
                                    counter = 9;
                                }
                        } else { 
                    %>
                            <div class="hexagon-item">
                    <%       
                            counter--;
                        }
                    %>
                        <div class="hex-item">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                        <div class="hex-item">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                        <a class="hex-content" href="FilterFoodCategoryController?id=<%= fnbCategory.getFnbCategoryID() %>">
                            <span class="hex-content-inner">
                                <span class="icon">
                                    <i class="fa fa-universal-access"></i>
                                </span>
                                <span class="title"><%= fnbCategory.getFnbCategory() %></span>
                            </span>
                            <svg viewBox="0 0 173.20508075688772 200" height="200" width="174" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M86.60254037844386 0L173.20508075688772 50L173.20508075688772 150L86.60254037844386 200L0 150L0 50Z" fill="rgb(13, 5, 31)"></path></svg>
                        </a>
                    </div>
            <% } %>
            </div>
            
            <div id="toast"></div>
            
            <div class="product">     
                
                <%
                    //int totalFavItem = 0;
                    ArrayList<FavItem> favItemList = favItemDA.getRecordByAccount(((Account) session.getAttribute("currentUser")).getEmailAddress());
                    //totalFavItem = favItemList.size();

                    ArrayList<Fnb> fnbList = fnbDA.getRecord();;
                    ArrayList<FnbCategory> filterFnbCategoryList = new ArrayList<FnbCategory>();
                    
                    if(request.getAttribute("filterFnbList") != null) {
                        fnbList = (ArrayList<Fnb>) request.getAttribute("filterFnbList");
                        
                        for(FnbCategory fnbCategory : fnbCategoryList) {
                            if(fnbCategory.getFnbCategoryID().equals(request.getParameter("id"))) {
                                filterFnbCategoryList.add(fnbCategory);
                            }
                        }

                        fnbCategoryList = (ArrayList<FnbCategory>) filterFnbCategoryList.clone();
                    }

                        for(FnbCategory fnbCategory : fnbCategoryList) {
                %>
                            <h1 id="<%= fnbCategory.getFnbCategory() %>"><%= fnbCategory.getFnbCategory() %></h1>

                           <div class="flex-container">     
                            <%
                                for(Fnb fnb : fnbList) {
                                    if(fnb.getFnbCategory().getFnbCategory().equals(fnbCategory.getFnbCategory())) {
                                        if(fnb.isActive() && fnb.getFnbStockLeft() > 0) {
                            %>
                                            <form method="post" action="AddToCartController" id="addToCartForm">
                                                <input type="hidden" name="action" value="add" />
                                                <div id="<%= fnb.getFnbID() %>">
                                                    <p class="itemName"><b><%= fnb.getFnbDescription() %></b></p>
                                                    <button 
                                                    <% boolean isFav = false;
                                                            for(FavItem favItem : favItemList) {
                                                                if(fnb.getFnbID().equals(favItem.getFnb().getFnbID())) { 
                                                                    isFav = true;    
                                                    %>
                                                                        class="like liked"
                                                        <% 
                                                                    } 
                                                                } 
                                                                if(!isFav) { 
                                                        %>
                                                                    class="like"
                                                        <% } %>
                                                        
                                                        type="button" onclick="location.href='AddToFavController?id=<%= fnb.getFnbID() %>'"></button>
                                                    
                                                    <p style="text-align:center"><img class="itemImage" src="img/food/<%= fnb.getFnbImage() %>" /></p>
                                                    <p class="itemPrice">RM <%= String.format("%.2f", fnb.getFnbPrice()) %></p>
                                                    <button type="submit" class="add-to-cart">ADD TO CART</button>
                                                    <input type="hidden" name="fnbID" value="<%= fnb.getFnbID() %>" />
                                                </div>
                                            </form>
                            <%
                                        }   
                                    }
                                } 
                            %>
                            </div>
                <% } %>      
            </div>
            
            <%
                int cartItem = 0;
                if(session.getAttribute("fnbOrderLineList") != null) {
                    ArrayList<FnbOrderLine> fnbOrderLineList = (ArrayList<FnbOrderLine>)session.getAttribute("fnbOrderLineList");
                    cartItem = fnbOrderLineList.size();
                }
                
                if(session.getAttribute("fnbOrder") != null && cartItem == 0) {
                } else {
            %>
            
                <button id="cartside" class="cartside" onclick="location.href='cart.jsp'" style="width:auto;">
                    <ion-icon name="cart-outline" id="cart"></ion-icon>
                    <span class="totalItem"><%= cartItem %></span>
                </button> 
            
            <% } %>

        </section>

        <!-- footer -->
        <footer style="margin-top: 100px;">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer> 

        <script type="text/javascript">
            <% if(request.getParameter("id") != null) { %>
                    window.scrollTo(0, 450); // values are x,y-offset
            <% } %>
            
            <% 
                if("add".equals(request.getParameter("action"))) { 
                    if(request.getAttribute("errMsg") == null) { 
            %>
                        var list = document.getElementById("toast");
                        list.classList.add("show");
                        list.innerHTML = '<ion-icon name="cart-outline"></ion-icon> Product added to cart';
                        setTimeout(function(){
                            list.classList.remove("show");
                        }, 3000);
                <% }
                } %>
                    
            <% 
                if("add".equals(request.getParameter("action"))) { 
                    if(request.getAttribute("errMsg") == null) { 
            %>
                        var list = document.getElementById("toast");
                        list.classList.add("show");
                        list.innerHTML = '<ion-icon name="cart-outline"></ion-icon> Product added to cart';
                        setTimeout(function(){
                            list.classList.remove("show");
                        }, 3000);
                <% }
                } %>
                
            <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>
            
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
