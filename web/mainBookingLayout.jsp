<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*,java.util.*"%>
<%-- Retrieve the Booking Object saved in the session--%>
<jsp:useBean id="bookingList" type="List<model.Booking>" scope="session" /> 
<jsp:useBean id="ticketList" type="List<model.Ticket>" scope="session" />
<jsp:useBean id="fnbOrderList" type="List<model.FnbOrder>" scope="session" />
<%
    int index = 0;
    Integer totalRecordCount = (Integer)session.getAttribute("totalNoOfRecord");
    List <Integer> noOfTicket = (ArrayList <Integer>)session.getAttribute("noOfTicket");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <style>
            <%@ include file="bookingStyle.css"%>
        </style>
    </head>
    <body>
            <jsp:include page="AdminLayout.jsp" />
            <%! int j = 0;%>
            <section class="cc-attributes-details-layout" style="margin-bottom: 30px;  height: auto;">
                <div>
                    <div class="cc-attributes-details-header">
                        <h1>Booking Details</h1>
                    </div>

                <div style="display: inline-block; margin: 25px 0px; width: 100%;">
                    <form action="searchItem" method="POST" id="searchForm">
                        <div>
                            <input type="date" id="userSelectDate" name="userSelectDate" class="ticketOrder" style="width: 50%; height: 3em; float: left; font-size: 13px; color: black;"/>
                        </div>

                        <div style="float: right; max-width:400px;">
                            <div class="input-icons">
                                <i class="fas fa-search icon"></i>
                                <input type="search"  name="bookingSearch" id="searchInput"  placeholder="Search..."/>
                                <input type="submit" id="searchBtn" form="searchForm" value="Submit" style="display:none">
                            </div>
                        </div>
                    </form>
                </div>

                <div class="cc-attributes-details-form-container">
                    <table class="cc-attributes-details-form" id="myTable">
                        <tr class="cc-attributes-details-form">
                            <form action="SortBookingItem" method="POST">
                                <th class="cc-attributes-details-form">
                                    <button type="submit"  id="headerBtn">ID</button>
                                    <input type="hidden" name="sortBooking" value="bookingId">
                                </th>
                            </form>
                            <form action="SortBookingItem" method="POST">
                                    <th class="cc-attributes-details-form">
                                        <button type="submit"  id="headerBtn">Date & Time</button>
                                        <input type="hidden" name="sortBooking" value="bookingDateTime">
                                    </th>
                            </form>

                            <th class="cc-attributes-details-form">
                                <button type="submit"  id="headerBtn">Ticket ID</button>
                                <input type="hidden" name="sortBooking" value="TicketID">
                            </th>

                            <th class="cc-attributes-details-form">
                                <button type="submit"  id="headerBtn">Fnb ID</button>
                                <input type="hidden" name="sortBooking" value="FnbID">
                            </th>

                            <form action="SortBookingItem" method="POST">
                                    <th class="cc-attributes-details-form">
                                        <button type="submit"  id="headerBtn">Email Address</button>
                                        <input type="hidden" name="sortBooking" value="emailAddress">
                                    </th>
                            </form>
                            <form action="SortBookingItem" method="POST">
                                        <th class="cc-attributes-details-form">
                                            <button type="submit"  id="headerBtn">Payment Method</button>
                                            <input type="hidden" name="sortBooking" value="paymentMethod">
                                        </th>
                            </form>
                            <th class="cc-attributes-details-form" colspan="2">Action</th>
                        </tr>
                
                        <form id="deleteCheckBox" method="POST" action="DeleteBookingConfirmation.jsp">
                        <%int rowSpanInt = 0;
                            for(int j = 0; j < bookingList.size(); j++){
                                if(noOfTicket.get(j) != 0){
                                    rowSpanInt = noOfTicket.get(j);%>
                                        <%for(int i = 0; i < noOfTicket.get(j); i++){
                                        if(i == 0){%>
                                            <tr class="cc-attributes-details-form">
                                                <td class="cc-attributes-details-form" id="col1" rowspan="<%=rowSpanInt%>"><%=bookingList.get(j).getBookingId()%></td>
                                                <td class="cc-attributes-details-form" id="col3" rowspan="<%=rowSpanInt%>"><%=bookingList.get(j).getBookDateTime()%></td>
                                                <td class="cc-attributes-details-form" id="col3"><%=ticketList.get(index).getTicketId()%></td>
                                                <td class="cc-attributes-details-form" id="col3"><%=fnbOrderList.get(j).getFnbOrderID()%></td>
                                                <td class="cc-attributes-details-form" id="col4" rowspan="<%=rowSpanInt%>"><%=bookingList.get(j).getEmailAddress().getEmailAddress()%></td>
                                                <td class="cc-attributes-details-form" id="col4" rowspan="<%=rowSpanInt%>"><%=bookingList.get(j).getPaymentId().getPaymentMethod()%></td>
                                                <td class="cc-attributes-details-form" style='border:none;' rowspan="<%=rowSpanInt%>">
                                                    <a href="ViewBookingRecordDetails?bookingId=<%=bookingList.get(j).getBookingId()%>""><i class="fa-solid fa-eye icon"></i></a>
                                                </td>
                                                <td class="cc-attributes-details-form" style='border:none;' rowspan="<%=rowSpanInt%>">
                                                    <a href="RetrieveBooking?bookingId=<%=bookingList.get(j).getBookingId()%>""><i class="fas fa-edit icon"></i></a>
                                                </td>
                                            </tr>        
                                            <%index++;%>
                                        <%}else{%>
                                            <tr class="cc-attributes-details-form">
                                                <td class="cc-attributes-details-form" id="col3"><%=ticketList.get(index).getTicketId()%></td>
                                                <td class="cc-attributes-details-form" id="col3"><%=fnbOrderList.get(j).getFnbOrderID()%></td>
                                            </tr>   
                                            <%index++;%>
                                        <%}}%>   
                            <%}
                            }%>
                        </form>
                    </table>

                </div>                 
       </section>         
        <script>
            var input = document.getElementById("searchInput");
            input.addEventListener("keyup", function(event) {
              if (event.keyCode === 13) {
               event.preventDefault();
               document.getElementById("searchBtn").click();
              }
            });
        </script>
    
        <script>
            $("#selectAll").click(function () {
                $(".checkboxAll").prop('checked', $(this).prop('checked'));
            });
        </script>
    </body>
</html>
