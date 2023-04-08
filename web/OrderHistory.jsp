<%@page import="java.text.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <%@include file="checkCustomerAccess.jsp"%>
        <%@include file="header.jsp"%>
        <title>CC Cinema</title>
        <style>
            .rounded-circle {
                border-radius: 50% !important;
            }
            
            .card {
                box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
            }
            
            .card .card-header {
                font-weight: 500;
            }
            
            .card-header:first-child {
                border-radius: 0.35rem 0.35rem 0 0;
            }
            
            .card-header {
                padding: 1rem 1.35rem;
                margin-bottom: 0;
                background-color: rgba(33, 40, 50, 0.03);
                border-bottom: 1px solid rgba(33, 40, 50, 0.125);
            }
            
            .form-control, .dataTable-input {
                display: block;
                width: 100%;
                padding: 0.875rem 1.125rem;
                font-size: 0.875rem;
                font-weight: 400;
                line-height: 1;
                color: #69707a;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #c5ccd6;
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                border-radius: 0.35rem;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
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
            
            div.side{
                display: flex;
                justify-content: space-between;
            }
            
            div.form-floating{
                width: 48%;
            }
            
            div.long-input{
                width: 100%;
            }
            
            nav > a.active{
                transition: border-bottom 1s linear;
            }
            
            div.end{
                color: grey;
                font-size: 12px;
                text-align: center;
            }
            
            .list a{
                text-decoration: none;
                color: black;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            article.card2 {
                display: table;
                width: 100%;
                background-color: #e0dcdc;
                color: #63639c;
                margin-bottom: 10px;
                font-family: 'Oswald', sans-serif;
                text-transform: uppercase;
                border-radius: 4px;
                position: relative;
                box-shadow: 0 1px 6px rgba(0, 0, 0, 0.12), 0 1px 4px rgba(0, 0, 0, 0.24);
            }

            section.date {
                display: table-cell;
                width: 18%;
                position: relative;
                text-align: center;
                border-right: 2px dashed #fff;
                font-size: 18px;
                color: black;
            }

            .date:before,
            .date:after {
                content: "";
                display: block;
                width: 30px;
                height: 30px;
                background-color: #fff;
                position: absolute;
                top: -15px;
                right: -15px;
                z-index: 1;
                border-radius: 50%;
            }

            .date:after {
                top: auto;
                bottom: -15px;
            }

            .date time {
                display: block;
                position: absolute;
                top: 50%;
                left: 50%;
                -webkit-transform: translate(-50%, -50%);
                -ms-transform: translate(-50%, -50%);
                transform: translate(-50%, -50%);
            }

            .date time span {
                display: block;
            }
            
            .date time span:first-child {
                font-weight: 600;
                font-size: 130%;
                text-transform: uppercase;
            }

            .date time span:last-child {
                font-weight: 600;
                margin-top: -10px
            }
            
            .card-cont {
                display: table-cell;
                width: 52%;
                font-size: 100%;
                padding: 10px 10px 30px 50px;
            }

            .card-cont h3 {
                color: #3C3C3C;
                font-size: 150%;
            }

            .card-cont .even-date time span {
                display: block;
            }
            
            .movie-pic {
                display: table-cell;
                width: 20%;
            }
            
            .button{
                cursor: pointer;
                background-color:#7058a1;
                color: white;
                border: none;
                font-size: large;
                outline: none;
                border-radius: 5px;
                width: 100px;
                transition: opacity .2s;
            }
            
            .button:hover{
                opacity: 0.7;
            }
        </style>
    </head>
    <body>
        <div class="container-xl px-4 mt-4">
            <nav class="nav nav-borders">
                <a class="nav-link" href="fnbOrderDeliveryHistory.jsp" onclick="orders()" id="ordersNav">Orders</a>
                <a class="nav-link active" href="#" onclick="tickets()" id="ticketsNav">Tickets</a>
                <a class="nav-link" href="favouriteList.jsp" onclick="fav()" id="favNav">Favourite</a>
            </nav>
            <hr class="mt-0 mb-4">
            <div class="row">
                <div class="col-xl-12" id="tickets">
                    <div class="card mb-4">
                        <div class="card-header">Tickets</div>
                        <div class="card-body">
                            <%
                                TicketDA ticketDA = new TicketDA();
                                List<Ticket> allTicket = ticketDA.getAllRecord(currentUser.getEmailAddress());
                                
                                String previousBookingId = "";
                                if(allTicket != null){
                                    for(int i = 0; i < allTicket.size(); i++){
                                        if(!previousBookingId.equalsIgnoreCase(allTicket.get(i).getBookingDetails().getBookingId())){
                                            List<Ticket> oneBooking = ticketDA.getBookingRecord(allTicket.get(i).getBookingDetails().getBookingId());
                                            
                                            DateFormat outputFormat = new SimpleDateFormat("dd MMM");
                                            DateFormat outputFormat2 = new SimpleDateFormat("dd MMM YYYY");
                                            DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");

                                            String inputDate = allTicket.get(i).getSeatId().getMovieScheduleInfor().getShowDate();
                                            Date date = inputFormat.parse(inputDate);
                                            String outputDate = outputFormat.format(date);
                                            String outputDate2 = outputFormat2.format(date);

                                            String inputTime = allTicket.get(i).getSeatId().getMovieScheduleInfor().getShowTime();
                            %>
                            <article class="card2">
                                <section class="date">
                                    <time>
                                        <span><%= outputDate %></span><span><%= inputTime.substring(0, 5) %></span>
                                    </time>
                                </section>
                                <section class="card-cont">
                                    <h3><%= allTicket.get(i).getSeatId().getMovieScheduleInfor().getMovie().getMovieName() %></h3>
                                    <div class="even-date">
                                        <i class="fa fa-calendar"></i>
                                        <time>
                                            <span><%= outputDate2 %></span>
                                            <span><%= inputTime.substring(0, 5) %></span>
                                            <span><%= allTicket.get(i).getSeatId().getMovieScheduleInfor().getMovie().getDuration() %></span>
                                        </time>
                                    </div>
                                    <div class="even-info">
                                        <span><%= allTicket.get(i).getSeatId().getMovieScheduleInfor().getTheatre().getTheatreDesc() %></span><br/>
                                        <span>Seat: 
                                            <%
                                                for(int j = 0; j < oneBooking.size(); j++){ %>
                                                    <%= oneBooking.get(j).getSeatId().getSeatNo() %><%
                                                    if(j != oneBooking.size() - 1){ %>, <% }
                                                }
                                            %>
                                        </span>
                                    </div>
                                    <br/><button class="button" onclick="location.href='ticket.jsp?selectedBookingId=<%= allTicket.get(i).getBookingDetails().getBookingId() %>';">View</button>
                                </section>
                                <section class="movie-pic">
                                    <table border="0">
                                        <tr>
                                            <td style="color: black; font-size: 18px;">RM <%= String.format("%.2f", allTicket.get(i).getBookingDetails().getPaymentId().getTotalAmount()) %></td>
                                        </tr>
                                        <tr>
                                            <td><img src="<%= allTicket.get(i).getSeatId().getMovieScheduleInfor().getMovie().getMoviePoster() %>" style="width: 140px; height: 170px;"/></td>
                                        </tr>
                                    </table>
                                </section>
                            </article><br/>
                            <%              previousBookingId = allTicket.get(i).getBookingDetails().getBookingId();
                                        }
                                    }
                                }
                            %>
                        </div>
                        <div class="end">-- End of Tickets --</div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>        
        <script type = "text/javascript">
        <%
            String p = request.getParameter("page");
            if(p.equals("tickets")){%>
                tickets(); <%
            }
        %>
        
        function tickets() {
            document.getElementById("tickets").style.display = "block";
            document.getElementById("ticketsNav").className = "nav-link active";
        }
        </script>
    </body>
</html>
