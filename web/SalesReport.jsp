<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*,java.util.*"%>

<%-- Retrieve the Ticket Object saved in the session--%>
<jsp:useBean id="bookingDetailList" type="List<model.Ticket>" scope="session" />
<jsp:useBean id="fnbOrderList" type="List<model.FnbOrderLine>" scope="session" />
<%
    List<Integer> bookedTicketNo = (ArrayList <Integer>) session.getAttribute("bookedTicketNo");
    List<Integer> bookedFnbNo = (ArrayList <Integer>) session.getAttribute("bookedFnbNo");
    double grandTotal = 0.00;
    List <Double> fnbSubTotal = (ArrayList<Double>) session.getAttribute("fnbSubTotal");
%>
<%@ include file="checkStaffAccess.jsp"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <style>
            <%@include file="bookingStyle.css" %> 
        </style>
    </head>
    <body>
        <section class="cc-attributes-details-layout" style="border: 3px solid black; height: auto;">
            <div class="cc-attributes-details-header">
                <p id="demo"></p>
                <h1>Daily Sales Report</h1>
            </div>
            
            <form action="RetrieveSalesReport" method="POST">
                Date :     <input type="date" id="userSelectDate" name="userSelectDate" class="ticketOrder" style="width: 80%; height: 3em; margin-top: 20px; padding-left: 15px; font-size: 13px; color: black;" required/>
                <button type="submit" value="" style="display: flex; float: right; width: 13%;  margin-top: 20px;" >Search</button>
            </form>
            
            <div class="cc-attributes-details-form-container" style="margin: 20px 0px 50px; height: auto;">
                <% int index = 0, fnbIndex = 0 ; 
                    double price = 0.00;
                    for(int count = 0; count < bookedTicketNo.size(); count++){
                    double ticketSubTotal = 0.00;%>
                    <table class="cc-attributes-details-form" id="myTable" style="border: none; margin: 50px 0px 15px;">                 
                            <tr>
                                <th class="cc-attributes-details-form border-text" style="width: 15%;">
                                    <p>Booking ID: </p>
                                </th>
                                <td  class="cc-attributes-details-form border-text" colspan="3">
                                    <strong><%=bookingDetailList.get(index).getBookingDetails().getBookingId()%></strong>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="cc-attributes-details-form border-text">
                                    <p>Email Address: </p>
                                </th>
                                <td class="cc-attributes-details-form border-text" colspan="3">
                                    <strong><%=bookingDetailList.get(index).getBookingDetails().getEmailAddress().getEmailAddress()%></strong>
                                </td>
                            </tr>
                                                        
                            <tr>
                                <th class="cc-attributes-details-form border-text">
                                    <p>Payment Method: </p>
                                </th>
                                <td class="cc-attributes-details-form border-text" colspan="3">
                                    <strong><%=bookingDetailList.get(index).getBookingDetails().getPaymentId().getPaymentMethod()%></strong>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="cc-attributes-details-form border-text">
                                    <p>Discount Amount: </p>
                                </th>
                                <td class="cc-attributes-details-form border-text" colspan="3">
                                    <strong><%out.print(String.format("RM %.2f", bookingDetailList.get(index).getBookingDetails().getPaymentId().getPromotion().getPromoAmount()));%></strong>
                                </td>
                            </tr>                            
                    </table>
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

                            <%for(int j = index; j < (bookedTicketNo.get(count) + index); j++){%>
                                <tr>
                                    <td class="cc-attributes-details-form" id="col3"><%=bookingDetailList.get(j).getTicketId()%></td>
                                    <td class="cc-attributes-details-form" id="col3"><%=bookingDetailList.get(j).getSeatId().getMovieScheduleInfor().getMovie().getMovieName()%></td>
                                    <td class="cc-attributes-details-form" id="col4"><%=bookingDetailList.get(j).getSeatId().getMovieScheduleInfor().getShowDateTime()%></td>
                                    <td class="cc-attributes-details-form" id="col4"><%=bookingDetailList.get(j).getSeatId().getSeatNo()%></td>
                                    <%price = bookingDetailList.get(j).getSeatId().getSeatType().getSeatTypePrice() * (1 - bookingDetailList.get(j).getTicketType().getTicketDiscountRate());
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
                <%if(fnbSubTotal.get(count) != 0.00){%>                            
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
                    
                    <%for(int j = fnbIndex; j < (bookedFnbNo.get(count) + fnbIndex); j++){%>
                        <tr>
                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrderList.get(j).getFnb().getFnbID()%></td>
                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrderList.get(j).getFnb().getFnbDescription()%></td>
                            <td class="cc-attributes-details-form" id="col4"><%=fnbOrderList.get(j).getQuantity()%></td>
                            <td class="cc-attributes-details-form" id="col4"><%out.print(String.format("RM %.2f", fnbOrderList.get(j).getFnb().getFnbPrice()));%></td>
                        </tr>
                    <%}%>
                    
                    <tr>
                        <td class="cc-attributes-details-form" colspan="3" ><strong>Fnb SubTotal : </strong></td>
                        
                        <td class="cc-attributes-details-form" ><%out.print(String.format("RM %.2f", fnbSubTotal.get(count)));%></td>         
                    </tr>
                </table>
                    <% }
                            double total = (fnbSubTotal.get(count) + ticketSubTotal) - bookingDetailList.get(index).getBookingDetails().getPaymentId().getPromotion().getPromoAmount();
                            index = index + bookedTicketNo.get(count);
                            fnbIndex = fnbIndex + bookedFnbNo.get(count);
                            grandTotal += total;
                        }%>
            </div>
            
            
        <section class="cc-btn-continue-layout" style="position:fixed; width: 65%; height: 10%; bottom: 0; right: 8%; background-color: rgba(80, 64, 100, 0.9); ">
            <div class="cc-btn-continue-container" style="display: flex; margin-left: 50px; position: absolute; height: 80%; width: 100%; transform: translateY(40%);  font-family: Verdana, sans-serif;">
                <p class="cc-btn-continue" id="continue-btn" style="color: white; border: none; font-size: 25px;">Grand Total: </p>
                <p id="grandTotal" class="cc-btn-continue" 
                   style="display: flex; margin-left: 50%; transform: translateY(-27%);  width: 20%; background-color: #000000; border: none; border-radius: 5px; color: white; border: none; font-size: 30px; align-items: center; justify-content: center;">
                            RM <%out.print(String.format("%.2f", grandTotal));%></p>
            </div>
        </section>   
            
        </section>             
    </body>
</html>
