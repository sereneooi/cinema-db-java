<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.ArrayList"%>
<jsp:useBean id="questionDA" scope="application" class="model.QuestionDA"></jsp:useBean>

<!DOCTYPE html>
<html class="background">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <%@include file="checkCustomerAccess.jsp"%>
        <style>
          .dropdown-content a:hover, .dropdown-content li:hover{
              cursor: pointer;
          }
          @font-face {
          font-family: 'mahelisa';
          src: url(mahelisa.ttf);
          }
        .form {
            width: 100%;
            min-height: 800px;
            background: linear-gradient(to top, #e3eeff 0%, #e3eeff 1%, #f3e7e9 100%);
        }
        .header {
            line-height: 50px;
            text-transform: uppercase;
            font-family: 'mahelisa';
            font-size: 50px;
            background: linear-gradient(to bottom, rgb(85, 25, 97), rgb(13, 5, 31));
            color:rgb(194, 158, 201);
            width: 100%;
            letter-spacing: 15px;
            text-align: center;
            word-spacing: 15px;
            margin-left: 0px;
        }
        .feedbackTable {
            font-family: "Comic Sans MS", cursive, sans-serif;
            font-size: 20px;
            color: rgb(63, 30, 99);
            margin-top: -40px;
            border-collapse: collapse;
        }     
        .feedbackTable  td {
            vertical-align: middle;
            padding: 10px;
        }        
        .feedbackTable td:nth-of-type(1), .feedbackTable th:nth-of-type(1) {
            border-right: 2px solid white;
        }       
        .feedbackTable td:nth-of-type(1) {
            padding: 0px;
        }     
        .feedbackTable th {
            border-bottom: 2px solid white;
        }      
        .feedbackTable tr {
            border-bottom: 2px solid white;
        }       
        .feedbackTable tr:nth-last-child {
            border: none;
        }
        input[type="submit"]:hover {
            box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
            transform: translateY(1px);
            opacity: 0.8;
        }
        p {
            margin-left: 15px;
        }
        .radio {
            display: none;
        }
        .radio ~ span, .radio1 ~ span {
            font-size: 3rem;
            filter: grayscale(100);
            cursor: pointer;
            transition: 0.3s;
        }
        .radio:checked ~ span, .radio1:checked ~ span {
            filter: grayscale(0);
        }
        input[type="submit"] {
            margin-top: 30px;
            margin-left: 855px;
            padding: 18px 30px;
            color: rgba(255,255,255,0.9);
            background: linear-gradient(-45deg, #ffa63d, #ff3d77, #338aff, #3cf0c5);
            background-size: 600%;
            animation: anime 16s linear infinite;
            box-shadow: 0px 40px 30px -10px rgba(0, 0, 0, .3);
            transition: all .3s ease-in-out;
            font-family: "Comic Sans MS", cursive, sans-serif;
            font-size: 17px;
            display: block;
            border: none;
            border-radius: 5px;
            text-transform: uppercase;
        }
        input[type="submit"]:hover {
            box-shadow: 0px 20px 15px -5px rgba(0,0,0, .5);
            transform: translateY(1px);
            opacity: 0.8;
        }
        @keyframes anime {
          0% {
              background-position: 0% 50%;
          }
          50% {
              background-position: 100% 50%;
          }
          100% {
              background-position: 0% 50%;
          }
        }
        </style>    
    </head>

    <body>
        <%@include file="header.jsp"%>

        <!-- section -->
        <section>
            <form method="post" action="FeedbackFormController">
                <div class="form">
                    <h1 class="header">Feedback Form</h1>
                    <table class="feedbackTable">
                        <tr>
                            <th>Question</th>
                            <th colspan="5">Rating</th>
                        </tr>
                        <% 
                            int j = 0;
                            int counter = 0;
                            ArrayList<Question> questionList = questionDA.getRecord();
                            for(int i = 0; i < questionList.size(); i++) {
                                Question question = questionList.get(i);
                                if(question.isActive()) {
                                    counter++;
                        %>
                                    <tr>
                                        <td style="width:200%"><p><%= counter %>. <%= question.getQuestion() %></p></td>
                                        <td>
                                            <label for="<%= (j+=1) %>">
                                                <input class="radio" type="radio" name="rating[<%= i %>]" id="<%= j %>" value="5" required />
                                                <span>&#128513</span>
                                            </label>
                                        </td>
                                        <td>
                                            <label for="<%= (j+=1) %>">
                                                <input class="radio" type="radio" name="rating[<%= i %>]" id="<%= j %>" value="4" />
                                                <span>&#128515</span>
                                            </label>
                                        </td>
                                        <td>
                                            <label for="<%= (j+=1) %>">
                                                <input class="radio" type="radio" name="rating[<%= i %>]" id="<%= j %>" value="3" />
                                                <span>&#128528</span>
                                            </label>
                                        </td>
                                        <td>
                                            <label for="<%= (j+=1) %>">
                                                <input class="radio" type="radio" name="rating[<%= i %>]" id="<%= j %>" value="2" />
                                                <span>&#128530</span>
                                            </label>
                                        </td>
                                        <td>
                                            <label for="<%= (j+=1) %>">
                                                <input class="radio" type="radio" name="rating[<%= i %>]" id="<%= j %>" value="1" />
                                                <span>&#128545</span>
                                            </label>
                                        </td>
                                    </tr>
                        <% } 
                            } %>
                    </table>
                    <input type="submit" value="Submit" />
                </div>
            </form>
        </section>

        <!-- footer -->
        <footer style="margin-top: 20px">
            <address>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</address>
        </footer>

    </body>
</html>
