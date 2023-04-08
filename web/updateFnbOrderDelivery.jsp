<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.text.SimpleDateFormat, java.time.*, java.time.format.*" %>

<%
    FnbOrder fnbOrderObj = new FnbOrder();
    String deliveryDate = "";
    
    if(request.getAttribute("fnbOrderObj") != null) {
        fnbOrderObj = (FnbOrder) request.getAttribute("fnbOrderObj");

        SimpleDateFormat fromUser = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
        deliveryDate = myFormat.format(fromUser.parse(fnbOrderObj.getDeliveryDateTime().substring(0, 10)));
    } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css" type="text/css">
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            <div>
                <ion-icon name="arrow-back-circle-outline" onclick="location.href='FilterFnbOrderDeliveryController?deliveryDate=<%= deliveryDate %>'"></ion-icon>
                <h1>Update Fnb Order Delivery</h1>
            </div>

            <form method="post" action="UpdateFnbOrderDeliveryController">
                <div>
                    <div class="form-group focused">
                        <label class="form-label" for="fnbOrderID">FnbOrderID</label>              
                        <input name="fnbOrderID" class="form-input" type="text" value="<%= fnbOrderObj.getFnbOrderID() %>" readonly />
                        <span class="form-input-required">*</span>
                    </div>
                        
                    <div class="form-group focused">
                        <label class="form-label" for="fnbOrderDateTime">FnbOrderDateTime</label>              
                        <input name="fnbOrderDateTime" class="form-input" type="text" value="<%= fnbOrderObj.getFnbOrderDateTime() %>" readonly />
                        <span class="form-input-required">*</span>
                    </div>

                    <div class="form-group focused">
                        <label class="form-label" for="deliveryAddress">DeliveryAddress</label>
                        <input name="deliveryAddress" class="form-input" type="text" value="<%= fnbOrderObj.getDeliveryAddress() %>" autocomplete="off" required />
                        <span class="form-input-required">*</span>
                    </div>
                        
                    <div class="form-group focused">
                        <label class="form-label" for="deliveryDate">DeliveryDate</label>
                        <input name="deliveryDate" id="deliveryDate" class="form-input" type="date" autocomplete="off" required />
                        <span class="form-input-required">*</span>
                    </div>
                        
                    <div class="form-group focused">
                        <label class="form-label" for="deliveryTime">DeliveryTime</label>
                        <select class="custom-select" name="deliveryTime" id="deliveryTime" required>
                            <option>Now (30 - 45 mins)</option>
                        </select>
                        <span class="form-input-required">*</span>
                    </div>
                        
                    <div class="form-group focused">
                        <label class="form-label" for="deliveryStatus">DeliveryStatus</label>
                        <select class="custom-select" name="deliveryStatus" required>
                            <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("Order Placed")) { %>
                                <option value="Order Placed"
                                    <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("Order Placed")) { %>
                                        selected
                                    <% } %>
                                >Order Placed</option> 
                            <% } %>
                            <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("Order Placed") || fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("In the Kitchen")) { %>
                                <option value="In the Kitchen"
                                    <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("In the Kitchen")) { %>
                                        selected
                                    <% } %>
                                    >In the Kitchen</option> 
                            <% } %>
                            <% if(!fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("Delivered")) { %>
                                <option value="On the Way"
                                    <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("On the Way")) { %>
                                        selected
                                    <% } %>
                                    >On the Way</option>
                            <% } %>
                            <option value="Delivered"
                                <% if(fnbOrderObj.getDeliveryStatus().equalsIgnoreCase("Delivered")) { %>
                                    selected
                                <% } %>
                                >Delivered</option>
                        </select>
                        <span class="form-input-required">*</span>
                    </div>

                    <button type="submit" class="modal-btn-update">Update</button>
                </div>
            </form>
        </div>
                        
        <script>
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
            
             <% if(request.getAttribute("errMsg") != null) { %>
                swal(
                    'Error!',
                    '<%= request.getAttribute("errMsg") %>',
                    'error'
                )
            <% } %>
                
            <% if(request.getAttribute("successMsg") != null) { %>
                swal(
                    'Success',
                    '<%= request.getAttribute("successMsg") %>' ,
                    'success'
                ) 
            <% } %>
            
            <%
                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime now = LocalDateTime.now();
                LocalDateTime max = now.plusDays(2);
            %>
                document.getElementById("deliveryDate").setAttribute("value", '<%= deliveryDate %>');
                document.getElementById("deliveryDate").setAttribute("max", '<%= df.format(max) %>');
            
            <% 
                DateTimeFormatter tf = DateTimeFormatter.ofPattern("hh:mm a");
                LocalDateTime time = LocalDate.now().atTime(10, 0);
                int openHour = 10;
                int closeHour = 21;
                int counter = 0;
                
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
                                
            var x= document.getElementById("deliveryTime");

            for(let i=0; i<x.options.length;i++){
                if(x.options[i].text == '<%= fnbOrderObj.getDeliveryDateTime().substring(11) %>') {
                    x.options[i].selected = "selected";
                }
            }
        </script>
                            
    </body>
</html>
