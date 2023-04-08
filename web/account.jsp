<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<!DOCTYPE html>
<html>
<head>
    <title>CC Cinema</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="logo.png" rel="icon" type="image/png"/>
    <link href="style1.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <%@include file="checkCustomerAccess.jsp"%>
    <%@include file="header.jsp"%>
</head>
<style>
html{
    background-image: url(background.png);
}

body {
    background-color: rgb(51, 51, 51);
    margin: 0 auto;
    width: 100%;
    max-width: 1020px;
    min-width: 800px;
    z-index: -1;
}

a.edit{
    text-decoration: none;
    color: rgb(70, 134, 255);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

a.edit:hover{
    color: rgb(70, 134, 255);
    text-decoration: underline;
}

div#modal_header{
    display: flex;
    justify-content: space-between;
}

div.checking{
    color: black;
    background-color: #ece7e7ea;
    border-radius: 10px;
    width: 150px;
    height: 150px;
    text-align: center;
    margin: auto;
    margin-top: 50px;
    margin-bottom: 50px;
    box-shadow: 8px 8px 20px #000;
    cursor: pointer;
    transition: transform .2s;
}

div.checking:hover{
    transform: scale(1.05); 
}

div.checking:active{
    transform: translateY(2px);
}

div#accountSetting{
    background-color: rgba(251, 251, 251, 0.931);
    box-shadow: 8px 8px 20px #000;
    border-radius: 15px;
    width: 90%;
    margin: auto;
    margin-top: 50px;
    margin-bottom: 50px;
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

