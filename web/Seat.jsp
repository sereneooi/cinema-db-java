<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*"%>
<!--Seat-->
<%-- fetch the attributes of the requeste object from RetrieveTheatreDetail.java --%>
<%
    MovieSchedule movieScheduleDetails= (MovieSchedule)session.getAttribute("movieScheduleDetails");
    
    int seatCount = movieScheduleDetails.getTheatre().getTotalSeatCount();
    String hallNumber = movieScheduleDetails.getTheatre().getTheatreDesc();
    String theatreClasses = movieScheduleDetails.getTheatre().getTheatreClasses().getTheatreClassesDesc();
    String movieName = movieScheduleDetails.getMovie().getMovieName();
    LocalDateTime showDateTime = movieScheduleDetails.getShowDateTime();
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    String formatDateTime = showDateTime.format(formatter);
    String[] dateTime = formatDateTime.split(" ", 2);
    
    String showDate = dateTime[0];
    String showTime = dateTime[1];
    
    List <String> sNo = (ArrayList<String>)session.getAttribute("scheduleId");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="Homestyle.css" rel="stylesheet" type="text/css" />
        <link href="style-Copy-2.css" rel="stylesheet" type="text/css" />
        <link href="layout.css" rel="stylesheet" type="text/css" />
        <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Montserrat&amp;display=swap'>
        <script src="https://kit.fontawesome.com/45084f36b1.js" crossorigin="anonymous"></script>
    
        <style>
            <%@ include file="bookingStyle.css"%>
            <%@ include file="checkboxStyle.css"%>
            .cc-btn-continue-layout{
                  position: fixed;
                  background-color: rgb(51, 51, 51); 
              }
              
              .row input[type="checkbox"]:disabled  + .legendSelected{
                border: 3px solid #e0ebf5;
                box-shadow: 3px 3px 6px 3px rgba(0, 0, 0, 0), -3px -3px 3px 3px rgba(247, 251, 255, 0), 3px 3px 8px 2px rgba(0, 0, 0, 0.1) inset, -3px -3px 7px 2px rgba(247, 251, 255, 0.7) inset;
                background-color: rgb(105, 172, 56);
                -webkit-text-stroke: 2.2px #fff;
                text-stroke: 1px solid #7989A4;
                -webkit-animation-name: rubberBand;
                animation-name: rubberBand;
                animation-duration: 300ms;
                animation-fill-mode: both;
                border: 6px solid transparent;
                cursor: context-menu;
                content: "✔";
            }
            .row input[type="checkbox"]:disabled + .legendSelected:after{
                content: "✔";
            }
            
            .row input[type="checkbox"]:disabled  + .legendSingleSeat {
                align-items: center;
                background-color: #d9e3f2;
                border: 8px solid transaparent;
                box-shadow: 0px 0px 6px 6px rgba(0, 0, 0, 0.1), 3px 3px 3px 6px rgba(247, 251, 255, 0.5), 0px 0px 8px 5px rgba(0, 0, 0, 0) inset, 0px 0px 7px 5px rgba(247, 251, 255, 0) inset;
                color: transparent;
                cursor: pointer;
                display: flex;
                height: 100%;
                justify-content: center;
                position: relative;
                transition: border 0.1s ease, box-shadow 0.1s ease, color 0.1s ease, text-stroke 0.1s ease, -webkit-text-stroke 0.1s ease top ease 0.1s;
                width: 80%;
                -webkit-text-stroke: 2.2px #fff;
                position: relative;
                top: 0;
                transition-property: opcaity, transform;
                will-change: opcaity, transform;
                border: 4px solid transparent;
                border-radius: 14px;
                background-repeat: no-repeat;
                height: 32px;
                width: 80%;
                cursor: context-menu;
            }
            
            .row input[type="checkbox"]:disabled + .legendSingleSeat:after{
                content: "😎";
            }
            
            #legendTwinSeat + .twinSeatAll{
                background-color: pink;
                 align-items: center;
                border: 8px solid transaparent;
                box-shadow: 0px 0px 6px 6px rgba(0, 0, 0, 0.1), 3px 3px 3px 6px rgba(247, 251, 255, 0.5), 0px 0px 8px 5px rgba(0, 0, 0, 0) inset, 0px 0px 7px 5px rgba(247, 251, 255, 0) inset;
                color: transparent;
                cursor: pointer;
                display: flex;
                height: 100%;
                justify-content: center;
                position: relative;
                transition: border 0.1s ease, box-shadow 0.1s ease, color 0.1s ease, text-stroke 0.1s ease, -webkit-text-stroke 0.1s ease top ease 0.1s;
                width: 80%;
                -webkit-text-stroke: 2.2px #fff;
                position: relative;
                top: 0;
                transition-property: opcaity, transform;
                will-change: opcaity, transform;
                border: 4px solid transparent;
                border-radius: 14px;
                background-repeat: no-repeat;
                height: 32px;
                width: 80%;
                cursor: context-menu;
                content: "💕";
            }
            
            .row input[type="checkbox"]:disabled + .twinSeatAll:after{
                content: "💕";
            }
            
            h5{
                color: white;
                margin-left: 15px;
                width: 70%;
                font-size: 15px;
            }
            
            .icon{
                color: white;
                padding: 2px;
                min-width: 20px;
            }
            </style>    

    </head>
    
    <body style="min-width: 90em;">
        <div style="background-color:rgb(51, 51, 51);">
        <!-- header -->
        <header class="cc-btn-continue-layout" style="position:fixed; min-width: 100%; min-height: 14%; top: 0; left: 0;  background-color:rgba(0,0,0,1); z-index: 999;">
            <div class="cc-btn-continue-container" style="display: flex; position: absolute; height: 100%; width: 100%; ">
                <a href="cinema.html"><img src="logo.png" alt="CC Cinema" id="logo" name="logo" style="all: initial; z-index: 999; width: 30%; margin: 20px 0px; "/></a>
                <a style="margin-left: -85px; margin-top: 55px; font-family: mahelisa; font-size:45px; font-variant: small-caps; font-style: italic; color: rgb(204, 153, 255); height: 60%; ">Cc Cinema</a>
                <div class="userOrder" style="display: flew; width: 70%;">
                    <div class="movieHeader">
                        <span class="close" onclick="window.location='movieSchedule.jsp'" >&times;</span>
                        <h3 style="text-align: center; color: white"><%=movieName%></h3>
                    </div>
                    <div class="movieHeader" style="display: flex; justify-content: center;">
                        <i class="fa-regular fa-circle-h icon"></i><p><%=hallNumber%></p>
                        <i class="fa fa-film icon" style="color: white; size: 50px;"></i><p><%=theatreClasses%></p> 
                        <i class="fas fa-calendar-alt icon" style="color: white; size: 50px;"></i><p ><%out.print(showDate);%></p> 
                        <i class="fa fa-clock-o icon" style="color: white; size: 50px;"></i><p><%=showTime%></p> 
                    </div>
                    
            </div>
        </header>
        <section style="background-color:rgb(51, 51, 51); height: 100em ">
        <section style="margin-top: 300px; width: 20%; float: left; ">
            <div style="background-color: rgba(77, 77, 77, 0.6); box-shadow: 3px 6px 10px #000, -3px -6px 10px #000; width: 26.5em; height: 55em; margin-bottom: 20px;">
                <iframe width="420" height="315"
                src="<%=movieScheduleDetails.getMovie().getMovieTrailer()%>">
                </iframe>
                
                <div class="movieTicketBooking" style=" padding: 15px;">
                    <label >Synopsis</label>
                    <p style="color: #a6a6a6; font-family: Comic Sans MS, cursive, sans-serif; text-align: justify; text-justify: inter-word;"><%=movieScheduleDetails.getMovie().getSynopsis()%></p>
                </div>
            </div>
        </section>
                        
        <section style="background-color:rgb(51, 51, 51); width: 67%; float: right; height: 100em; ">
            <div style="margin-top: 300px;">
            <!--Screen-->
            <section class="seat-layout" style="margin-bottom: 150px;">
                <ul class="seat-row-container"  style="width: 100%; margin: auto; margin-bottom: 60px;">
                    <li class="screen">
                        <div class="row">
                            <input id="legendSingleSeat" name="legendSingleSeat" title="Single Seat" type="checkbox"disabled />
                            <label for="legendSingleSeat" class="button button-square button-border legendSingleSeat" style="margin-right: 5px; width: 25%;"></label><h5>Single Seat</h5>
                        </div>
                    </li> 
                    <li class="screen">
                        <div class="row">
                            <input id="legendTwinSeat" name="legendTwinSeat" title="Couple Seat" type="checkbox" disabled/>
                            <label for="legendTwinSeat" class="button button-square button-border twinSeatAll" style="margin-right: 10  px; width: 100%;"></label>
                            <input id="legendTwinSeat2" name="legendTwinSeat" title="Couple Seat" type="checkbox" />
                            <label for="legendTwinSeat2" class="button button-square button-border twinSeatAll" style="margin-right: 0px; width: 100%;"></label><h5>Twin</h5>
                        </div>
                    </li> 
                    <li class="screen">
                        <div class="row">
                            <input id="selectedSeat" name="selectedSeat" title="Unavailable Seat" type="checkbox"  disabled/>
                            <label for="selectedSeat" class="button button-square button-border legendSelected" style="background-color: rgb(105, 172, 56);margin-right: 5px; width: 30%;"></label><h5>Selected</h5>
                        </div>
                    </li> 
                    <li class="screen">
                        <div class="row">
                            <input id="selectedSeat" name="selectedSeat" title="Unavailable Seat" type="checkbox" disabled/>
                            <label for="selectedSeat" class="button button-square button-border legendSold" style="margin-right: 5px; width: 25%;"></label><h5>Sold</h5>
                        </div>
                    </li> 
                </ul>
                
                <div style="display: flex;  justify-content: center; position: relative; margin-bottom: 20px;">
                    <img src="image/bg-screen-transwhite.png" alt="White Screen" style="display: block;" />
                    <i class='far fa-hand-point-up' style="font-size:25px; position: absolute; margin-top: 10px; bottom:0; left:-50; color: white; z-index: 1;"></i>
                    
                 </div>
                <div style="display: flex;  justify-content: center; position: relative; margin-bottom: 20px;">
                    <p style="all: initial; margin-top: -10px; bottom:0; color:white;">This is Screen</p></div>
                
                    <form action="AddSeat" method="POST" onsubmit="return checkFormData()">
                <div id="plan" class="seat-container">
                    <%! int alphaCol = 65; String colName = ""; int colNumber; String seatId = "";%>
                    
                    <%for ( int seatNumber = 1; seatNumber <= seatCount; seatNumber++){ %>
                    
                        <ul class="seat-row-container">
                            
                            <!-- Seat Column Alpha-->
                            <%colName = String.valueOf(Character.toChars(alphaCol));%>
                            <li class="seat-alphaCol"><h1 style="all: initial; color: white;"><%= colName%></h1></li>
                            
                            <% for (colNumber = 1; colNumber <= 12; colNumber++){ 
                                    if(seatNumber<=seatCount){%>
                                        <% seatId = colName + String.valueOf(colNumber);
                                        if(seatCount > 100 && seatNumber > (seatCount - 24)){
                                                if(sNo.contains(seatId)){%>
                                                    <li class="screen">
                                                        <div class="row">
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" value="<%= seatId+"@ST0001"%>" type="checkbox" disabled/>
                                                            <label for="<%= seatId%>" class="button button-square button-border twinSeatAll" style="margin-right: 5px;"></label>
                                                            <%colNumber++; seatNumber++; 
                                                            seatId = colName + String.valueOf(colNumber);%>
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" value="<%= seatId+"@ST0001"%>" type="checkbox" disabled/>
                                                            <label for="<%= seatId%>" class="button button-square button-border twinSeatAll"></label>
                                                        </div>
                                                    </li> 

                                            <%}else{ %>
                                                    <li class="screen">
                                                        <div class="row">
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" class="seatToselect" value="<%= seatId+"@ST0001"%>" type="checkbox"/>
                                                            <label for="<%= seatId%>" class="button button-square button-border twinSeatAll"></label>
                                                            <%colNumber++; seatNumber++;
                                                            seatId = colName + String.valueOf(colNumber);%>
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" class="seatToselect" value="<%= seatId+"@ST0001"%>" type="checkbox"/>
                                                            <label for="<%= seatId%>" class="button button-square button-border twinSeatAll"></label>
                                                        </div>
                                                    </li> 
                                                    <%
                                                  }
                                          }else{
                                                if(sNo.contains(seatId)){%>
                                                    <li class="screen">
                                                        <div class="row">
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" value="<%= seatId+"@ST0002"%>" type="checkbox" disabled/>
                                                            <label for="<%= seatId%>" class="button button-square button-border"></label>
                                                        </div>
                                                    </li> 
                                            <%}else{ %>
                                                    <li class="screen">
                                                        <div class="row">
                                                            <input id="<%= seatId%>" name="<%="selectedSeat["+seatNumber+"]"%>" title="<%= seatId%>" class="seatToselect" value="<%= seatId+"@ST0002"%>" type="checkbox" onclick="toggleText()"/>
                                                            <label for="<%= seatId%>" class="button button-square button-border"></label>
                                                        </div>
                                                    </li> 
                                                    <%
                                                    }
                                            }
                                        seatNumber++;
                                        if(seatNumber == (seatCount - 23)){colNumber=13;}
                                    }
                                }%>
                            <!-- Seat Column Alpha-->
                            <li class="seat-alphaCol"><h1 style="all: initial; color: white;"><% out.print(String.valueOf(Character.toChars(alphaCol)));%></h1></li>
                        </ul>
                    <% alphaCol++;
                        } %>
                        
                        <section class="cc-btn-continue-layout" style="position:fixed; min-width: 100%; min-height: 10%; bottom: 0; left: 0;  background-color:rgba(0,0,0,0.3); ">
                            <div class="cc-btn-continue-container" style="display: flex; position: absolute; height: 80%; width: 100%; justify-content: center; transform: translateY(13%);">
                                <button type="submit" class="cc-btn-continue" id="continue-btn" style="width: 20%; cursor: pointer; background-color: #a999b3; border: none; border-radius: 5px;">Continue</button>
                            </div>
                        </section>
                </div>
                </form>
            </section>
            </div>
                        </section> 
        </section>              
