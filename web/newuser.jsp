<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%
Account currentUser = (Account) session.getAttribute("currentUser");  // use to pass across the website later
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
<html>
<head>
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <link rel="stylesheet" href="login.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
*{
    font-size: small;
}

.button{
    width: 100px;
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

#title{
    text-align: center; 
}

table#content{
    background-color: rgb(0, 0, 0, 0.65);
    margin: auto;
    line-height: 40px;
    color: white;
    height: 600px;
    box-shadow: 8px 8px 20px #000;
    border-radius: 15px;
}
</style>
<script type="text/javascript">
    var checkPassword = function() {
    if (document.getElementById('npsw').value == document.getElementById('retypepsw').value) {
      document.getElementById('message').style.color = 'green';
      document.getElementById('message').innerHTML = '&#10004; matching';
      document.getElementById('changePassSubmit').disabled = false;
      document.getElementById('changePassSubmit').style.cursor = "pointer";
    }else{
      document.getElementById('message').style.color = 'red';
      document.getElementById('message').innerHTML = '&#10006; not matching';
      document.getElementById('changePassSubmit').disabled = true;
      document.getElementById('changePassSubmit').style.cursor = "not-allowed";
    }
}

function npasswordVisibility() {
    var pswtype = document.getElementById("npsw");
    var icon = document.getElementById('toggleNPassword');
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

function repasswordVisibility() {
    var pswtype = document.getElementById("retypepsw");
    var icon = document.getElementById('toggleREPassword');
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
</head>
<body>
    <table id="container">
        <tr>
            <div class="alert alert-danger alert-dismissible fade ${show}" role="alert">
                <span class="error"><strong>${msg}</strong></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </tr>
        <tr>
            <td>
                <form name="register" method="POST" action="Register"/>
                    <table style="width: 65%;" border="0" id="content" class="modal-content animate">
                        <tr>
                            <td colspan="3"></td> 
                            <td align="right">
                                <button onclick="location.href='login.jsp'" class="close" title="Close Modal">&times;</button>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="4" id="title">NEW USER</th>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label for="newemail">EMAIL ADDRESS</label></td>
                            <td><input type="email" maxlength="50" placeholder="abc@gmail.com" value="${email}"
                                size="60" style="height:30px" id="newemail" name="newemail" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label for="newname">NAME</label></td>
                            <td><input type="text" maxlength="50" placeholder="Lilian" value="${name}"
                                size="60" style="height:30px" id="newname" name="newname" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><label for="npsw">PASSWORD</label></td>
                            <td>
                                <input type="password" placeholder="Abcd1234" id="npsw" name="npsw" onkeyup="checkPassword();" value="${npsw}"
                                size="60" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                            </td>
                            <td><i class="far fa-eye" id="toggleNPassword" onclick="npasswordVisibility();"></i></td>
                        </tr>
                        <tr>
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="retypepsw">RETYPE PASSWORD</label></td>
                            <td>
                                <input type="password" placeholder="Abcd1234" id="retypepsw" onkeyup="checkPassword();" name="retypePass"
                                size="60" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                            </td>
                            <td><i class="far fa-eye" id="toggleREPassword" onclick="repasswordVisibility();"></i></td>
                        </tr>
                        <tr>
                            <td style="height: 10px; line-height: 10px;" colspan="2"></td>
                            <td style="height: 10px; line-height: 10px;" colspan="2">
                                <span id="message" style="font-size: 15px;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label for="newic">IC</label></td>
                            <td><input type="text" maxlength="50" placeholder="000101-07-0123" name="newic" 
                                size="60" style="height:30px" id="newic" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label>GENDER</label></td>
                            <td>
                                <input type="radio" id="female" name="gender" value="Female" style="cursor: pointer;" ${female}/>
                                <label for="female" style="cursor: pointer;">Female</label>
                                <input type="radio" id="male" name="gender" value="Male" style="cursor: pointer;" ${male}/>
                                <label for="male" style="cursor: pointer;">Male</label>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="birthday">DATE OF BIRTH</label></td>
                            <td><input type="date" id="birthday" name="birthday" style="height:30px" value="${birthDate}" required/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="address">ADDRESS</label></td>
                            <td><input type="text" id="address" name="address" value="${address}" style="height:30px" size="60" placeholder="1, Taman Sui, P.P" required/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="telNo">TEL NO</label></td>
                            <td>
                                <input type="tel" id="telNo" name="telNo" value="${phoneNo}" style="height:30px" size="60" placeholder="012-3456789" 
                                pattern="[0-9]{3}-[0-9]{7,8}" required/>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="hidden" value="R0003" name="role" id="role" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colspan="2" style="line-height: 20px;">
                                <input type="checkbox" id="tNc" name="tNc" style="cursor: pointer;" required/>
                                <label for="tNc" style="cursor: pointer;">
                                    I certify that I am 18 and above and I have read and agreed to the Terms & Conditions and Privacy Policy.
                                </label>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 30px;"></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right">
                                <table border="0" style="width: 30%;">
                                    <tr>
                                        <td align="right"><input class="button" value="Back" type="button" name="back" style="Height:32px;" onclick="location.href='login.jsp'"/></td>
                                        <td align="right"><input class="button" type="submit" value="Submit" name="submit" id="changePassSubmit" style="Height:32px; cursor:not-allowed" disabled/></td>
                                    </tr>
                                </table>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>