h1{
    color: rgba(251, 251, 251, 0.931);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h2.title{
    margin-bottom: 30px;
    margin-top: 10px;
}

h6.accInfo{
    font-weight: normal;
    display: block;
    width: 250px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    margin: 0; 
}
</style>
<body>
    <!--body for profile-->
    <h1>
        HI, 
        <span id="userName">
            <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
            Account accName = (Account) session.getAttribute("currentUser"); 
            Account tempAcc = (Account) session.getAttribute("tempUser"); // contain the temporary data of the user which edit in the half way
            Account display;
            if(tempAcc != null){
                display = tempAcc;
            }else{
                display = currentUser;
            }
            if(accName == null){ %>Your Account<% }else{ %><%= accName.getName() %><% } %>.
        </span>
    </h1>
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
    <table>
        <tr>
            <td> 
                <div id="order" class="checking" onclick="location.href='fnbOrderDeliveryHistory.jsp';">
                    Orders<br/><br/>
                    <!--<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">1</span>-->
                    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
                        <path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                      </svg>
                </div>
            </td>
            <td>
                <div id="ticket" class="checking" onclick="location.href='OrderHistory.jsp?page=tickets';">
                    Tickets<br/><br/>
                    <svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-ticket-perforated-fill" viewBox="0 0 16 16">
                        <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3h13A1.5 1.5 0 0 1 16 4.5V6a.5.5 0 0 1-.5.5 1.5 1.5 0 0 0 0 3 .5.5 0 0 1 .5.5v1.5a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 11.5V10a.5.5 0 0 1 .5-.5 1.5 1.5 0 1 0 0-3A.5.5 0 0 1 0 6V4.5Zm4-1v1h1v-1H4Zm1 3v-1H4v1h1Zm7 0v-1h-1v1h1Zm-1-2h1v-1h-1v1Zm-6 3H4v1h1v-1Zm7 1v-1h-1v1h1Zm-7 1H4v1h1v-1Zm7 1v-1h-1v1h1Zm-8 1v1h1v-1H4Zm7 1h1v-1h-1v1Z"/>
                    </svg>
                </div>
            </td>
            <td>
                <div id="rating" class="checking" onclick="location.href='favouriteList.jsp';" style="position: relative;" ${positionNeedRelative}>
                    Favourite<br/><br/>
                    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                    </svg>
            </td>
            
        </tr>
    </table>
    <div id="accountSetting">
        <table border="0" style="width: 80%;" align="center">
            <tr>
                <td colspan="3"><h2 class="title">Account Settings</h2></td>
            </tr>
            <tr>
                <td rowspan="6" style="vertical-align: top;"><h4>Profile</h4></td>
                <td><h5>Contact Information</h5></td>
                <td><h5>Change Password</h5></td>
            </tr>
            <tr>
                <td><h6 class="accInfo"><% if(currentUser != null){ %><%= currentUser.getName() %><% } %></h6></td>
                <td rowspan="5" style="vertical-align: top">
                    <a href="#changePsw" class="edit" data-bs-toggle="modal" data-bs-target="#changePsw">Edit</a>
                    <div class="modal fade" id="changePsw" tabindex="-1" aria-labelledby="changePsdLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                                <div class="modal-body">
                                    <div id="modal_header">
                                        <h3>Edit your password.</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                                    </div>
                                    <br>
                                    <form method="post" action="UpdatePassword">
                                        <div><span style="color:red">${noChangePassMsg}</span></div>
                                        <div class="form-floating">
                                            <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="npsw" name="npsw" onkeyup="checkPassword();" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required autofocus/>
                                            <label for="npsw">Password</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control" type="password" minlength="8" placeholder="Abcd1234" id="confirmNpsw" onkeyup="checkPassword();" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                                            <label for="newPass">Confirm Password</label>
                                        </div>
                                        <div class="form-floating" style="height: 15px;">
                                            <span id="message" style="font-size: 15px;"></span>
                                        </div>
                                        <br>
                                        <input class="button" type="submit" value="Save" name="save" id="changePassSubmit" style="Height:40px; cursor:not-allowed" disabled/>
                                        <br>
                                        <div align="center" style="padding-top: 10px;">
                                            <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><h6 class="accInfo"><% if(currentUser != null){ %><%= currentUser.getIc() %><% } %></h6></td>
            </tr>
            <tr>
                <td><h6 class="accInfo"><% if(currentUser != null){ %><%= currentUser.getAddress()%><% } %></h6></td>
            </tr>
            <tr>
                <td><h6 class="accInfo"><% if(currentUser != null){ %><%= currentUser.getContactNo() %><% } %></h6></td>
            </tr>
            <tr>
                <td>
                    <a href="#info" class="edit" data-bs-toggle="modal" data-bs-target="#info">Edit</a>
                    <div class="modal fade" id="info" tabindex="-1" aria-labelledby="infoLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                                <div class="modal-body">
                                    <div id="modal_header">
                                        <h3>Edit your personal info.</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                                    </div>
                                    <br>
                                    <form method="POST" action="EditAccount">
                                        <div><span style="color: red">${noChangesMsg}</span></div>
                                        <div class="form-floating">
                                            <input class="form-control" type="email" maxlength="50" placeholder="abc@gmail.com" name="newemail" id="newemail" style="cursor: not-allowed;" <% if(display != null){ %> value="<%=  display.getEmailAddress() %>" <% } %> readonly/>
                                            <label for="newemail">Email Address</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control" type="text" maxlength="50" placeholder="Lilian" name="newname" id="newname" <% if(display != null){ %> value="<%= display.getName() %>" <% } %> required autofocus/>
                                            <label for="newname">Name</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control ${validIc}" type="text" maxlength="14" placeholder="000101-07-0123" name="newic" id="newic" <% if(display != null){ %> value="<%= display.getIc() %>" <% } %> required/>
                                            <div><span style="color: red">${invalidIcMsg}</span></div>
                                            <label for="newic">IC</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <select class="form-select" id="gender" aria-label="Gender" name="gender">
                                                <option value="Female" <% if(display != null){ if(display.getGender() == 'F'){ %> selected <% }} %>>Female</option>
                                                <option value="Male" <% if(display != null){ if(display.getGender() == 'M'){ %> selected <% }} %>>Male</option>
                                            </select>
                                            <label for="gender">Gender</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control" type="date" name="birthday" id="birthday" <% if(display != null){ %> value="<%= display.getBirthDate() %>" <% } %> required/>
                                            <label for="birthday">Date of Birth</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control" type="text" placeholder="1, Taman Sui, P.P" name="address" id="address" <% if(display != null){ %> value="<%= display.getAddress() %>" <% } %> required/>
                                            <label for="address">Address</label>
                                        </div>
                                        <br>
                                        <div class="form-floating">
                                            <input class="form-control" type="text" maxlength="14" placeholder="012-3456789" name="telNo" <% if(display != null){ %> value="<%= display.getContactNo() %>" <% } %> id="telNo" pattern="[0-9]{3}-[0-9]{7,8}" required autofocus/>
                                            <label for="telNo">Contact No</label>
                                            <input type="hidden" value="R0003" name="role" id="role" />
                                        </div>
                                        <br>
                                        <input class="button" type="submit" value="Save" name="save" style="Height:40px;"/>
                                        <br>
                                        <div align="center" style="padding-top: 10px;">
                                            <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><h4>Delete Account</h4></td>
                <td style="vertical-align: top;">
                    <a href="#deleteAcc" class="edit" data-bs-toggle="modal" data-bs-target="#deleteAcc">Delete My Account</a>
                    <div class="modal fade" id="deleteAcc" tabindex="-1" aria-labelledby="deleteAccLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content" style="border-radius: 15px; padding: 20px 50px 20px 50px;">
                                <div class="modal-body">
                                    <div id="modal_header">
                                        <h3>Delete your account permanently.</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                                    </div>
                                    <p>Are you sure you want to delete this account permanently? Data is not able to be recovered once deleted the account.</p>
                                    <br>
                                    <form action="DeleteAccount" method="POST" style="padding: 0px;">
                                        <input class="button" type="submit" value="Delete" name="delete" style="Height:40px; background-color: red;"/>
                                    <br>
                                    </form>
                                    <div align="center" style="padding-top: 10px;">
                                        <a href="#" class="edit" data-bs-dismiss="modal" aria-label="Close">Cancel</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
    </div>
    <footer>&#169;Copyright Reserved 2020 CC Cinema Sdn Bhd. All Rights Reserved.</footer>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script>
        <%  if(session.getAttribute("errorForInfo") != null){  
                session.removeAttribute("errorForInfo");
        %>
                $(document).ready(function(){
                    $('#info').modal('show');
                });  
        <%  }else if(session.getAttribute("errorForChangePass") != null){  
                session.removeAttribute("errorForChangePass");
        %>
                $(document).ready(function(){
                    $('#changePsw').modal('show');
                }); 
        <%  } %>
    </script>
</body>
</html>
