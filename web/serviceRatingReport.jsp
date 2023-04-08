<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*, java.sql.*" %>
<jsp:useBean id="questionDA" scope="application" class="model.QuestionDA"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="yqStyle.css" type="text/css">
        
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <style>
            .question {
                min-height: 400px;
                margin-top: 35px;
                margin-left: 5px;
                margin-right: 5px;
                padding: 10px;
                box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 12px;
                position: relative;
            }
            .question h2 {
                margin-bottom: 15px;
            }
            .summary {
                width: 32%;
                text-align: center;
                font-size: 25px;
                margin-top: -3%;
            }
            .summary h2 {
                margin-top: 20%;
                font-size: 30px;
            }
            .summary h1 {
                margin-bottom: 8%;
                font-family: auto;
                font-size: 100px;
            }
            ion-icon[name="person-outline"] {
                margin-right: 10px;
            }
            /* Bar Graph Horizontal */
            .bar-graph {
                margin-left: 35%;
                margin-top: -31%;
            }
            .bar-graph .emoji {
                opacity: 1;
            }
            .bar-graph-horizontal > div {
                float: left;
                margin-bottom: 8px;
                width: 100%;
            }
            .bar-graph-horizontal .emoji {
                float: left;
                width: 50px;
                font-size: 40px;
                margin-right: 10px;
            }
            .bar-graph-horizontal .bar {
                border-radius: 3px;
                height: 55px;
                float: left;
                overflow: hidden;
                position: relative;
                width: 0;
                max-width: 540px;
            }
            .bar-graph-one .bar::after {
                color: #fff;
                content: attr(data-count);
                font-weight: 700;
                position: absolute;
                right: 16px;
                top: 17px;
            }
            .bar-graph-one .bar-4 .bar {
                background-color: #E1DDEC;
            }
            .bar-graph-one .bar-3 .bar {
                background-color: #CBC2DD;
            }
            .bar-graph-one .bar-2 .bar {
                background-color: #A393C0;
            }
            .bar-graph-one .bar-1 .bar {
                background-color: #836EA9;
            }
            .bar-graph-one .bar-0 .bar {
                background-color: #684C96;
            }
            .progress { 
                height: 200px;
                width: 200px;
                margin: 0 auto;
                position: relative;
            }
            .progress-circle {
                transform: rotate(-90deg);
                margin-top: -10px;
            }
            .progress-circle-back {
	fill: none; 
	stroke: #f2f2f2;
	stroke-width:10px;
            }
            .progress-circle-prog {
	fill: none; 
	stroke-width: 10px;  
	stroke-dasharray: 0 999;    
	stroke-dashoffset: 0px;
                transition: stroke-dasharray 0.7s linear 0s;
            }
            .progress-text {
	width: 100%;
	position: absolute;
	top: 60px;
	text-align: center;
	font-size: 2em;
            }
            .green, .grey {
                color: #9FE2BF;
                font-size: 20px;
                position: absolute;
                right: 10px;
            }
            .grey {
                color: #cccccc;
            }

        </style>
    </head>
    <body>
        <%@include file="AdminLayout.jsp"%>
        
        <div class="content">
            <div class="header">
                <h1>Service Rating Report</h1>
            </div>
            
            <div class="body">
                
                <% 
                    ArrayList<Question> questionList = questionDA.getRecord();
    
                    for(Question question : questionList) {
                        int[] count = FeedbackResponse.countRating(question.getQuestionID());
                        double[] percentage = FeedbackResponse.percentageRating(count);
                        double averageRating = FeedbackResponse.averageRating(count);
                %>
                        <div class="question">
                            <h2><%= question.getQuestion() %>
                                <span style="float: right;"><span class=
                                    <% if(question.isActive()) { %>
                                        "green">● Active
                                    <% } else {%>
                                        "grey">● Inactive
                                    <% } %>
                                    </span> 
                                </span>
                            </h2>
                            <div>
                                <div class="summary">
                                    <h2>Average Rating</h2>
                                    <div class="progress">
                                        <svg class="progress-circle" width="200px" height="200px" xmlns="http://www.w3.org/2000/svg">
                                            <circle class="progress-circle-back" cx="100" cy="100" r="90"></circle>
                                            <circle class="progress-circle-prog" cx="100" cy="100" r="90" style="stroke-dasharray: calc(2 * (22/7) * 90); stroke-dashoffset: calc(2 * (22/7) * 90 * (1 - <%= averageRating / 5 %>))"
                                            <% if(averageRating <= 1.25) { %>
                                                        stroke="#EB1C24";
                                            <% } else if(averageRating <= 2.5) { %>
                                                        stroke="#F99F27";
                                            <% } else if(averageRating <= 3.75) { %>
                                                        stroke="#FFF000";
                                            <% } else { %>
                                                        stroke="#BED63A";
                                            <% } %>
                                            ></circle>
                                        </svg>
                                    <div class="progress-text" data-progress="0"><%= String.format("%.2f", averageRating) %></div>
                                    </div>	      
                                    <p><ion-icon name="person-outline"></ion-icon><span style="vertical-align: top"><%= FeedbackResponse.totalRespondent(count) %> total</span></p>
                                </div>
                                <div class="bar-graph bar-graph-horizontal bar-graph-one">

                                    <% for(int i = count.length-1; i >= 0; i--) { %>

                                        <div class="bar-<%= i %>">
                                            <span class="emoji">
                                                <% if(i == 4) { %>
                                                            &#128513
                                                <% } else if(i == 3) { %>
                                                            &#128515
                                                <% } else if(i == 2) { %>
                                                            &#128528
                                                <% } else if(i == 1) { %>
                                                            &#128530
                                                <% } else { %>
                                                            &#128545
                                                <% } %>
                                            </span>
                                            <div class="bar" data-count="<%= count[i] %>" style="width: <%= percentage[i] %>%"></div>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <% } %>
            </div>
        </div>
    </body>
</html>