</div>
        <script>
            // Create an empty array to store the seat ids for click event
            window.tempArray = [];
            //Handle the click event
            function updateLocation(){
                    $('#selectedSeat').html(window.tempArray.join('-  -')).css({
                        backgroundColor: '#F6511D',
                        color: '#fff',
                        padding: '0.2em',
                        borderRadius: '2px',
                        margin: '0 10px 0 0'
                    });
            }

            $('#plan').on('click', 'li.screen', function() {
                var maxSeats = 4; //grabbed from JSON
                var seat=$(this);
                var seatLocation = seat.attr('id');
                if (seat.hasClass('booked')){ // Check if the user changed his mind
                        seat.removeClass('booked')
                        window.tempArray.splice(window.tempArray.indexOf(seatLocation), 1);
                        updateLocation();
                        console.log(window.tempArray);
                } else if ($('.booked').length < maxSeats) { // Use .length to check how many '.booked' DOM elements present
                    if (seat.hasClass('taken')){
                        alert('This Seat Is already booked!');
                    } else {
                        seat.addClass('booked')
                        window.tempArray.push(seatLocation);
                        updateLocation();
                        console.log(window.tempArray);
                    }
                }

            });
        </script>
        
        <script>
            function checkFormData() {
                if (!$('input:checked').length > 0) {
                    document.getElementById("continue-btn").disabled = true;
                    document.getElementById("errMessage").innerHTML = "Must Choose At Least One Order.";
                    return false;
                }
                return true;
            }
        </script>
        
        <script>
            var boxes = $('.seatToselect');

            boxes.on('change', function() {
                $('#continue-btn').prop('disabled', !boxes.filter(':checked').length);
            }).trigger('change');
        </script>
    </body>
</html>
