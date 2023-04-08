<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
String selectedBookingId = request.getParameter("selectedBookingId");
if(selectedBookingId == null || selectedBookingId.equals("")){
    Booking booking = (Booking) session.getAttribute("booking");
   selectedBookingId = booking.getBookingId();
}

TicketDA ticketDA = new TicketDA();
List<Ticket> displayTicket = ticketDA.getBookingRecord(selectedBookingId);
out.println(displayTicket.size());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="logo.png" rel="icon" type="image/png"/>
        <title>CC Cinema</title>
<!--        <link href="Homestyle.css" rel="stylesheet" type="text/css" />
        <link href="layout.css" rel="stylesheet" type="text/css" />
        <link href="style-Copy-2.css" rel="stylesheet" type="text/css" />
        <link href="style1.css" rel="stylesheet" type="text/css" />
        <link href="paymentStyle.css" rel="stylesheet" type="text/css" />-->
        <%@include file="checkCustomerAccess.jsp"%>
        <%@include file="header.jsp"%>
        <style>
        .dropdown-content a:hover, .dropdown-content li:hover{
            cursor: pointer;
        }

        @font-face {
           font-family: 'mahelisa';
           src: url(mahelisa.ttf);
        }

        table#t1{
            font-size: 20px;
            border-collapse: collapse;
            background-color: white;
        }

        table#box{
            border-radius: 10px;
            width: 90%;
            height: 700px;
            margin-top: 50px;
            box-shadow: 8px 8px 20px #000;
        }

        table#t1 tr td, table#box tr td, table#t2 tr td, table#t3 tr td{
            vertical-align: middle;
            line-height: 35px;
            padding: 5px 20px 5px 5px;
        }

        table#t2{
            border-collapse: collapse;
            border: 1px solid black;
            margin-left: 20px;
        }

        table#t3{
            border-collapse: collapse;
            margin-left: 30px;
            border: 1px solid black;
            margin-top: auto;
        }

        hr{
            border: 1px solid black;
        }

        .button{
            cursor: pointer;
            background-color:#7058a1;
            color: white;
            border: none;
            font-size: large;
            outline: none;
            transition: transform .2s;
            border-radius: 5px;
            width: 15%;
        }

        .button:hover{
            opacity: 0.7;
            -ms-transform: scale(1.05);
            -webkit-transform: scale(1.05); 
            transform: scale(1.05); 
        }

        .button:active {
            background-color: #7058a1;
            transform: translateY(2px);
        }

        input{
            font-family: 'Times New Roman', Times, serif;
            font-weight: bold;
        }
        
        #moviename, #datetime, #seatNo, #theatre{
            font-weight: bold;
        }
        </style>
    </head>
    <body>
        <script>
            function printContent(content){
                var restorepage = document.body.innerHTML;
                var printcontent = document.getElementById('content').innerHTML;
                document.body.innerHTML = printcontent;
                window.print();
                document.body.innerHTML = restorepage;
            }
        </script>
