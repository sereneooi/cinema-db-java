<%@page import="model.*, java.util.*"%>
<%
    TicketTypeDA ticketTypeDA = new TicketTypeDA();
    List <TicketType> ticketType = ticketTypeDA.retrieveAllRecord();
    session.getAttribute("scheduleId");
    SeatTypeDA seatTypeDA = new SeatTypeDA();
    
    List<SeatType> seatType = seatTypeDA.retrieveAllRecord();
    List <Seat> seat = (ArrayList <Seat>)request.getSession().getAttribute("seatList");
    int totalSelectedSeatCount = ((Integer)request.getSession().getAttribute("totalSelectedSeatCount")).intValue();
    
    Integer[] typeCount = new Integer[seatType.size()];    // all elements are null
    Arrays.fill(typeCount, 0);
    
    for(int i = 0; i < seat.size(); i++){
        for(int j = 0; j < seatType.size(); j++){
            if(seatType.get(j).getSeatTypeId().equals(seat.get(i).getSeatType().getSeatTypeId())){
                typeCount[j]++;
            }
        }
    }
%>

<html>
<head>
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
<style>
<%@include  file="bookingStyle.css"%>
body{
    overflow-x:hidden;
    overflow-y:auto;
}

input[type="button"], input[type="submit"]{
    background-color:#6667AB;
    display:inline-block;
    padding:0.35em 1.2em;
    margin:0 0.3em 0.3em 0;
    border-radius:0.12em;
    box-sizing: border-box;
    text-decoration:none;
    font-family:'Roboto',sans-serif;
    font-weight:300;
    color:#FFFFFF;
    text-align:center;
    transition: all 0.2s;
}

input[type="button"]:hover, input[type="submit"]:hover{
    color:#000000;
    background-color:rgba(255, 255, 255, 0.7);
}

@media all and (max-width:30em){
    input[type="button"], input[type="submit"]{
        display:block;
        margin:0.4em auto;
    }
}

/* The Close Button (x) */
.close {
  color: white;
  font-size: 35px;
  font-weight: bold;
  background: transparent;
  border: none;
  outline: none;
}

.close:hover{
  color: #9966ff;
  cursor: pointer;
}

.movieTicketBooking{
    list-style-type: none;
}

#applyVouhcer{
    display:none;
}

#voucher, #total{
    font-family: Verdana, sans-serif;
    font-weight: bold;
    font-size: 15px;
    color: #fff;
    height: 44px;
    margin: 10px 0 0;
    margin-left: 20px;
    background: transparent;
    border: 1px solid #f9d5e5;
    border-width: 0 0 2px 0;
    padding: 0px 45px 15px 0;
    -webkit-border-radius: 0;
    -moz-border-radius: 0;
    -o-border-radius: 0;
    -ms-border-radius: 0;
    border-radius: 0;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    -o-box-shadow: none;
    -ms-box-shadow: none;
    box-shadow: none;
    z-index: 2;
    position: relative;
}

#voucher:focus{
    border: 1px solid #f9d5e5;
    border-width: 0 0 2px 0;
    outline:none;
}

#transparent-bg{
    overflow-x: none;
    overflow-y: none;
    pointer-events: none;
    user-select: none;
    -moz-opacity: 0.30; 
    opacity: .30; 
    filter: alpha(opacity=30);
    z-index: 1000; 
    -webkit-animation: animateBackground 1s;
    animation: animateBackground 1s ;
}

@keyframes animateBackground {
    from {opacity: 0.8;}
    to {opacity: 0.30;}
}

#popup-movieTicket-Form{
    left:50%;
    top:50%;
    animation: animationDropCenter 1s;
}

