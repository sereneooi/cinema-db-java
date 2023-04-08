<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <script type="text/javascript">
        <%
            Account currentUser = (Account) session.getAttribute("currentUser"); 

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if(currentUser == null){ // if the user does not log out the existing account
                %>
                    alert('Please log in to your account first.');
                    location='login.jsp';
                <%
            }else{
                session.invalidate(); %>
                location="login.jsp";
            <% } %>
    </script>
</html>
