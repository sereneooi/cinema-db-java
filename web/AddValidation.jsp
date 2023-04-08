<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "model.*,java.util.*"%>
<style>
    <%@include file="bookingStyle.css" %>
    #popup-validation-Form-content{
        transform: translate(125%, 25%); 
        width: 30%; height: 65%; 
        background: whitesmoke; 
        border-radius: 15px; 
        padding: 0px;
    }
    
    .image {
       position:relative;
       display:inline-block;
    }
    
    .overlay {
       position:absolute;
       top: 2%;
       right: 5%;
       size: 40px;
       color: white;
       display:inline-block;
       -webkit-box-sizing:border-box;
       -moz-box-sizing:border-box;
       box-sizing:border-box;

       /* All other styling - see example */
       img {
          vertical-align:top;
       }
    }
</style>

<%if(session.getAttribute("Object") instanceof Theatre){%>
        <jsp:include page="TheatreAdminLayout.jsp" />
<%}else if(session.getAttribute("Object") instanceof Booking){%>
        <jsp:include page="mainBookingLayout.jsp" />
<%}%>
<%
    boolean validation = (Boolean)session.getAttribute("verificationSucceed");
    String validationMessage = (String)session.getAttribute("ValidationMessage");
    if (validation){%>
    <div  id='popup-validation-Form'>
        <div id='popup-validation-Form-content'>
            <div class="image">
                <span class="close overlay" onclick="closeWin()">&times;</span>
                <img src=".\image\success_msg.gif" alt="Success Message" style="border-radius: 15px; width:100%;height:70%;">
            </div>
            <h1 style="text-align: center; font-family: Verdana, sans-serif; color: #b5e7a0; margin: 20px 0px 15px;">Success !</h1>
            <p class="success_Msg" style="text-align: center; font-size: 15px;"><%=validationMessage%></p>
            <button onclick="closeWin()" class="validation"style="margin:40px 0px 0px 130px; padding:0.8em 5em; background-color:#28c8a0;">GO BACK</button>
        </div>
    </div>
    <%}else{%>
        <div  id='popup-validation-Form'>
            <div id='popup-validation-Form-content'>
                <div class="image">
                    <span class="close overlay" onclick="closeWin()">&times;</span>
                    <img src=".\image\error_msg.gif" alt="Error Message" style="border-radius: 15px; width:100%;height:70%;">
                </div>
                <h1 style="text-align: center; font-family: Verdana, sans-serif; color: #c94c4c; margin: 20px 0px 15px;">Error !</h1>
                <p class="success_Msg" style="text-align: center; font-size: 15px; margin: 0px 10px;"><%=validationMessage%></p>
                <button onclick="closeWin()" class="validation"style="margin:23px 0px 0px 130px; padding:0.8em 5em; background-color:#f24329;">Try Again !</button>
            </div>
        </div>            
    <%}%>

<script>
    var my_modal = document.getElementById('popup-validation-Form');
    var main_page = document.getElementById('blur');
    
    function showModal(){
      my_modal.style.display = "block";
    }

    // now show automatically after 0.1s
    setTimeout(showModal,100) 
    
    function closeWin() {
        my_modal.style.display = "none";
        main_page.style.filter = "none";
        main_page.style['pointer-events'] = 'auto';
        main_page.style.userSelect = "auto";
    }
</script>       