<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${theme}/bower_components/jquery/dist/jquery.min.js"></script>
<style>
    p{
        color: #424069;
    }
</style>
<div class="login-box">
    <div class="login-logo">
        <b>Forgot Password</b>
    </div>
        <p> Enter your email and we'll send a link to reset your password </p>
    <div class="login-box-body">
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>
        <form:form method="POST" id="forgotPassword" action="sendPasswordUrl">
            <div class="form-group has-feedback">
                <input path="username" name='username' id="username" type="text" class="form-control"
                       placeholder="email"/>
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="col-xs-4">
                <button name="submit" type="submit" class="btn btn-primary btn-block btn-flat">Submit
                </button>
            </div>
            <div class="col-xs-4 pull-right">
                <a href="${ctx}/login" name="login" type="button" class="btn btn-success btn-block btn-flat"> <i class="fa fa-reply"></i>  Home
                </a>
            </div>
        </form:form>
        <br>
        <br>
    </div>
</div>