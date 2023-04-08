<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*, java.util.*"%>
<jsp:useBean id="ticket" type="List<model.Ticket>" scope="session" />
<jsp:useBean id="fnbOrder" type="List<model.FnbOrderLine>" scope="session" />
<%Double fnbSubTotal = (Double) session.getAttribute("fnbSubTotal");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            <%@ include file="bookingStyle.css"%>
              hr.line {
                border-top: 2px solid grey;
                width: 100%;
              }
              
              #ticketOrderSelection{
                  display: none;
              }
              
              #displaySelectedValue:focus{
                  outline: none;
              }
              /* Dashed red border */
            hr.new2 {
              border-top: 1px dashed red;
            }           
        </style>
        
    </head>
    <body>
        <jsp:include page="mainBookingLayout.jsp" />
            <div id="popup-View-Form"  style=" overflow-y: auto;">
              <div class="popup-Form-container"
                    <div id="popup-View-Form-content" style="height: auto; top: 60%;">  
                        <div class="cc-attributes-details-header"><h2 style="text-align: center;">Booking Details</h2></div>
                        
                        <section style="width:50%; float: right;">
                            <div><h5 style="text-align: center;"><i><hr class="new2"> Account Details <hr class="new2"></i></h5></div>
                            <div>Role: <strong><%=ticket.get(0).getBookingDetails().getEmailAddress().getRole().getRole()%></strong></div>
                            
                            <table class="tableCss">
                                <tr class="trCss popUp">
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa-solid fa-id-card"></i>&ensp;<label>IC Number</label><br/> 
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getEmailAddress().getIc()%></div>
                                    </td>
                                    
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa-solid fa-envelope"></i>&ensp;<label>Email Address</label><br/>
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getEmailAddress().getEmailAddress()%></div>
                                    </td>
                                </tr>
                                
                                <tr class= "trCss popUp">
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa fa-venus-double" aria-hidden="true">&ensp;</i><label>Gender</label><br/>
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getEmailAddress().getGender()%></div>
                                    </td>
                                   
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa fa-birthday-cake" aria-hidden="true">&ensp;</i><label>Birth Date</label><br/>
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getEmailAddress().getBirthDate()%></div>
                                    </td>
                                </tr>
                            </table>  
                        </section>

                        <section style="width:50%; float: left;">
                            <div><h5 style="text-align: center;"><i>
                                        <hr class="new2" style="border-top: 1px dashed blueviolet;"> Payment Details <hr class="new2" style="border-top: 1px dashed blueviolet;"></i>
                                </h5></div>
                            
                            <table class="tableCss">
                                <tr class="trCss popUp">
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa fa-credit-card-alt" aria-hidden="true"></i>&ensp;<label>Payment Method</label><br/>
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getPaymentId().getPaymentMethod()%></td></div>
                                    </td>
                                    
                                    <td class="tdCss popUp bookingForm">
                                        <i class="fa-solid fa-hand-holding-dollar"></i>&ensp;<label>Total Amount</label><br/>
                                        <div class="space-between"><%=ticket.get(0).getBookingDetails().getPaymentId().getTotalAmount()%></td></div>
                                    </td>
                                </tr>
                            </table>  
                        </section>

                        <section>
                            <table class="cc-attributes-details-form" id="myTable" style="border: none;">      
                                <tr>
                                    <th class="cc-attributes-details-form border-text" colspan="5" style="font-size: 20px; padding-top: 10px; border-left-style: none; border-right-style: none; border-top-style: none;"><i>Ticket Order</i></th>
                                </tr>

                                <tr>
                                    <th class="cc-attributes-details-form"><strong>Ticket ID</strong></th>
                                    <th class="cc-attributes-details-form"><strong>Movie</strong></th>
                                    <th class="cc-attributes-details-form"><strong>Show Date</strong></th> 
                                    <th class="cc-attributes-details-form"><strong>Seat No</strong></th>
                                    <th class="cc-attributes-details-form"><strong>Price</strong></th>
                                </tr>

                                <% double price = 0.00, ticketSubTotal = 0.00;
                                    for(int j = 0; j < ticket.size(); j++){%>
                                    <tr>
                                        <td class="cc-attributes-details-form" id="col3"><%=ticket.get(j).getTicketId()%></td>
                                        <td class="cc-attributes-details-form" id="col3"><%=ticket.get(j).getSeatId().getMovieScheduleInfor().getMovie().getMovieName()%></td>
                                        <td class="cc-attributes-details-form" id="col4"><%=ticket.get(j).getSeatId().getMovieScheduleInfor().getShowDateTime()%></td>
                                        <td class="cc-attributes-details-form" id="col4"><%=ticket.get(j).getSeatId().getSeatNo()%></td>
                                        <%price = ticket.get(j).getSeatId().getSeatType().getSeatTypePrice() * (1 - ticket.get(j).getTicketType().getTicketDiscountRate());
                                              ticketSubTotal += price;%>
                                        <td class="cc-attributes-details-form" id="col4"><%out.print(String.format("RM %.2f", price));%></td>
                                    </tr>
                                <%}%>

                                <tr>
                                    <th class="cc-attributes-details-form" colspan="4" >
                                        <button type="submit"  id="headerBtn"><strong>Ticket SubTotal : </strong></button>
                                    </th>
                                    <td class="cc-attributes-details-form" ><%out.print(String.format("RM %.2f", ticketSubTotal));%></td>         
                                </tr> 
                            </table>
                        </section>
                        
                        <section>
                            <%if(fnbOrder.get(0).getQuantity() != 0){%>                            
                                <table class="cc-attributes-details-form" id="myTable" style="border: none;">      
                                    <tr>
                                        <th class="cc-attributes-details-form border-text" colspan="" style="font-size: 20px; padding-top: 10px; border-left-style: none; border-right-style: none; border-top-style: none;"><i>FnB Order</i></th>
                                    </tr>

                                    <tr>
                                        <th class="cc-attributes-details-form" ><strong>FnB ID</strong></th>
                                        <th class="cc-attributes-details-form"><strong>FnB Description</strong></th>
                                        <th class="cc-attributes-details-form"><strong>Quantity</strong></th>
                                        <th class="cc-attributes-details-form"><strong>Price</strong></th>
                                    </tr>

                                    <%for(int j = 0; j < fnbOrder.size(); j++){%>
                                        <tr>
                                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrder.get(j).getFnb().getFnbID()%></td>
                                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrder.get(j).getFnb().getFnbDescription()%></td>
                                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrder.get(j).getQuantity()%></td>
                                            <td class="cc-attributes-details-form" id="col4"><%out.print(String.format("RM %.2f", fnbOrder.get(j).getFnb().getFnbPrice()));%></td>
                                        </tr>
                                    <%}%>

                                    <tr>
                                        <td class="cc-attributes-details-form" colspan="3" ><strong>Fnb SubTotal : </strong></td>

                                        <td class="cc-attributes-details-form" ><%out.print(String.format("RM %.2f", fnbSubTotal));%></td>         
                                    </tr>
                                </table>
                                <%}%>
                        </section>
                                
                            <span class ="popup-Form-btn" onclick="window.location='mainBookingLayout.jsp'" style="margin-right:50px;">CLOSE</span>                                       
                    </div>
                </div>
   
        <script>
            var infor_modal = document.getElementById('popup-View-Form');

            function showPopUpModal(){
                infor_modal.style.display = "block";
            }

            // now show automatically after 0.1s
            setTimeout(showPopUpModal,100) 
            
            function closeWin() {
                infor_modal.style.display = "none";
            }
        </script>
    </body>
</html>