<!--        <div >
            <img id="seat" src="seats.png" alt="Seats" />
            <img id="popcorn" src="popcorn.png" alt="Foods" />
            <img id="payment" src="payment.png" alt="Payment" />
            <img id="ticket" src="ticket.png" alt="Ticket" />
        </div>
        <div>
            <div class="processBar">
                <div class="processBarVisible">
                    <div class="processBarVisibleStep" style="margin-left: 60px"></div>
                    <div class="processBarVisibleStep"></div>
                    <div class="processBarVisibleStep"></div>
                    <div class="processBarVisibleStep"></div>
                </div>
                <div class="processBarBlock">
                    <div class="processBarBlockStep" style="margin-left: 55px"></div>
                    <div class="processBarBlockStep"></div>
                    <div class="processBarBlockStep"></div>
                    <div class="processBarBlockStep rejected"></div>
                </div>
            </div>
        </div>-->
        <div id="content">
            <table style="background-color: white;" id="box" align="center">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <a href="cinema.jsp"><img src="logo.png" alt="CC Cinema" id="logo" name="logo"/></a>
                                </td>
                                <th rowspan="2">
                                    <a href="cinema.jsp" 
                                    style="font-family: 'Times New Roman', Times, serif; font-size:50px; 
                                    font-variant: small-caps; text-decoration: none; text-align: center; color: black;">
                                    Cc Cinema</a>
                                </th>
                                <th colspan="4" style="vertical-align: bottom;"></th>
                            </tr>
                            <tr>
                                <td style="font-family: mahelisa; font-size:45px; 
                                    font-variant: small-caps; font-style: italic; text-decoration: none; 
                                    vertical-align: top; text-align: left;" colspan="4">Cc Cinema
                                </td>
                            </tr>
                        </table>
                        <hr/><br/>
                        <table border="0" style="width: 90%;" id="t1" align="center">
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-journal-check" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M10.854 6.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 8.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                        <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                                        <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                                    </svg>
                                    Booking ID
                                </td>
                                <td style="width: 60%;">: <%= selectedBookingId %></td>
                                <td rowspan="17" style="vertical-align: top;"><img src="<%= displayTicket.get(0).getSeatId().getMovieScheduleInfor().getMovie().getMoviePoster() %>" style="width: 140px; height: 170px;"/></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-film" viewBox="0 0 16 16">
                                        <path d="M0 1a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H1a1 1 0 0 1-1-1V1zm4 0v6h8V1H4zm8 8H4v6h8V9zM1 1v2h2V1H1zm2 3H1v2h2V4zM1 7v2h2V7H1zm2 3H1v2h2v-2zm-2 3v2h2v-2H1zM15 1h-2v2h2V1zm-2 3v2h2V4h-2zm2 3h-2v2h2V7zm-2 3v2h2v-2h-2zm2 3h-2v2h2v-2z"/>
                                    </svg>
                                    Movie
                                </td>
                                <td><span id="movieName">: <%= displayTicket.get(0).getSeatId().getMovieScheduleInfor().getMovie().getMovieName() %></span></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-calendar-event" viewBox="0 0 16 16">
                                        <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                                        <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                    </svg>
                                    Movie Date Time
                                </td>
                                <td>
                                    <%
                                        DateFormat outputFormat = new SimpleDateFormat("dd MMM yyyy");
                                        DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");

                                        String inputDate = displayTicket.get(0).getSeatId().getMovieScheduleInfor().getShowDate();
                                        Date date = inputFormat.parse(inputDate);
                                        String outputDate = outputFormat.format(date);
                                        
                                        String inputTime = displayTicket.get(0).getSeatId().getMovieScheduleInfor().getShowTime();
                                    %>
                                    <span id="datetime">: <%= outputDate %> -- <%= inputTime.substring(0, 5) %></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-collection-play" viewBox="0 0 16 16">
                                        <path d="M2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1zm2.765 5.576A.5.5 0 0 0 6 7v5a.5.5 0 0 0 .765.424l4-2.5a.5.5 0 0 0 0-.848l-4-2.5z"/>
                                        <path d="M1.5 14.5A1.5 1.5 0 0 1 0 13V6a1.5 1.5 0 0 1 1.5-1.5h13A1.5 1.5 0 0 1 16 6v7a1.5 1.5 0 0 1-1.5 1.5h-13zm13-1a.5.5 0 0 0 .5-.5V6a.5.5 0 0 0-.5-.5h-13A.5.5 0 0 0 1 6v7a.5.5 0 0 0 .5.5h13z"/>
                                    </svg>
                                    Theatre
                                </td>
                                <td><span id="theatre">: <%= displayTicket.get(0).getSeatId().getMovieScheduleInfor().getTheatre().getTheatreDesc() %></span></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-ui-checks-grid" viewBox="0 0 16 16">
                                        <path d="M2 10h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1zm9-9h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-3a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zm0 9a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h3a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-3zm0-10a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h3a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2h-3zM2 9a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h3a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H2zm7 2a2 2 0 0 1 2-2h3a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2h-3a2 2 0 0 1-2-2v-3zM0 2a2 2 0 0 1 2-2h3a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm5.354.854a.5.5 0 1 0-.708-.708L3 3.793l-.646-.647a.5.5 0 1 0-.708.708l1 1a.5.5 0 0 0 .708 0l2-2z"/>
                                    </svg>
                                    Seat No.
                                </td>
                                <td>
                                    <span id="seatNo">: 
                                        <%
                                            int singleSeatCount = 0, adultCount = 0, studentCount = 0, okuCount = 0, childrenCount = 0;
                                            for(int i = 0; i < displayTicket.size(); i++){%> 
                                                <%= displayTicket.get(i).getSeatId().getSeatNo() %><% 
                                                if(i != displayTicket.size() - 1){ %>, <% }
                                                if(displayTicket.get(i).getSeatId().getSeatType().getSeatTypeDesc().equalsIgnoreCase("Single Seat")){
                                                    singleSeatCount++;

                                                    if(displayTicket.get(i).getTicketType().getTicketTypeDesc().equalsIgnoreCase("Adult")){
                                                        adultCount++;
                                                    }else if(displayTicket.get(i).getTicketType().getTicketTypeDesc().equalsIgnoreCase("Children")){
                                                        childrenCount++;
                                                    }else if(displayTicket.get(i).getTicketType().getTicketTypeDesc().equalsIgnoreCase("OKU")){
                                                        okuCount++;
                                                    }else if(displayTicket.get(i).getTicketType().getTicketTypeDesc().equalsIgnoreCase("Student")){
                                                        studentCount++;
                                                    }
                                                }
                                            }
                                        %>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-align-start" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1.5 1a.5.5 0 0 1 .5.5v13a.5.5 0 0 1-1 0v-13a.5.5 0 0 1 .5-.5z"/>
                                        <path d="M3 7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V7z"/>
                                    </svg>
                                    Seat Type
                                </td>
                                <td>Single Seat</td>
                                <td><span id="single">: <%= singleSeatCount %></span></td>
                            </tr>
                            <tr>
                                <td>Twin Seat</td>
                                <td><span id="twinS">: <%= displayTicket.size()-singleSeatCount %></span></td>
                            </tr>
                            <tr style="border-top: 1px dashed black;">
                                <td rowspan="5">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-ticket-perforated" viewBox="0 0 16 16">
                                        <path d="M4 4.85v.9h1v-.9H4Zm7 0v.9h1v-.9h-1Zm-7 1.8v.9h1v-.9H4Zm7 0v.9h1v-.9h-1Zm-7 1.8v.9h1v-.9H4Zm7 0v.9h1v-.9h-1Zm-7 1.8v.9h1v-.9H4Zm7 0v.9h1v-.9h-1Z"/>
                                        <path d="M1.5 3A1.5 1.5 0 0 0 0 4.5V6a.5.5 0 0 0 .5.5 1.5 1.5 0 1 1 0 3 .5.5 0 0 0-.5.5v1.5A1.5 1.5 0 0 0 1.5 13h13a1.5 1.5 0 0 0 1.5-1.5V10a.5.5 0 0 0-.5-.5 1.5 1.5 0 0 1 0-3A.5.5 0 0 0 16 6V4.5A1.5 1.5 0 0 0 14.5 3h-13ZM1 4.5a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v1.05a2.5 2.5 0 0 0 0 4.9v1.05a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-1.05a2.5 2.5 0 0 0 0-4.9V4.5Z"/>
                                    </svg>
                                    Tickets
                                </td>
                                <td>Adults</td>
                                <td><span id="adultNo">: <%= adultCount %></span></td>
                            </tr>
                            <tr>
                                <td>Children</td>
                                <td><span id="childrenNo">: <%= childrenCount %></span></td>
                            </tr>
                            <tr>
                                <td>Students</td>
                                <td><span id="studentsNo">: <%= studentCount %></span></td>
                            </tr>
                            <tr>
                                <td>OKU</td>
                                <td><span id="okuNo">: <%= okuCount %></span></td>
                            </tr>
                            <tr>
                                <td>Twin Seat</td>
                                <td><span id="twin">: <%= displayTicket.size()-singleSeatCount %> </span></td>
                            </tr>
                            <tr style="border-top: 1px solid black;">
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-file-person" viewBox="0 0 16 16">
                                        <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
                                        <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                                    </svg>
                                    Email Address
                                </td>
                                <td style="width: 60%; font-size: 18px;">: <%= currentUser.getEmailAddress() %></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-currency-exchange" viewBox="0 0 16 16">
                                        <path d="M0 5a5.002 5.002 0 0 0 4.027 4.905 6.46 6.46 0 0 1 .544-2.073C3.695 7.536 3.132 6.864 3 5.91h-.5v-.426h.466V5.05c0-.046 0-.093.004-.135H2.5v-.427h.511C3.236 3.24 4.213 2.5 5.681 2.5c.316 0 .59.031.819.085v.733a3.46 3.46 0 0 0-.815-.082c-.919 0-1.538.466-1.734 1.252h1.917v.427h-1.98c-.003.046-.003.097-.003.147v.422h1.983v.427H3.93c.118.602.468 1.03 1.005 1.229a6.5 6.5 0 0 1 4.97-3.113A5.002 5.002 0 0 0 0 5zm16 5.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0zm-7.75 1.322c.069.835.746 1.485 1.964 1.562V14h.54v-.62c1.259-.086 1.996-.74 1.996-1.69 0-.865-.563-1.31-1.57-1.54l-.426-.1V8.374c.54.06.884.347.966.745h.948c-.07-.804-.779-1.433-1.914-1.502V7h-.54v.629c-1.076.103-1.808.732-1.808 1.622 0 .787.544 1.288 1.45 1.493l.358.085v1.78c-.554-.08-.92-.376-1.003-.787H8.25zm1.96-1.895c-.532-.12-.82-.364-.82-.732 0-.41.311-.719.824-.809v1.54h-.005zm.622 1.044c.645.145.943.38.943.796 0 .474-.37.8-1.02.86v-1.674l.077.018z"/>
                                    </svg>
                                    Subtotal
                                </td>
                                <%
                                    double discount = 0;
                                    if(displayTicket.get(0).getBookingDetails().getPaymentId().getPromotion() != null){
                                        discount = displayTicket.get(0).getBookingDetails().getPaymentId().getPromotion().getPromoAmount();
                                    }
                                %>
                                <td><span id="subTotal">: RM <% if(displayTicket != null){ %><%= String.format("%.2f", displayTicket.get(0).getBookingDetails().getPaymentId().getTotalAmount()+discount) %><% } %></span></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-patch-minus" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M5.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1-.5-.5z"/>
                                        <path d="m10.273 2.513-.921-.944.715-.698.622.637.89-.011a2.89 2.89 0 0 1 2.924 2.924l-.01.89.636.622a2.89 2.89 0 0 1 0 4.134l-.637.622.011.89a2.89 2.89 0 0 1-2.924 2.924l-.89-.01-.622.636a2.89 2.89 0 0 1-4.134 0l-.622-.637-.89.011a2.89 2.89 0 0 1-2.924-2.924l.01-.89-.636-.622a2.89 2.89 0 0 1 0-4.134l.637-.622-.011-.89a2.89 2.89 0 0 1 2.924-2.924l.89.01.622-.636a2.89 2.89 0 0 1 4.134 0l-.715.698a1.89 1.89 0 0 0-2.704 0l-.92.944-1.32-.016a1.89 1.89 0 0 0-1.911 1.912l.016 1.318-.944.921a1.89 1.89 0 0 0 0 2.704l.944.92-.016 1.32a1.89 1.89 0 0 0 1.912 1.911l1.318-.016.921.944a1.89 1.89 0 0 0 2.704 0l.92-.944 1.32.016a1.89 1.89 0 0 0 1.911-1.912l-.016-1.318.944-.921a1.89 1.89 0 0 0 0-2.704l-.944-.92.016-1.32a1.89 1.89 0 0 0-1.912-1.911l-1.318.016z"/>
                                    </svg>
                                    Promo Discount
                                </td>
                                <td><span id="promo">: RM <% if(displayTicket != null){ %><%= String.format("%.2f", discount) %><%} %></span></td>
                            </tr>
                            <tr style="border-top: 1px solid black;">
                                <td style="line-height: 40px;" colspan="2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                        <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
                                    </svg>
                                    Amount Paid
                                </td>
                                <td><span id="totalAmount">: RM <% if(displayTicket != null){ %><%= String.format("%.2f", displayTicket.get(0).getBookingDetails().getPaymentId().getTotalAmount()) %><% } %></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img title="QR Code" src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=<%= selectedBookingId %>;<%= currentUser.getEmailAddress() %>">
                                </td>
                                <td colspan="3">
                                    <h4 style="text-align: center;">
                                        Scan QR Code at the <span style="color: red;">checkpoint counter</span> or
                                        <span style="color: red;">autogate</span>
                                    </h4>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div><br/><br/>
        <div align="right" style="margin-right: 45px;">
            <input class="button" type="button" value="Print" name="print" id="print" style="Height:30px;" onclick="printContent('content')"/>
        </div> <br/>
        <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
    </body>
</html>