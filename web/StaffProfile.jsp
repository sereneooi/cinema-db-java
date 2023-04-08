<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <style>
            .content {
                margin-left: 300px;
                min-height: calc(100vh - 60px);
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
                height: 35px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
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
            
            .img-account-profile {
                height: 10rem;
            }
            
            .rounded-circle {
                border-radius: 50% !important;
            }
            
            .card {
                box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
            }
            
            .card .card-header {
                font-weight: 500;
            }
            
            .card-header:first-child {
                border-radius: 0.35rem 0.35rem 0 0;
            }
            
            .card-header {
                padding: 1rem 1.35rem;
                margin-bottom: 0;
                background-color: rgba(33, 40, 50, 0.03);
                border-bottom: 1px solid rgba(33, 40, 50, 0.125);
            }
            
            .form-control, .dataTable-input {
                display: block;
                width: 100%;
                padding: 0.875rem 1.125rem;
                font-size: 0.875rem;
                font-weight: 400;
                line-height: 1;
                color: #69707a;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid #c5ccd6;
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                border-radius: 0.35rem;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }
            
            .nav-borders .nav-link.active {
                color: #0061f2;
                border-bottom-color: #0061f2;
            }
            
            .nav-borders .nav-link {
                color: #69707a;
                border-bottom-width: 0.125rem;
                border-bottom-style: solid;
                border-bottom-color: transparent;
                padding-top: 0.5rem;
                padding-bottom: 0.5rem;
                padding-left: 0;
                padding-right: 0;
                margin-left: 1rem;
                margin-right: 1rem;
            }
            
            div.side{
                display: flex;
                justify-content: space-between;
            }
            
            div.form-floating{
                width: 48%;
            }
            
            div.long-input{
                width: 100%;
            }
            
            nav > a.active{
                transition: border-bottom 1s linear;
            }
            
            select[readonly] {
                background: #eee; 
                pointer-events: none;
                touch-action: none;
            }
        </style>
    </head>
    <body>
        <script type="text/javascript">
            var checkPassword = function() {
                if (document.getElementById('npsw').value == document.getElementById('confirmNpsw').value) {
                    document.getElementById("confirmNpsw").className = "form-control is-valid";
                    document.getElementById("message").innerHTML = "";
                    document.getElementById('changePassSubmit').disabled = false;
                    document.getElementById('changePassSubmit').style.cursor = "pointer";
                }else{
                    document.getElementById("confirmNpsw").className = "form-control is-invalid";
                    document.getElementById('message').style.color = 'red';
                    document.getElementById("message").innerHTML = "Password entered not matching.";
                    document.getElementById('changePassSubmit').disabled = true;
                    document.getElementById('changePassSubmit').style.cursor = "not-allowed";
                }
            }
        </script>
        <%@include file="checkAccess.jsp"%>
        <%
            Account tempAcc = (Account) session.getAttribute("tempUser");
            Account display;
            if(tempAcc != null){
                display = tempAcc;
            }else{
                display = currentUser;
            }
        %>
        <div class="content" align="center"><br/>
            <div class="container-xl px-4 mt-4">
                <nav class="nav nav-borders">
                    <a class="nav-link active" href="#" onclick="profile()" id="profileNav">Profile</a>
                    <a class="nav-link" href="#" onclick="passwd()" id="passwordNav">Password</a>
                </nav>
                <hr class="mt-0 mb-4">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card mb-4 mb-xl-0">
                            <div class="card-header">Profile</div>
                            <div class="card-body text-center">
                                <img class="img-account-profile rounded-circle mb-2" src="youraccount.png" alt="Profile"> 
                                <div class="small font-italic text-muted mb-4">${currentUser.emailAddress}</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8" id="accDetails" style="display: block;">
                        <div class="card mb-4">
                            <div class="card-header">Account Details</div>
                            <div class="card-body">
                                <form method="POST" action="UpdateStaffProfile">
                                    <div><span style="color: red">${noChangesMsg}</span></div><br/>
                                    <div class="form-floating long-input">
                                        <input class="form-control" type="email" maxlength="30" placeholder="abc@gmail.com" name="newemail" id="newemail" style="cursor: not-allowed;" <% if(display != null){ %> value="<%=  display.getEmailAddress() %>" <% } %> readonly/>
                                        <label for="newemail">Email Address</label>
                                    </div><br/>
                                    <div class="side">
                                        <div class="form-floating">
                                            <input class="form-control" type="text" maxlength="50" placeholder="Lilian" name="newname" id="newname" <% if(display != null){ %> value="<%= display.getName() %>" <% } %> required autofocus/>
                                            <label for="newname">Name</label>
                                        </div>
                                        <div class="form-floating">
                                            <input class="form-control ${validIc}" type="text" maxlength="14" placeholder="000101-07-0123" name="newic" id="newic" <% if(display != null){ %> value="<%= display.getIc() %>" <% } %> required/>
                                            <div><span style="color: red">${invalidIcMsg}</span></div>
                                            <label for="newic">IC Number</label>
                                        </div>
                                    </div><br/>
                                    <div class="side">
                                        <div class="form-floating">
                                            <select class="form-select" id="gender" aria-label="Gender" name="gender">
                                                <option value="Female" <% if(display != null){ if(display.getGender() == 'F'){ %> selected <% }} %>>Female</option>
                                                <option value="Male" <% if(display != null){ if(display.getGender() == 'M'){ %> selected <% }} %>>Male</option>
                                            </select>
                                            <label for="gender">Gender</label>
                                        </div>
                                        <div class="form-floating">
                                            <input class="form-control" type="date" name="birthday" id="birthday" <% if(display != null){ %> value="<%= display.getBirthDate() %>" <% } %> required/>
                                            <label for="birthday">Date of Birth</label>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="form-floating long-input">
                                        <input class="form-control" type="text" placeholder="1, Taman Sui, P.P" name="address" id="address" <% if(display != null){ %> value="<%= display.getAddress() %>" <% } %> required/>
                                        <label for="address">Address</label>
                                    </div>
                                    <br/>
                                    <div class="side">
                                        <div class="form-floating">
                                            <input class="form-control" type="text" maxlength="14" placeholder="012-3456789" name="telNo" <% if(display != null){ %> value="<%= display.getContactNo() %>" <% } %> id="telNo" pattern="[0-9]{3}-[0-9]{7,8}" required autofocus/>
                                            <label for="telNo">Contact No</label>
                                        </div>
                                        <div class="form-floating">
                                            <select class="form-select" id="role" aria-label="Role" name="role" <% if(!currentUser.getRole().getRoleId().equals("R0001")){ %> readonly tabindex="-1" aria-disabled="true" <% } %>>
                                            <%
                                                List<Role> roleLists = (List<Role>) session.getAttribute("allRoleForStaff");
                                                Role roleList = null;
                                                if(roleLists != null){
                                                    for(int i = 0; i < roleLists.size(); i++){
                                                        roleList = roleLists.get(i);
                                            %>
                                                <option value="<%= roleList.getRoleId() %>" <% if(currentUser != null){ if(currentUser.getRole().getRoleId().equals(roleList.getRoleId())){ %> selected <% } } %>><%= roleList.getRole() %></option>
                                                <% }} %>
                                            </select>
                                            <label for="role">Role</label>
                                        </div>
                                    </div><br/>
                                    <input class="button" type="submit" value="Save Changes" name="save" style="Height:40px;"/>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8" id="changePassword" style="display: none;">
                        <div class="card mb-4">
                            <div class="card-header">Change Password</div>
                            <div class="card-body">
                                <form method="post" action="UpdatePassword">
                                    <div><span style="color:red">${noChangePassMsg}</span></div><br/>
                                    <div class="form-floating long-input">
                                        <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="npsw" name="npsw" onkeyup="checkPassword();" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required autofocus/>
                                        <label for="npsw">Password</label>
                                    </div>
                                    <br>
                                    <div class="form-floating long-input">
                                        <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="confirmNpsw" onkeyup="checkPassword();" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                                        <label for="newPass">Confirm Password</label>
                                    </div>
                                    <div class="form-floating" style="height: 15px;">
                                        <span id="message" style="font-size: 15px;"></span>
                                    </div>
                                    <br>
                                    <input class="button" type="submit" value="Save Changes" name="save" id="changePassSubmit" style="Height:40px; cursor:not-allowed" disabled/>
                                    <br>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>        
        <script type = "text/javascript">
        function profile() {
            document.getElementById("accDetails").style.display = "block";
            document.getElementById("profileNav").className = "nav-link active";
            document.getElementById("changePassword").style.display = "none";
            document.getElementById("passwordNav").className = "nav-link";
        }
        
        function passwd() {
            document.getElementById("accDetails").style.display = "none";
            document.getElementById("profileNav").className = "nav-link";
            document.getElementById("changePassword").style.display = "block";
            document.getElementById("passwordNav").className = "nav-link active";
        }
        
    <%  if(session.getAttribute("errorForChangePass") != null){  
            session.removeAttribute("errorForChangePass"); %>
            passwd();
    <%  } %>
        </script>
    </body>
</html>
