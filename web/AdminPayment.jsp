<%@page import="model.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.PaymentDA"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <style>
         .dropdown-content a:hover, .dropdown-content li:hover{
            cursor: pointer;
        }
        @font-face {
        font-family: 'mahelisa';
        src: url(mahelisa.ttf);
        }

        #title{
            width: 100%;
            height: 100px;
        }
        
        /*                    
                    html{
            background-image: url(background.png);
        }
         */
        body {
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
        }

        .content table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        
        .content th{
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
            background-color: rgb(148, 73, 199);
        }

        .content td{
          border: 1px solid #dddddd;
          text-align: left;
          padding: 8px;
        }
        
        .content tr:nth-child(odd) {
          background-color: rgb(194, 158, 201);
        }

        .content tr:nth-child(even) {
          background-color: rgb(220, 198, 241);
        }

        #label{
            color: rgb(153, 102, 255);
            font-size: 30px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 60px;
        }

        #payment {
            text-shadow: 2px 2px 2px pink;
            text-align: center;
            margin-top: -50px;
            background: linear-gradient(to bottom, rgb(194, 158, 201), rgb(71, 59, 100));
            font-family: 'mahelisa';
            font-size: 40px; 
            color:rgb(63, 30, 99); 
            text-align: center; 
            border-radius: 30px; 
            line-height: 60px;
        }
        
        #submit {
              border: none;
              padding: 22px 33px;
              border-radius: 5px;
              margin-top: 10px;
              margin-left: 600px;
              background: linear-gradient(45deg, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);;
              box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
              transition: all .3s ease-in-out;
              font-size: 13px;
        }

        #submit:hover{
              box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
              transform: translateY(1px);
              opacity: 0.8;
        }

    </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        <br/>
        <br/>
        <br/>
        <div class="content" style="margin-left: 300px">
        <section id="title" style="width:100%">
            <h1 id="payment">PAYMENT</h1>
        </section>
        <br/>
        <br/>
            <table>
                <thead style="">
                    <tr>
                        <th>Line N0</th>
                        <th>Payment ID</th>   
                        <th>Payment Date Time</th>  
                        <th>Total Amount</th>  
                        <th>Payment Method</th>  
                        <th>Promotion Code</th>  
                    </tr>
                </thead>
                <tbody>
                    <%
                        
                        PaymentDA payDA = new PaymentDA();
                        //display all the payment records from the payment table
                        ArrayList<Payment> payList = payDA.getAllPayment();
                        for (int i = 0; i < payList.size(); i++) {%>
                        <tr>                     
                        <td><%= (i+1)%></td>
                        <td><%= payList.get(i).getPaymentID() %></td>
                        <td><%= payList.get(i).getPaymentDateTime() %></td>
                        <td><%= payList.get(i).getTotalAmount() %></td>
                        <td><%= payList.get(i).getPaymentMethod() %></td>
                        <td><%= payList.get(i).getPromotion().getPromoCode() %></td>
                        </tr>
                   <% }%>
                </tbody>
            </table>
            <br/>
            <br/>
        </div>
    </body>
</html>
