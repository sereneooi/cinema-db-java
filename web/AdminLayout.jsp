<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*;"%>
<jsp:useBean id="currentUser" scope="session" class="model.Account"/>

<!DOCTYPE html>
<html>
    <head>
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
 
            body {
                overflow-x: hidden;
                margin: 0 auto;
                width: 100%;
                min-width: 1280px;
                max-width: 1280px;
            }
 
            .container {
                position: relative;
                width: 100%;
            }
 
            .navigation {
                position: fixed;
                width: 300px;
                height: 100%;
                background: rgb(51, 51, 51);
                overflow-y: scroll;
            }
 
            .navigation > ul {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
            }
 
            .navigation > ul li {
                position: relative;
                width: 100%;
                height: 80%;
                list-style: none;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                font-family: 'Times New Roman', Times, serif;
            }
 
            .dropdown-container {
                display: none;
                background-color:rgb(71, 71, 71);
                padding-left: 10px;
            }
 
            .navigation > ul > li:hover,
            .dropdown-btn.active {
                background: #594f8d;
            }
 
            .navigation > ul > li:nth-child(1) {
                margin-bottom: 10px;
                border: none;
            }
 
            .navigation > ul > li:hover:nth-child(1) {
                background: none;
            }
 
            .navigation > ul > li:nth-child(1) a span {
                margin-left: 20%;
                font-size: 23px;
            }
 
            .navigation > ul li img {
                margin-left: 30%;
                height: 90px;
                width: 90px;
                margin-top: 25px;
                cursor: pointer;
            }
 
            .dropdown-btn {
                background: none;
                border: none;
                font-family: 'Times New Roman', Times, serif;
                cursor: pointer;
            }
 
            ion-icon[name="caret-down-outline"] {
                position: absolute;
                float: right;
                top: 13px;
                right: 10px;
                font-size: 20px;
            }
 
            .navigation > ul li a,
            .navigation > ul li .dropdown-btn {
                position: relative;
                display: block;
                width: 100%;
                display: flex;
                text-decoration: none;
                color: rgb(179, 179, 255);
                font-size: 15px;
            }
 
            .navigation > ul > li:hover > a,
            .dropdown-btn:hover .title,
            .dropdown-container > ul > li:hover > a {
                color: #fff;
            }
 
            .dropdown-btn.active .title {
                color: #fff;
            }
 
            .navigation > ul > li:hover:nth-child(1) a {
                color: rgb(179, 179, 255);
            }
 
            .navigation > ul li .title {
                position: relative;
                display: block;
                padding: 0 15px;
                height: 50px;
                line-height: 50px;
                text-align: start;
                white-space: nowrap;
            }
 
            .topbar {
                width: 100%;
                height: 60px;
                display: flex;
                justify-content: space-between;
                background-color: #504064;
                align-items: center;
                padding: 0 10px;
            }
 
            .user {
                position: relative;
                min-width: 40px;
                height: 40px;
                border-radius: 50%;
                overflow: hidden;
                cursor: pointer;
                margin-left: calc(100% - 45px);
            }
 
            .user img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
             .logout{
                height: 40px;
                width: 100px;
                cursor: pointer;
                background-color: transparent;
                color: white;
                border: 2px solid white;
                font-size: large;
                border-radius: 5px;
                font-family: 'Times New Roman', Times, serif;
            }
            
            .logout:hover{
                background-color: whitesmoke;
                color: #504064;
                -webkit-transition: background-color 300ms linear;
                -ms-transition: background-color 300ms linear;
                transition: background-color 300ms linear;
            }
            
            .yourAccount{
                color: whitesmoke;
                font-family: 'Times New Roman', Times, serif;
                font-size: 18px;
                padding-left: 10px;
            }
            
            .profile:hover{
                background-color: rgb(217, 217, 217, 0.2);
                border-radius: 25px;
                cursor: pointer;
                -webkit-transition: background-color 200ms linear;
                -ms-transition: background-color 200ms linear;
                transition: background-color 200ms linear;
            }
            
            *::-webkit-scrollbar {
                width: 12px;
            }

            *::-webkit-scrollbar-track {
                background: black;
            }

            *::-webkit-scrollbar-thumb {
                background-color: rgb(51, 51, 51);
                border-radius: 20px;
                border: 2px solid;
            }
            
            @media (min-width: 1200px) {
                .container, .container-lg, .container-md, .container-sm, .container-xl {
                    max-width: none;
                }
            }
            @media (min-width: 992px) {
                .container, .container-lg, .container-md, .container-sm {
                    max-width: none;
                }
            }
            @media (min-width: 768px) {
                .container, .container-md, .container-sm {
                    max-width: none;
                }
            }
            @media (min-width: 576px) {
                .container, .container-sm {
                    max-width: none;
                }
            }
            .container, .container-fluid, .container-lg, .container-md, .container-sm, .container-xl, .container-xxl {
                width: 100%;
                padding-right: 0px;
                padding-left: 0px;
            }
            ol, ul {
                padding-left: 0px;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="navigation">
                <ul>
                     <li>
                        <a href="adminDashboard.jsp"><img src="logo.png" alt="CC Cinema Logo"></a>
                        <a href="adminDashboard.jsp"><span class="title">CC CINEMA</span></a>
                    </li>
                      <li>
                        <button class="dropdown-btn">
                            <span class="title">User</span>
                            <ion-icon name="caret-down-outline" style="color: white;"></ion-icon>
                        </button>
                        <div class="dropdown-container">
                            <ul>
                                <li>
                                    <a href="StaffList?page=manageStaff"><span class="title">Staff</span></a>
                                </li>
                                <li>
                                    <a href="customerRecord.jsp"><span class="title">Customer</span></a>
                                </li>
                                <li>
                                    <a href="RoleList?page=manageRole"><span class="title">Role</span></a>
                                </li>
                            </ul>
                        </div>
                    </li>
                     <li>
                        <button class="dropdown-btn">
                            <span class="title">Movie</span>
                            <ion-icon name="caret-down-outline" style="color: white;"></ion-icon>
                        </button>
                        <div class="dropdown-container">
                            <ul>
                                 <li>
                                    <a href="AdminActorList.jsp"><span class="title">Actor</span></a>
                                </li>
                                 <li>
                                    <a href="AdminMovie.jsp"><span class="title">Movie</span></a>
                                </li>
                                 <li>
                                    <a href="AdminMovieSchedule.jsp"><span class="title">Movie Schedule</span></a>
                                </li>
                        </div>
                    </li>
                     <li>
                        <a href="javascript:document.myForm.submit();"><span class="title">Theatre</span></a>
                         <form action="RetrieveTheatre" method="POST" name="myForm"></form>
                    </li>
                     <li>
                        <button class="dropdown-btn">
                            <span class="title">Food</span>
                            <ion-icon name="caret-down-outline" style="color: white;"></ion-icon>
                        </button>
                        <div class="dropdown-container">
                            <ul>
                                <li>
                                    <a href="fnbCategory.jsp"><span class="title">Food and Beverages Category</span></a>
                                </li>
                                <li>
                                    <a href="fnb.jsp"><span class="title">Food and Beverages</span></a>
                                </li>
                            </ul>
                        </div>
                    </li>
                     <li>
                        <button class="dropdown-btn">
                            <span class="title">Booking</span>
                            <ion-icon name="caret-down-outline" style="color: white;"></ion-icon>
                        </button>
                        <div class="dropdown-container">
                            <ul>
                                <li>
                                    <a href="javascript:document.bookingForm.submit();"><span class="title">Booking</span></a>
                                    <form action="RetrieveBooking" method="POST" name="bookingForm"></form>
                                </li>
                                 <li>
                                    <a href="fnbOrderDelivery.jsp"><span class="title">Food and Beverages Order Delivery</span></a>
                                </li>
                            </ul>
                        </div>
                    </li>
                     <li>
                        <a href="AdminPromotion.jsp"><span class="title">Promotion</span></a>
                    </li>
                    <li>
                        <a href="AdminPayment.jsp"><span class="title">Payment</span></a>
                    </li>
                    <li>
                        <a href="question.jsp"><span class="title">Question</span></a>
                    </li>
                     <li>
                        <button class="dropdown-btn">
                            <span class="title">Report</span>
                            <ion-icon name="caret-down-outline" style="color: white;"></ion-icon>
                        </button>
                        <div class="dropdown-container">
                            <ul>
                                 <li>
                                    <a href="topFavouriteFnbReport.jsp"><span class="title">Top Favourite Food and Beverages Report</span></a>
                                </li>
                                 <li>
                                    <a href="serviceRatingReport.jsp"><span class="title">Service Rating Report</span></a>
                                </li>
                                <li>
                                    <a href="javascript:document.salesReportForm.submit();"><span class="title">Daily Sales Report</span></a>
                                    <form action="RetrieveSalesReport" method="POST" name="salesReportForm"></form>                                     
                                </li>
                                 <li>
                                    <a href="javascript:document.topSalesReportForm.submit();"><span class="title">Top List of Highest Grossing Report</span></a>
                                    <form action="RetrieveTopSalesReport" method="POST" name="topSalesReportForm"></form>     
                                </li>  
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
 
            <div class="main">
                <div class="topbar">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: right;">
                                <table align="right" class="profile" onclick="location.href='./UpdateStaffProfile';">
                                    <tr>
                                        <td><span class="yourAccount">${currentUser.name}</span></td>
                                        <td style="width: 50px;"><div class="user"><img src="youraccount.png"></div> </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align: right; width: 11%;">
                                <button type="button" class="logout" onclick="location.href='logout.jsp';">Logout</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

 
        <script>
            var dropdown = document.getElementsByClassName("dropdown-btn");
 
            for (let i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        </script>
    </body>
</html>
