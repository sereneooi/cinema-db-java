<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%--<%@page import="model.Account"%>
<%
Account currentUser = (Account) session.getAttribute("currentUser"); 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
if(currentUser != null){ 
    %>
    <script type="text/javascript"> 
        alert('<%=currentUser.getName() %>, Please log out your account first.');
        location='cinema.jsp';
    </script>
    <%
}
%>--%>
<!DOCTYPE html>
<html>
<head>
    <title>CC Cinema</title>
    <link href="logo.png" rel="icon" type="image/png"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
    #title{
        text-align: center; 
    }

    .button{
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        width: 100px;
    }

    .button:active {
        transform: translateY(4px);
    }
    
    .optBtn{
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        width: 100px;
        background-color: #7058a1;
        border-radius: 5px;
        outline: none;
    }
    
    .optBtn:hover{
        opacity: 0.7;
    }
    
    td{
        font-weight: normal;
    }
    
    td.firstRow{
        height:30px;
    }

    @-webkit-keyframes animatezoom {
        from {-webkit-transform: scale(0)} 
        to {-webkit-transform: scale(1)}
    }

    @keyframes animatezoom {
        from {transform: scale(0)} 
        to {transform: scale(1)}
    }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="login.css">
</head>
<script type="text/javascript">
    var checkPassword = function() {
        if (document.getElementById('npsw').value == document.getElementById('confirmNpsw').value) {
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
    
    function passwordVisibility() {
        var pswtype = document.getElementById("npsw");
        var icon = document.getElementById('toggleNewPassword');
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
    
    function confirmPasswordVisibility() {
        var pswtype = document.getElementById("confirmNpsw");
        var icon = document.getElementById("toggleConfirmPassword");
        
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
<body>
    <table id="container">
        <tr>
            <div class="alert ${typeOfForgotPassColor} alert-dismissible fade ${showForgotPass}" role="alert">
                <span><strong>${ForgotPassErrorMsg} ${noChangePassMsg}</strong></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </tr>
        <tr>
            <td>
                <table class="modal-content animate" style="width: 60%; height: 550px;" border="0" id="content">
                    <tr style="height: 10px;">
                        <td colspan="3"></td> 
                        <td align="right">
                            <button onclick="location.href='login.jsp'" class="close" title="Close Modal" ${closeDisable}>&times;</button>
                        </td>
                    </tr>
                    <tr style="height: 15px;">
                        <th colspan="4" id="title">RESET PASSWORD</th>
                    </tr>
                    <tr style="height: 50px;">
                        <td colspan="4"></td>
                    </tr>
                    <form action="ForgotPassword" method="POST">
                    <tr>
                        <td class="firstRow" style="width: 15%;"></td>
                        <td class="firstRow" style="width: 25%;"><label for="emailAdd">EMAIL ADDRESS</label></td>
                        <td class="firstRow" style="line-height:30px;">
                            <input type="email" maxlength="50" placeholder="abc@gmail.com" id="emailAdd" name="emailAdd" value="${forgotEmail}" 
                            size="60" style="height:30px;" required autofocus ${emailReadOnly}/>
                        </td>
                        <td class="firstRow" style="width: 15%; text-align: center;"><input id="optInput" class="optBtn" type="submit" value="Get OTP" name="submit" ${OtpBtn}/></td>
                    </tr>
                    </form>
                    <tr style="height: 25px;">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><label for="otp">OTP</label></td>
                        <form action="ValidateOtp" method="GET">
                        <td>
                            <input type="text" id="otp" name="otp" size="60" style="height:30px" value="${otpValue}" required/>
                        </td>
                        <td class="firstRow" style="width: 15%; text-align: center;"><input class="optBtn" type="submit" value="Submit" name="submit" ${SubmitOtpBtn}/></td></td>
                        </form>
                    </tr>
                    <tr style="height: 25px;">
                        <td colspan="4"></td>
                    </tr>
                    <form action="UpdatePassword" method="GET">
                    <tr>
                        <td></td>
                        <td><label for="npsw">NEW PASSWORD</label></td>
                        <td>
                            <input type="password" minlength="8" placeholder="Abcd1234" id="npsw" onkeyup="checkPassword();" name="npsw"
                            size="60" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                        </td>
                        <td><i class="far fa-eye" id="toggleNewPassword" onclick="passwordVisibility();"></i></td>
                    </tr>
                    <tr>
                        <td style="height: 20px;" colspan="4"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="width: 30%;"><label for="confirmNpsw">CONFIRM PASSWORD</label></td>
                        <td>
                            <input type="password" minlength="8" placeholder="Abcd1234" id="confirmNpsw" onkeyup="checkPassword();"
                            size="60" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                        </td>
                        <td><i class="far fa-eye" id="toggleConfirmPassword" onclick="confirmPasswordVisibility();"></i></td>
                    </tr>
                    <tr style="line-height: 15px;">
                        <td colspan="2"></td>
                        <td colspan="2">
                            <span id="message" style="font-size: 15px;"></span>
                        </td>
                    </tr>
                    <tr style="height: 25px;"></tr>
                    <tr>
                        <td colspan="3" align="right">
                            <table border="0" style="width: 30%;">
                                <tr>
                                    <td colspan="2" align="right"><input id="changePassSubmit" class="button" type="submit" value="Save" name="save" style="cursor: not-allowed;" disabled/></td>
                                </tr>
                            </table>
                        </td>
                        <td></td>
                    </tr>
                    </form>
                </table>
            </td>
        </tr>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script type="text/javascript">
        if(document.getElementById("emailAdd").value === null || document.getElementById("emailAdd").value === "" || document.getElementById("emailAdd").value === undefined
                || document.getElementById("otp").value === null || document.getElementById("otp").value === "" || document.getElementById("otp").value === undefined){
            document.getElementById('npsw').disabled = true;
            document.getElementById('npsw').style.cursor = "not-allowed";
            document.getElementById('confirmNpsw').disabled = true;
            document.getElementById('confirmNpsw').style.cursor = "not-allowed";
        }
    </script>
</body>
</html>