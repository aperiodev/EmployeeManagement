<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Welcome</title>
</head>
<body>
<table>
    <c:url value="/j_spring_security_logout" var="logoutUrl" />
    <form action="${logoutUrl}" method="post" id="logoutForm">
        <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
    </form>
    <tr>
        <td>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h2>
                    Welcome : ${pageContext.request.userPrincipal.name} | <a
                        href="#" onclick="formSubmit()"> Logout</a>
                </h2>
            </c:if>
        </td>
    </tr>

</table>
<script>
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }
</script>
</body>
</html>
