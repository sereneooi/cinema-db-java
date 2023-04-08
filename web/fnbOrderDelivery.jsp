<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList, java.time.format.DateTimeFormatter, java.time.*, java.text.*" %>
<jsp:useBean id="fnbCategoryDA" scope="application" class="model.FnbCategoryDA"></jsp:useBean>
<jsp:useBean id="fnbOrderDA" scope="application" class="model.FnbOrderDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <style>
            .my-modal {
                position: fixed;
                background-color: rgba(255, 255, 255, .8);
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                display: none;
                overflow: auto;
                z-index: 11;
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
            .customerInformation {
                margin-top: 40px;
            }
            .customerInformation h1 {
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
            .customerInformation p {
                margin: 10px;
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
        </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            
            <div class="header">
                <h1>Food & Beverages Order Delivery</h1>
            </div>
            
            <% 
                LocalDate today = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-YYYY");
                String countDeliveryStatusDate = formatter.format(today);
                
                if(request.getAttribute("reformattedStr") != null) {
                    countDeliveryStatusDate = (String) request.getAttribute("reformattedStr");
                }
            %>
            
            <ul class="flex-container">
                <li class="flex-item">
                    <ion-icon name="clipboard-outline"></ion-icon>
                    <h2>Order Placed</h2>
                    <h3><%= fnbOrderDA.countDeliveryStatus("Order placed", countDeliveryStatusDate) %></h3>
                </li>
                <li class="flex-item">
                    <ion-icon name="restaurant-outline"></ion-icon>
                    <h2>In the Kitchen</h2>
                    <h3><%= fnbOrderDA.countDeliveryStatus("In the kitchen", countDeliveryStatusDate) %></h3>
                </li>
                <li class="flex-item">
                    <ion-icon name="car-sport-outline"></ion-icon>
                    <h2>On the Way</h2>
                    <h3><%= fnbOrderDA.countDeliveryStatus("On the way", countDeliveryStatusDate) %></h3>
                </li>
                <li class="flex-item">
                    <ion-icon name="bag-check-outline"></ion-icon>
                    <h2>Delivered</h2>
                    <h3><%= fnbOrderDA.countDeliveryStatus("Delivered", countDeliveryStatusDate) %></h3>
                </li>
            </ul>
            
            <form method="get" action="FilterFnbOrderDeliveryController" id="DeliveryDateForm">
                <div class="form-group focused" style="margin-top: 15px">
                    <label class="form-label" for="deliveryDate">DeliveryDate</label>
                    <input type="date" name="deliveryDate" id="deliveryDate" class="form-input" style="width: 20%" required />
                </div>
            </form>
            
            <div class="body" style="margin-top: 20px">          
                <table id="example" style="width:100%">
                    <thead>
                        <tr>
                            <th style="min-width: 118px">
                                <form class="sortingForm" method="post" action="SortFnbOrderDeliveryController">
                                    <input type="text" name="columnName" value="FnbOrderID" size="7" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 166px">
                                <form class="sortingForm" method="post" action="SortFnbOrderDeliveryController">
                                    <input type="text" name="columnName" value="FnbOrderDateTime" size="13" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th>
                                <form class="sortingForm" method="post" action="SortFnbOrderDeliveryController">
                                    <input type="text" name="columnName" value="DeliveryAddress" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 218px;">
                                <form class="sortingForm" method="post" action="SortFnbOrderDeliveryController">
                                    <input type="text" name="columnName" value="DeliveryDateTime" size="12" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 142px">
                                <form class="sortingForm" method="post" action="SortFnbOrderDeliveryController">
                                    <input type="text" name="columnName" value="DeliveryStatus" size="10" readonly />
                                    <button type="button" class="order">
                                        <ion-icon name="caret-up-outline" class="asc"></ion-icon>
                                        <ion-icon name="caret-down-outline" class="desc"></ion-icon>
                                    </button>
                                </form>
                            </th>
                            <th style="min-width: 90px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Display row data
                            ArrayList<FnbOrder> fnbOrderList = fnbOrderDA.getDeliveryRecord(formatter.format(today));
                            int size = fnbOrderList.size();
                            
                            if(request.getAttribute("filterFnbOrderList") != null) {
                                fnbOrderList = (ArrayList<FnbOrder>) request.getAttribute("filterFnbOrderList");
                            } else if(request.getAttribute("sortFnbOrderList") != null) {
                                fnbOrderList = (ArrayList<FnbOrder>) request.getAttribute("sortFnbOrderList");
                            }
                            
                            for (FnbOrder fnbOrder : fnbOrderList) {
                        %>
                                <tr>
                                    <td><a href="FnbOrderDeliveryLineController?id=<%= fnbOrder.getFnbOrderID() %>"><%= fnbOrder.getFnbOrderID() %></a></td>
                                    <td><%= fnbOrder.getFnbOrderDateTime() %></td>
                                    <td><%= fnbOrder.getDeliveryAddress() %></td>
                                    <td><%= fnbOrder.getDeliveryDateTime() %></td>
                                    <td>
                                        <p class="deliveryStatus" style=
                                            <% if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("Order placed")) { %>
                                                "background: #c3a2a2">
                                            <% } else if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("In the kitchen")) { %>
                                                "background: #c3bba2">
                                            <% } else if(fnbOrder.getDeliveryStatus().equalsIgnoreCase("On the way")) { %>
                                                "background: #b3c3a2">
                                            <% } else { %>
                                                "background: #a2c3c3">
                                            <% } %>
                                        <%= fnbOrder.getDeliveryStatus() %></p></td>
                                        <td>
                                            <% if(!fnbOrder.getDeliveryStatus().equalsIgnoreCase("Delivered")){ %>
                                                <form class="open-form-update" method="post" action="GetFnbOrderDeliveryController">
                                                    <input type="hidden" name="fnbOrderID" value="<%= fnbOrder.getFnbOrderID() %>" />
                                                    <button class="btn-update">
                                                        <ion-icon name="pencil-outline"></ion-icon>
                                                    </button>
                                                </form>
                                            <% } %>
                                        </td>
                                </tr>
                        <% } %>
                    </tbody>
                </table>
                    
                <p>Showing <%= fnbOrderList.size() %> entries</p>
                
            </div>
        </div>
                
        <div class="my-modal">
            <div class="my-modal-content">  
                <% 
                    if(request.getAttribute("fnbOrderLineListObj") != null) {
                        FnbOrder fnbOrderObj = (FnbOrder) request.getAttribute("fnbOrderObj");
                        SimpleDateFormat fromUser = new SimpleDateFormat("dd-MM-yyyy");
                        SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
                        String deliveryDate = myFormat.format(fromUser.parse(fnbOrderObj.getDeliveryDateTime().substring(0, 10)));
                    
                        Object[] fnbOrderLineListObj = (Object[]) request.getAttribute("fnbOrderLineListObj");    
                        ArrayList<FnbOrderLine> fnbOrderLineList = (ArrayList<FnbOrderLine>) fnbOrderLineListObj[0];
                        ArrayList<Fnb> fnbList = (ArrayList<Fnb>) fnbOrderLineListObj[1];
                        Account account = (Account) fnbOrderLineListObj[2];
                %>
                    
                    <button id="js-close" class="btn btn-primary" onclick="location.href='FilterFnbOrderDeliveryController?deliveryDate=<%= deliveryDate %>'">x</button>
                    
                    <div class="customerInformation" style="border: 5px solid black">
                        <h1>Customer Information</h1>       
                        <p><b>Name:</b> <%= account.getName() %></p>
                        <p><b>Contact No:</b> <%= account.getContactNo() %></p>
                        <p><b>Email Address:</b> <%= account.getEmailAddress() %></p>
                    </div>

                <div class="foodSummary">

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
        
        <script>
            <% if(request.getAttribute("successMsg") != null) { %>
                swal(
                    'Success',
                    '<%= request.getAttribute("successMsg") %>' ,
                    'success'
                )
            <% } %>
                
            <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>
            
            $('#example tbody').on('click', '.btn-delete', function () {
                swal({
                    title: "Are you sure?", 
                    text: "Do you want to delete? This process cannot be undone", 
                    type: "warning",
                    confirmButtonText: "Delete",
                    showCancelButton: true
                })
                    .then((result) => {
                        if (result.value) {
                            $(this).parent().submit();
                        } 
                    })
            });
            
            $('.order').on('click', function () {
                <% if(fnbOrderList.size() > 0) { %>
                    if($(this).find('.asc').css('color') == 'rgb(130, 135, 223)') {
                        $(this).append('<input type="hidden" name="order" value="desc" />');
                    } else {
                        $(this).append('<input type="hidden" name="order" value="asc" />');
                    }
                    $(this).append('<input type="hidden" name="deliveryDate" value="' + document.getElementById("deliveryDate").value + '" />');
                    $(this).parent().submit();
                <% } %>
            });
            
            <% 
                if(request.getParameter("order") != null) {
                    String order = request.getParameter("order");
                    String columnName = request.getParameter("columnName");
                    if("asc".equals(order)) {
            %>
                        let form = document.getElementsByClassName('sortingForm');
                        for(let i = 0; i < form.length; i++) {
                            if(form[i].firstElementChild.value == '<%= columnName %>') {
                                form[i].querySelector('.asc').style.color = 'rgb(130, 135, 223)';
                            } 
                        }
            <% } else { %>
                        let form = document.getElementsByClassName('sortingForm');
                        for(let i = 0; i < form.length; i++) {
                            if(form[i].firstElementChild.value == '<%= columnName %>') {
                                form[i].querySelector('.asc').style.color = 'rgb(217, 217, 217)';
                                form[i].querySelector('.desc').style.color = 'rgb(130, 135, 223)';
                            }
                        }
            <% } 
                } %>
                    
            <%
                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime now = LocalDateTime.now();
                LocalDateTime max = now.plusDays(2);
            %>
                document.getElementById("deliveryDate").setAttribute("value", '<%= df.format(now) %>');
                document.getElementById("deliveryDate").setAttribute("max", '<%= df.format(max) %>');
                
                <% if(request.getParameter("deliveryDate") != null) { %>
                    document.getElementById("deliveryDate").setAttribute("value", '<%= request.getParameter("deliveryDate") %>');
                <% } %>
            
            $('#deliveryDate').change(function(){               
                $(this).parents('form').submit();
            });
    
            $('input').focus(function(){
                $(this).parents('.form-group').addClass('focused');
            });

            $('input').blur(function(){
                var inputValue = $(this).val();
                if (inputValue == "") {
                    $(this).removeClass('filled');
                    $(this).parents('.form-group').removeClass('focused');  
                } else {
                    $(this).addClass('filled');
                }
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
            
            var $body = $('body');
            $('#js-close').on('click',()=> {
                $('.my-modal').fadeOut();
                $body.removeClass('no-scroll');
            });
            
            <% if(request.getAttribute("fnbOrderLineListObj") != null) { %>
                $('.my-modal').fadeIn();
                $body.addClass('no-scroll');
            <% } %>
               
        </script>
    </body>
</html>
