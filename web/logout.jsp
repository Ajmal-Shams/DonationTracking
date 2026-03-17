<%-- 
    Document   : logout
    Created on : Nov 18, 2022, 3:55:56 PM
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<body>
		<% session.invalidate(); %> <!-- HERE WE ARE INVALIDATE THE SESSION, SO THAT NO VALUES WILL BE PRESENT IN SESSION -->
		<jsp:forward page="index.jsp"/>
	</body>
</html>
