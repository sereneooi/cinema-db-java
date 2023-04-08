<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="checkStaffAccess.jsp"%>
<%List <Integer> soldQty = (ArrayList <Integer>) session.getAttribute("soldQty");
List <String> ticket = (ArrayList <String>) session.getAttribute("ticketFilm");
List <Double> gross = (ArrayList <Double>)session.getAttribute("gross");%>
<!DOCTYPE html>
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
        <section class="cc-attributes-details-layout" style="height: auto;">
            <div class="cc-attributes-details-header">
                <p id="demo"></p>
                <h1>Top 5 List Of Highest Grossing Film In 2022 </h1>
            </div>
            
            <div class="cc-attributes-details-form-container" style="margin: 20px 0px 50px; height: auto;">
                <table class="cc-attributes-details-form" id="myTable">
                    <thead>
                        <tr>
                            <th class="cc-attributes-details-form" >Rank</th>
                            <th class="cc-attributes-details-form" >Movie Name</th>
                            <th class="cc-attributes-details-form" >Quantity</th>
                            <th class="cc-attributes-details-form" >Grossing</th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <%for(int i = 0; i < soldQty.size(); i++){%>
                            <tr>
                                <td class="cc-attributes-details-form"><%=i + 1%></td>
                                <td class="cc-attributes-details-form"><%=ticket.get(i)%></td>
                                <td class="cc-attributes-details-form"><%=soldQty.get(i)%></td>
                                <td class="cc-attributes-details-form"><%out.print(String.format("RM %.2f", gross.get(i)));%></td>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </section>
    </body>
</html>
