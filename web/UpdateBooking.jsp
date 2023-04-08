<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*, java.util.*"%>
<% 
//reqest from AddBooking servlet
Account account = (Account)request.getAttribute("accResult");
Payment payment = (Payment)request.getAttribute("paymentResult");
String accConfirmMsg = (String)request.getAttribute("accConfirmMsg");
String payConfirmMsg = (String)request.getAttribute("paymentConfirmMsg");

String userInputEmailAddress = (String)session.getAttribute("emailAddress");
if(userInputEmailAddress == null){
    userInputEmailAddress = "";
}

String userInputPaymentId = (String)session.getAttribute("paymentId");
if(userInputPaymentId == null){
    userInputPaymentId = "";
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="./bookingScript.js"></script>
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
              
              #totalSeatCount{
                  all: inital;
                  background-color: white;
            }
        </style>
    </head>
    <body>
                
        <%
        Booking book = (Booking) session.getAttribute("booking");
        if(book != null){%>
            <jsp:useBean id="booking" scope="session" class="model.Booking"/>        
            <jsp:include page="mainBookingLayout.jsp" />
            <div id="popup-BookUpdate-Form">
                <div class="popup-Form-container">
                    <div id="popup-BookUpdate-Form-content" style="height: auto; overflow: auto;">
                    <div><span class="close" onclick="window.location='mainBookingLayout.jsp'">&times;</span></div>
                        <form action="UpdateBooking" method="POST" >
                            <h1>Update Booking Details</h1>                          
                            <hr class="solid">        
                            <br/>
                                <div>
                                     <div class="bookingForm">
                                        <label>Booking ID</label><br/>
                                        <div class="input-icons space-between">
                                            <i class="fa-solid fa-ticket-simple icon"></i>
                                            <input type="text"  name="bookingId" id="bookingId" value="<%=booking.getBookingId()%>" required  placeholder="" readonly/>
                                        </div>
                                    </div>

                                    <div class="bookingForm">
                                        <label>Email Address</label><br/>
                                        <div class="input-icons space-between">
                                            <i class="fa-solid fa-envelope icon"></i>
                                            <input type="search"  name="emailAddress" id="searchEmail" placeholder="e.g. example@email.com" value="<%=booking.getEmailAddress().getEmailAddress()%>" onfocus="this.value=''" required="required"/>
                                            <%if(accConfirmMsg != null){%>
                                                <p class="errorMessage">
                                                    <%=accConfirmMsg%>
                                                </p>
                                            <%}%>
                                        </div>
                                    </div>            


                                    <div class="bookingForm">
                                        <label>Payment</label><br/>
                                        <div class="input-icons space-between">
                                            <i class="fa-solid fa-wallet icon"></i>
                                            <input type="search"  name="paymenID" id="paymentSearchInput" placeholder="e.g. P0001" value="<%=booking.getPaymentId().getPaymentID()%>" onfocus="this.value=''" required  placeholder="" />
                                            <%if(payConfirmMsg != null){%>
                                                <p class="errorMessage">
                                                    <%=payConfirmMsg%>
                                                </p>
                                            <%}%>
                                        </div>
                                    </div>
                                    </div>


                                    <br/><br/>

                                    <button type="submit" value="Submit" id="submitBtn">Submit</button>      
                                    <button type="reset">Reset</button>
                                </div>
                            </form>
                        </div>
                </div>
            </div>

        
            <form action="UpdateBooking" method="POST">
                <%if(account != null && payment != null ){%>
                        <!-- add .Gif upside the form -->
                        <div id="popup-Infor-Form"  style="border: 3px solid green;">
                            <div class="" style="display: flex; vertical-align: middle; justify-content: center; width: 50%; height: 80%; margin: auto; background-color: #d6d4e0; border-radius: 7px; transform: translateY(10%); ">
                                <div class="cc-attributes-details-form-container" style="width: 90%; height: 90%; border-radius: 15px; background-color: #fff; margin: auto;  transform: translateY(2%);">
                                    <table class="cc-attributes-details-form popUp" style="margin-top:30px;">
                                        <thead>
                                            <tr class="cc-attributes-details-form popUp">
                                                <td colspan="2" class="cc-attributes-details-form popUp"><h2>Confirm Update Booking Details</h2></td>
                                            </tr>
                                        </thead>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                                <td class="cc-attributes-details-form popUp"></td>
                                                <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td colspan="2" class="cc-attributes-details-form popUp"><h5><i>------------------------------------------Account Detail Confirmation------------------------------------------</i></h5></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp ">
                                            <td colspan="2" class="cc-attributes-details-form popUp"><strong><%=account.getRole().getRole()%></strong></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>IC Number</label><br/> 
                                                <i class="fa-solid fa-id-card"></i>&ensp;<%=account.getIc()%></td>
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Email Address</label><br/>
                                                <i class="fa-solid fa-envelope icon"></i>&ensp;<%=account.getEmailAddress()%></td>
                                        </tr>
                                        <tr class=.cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Gender</label><br/>
                                                <i class="fa fa-venus-double" aria-hidden="true">&ensp;</i><%=account.getGender()%></td>
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Birth Date</label><br/>
                                                <i class="fa fa-birthday-cake" aria-hidden="true">&ensp;</i><%=account.getBirthDate()%></td>
                                        </tr>
                                    </table>
                                        
                                        
                                    <table class="cc-attributes-details-form popUp">
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td colspan="2" class="cc-attributes-details-form popUp popUp"><h5><i>------------------------------------------Payment Detail Confirmation------------------------------------------</i></h5></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Payment Method</label><br/>
                                                <i class="fa fa-credit-card-alt" aria-hidden="true"></i>&ensp;<%=payment.getPaymentMethod()%></td>
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Date & Time</label><br/>
                                                <i class="fa-solid fa-calendar-days"></i>&ensp;<%=payment.getPaymentDateTime()%></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp"></td>
                                            <td class="cc-attributes-details-form popUp"></td>
                                        </tr>
                                        <tr class="cc-attributes-details-form popUp">
                                            <td class="cc-attributes-details-form popUp bookingForm">
                                                <label>Total Amount</label><br/>
                                                <i class="fa-solid fa-hand-holding-dollar"></i>&ensp;<%=payment.getTotalAmount()%></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                        <span class ="popup-Form-btn" onclick="closeWin()" style="margin-right:50px;">CLOSE</span>
                                        <input type='submit' name='confirmation' value="CONFIRM" class ="popup-Form-btn" style="margin-left:50px;"/>                                        
                                        <input type="hidden" name="confirm" value="true"/>                                                
                                </div>
                            </div>
                        </div>
                <%}%> 
            </form>
        <%}%>
        
        <script>
            var booking_modal = document.getElementById('popup-BookUpdate-Form');

            function showMyBookingModal(){
              booking_modal.style.display = "block";
            }
            
            // now show automatically after 0.1s
            setTimeout(showMyBookingModal,100) 
        </script>

        <script>
            var infor_modal = document.getElementById('popup-Infor-Form');

            function showPopUpModal(){
                infor_modal.style.display = "block";
                document.getElementById("popup-BookAdd-Form").style.filter = "filter: blur(5px)";
            }
            
            // now show automatically after 0.1s
            setTimeout(showPopUpModal,100) 
                        
            function closeWin() {
                infor_modal.style.display = "none";
            }
        </script>  
        
        <script>
            var my_modal = document.getElementById('popup-Update-Form');

            function showModal(){
              my_modal.style.display = "block";
            }

            // now show automatically after 0.1s
            setTimeout(showModal,100) 
        </script>
    </body>
</html>