@keyframes animationDropCenter {
    0% {
            top:0%;
    }
}
</style>
</head>
<script src="userinfo.js"></script>
<body onload="javascript:totalpriceCal();">
    <div id="transparent-bg"><jsp:include page="Seat.jsp" /> </div>
    <div id="popup-movieTicket-Form" style="background-color: rgb(51, 51, 51); height: auto;">
        <div><span class="close" onclick="closeTicketWin()">&times;</span></div>
            <div class="popup-Form-container" style="width: 80%; margin: auto;">
                <!-- form -->
                <form action="AddTicket" method="POST" id="ticketBooking">
                    <%for(int z=0; z<seatType.size();z++){
                            if(typeCount[z] != 0){
                                if(seatType.get(z).getSeatTypeDesc().equals("Single Seat")){%>
                                <div style="margin: 0px 0px 15px;">
                                    <div onclick="showTicket()" id="seatType" class="ticketBookHeader">
                                        <h3><%=seatType.get(z).getSeatTypeDesc()%></h3>
                                    </div>
                                    
                                    <div id="ticketType" style="margin: 0px; border: 1px solid #ddd; height: 55%; width: 99.7%;">
                                        <div style="width: 100%; border: 1px solid #ddd; height: auto;">
                                            <%  int seatNo = typeCount[z];
                                            for(int ticketCount = 0; ticketCount < ticketType.size(); ticketCount++){
                                                if(ticketType.get(ticketCount).getTicketTypeDesc().equals("Adult") || ticketType.get(ticketCount).getTicketTypeDesc().equals("Children")
                                                || ticketType.get(ticketCount).getTicketTypeDesc().equals("OKU") || ticketType.get(ticketCount).getTicketTypeDesc().equals("Student")){
                                                %>
                                                <div style="display: flex; margin: 15px 0px;">
                                                    <div class="movieTicketBooking" style="padding-left: 10px; width: 50%; float: left;">
                                                        <label for="adults"><%=ticketType.get(ticketCount).getTicketTypeDesc()%></label>
                                                        <%
                                                            double totalPrice = seatType.get(z).getSeatTypePrice() * (1 - ticketType.get(ticketCount).getTicketDiscountRate());
                                                        %>              
                                                        <input type="hidden" id="adultPrice" name="price" value="<%=String.format("%.2f", totalPrice)%>">
                                                        <p class="showPrice fontStyle">RM <%=String.format("%.2f", totalPrice)%></p>
                                                    </div>

                                                    <%String type=ticketType.get(ticketCount).getTicketTypeDesc();
                                                        String type1 = ticketType.get(ticketCount).getTicketTypeDesc()+"a";
                                                    %>
                                                    <div style="padding-right: 10px; width: 50%; float: right;">    
                                                         <div class="number-input">
                                                                <button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown(); totalpriceCal();"></button>      
                                                                <input class="quantity" type="number" id="<%=type1%>" name="<%="ticketTypeCount["+ticketCount+"]"%>" min="0" value="<%=seatNo%>" max="<%=typeCount[z]%>" readonly/>
                                                                <input type="hidden" id="<%=type%>" name="<%=type1%>" value="<%=seatNo%>" />          
                                                                <button type="button" onclick="findTotal(document.getElementById('<%=type%>').value, document.getElementById('<%=type%>').name); this.parentNode.querySelector('input[type=number]').stepUp(); totalpriceCal();" class="plus"></button>
                                                         </div>
                                                    </div>
                                                </div>
                                                <%}else{%>
                                                <input type="hidden" name="<%="ticketTypeCount["+ticketCount+"]"%>" value="0" />
                                                <%}
                                                seatNo=0;
                                            }%>
                                        </div>
                                    </div>
                                </div>
                    <%    }
                                if(!seatType.get(z).getSeatTypeDesc().equals("Single Seat")){%>
                                    <div style="margin: 0px 0px 15px;">
                                        <div onclick="showTicket1()" id="seatType" class="ticketBookHeader">
                                            <h3><%=seatType.get(z).getSeatTypeDesc()%></h3>
                                        </div>

                                        <div id="ticketType" style="margin: 0px; border: 1px solid #ddd; height: 55%; width: 99.7%;">
                                            <div style="width: 100%; border: 1px solid #ddd; height: auto;">
                                                 <% int seatNo = typeCount[z];
                                                        seatNo -= (seatNo/2); 
                                            for(int ticketCount = 0; ticketCount < ticketType.size(); ticketCount++){
                                                if(!ticketType.get(ticketCount).getTicketTypeDesc().equals("Adult") && !ticketType.get(ticketCount).getTicketTypeDesc().equals("Children")
                                                && !ticketType.get(ticketCount).getTicketTypeDesc().equals("OKU") && !ticketType.get(ticketCount).getTicketTypeDesc().equals("Student")){
                                                %>
                                                <div style="display: flex; margin: 15px 0px;">
                                                    <div class="movieTicketBooking" style="padding-left: 10px; width: 50%; float: left;">
                                                        <label><%=ticketType.get(ticketCount).getTicketTypeDesc()%></label>
                                                        <%
                                                            double totalPrice = seatType.get(z).getSeatTypePrice() * (1 - ticketType.get(0).getTicketDiscountRate());
                                                        %>              
                                                        <input type="hidden" id="adultPrice" name="price" value="<%=String.format("%.2f", totalPrice)%>">
                                                        <p class="showPrice fontStyle">RM <%=String.format("%.2f", totalPrice)%></p>
                                                    </div>
                                                    
                                                    <%String type=ticketType.get(ticketCount).getTicketTypeDesc();
                                                        String type1 = ticketType.get(ticketCount).getTicketTypeDesc()+"a";
                                                    %>
                                                    <div style="padding-right: 10px; width: 50%; float: right;">    
                                                         <div class="number-input">
                                                                <button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown(); totalpriceCal();"></button>      
                                                                <input class="quantity" type="number" id="<%=type1%>" name="<%="TwinSeatCount["+ticketCount+"]"%>" min="0" value="<%=seatNo%>" max="<%=typeCount[z]%>" readonly/>
                                                                <input type="hidden" id="<%=type%>" name="<%=type1%>" value="<%=seatNo%>" />          
                                                                <button type="button" onclick="findTotal(document.getElementById('<%=type%>').value, document.getElementById('<%=type%>').name); this.parentNode.querySelector('input[type=number]').stepUp(); totalpriceCal();" class="plus"></button>
                                                         </div>
                                                    </div>
                                                </div>
                                    <%}else{%>
                                                <input type="hidden" name="<%="TwinSeatCount["+ticketCount+"]"%>" value="0" />
                                   <%}
                                        }%>
                                            </div>
                                        </div>
                                    </div>
                            <%}
                                }
                            }%>
                

                <!-- Total -->
                <div style="width: 50%; width: 100%; margin: 40px 0px 0px;">
                    <ul class="seat-row-container">
                        <li class="fontStyle seat-alphaCol"><label class="total" style="font-size: 20px; font-weight: none; padding: 0px 15px 3px 0px;">TOTAL</label>
                            <input type="text" id="total" name="total" size="33" value="" style="margin-left: 0px; border: none; font-family:'Roboto',sans-serif; font-weight: bold; font-size: 30px; color: white; width: 60%;" readonly/></li>
                        <li class="fontStyle seat-alphaCol" style="width: 80%; padding-left: 5px; padding-top: 10px;" >
                            <input class="ticket-button" value="Next" type="submit" name="next" style="padding: 0px 15px 3px 0px; font-family: Verdana, sans-serif;" form="ticketBooking" />
                        </li>
                    </ul>
                </div>
            </form>                
            </div> 
    </div>

    <div id="popUpErrorMessage" class="popUpErrorMessage">
        <div class="popup-Form-container" style="margin-top: 20%;">
            <div style="max-width: 500px; margin: auto; font: 30px;"><span class="close" onclick="closeWin()">&times;</span></div>
            <h5 class="errorMsgCss">To select this ticket, please reduce your other ticket selection. Once you have reduced the desired number of tickets, please re-add them here.</h5>
        </div>
    </div>
                        
    <script>
        var my_modal = document.getElementById('popup-movieTicket-Form');
        var main_page = document.getElementById('transparent-bg');

        function showModal(){
          my_modal.style.display = "block";
        }

        // now show automatically after 0.1s
        setTimeout(showModal,100) 
      
        function closeTicketWin() {
            my_modal.style.display = "none";
            main_page.style.opacity = "1";
            main_page.style.filter = "alpha(opacity=100);";
            main_page.style['pointer-events'] = 'auto';
            main_page.style.userSelect = "auto";
        }
 
        function showTicket() {
          var div = document.getElementById("ticketType");

          if (div.style.display === "none") {
              div.style.display = "block";
          } else {
              div.style.display = "none";
          }
        }

        function showTicket1() {
          var div = document.getElementById("ticketType1");

          if (div.style.display === "block") {
              div.style.display = "none";
          } else {
              div.style.display = "block";
          }
        }

        function showVoucher() {
          var div = document.getElementById("applyVouhcer");

          if (div.style.display === "none") {
              div.style.display = "block";
          } else {
              div.style.display = "none";
          }
        }
    </script>
    
    <script type="text/javascript">
        //store how many tickets
        function totalpriceCal(){    
            var arr = document.getElementsByClassName("quantity");
            var priceArr = document.getElementsByName('price');
            //var discount = document.getElementsById('voucherDiscount');
            var totalPrice=0;
            
            for(var i=0;i<arr.length;i++){
                if(parseInt(arr[i].value))
                    totalPrice += parseInt(arr[i].value) * parseInt(priceArr[i].value);
            }
            //totalPrice = totalPrice - discount;

            document.getElementById('total').value = "RM " + (totalPrice).toFixed(2);
        }
    </script>
    
    <script type="text/javascript">
        function findTotal(value, id){
            var arr = document.getElementsByClassName("quantity");
            var eror_modal = document.getElementById('popUpErrorMessage');
            var tot=0;
 
            for(var i=0;i<arr.length;i++){
                if(parseInt(arr[i].value))
                    tot += parseInt(arr[i].value);
            }

            if(tot >= <%= totalSelectedSeatCount%>){
                function showErrorModal(){
                    document.getElementById(id).value = value-1;                    
                    eror_modal.style.display = "block";
                }
                showErrorModal();
            }
        }

        function closeWin() {
            document.getElementById('popUpErrorMessage').style.display = "none";
        }
    </script>
</body>
</html>