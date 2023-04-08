<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*, java.util.*"%>
<jsp:useBean id="theatreResult" scope="session" class="model.Theatre"/>
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
        <jsp:include page="TheatreAdminLayout.jsp" />
         
        <div id="popup-Update-Form">
             <div class="popup-Form-container">
                    <div id="popup-Update-Form-content" style="height: auto;">
                <div><span class="close" onclick="window.location='TheatreAdminLayout.jsp'">&times;</span></div>
                    <form action="UpdateItem" method="POST">
                        
                    <h1>Update Theatre Details</h1>
                    <br/>

                    <p>
                        <label>Theatre ID </label>
                        <br/>
                        <input type="text" name="theatreId" value="${theatreResult.theatreID}" readonly/>
                    </p>
                    
                    <br/>

                    <p><label>Theatre Description </label><br/>
                        <input type="text" name="theatreDesc" onfocus="this.value=''" value="${theatreResult.theatreDesc}"/></p>

                    <br/>

                    <p><label>Total Number of Seat </label><br/>
                        <input type="number" name="totalSeatCount" id="totalSeatCount" onfocus="this.value=''" value="${theatreResult.totalSeatCount}"/></p>

                    <br/>

                    <p><label>Theatre Classes</label><br/>
                        <select name="theatreClassesId" id="classType">
                            <option value="${theatreResult.theatreClasses.theatreClassesID}" selected>${theatreResult.theatreClasses.theatreClassesDesc}</option>
                            <option value="TC0001">D-BOX</option>
                            <option value="TC0002">IMAX®</option>
                            <option value="TC0003">Premiere Class</option>
                            <option value="TC0004">3D</option>
                            <option value="TC0005">2D</option>
                        </select>
                    </p>

                    <br/><br/>

                    <p>
                        <button type="submit" value="Submit">Submit</button>
                        <button type="reset">Reset</button>
                    </p>
                </form>
                    </div>
            </div>
        </div>
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
