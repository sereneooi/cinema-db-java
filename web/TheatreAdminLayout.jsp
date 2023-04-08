<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*,java.util.*"%>
<%-- Retrieve the Theatre Object saved in the session --%>
<jsp:useBean id="theatreList" type="List<model.Theatre>" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <style>
            <%@ include file="bookingStyle.css"%>
        </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        <div id="background-blur" class="content">
            <%Integer totalRecordCount = (Integer)session.getAttribute("totalNoOfRecord");%>
            <%! int j = 0;%>
                
            <section class="cc-attributes-details-layout"  style="margin-bottom: 30px;  height: auto;">
                <div>
                    <div class="cc-attributes-details-header">
                        <p id="demo"></p>
                        <h1>Theatre Details</h1>
                    </div>

                    <div style="display: inline-block; margin: 25px 0px; width: 100%;">
                        <button id="btnAdd" onclick="Add()" style="float: left;"><h1 style="font-size: 15px; font-family: 'Times New Roman', Times, serif;"><i class="fa-solid fa-plus"></i>&ensp;Add New Theatre</h1></button>
                        <a href="javascript:{}" onclick="document.getElementById('deleteCheckBox').submit();" id="selectAll1" class="btn"><h1 style="font-size: 15px; font-family: 'Times New Roman', Times, serif;"><i class="fa-solid fa-trash"></i>&ensp;Delete</h1></a>
                        
                        <div style="float: right; max-width:400px;margin:auto">
                            <div class="input-icons">
                                <i class="fas fa-search icon"></i>
                                <form action="searchItem" method="POST" id="searchForm">
                                    <input type="search"  name="theatreSearch" id="searchInput"/>
                                </form>
                                <input type="submit" id="searchBtn" form="searchForm" value="Submit" style="display:none">
                            </div>
                        </div>
                        
                    </div>
                    
                </div>

                <div class="cc-attributes-details-form-container" style="margin-bottom: 50px;">
                    <table class="cc-attributes-details-form" id="myTable" style="margin-bottom: 50px;">
                        <tr class="cc-attributes-details-form">
                            <th class="cc-attributes-details-form" style="padding: 0px 10px;"><input type="checkbox" name="selectAll"  id="selectAll" /></th>
                            <form action="SortItem" method="POST">
                                <th class="cc-attributes-details-form">
                                    <button type="submit"  id="headerBtn"><strong>ID</strong></button>
                                    <input type="hidden" name="sortTheatre" value="theatreId">
                                </th>
                            </form>
                            <form action="SortItem" method="POST">
                                    <th class="cc-attributes-details-form">
                                        <button type="submit"  id="headerBtn"><strong>Description</strong></button>
                                        <input type="hidden" name="sortTheatre" value="theatreDesc">
                                    </th>
                            </form>
                            <form action="SortItem" method="POST">
                                    <th class="cc-attributes-details-form">
                                        <button type="submit"  id="headerBtn"><strong>Total Seat Count</strong></button>
                                        <input type="hidden" name="sortTheatre" value="totalSeatCount">
                                    </th>
                            </form>
                            <form action="SortItem" method="POST">
                                    <th class="cc-attributes-details-form">
                                        <button type="submit"  id="headerBtn"><strong>Classes Type</strong></button>
                                        <input type="hidden" name="sortTheatre" value="theatreClassesDesc">
                                    </th>
                            </form>
                            <th class="cc-attributes-details-form" colspan="2"><strong>Action</th>
                        </tr>
                
                        <form id="deleteCheckBox" method="POST" action="DeleteConfirmation.jsp">
                            <%for(int i = 0; i<theatreList.size(); i++){
                                Theatre theatre = theatreList.get(i);
                            %>
                            <tr class="cc-attributes-details-form">
                                <td class="cc-attributes-details-form">
                                        <input type="checkbox" name="<%="theatreIdResult["+i+"]"%>"  class="checkboxAll" value="1"/>
                                </td>
                                <td class="cc-attributes-ssdetails-form" id="col1"><%=theatre.getTheatreID()%></td>
                                <td class="cc-attributes-details-form" id="col2"><%=theatre.getTheatreDesc()%></td>
                                <td class="cc-attributes-details-form" id="col3"><%=theatre.getTotalSeatCount()%></td>
                                <td class="cc-attributes-details-form" id="col4"><%=theatre.getTheatreClasses().getTheatreClassesDesc()%></td>
                                <td class="cc-attributes-details-form" style='border:none;'>
                                    <a href="RetrieveItem?id=<%=theatre.getTheatreID()%>""><i class="fas fa-edit icon"></i></a>
                                </td>
                                <td class="cc-attributes-details-form" style='border:none;'>
                                        <a href="DeleteConfirmation.jsp?theatreId=<%=theatre.getTheatreID()%>"><i class="fa-solid fa-trash icon"></i></a>
                                </td>
                            </tr>     
                            <% j++;
                                }%>
                        </form>
                    </table>

                </div>
            </section>
        </div>                   

        <div class ="popup-Form"  id="popup-Add-Form">
            <div class="popup-Form-container">
                <div><span class="close" onclick="Add()">&times;</span></div>

                <h1>New Theatre Details</h1>                          
                <hr class="solid">
                <br/>                      
                <form action="AddItem" method="POST" id="theatreForm">
                    <p>
                        <label>Theatre ID </label>
                        <br/>
                        <input type="text" name="theatreId" placeholder="T0001" required="required" pattern="[T|t][0-9][0-9][0-9][0-9]" Title="Please match the requested format (eg. T0001) with exactly length 5."  maxlength="5"/>
                    </p>
                    
                    <br/>   
                    
                    <p><label>Theatre Description </label><br/>
                        <input type="text" name="theatreDesc" placeholder="Hall 1" required="required" size="50"/></p>

                    <br/>

                    <p><label>Total Number of Seat </label><br/>
                        <input type="number" name="totalSeatCount" placeholder="100" required="required"/></p>

                    <br/>

                    <p><label>Theatre Classes </label><br/>
                        <select name="theatreClassesId">
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
                
        <script type="text/javascript">
            function Add(){
                var blurBg = document.getElementById('background-blur');
                blurBg.classList.toggle('active');
                var popup = document.getElementById('popup-Add-Form');
                popup.classList.toggle('active');
            }
            
            var closebtns = document.getElementsByClassName("close");

            closebtns.addEventListener("click", function() {
              this.parentElement.style.display = 'none';
            });
        </script>
        
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
    
    <script>   
        $("#selectAll1").click(function () {
            $(".checkboxAll").prop('checked', $(this).prop('checked'));
        });
    </script>
    </body>
</html>
