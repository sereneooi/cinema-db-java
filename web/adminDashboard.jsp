<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.time.*, java.util.*"%>
<jsp:useBean id="accountDA" scope="application" class="model.AccountDA"></jsp:useBean>
<jsp:useBean id="bookingDA" scope="application" class="model.BookingDA"></jsp:useBean>
<jsp:useBean id="paymentDA" scope="application" class="model.PaymentDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="yqStyle.css" type="text/css">

        <style>
            .flex-item {
                width: 290px;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            <ul class="flex-container">
                <li class="flex-item">
                    <ion-icon name="people-outline"></ion-icon>
                    <h2>Total Customers</h2>
                    <h3><%= accountDA.getTotalCustomers("R0003") %></h3>
                </li>
                <li class="flex-item">
                    <ion-icon name="clipboard-outline"></ion-icon>
                    <h2>Daily Orders</h2>
                    <% LocalDate now = LocalDate.now(); %>
                    <h3><%= bookingDA.getTotalDailyBooking(now.toString()) %></h3>
                </li>
                <li class="flex-item">
                    <ion-icon name="cash-outline"></ion-icon>
                    <h2>Daily Revenue</h2>
                    <h3 style="font-size: 45px; margin-top: 5px;">RM <%= String.format("%.2f", paymentDA.getDailyRevenue(now.toString())) %></h3>
                </li>
            </ul>
            
            <div class="body" style="width:100%">
                <table id="example" style="width:100%">
                    <thead>
                        <tr>
                            <th colspan="5">Daily Recent Transactions</th>
                        </tr>
                        <tr>
                            <th>BookingID</th>
                            <th>Booking Date Time</th>
                            <th>Booking Type</th>
                            <th>Total Amount</th>
                            <th>Customer's Email Address</th>
                        </tr>
                    </thead>
                    <tbody>                   
                        <% 
                            Object[] bookingArrObj = bookingDA.getRecentTransaction(now.toString());
                            ArrayList<Booking> bookingList = (ArrayList<Booking>) bookingArrObj[0];
                            ArrayList<String> fnbOrderList = (ArrayList<String>) bookingArrObj[1];
                            
                            if(bookingList.size() == 0) {
                        %>
                                <tr>
                                    <td colspan="5" style="text-align: center;">No record found</td>
                                </tr>
                        <%
                            }

                            for(int i = 0; i < bookingList.size(); i++) {
                                Booking booking = bookingList.get(i);
                        %>
                                <tr>
                                    <td><%= booking.getBookingId() %></td>
                                    <td><%= booking.getBookDateTime().substring(0, 19) %></td>
                                    <td>
                                        <% if(fnbOrderList.get(i) == null) { %>
                                                Movie Ticket
                                        <% } else { %>
                                                Food & Beverages Order Delivery
                                        <% } %>
                                    </td>
                                    <td><%= String.format("%.2f", booking.getPaymentId().getTotalAmount()) %></td>
                                    <td><%= booking.getEmailAddress().getEmailAddress() %></td>
                                </tr>
                        <% } %>
                    </tbody>
                </table>
            
            </div>
        </div>
    </body>
</html>
