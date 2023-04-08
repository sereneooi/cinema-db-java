<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <style>
    .content {
            margin-left: 300px;
            min-height: calc(100vh - 60px);
        }
    .mainContainer{
        width: 90%;
        text-align: left;
        border-collapse: separate !important;
        border-spacing: 0;
        box-shadow: 5px 5px 40px #000;
        border-radius: 15px;
    }

    .mainContainer th{
        text-align: center;
        background-color: #504064;
        color: whitesmoke;
        height: 50px;
        font-size: 18px;
    }

    .mainContainer td{
        background-color: whitesmoke;
        padding-left: 10px;
        line-height: 20px;
        font-size: 14px;
        padding-top: 10px;
        padding-bottom: 10px;
    }
    
    tr#titleBar td{
        font-weight: bold;
        font-size: 14px;
        background-color: lightgray;
    }

    table.mainContainer tr:first-child th:first-child {
        border-top-left-radius: 10px;
    }

    table.mainContainer tr:first-child th:last-child {
        border-top-right-radius: 10px;
    }

    table.mainContainer tr:last-child td:first-child {
        border-bottom-left-radius: 10px;
    }

    table.mainContainer tr:last-child td:last-child {
        border-bottom-right-radius: 10px;
    }

    div#modal_header{
        display: flex;
        justify-content: space-between;
    }

    .button{
        cursor: pointer;
        background-color:#7058a1;
        color: white;
        border: none;
        font-size: large;
        outline: none;
        transition: transform .2s;
        border-radius: 5px;
        width: 100%;
    }

    .button{
        cursor: pointer;
        background-color:#7058a1;
        color: white;
        border: none;
        font-size: large;
        outline: none;
        transition: transform .2s;
        border-radius: 5px;
        width: 100%;
    }

    .button:hover{
        opacity: 0.7;
        -ms-transform: scale(1.05);
        -webkit-transform: scale(1.05); 
        transform: scale(1.05); 
    }

    .button:active {
        background-color: #7058a1;
        transform: translateY(2px);
    }
    
    #role{
        width: 100%;
        height: 30px;
    }
    
    i {
        cursor: pointer;
        margin-left: -40px;
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
    <body>
        <%@include file="AdminLayout.jsp"%>
<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
if(currentUser == null){ 
    %>
    <script type="text/javascript"> 
        alert('Please log in your account first.');
        location='login.jsp';
    </script>
    <%
}else{
    if(!currentUser.getRole().getRoleId().equals("R0001")){
        %>
        <script type="text/javascript"> 
            alert('<%= currentUser.getName() %>, You are not allow to access this page.');
            location='cinema.jsp';
        </script>
        <%
    }
}
%>
        <div class="content" align="center">
            <div class="alert alert-danger alert-dismissible fade ${show}" role="alert">
                <span class="error"><strong>${msg}</strong></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div><br/><br/><br/>
            <table class="mainContainer" border="0">
                <thead>
                    <tr><th colspan="4">Register New Account</th></tr>
                </thead>
                <tbody>
                    <form action="Register" method="POST">
                        <tr><td colspan="4"></td></tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label for="newemail">EMAIL ADDRESS</label></td>
                            <td>
                                <input type="email" maxlength="50" placeholder="abc@gmail.com" class="form-control" value="${email}"
                                size="60" style="height:30px" id="newemail" name="newemail" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td width="15%"></td>
                            <td><label for="newname">NAME</label></td>
                            <td><input type="text" maxlength="50" placeholder="Lilian" class="form-control" value="${name}"
                                size="60" style="height:30px" id="newname" name="newname" required autofocus/>
                            </td>
                            <td width="15%"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><label for="npsw">PASSWORD</label></td>
                            <td>
                                <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="npsw" name="npsw" onkeyup="checkPassword();" value="${npsw}"
                                size="60" style="height:30px" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                            </td>
                            <td><i class="far fa-eye" id="toggleNPassword" onclick="npasswordVisibility();"></i></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="retypepsw">RETYPE PASSWORD</label></td>
                            <td>
                                <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="retypepsw" onkeyup="checkPassword();" 
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
                            <td><input type="text" maxlength="50" placeholder="000101-07-0123" class="form-control" name="newic" 
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
                            <td><input type="date" id="birthday" name="birthday" style="height:30px" class="form-control" value="${birthDate}" required/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="address">ADDRESS</label></td>
                            <td><input type="text" id="address" name="address" value="${address}" style="height:30px" size="60" placeholder="1, Taman Sui, P.P" class="form-control" required/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="telNo">TEL NO</label></td>
                            <td>
                                <input type="tel" id="telNo" name="telNo" value="${phoneNo}" style="height:30px" size="60" placeholder="012-3456789" class="form-control"
                                pattern="[0-9]{3}-[0-9]{7,8}" required/>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="width: 30%;"><label for="role">ROLE</label></td>
                            <td>
                                <select id="role" name="role">
                                    <%
                                        String selectedRole = (String) session.getAttribute("selectedRole");
                                        List<Role> roleLists = (List<Role>) session.getAttribute("allRoleForStaff");
                                        Role roleList = null;
                                        if(roleLists != null){
                                            for(int i = 0; i < roleLists.size(); i++){
                                                roleList = roleLists.get(i);
                                    %>
                                    <option value="<%= roleList.getRoleId() %>" <% if(roleList.getRoleId().equals(selectedRole)){ %> selected <% } %>><%= roleList.getRole() %></option>
                                    <% }} %>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right">
                                <table border="0" style="width: 30%;">
                                    <tr>
                                        <td align="right"><input class="button" type="submit" value="Add" name="submit" style="Height:32px; width: 100px;"/></td>
                                    </tr>
                                </table>
                            </td>
                            <td></td>
                        </tr>
                    </form>
                </tbody>
            </table>
            <div class="toast position-fixed bottom-0 end-0  bg-success p-2 text-dark bg-opacity-75 border-0 ${showSuccess}" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <b>${msg}</b>
                    </div>
                    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
             </div>
        </div>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
