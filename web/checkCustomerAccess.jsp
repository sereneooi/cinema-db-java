<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
Account currentUser = (Account) session.getAttribute("currentUser");
if(currentUser == null){ 
    %>
    <script type="text/javascript"> 
        alert('Please log in your account first.');
        location='login.jsp';
    </script>
    <%
}else{
    if(!currentUser.getRole().getRoleId().equals("R0003")){
        %>
        <script type="text/javascript"> 
            alert('<%= currentUser.getName() %>, You are not allow to access this page.');
            location='adminDashboard.jsp';
        </script>
        <%
    }
}
%>