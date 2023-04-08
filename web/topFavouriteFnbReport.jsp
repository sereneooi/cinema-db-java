<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList"%>
<jsp:useBean id="favItemDA" scope="application" class="model.FavItemDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <style>
             .barchart-Wrapper {
                display: table;
                position: relative;
                margin: 55px 0;
                height: 252px;
                margin-bottom: 130px;
            }
            .barChart-Container {
                display: table-cell;
                width: 100%;
                height: 100%;
                padding-left: 15px;
            }
            .barchart {
               display: table;
               table-layout: fixed;
               height: 100%;
               width: 100%;
               border-bottom: 3px solid black;
            }
            .barchart-Col {
                position: relative;
                vertical-align: bottom;
                display: table-cell;
                height: 100%;
            }
            .barchart-Col + .barchart-Col {
                border-left: 4px solid transparent;
            }
            .barchart-Bar {
                position: relative;
                height: 0;
                transition: height 0.5s 2s;
                width: 66px;
                margin: auto;
            }
              .barchart-Bar:after {
                content: attr(attr-height);
                color: white;
                position: absolute;
                text-align: center;
                width: 100%;
            }
            .barchart-BarFooter {
                position: absolute;
                text-align: center;
                height: 10%;
                width: 100%;
            }
            .barchart-BarFooter h3 {
                margin-top: 10px;
            }
            .bar-0 {
                background-color: #e3c4c4;
            }
            .bar-1 {
                background-color: #e3d4c4;
            }
            .bar-2 {
                background-color: #e8e8b0;
            }
            .bar-3 {	
                background-color: #badeba;
            }
            .bar-4 {
                background-color: #d4e3c4;
            }
            .bar-5 {
                background-color: #c4e3e3;
            }
            .bar-6 {
                background-color: #c4d4e3;
            }
            .bar-7 {
                background-color: #a9a9d6;
            }
            .bar-8 {
                background-color: #d4c4e3;
            }
            .bar-9 {
                background-color: #d4d4d4;
            }
            .count {
                text-align: center;
            }
            .table {
                display: table;
                font-size: 20px;
            }
            .row {
                display: table-row;
            }
            .cell {
                display: table-cell;
                vertical-align: middle;
                border-bottom: 1px solid black;
            }
            td:nth-of-type(5) {
                text-align: center;
            }
            .range {
                text-align: center;
                margin-top: 50px;
            }
            #slider::-webkit-slider-runnable-track {
                width: 100%;
                height: 20px;
                background: #373B44;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to left, #4286f4, #373B44);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to left, #4286f4, #373B44); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                border-radius: 10px;
                box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4);
                cursor: pointer;
                -webkit-appearance: none;
            }
            #slider::-webkit-slider-thumb {
                border: none;
                height: 50px;
                width: 50px;
                background-color: transparent;
                background-image: url(https://storage.googleapis.com/pw-stuff/thumbs-sprite.png);
                background-position: 0 0;
                background-size: cover;
                transform: scale(1.9);
                cursor: pointer;
                margin-top: -15px;
                -webkit-appearance: none;
            }
            #slider::-webkit-slider-thumb:active {
                background-position: 100% 0px;
                transform: scale(2.0);
            }
            #slider {
                -webkit-appearance: none;
                background: transparent;
                width: 90%;
                max-width: 500px;
                outline: none;
                margin-top: 50px;
            }
            #slider:focus,
            #slider:active,
            #slider::-moz-focus-inner,
            #slider::-moz-focus-outer {
                border: 0;
                outline: none;
            }
            .range label {
                background: #16222A;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to bottom, #3A6073, #16222A);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to bottom, #3A6073, #16222A); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4);
                padding: 14px;
                margin-left: 10px;
                font-family: Roboto, 'Helvetica Neue', Arial;
                font-size: 20px;
                width: 25px;
                text-align: center;
                color: darken(#4685d7, 20%);
                font-weight: bold;
                content: '';
                border-radius: 5px;
                color: white;
            }
            </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            <div class="header">
                <h1>Top Favourite Food & Beverages</h1>
            </div>
            
            <%  
                Object[] favItemObjList = favItemDA.getFavouriteCount();
                ArrayList<Fnb> fnbList = (ArrayList<Fnb>) favItemObjList[0];
                ArrayList<Integer> countList = (ArrayList<Integer>) favItemObjList[1];
                        
                int top = 10;
                int max = 10;
                
                if(fnbList.size() < 10) {
                    top = fnbList.size();
                    max = fnbList.size();
                } 
                
                if(request.getParameter("slider") != null) {
                    top = Integer.parseInt(request.getParameter("slider"));
                }
            %>
            
            <div class="range">
                <label for="slider"><%= top %></label>
                <form method="get" action="topFavouriteFnbReport.jsp?">
                    <input id="slider" name="slider" type="range" min="1" max="<%= max %>" value="<%= top %>">
                </form>
                <p style="margin-top: 40px">*Slide to filter how many top favourite food & beverages you would like to view</p>
            </div>

            
            <div class="barchart-Wrapper">
               <div class="barChart-Container">
                   <div class="barchart">

                    <% 
                        int total = 0;
                        for(int i = 0; i < countList.size(); i++) {
                            total += countList.get(i);
                        }
                        
                        for(int i = 0; i < fnbList.size(); i++) {
                            if(i == top) {
                                break;
                            }
                    %>

                       <div class="barchart-Col">
                           <div class="count"><%= countList.get(i) %></div>
                           <div class="barchart-Bar bar-<%= i %>" style="height: <%= (double) countList.get(i) / total * 100 %>%;"></div>
                           <div class="barchart-BarFooter">
                               <h3><%= fnbList.get(i).getFnbDescription() %></h3>
                           </div>
                       </div>

                    <% } %>

                  </div>
              </div>
           </div>
            <table id="example" style="width:100%; margin-top: 10%; margin-bottom: 20px;">
                    <thead>
                        <tr>
                            <th>FnbID</th>
                            <th>FnbDescription</th>
                            <th>FnbPrice</th>
                            <th>Active</th>
                            <th style="max-width: 70px;">Total Favourites</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <% 
                            for(int i = 0; i < fnbList.size(); i++) {
                                if(i == top) {
                                    break;
                                }
                        %>
                        
                        <tr>
                            <td><%= fnbList.get(i).getFnbID() %></td>
                            <td><%= fnbList.get(i).getFnbDescription() %></td>
                            <td>RM <%= String.format("%.2f", fnbList.get(i).getFnbPrice()) %></td>
                            <td>
                                <p class=
                                    <% if(fnbList.get(i).isActive()) { %>
                                        "true">active
                                    <% } else { %>
                                        "false">inactive
                                    <% } %>
                                </p>
                            </td>
                            <td><%= countList.get(i) %></td>
                        </tr>
                        
                        <% } %>
                        
                    </tbody>
            </table>
        </div>
    </body>
    <script>
        const input = document.querySelector("input");
        const label = document.querySelector("label");

        input.addEventListener("input", event => {
          const value = Number(input.value) / 100;
          label.innerHTML = input.value;          
        });
        
        $("#slider").on("input change", function() { 
            $(this).parent().submit();
        });
        

    </script>
</html>
