<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Account newRegisteredAcc = (Account) session.getAttribute("newRegisteredAcc"); // check whether just registered for a new account
Account currentUser = (Account) session.getAttribute("currentUser");  // use to pass across the website later

Cookie[] cookie = request.getCookies(); // check whether got ticked the remember me

String userEmail = "";
String userPassword = "";

if(newRegisteredAcc != null){
    userEmail = newRegisteredAcc.getEmailAddress();
    userPassword = newRegisteredAcc.getPassword();
  
}else if(cookie != null){
    for(Cookie c: cookie){
        if(c.getName().equals("LoginEmail")){
            userEmail = c.getValue();

        }else if(c.getName().equals("LoginPassword")){
            userPassword = c.getValue();
        }
    }
}
    
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
if(currentUser != null){ // if the user does not log out the existing account
    %>
    <script type="text/javascript"> 
        alert('<%=currentUser.getName() %>, Please log out your account first.');
        location='cinema.jsp';
    </script>
    <%
} 
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <script type="text/javascript">
        function passwordVisibility() {
            var pswtype = document.getElementById("psd");
            var icon = document.getElementById('togglePassword');
            if (pswtype.type === "password") {
                pswtype.type = "text";
                icon.removeAttribute("class");
                icon.setAttribute("class","fa fa-eye-slash");
            } else {
                pswtype.type = "password";
                icon.removeAttribute("class");
                icon.setAttribute("class","far fa-eye");
            }
        }
    </script>
    <style>
    #title{
        text-align: center; 
    }

    table#content{
        background-color: rgb(0, 0, 0, 0.65);
        margin: auto;
        line-height: 40px;
        color: white;
        height: 500px;
        box-shadow: 8px 8px 20px #000;
        border-radius: 15px;
    }
    
    a.register{
        text-decoration: none;
        color: whitesmoke;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    a.register:hover{
        color: whitesmoke;
        text-decoration: underline;
    }
    
    i {
        margin-left: -40%;
    }
    </style>
    <body>
        <table border="0" id="container">
            <tr>
                <div class="alert alert-success alert-dismissible fade ${showSuccess}" role="alert">
                    <span><strong>${msg}</strong></span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </tr>    
            <tr>
                <td>
                    <p align="center"> Welcome to CC Cinema! </p>
                    <table class="modal-content animate" border="0" style="width: 60%;" id="content">
                        <tr>
                            <td style="height: 10px;" colspan="3"></td> 
                            <td align="right">
                                <button onclick="location.href='cinema.jsp'" class="close" title="Close Modal">&times;</button>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="4" id="title">LOGIN</th>
                        </tr>
                        <tr style="height:65px;">
                            <td colspan="4"></td>
                        </tr>
                        <form name="login" id="login" method="POST" action="Login">
                        <tr>
                            <td width="15%"></td>
                            <td><label for="email">EMAIL ADDRESS</label></td>
                            <td width="50%"><input type="email" maxlength="50" placeholder="abc@gmail.com" name="email"
                                size="55" style="height:30px" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" id="email" 
                                value="<%= userEmail %>" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td style="height: 20px;" colspan="4"></td>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <div class="container">
                                <td><label for="psw">PASSWORD</label></td>
                                <td width="50%"><input type="password" minlength="8" placeholder="Abcd1234" name="psd" value="<%= userPassword %>"
                                    size="55" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" id="psd" required/>
                                </td>
                                <td width="15%"><i class="far fa-eye" id="togglePassword" onclick="passwordVisibility();"></i></td>
                            </div>
                        </tr>
                        <tr>
                            <td style="height: 60px;" colspan="4"></td>
                        </tr>
                        <tr style="line-height: 15px;">
                            <td width="15%"></td>
                            <td width="15%"><a href="forgotPassword.jsp" class="register">Forgot Password</a></td>
                            <td align="right" width="50%"><a href="newuser.jsp" class="register">New User?</a></td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td style="height: 10px;" colspan="4"></td>
                        </tr>
                        <tr style="line-height: 0px;">
                            <td colspan="4" align="center">
                                <input class="button" type="submit" value="SIGN IN" name="submit" id="submit"
                                style="width:70%;Height:30px;font-weight: bold;font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"/>
                            </td>
                        </tr>
                        <tr style="vertical-align: top;">
                            <td width="15%"></td>
                            <td colspan="3" align="left" style="font-size: 13px;">
                                <input type="checkbox" name="remember" id="remember" style="cursor: pointer;" checked/>
                                <label for="remember" style="cursor: pointer;">Remember me</label>
                            </td>
                        </tr>
                        </form>
                        <tr>
                            <td style="height: 50px" colspan="4"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
