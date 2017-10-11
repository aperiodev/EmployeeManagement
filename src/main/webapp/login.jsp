<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp" %>
<script src="${theme}/bower_components/jquery/dist/jquery.min.js"></script>

<div class="login-box">
    <div class="login-logo">
        <b>Employee Management</b>
    </div>
    <div class="login-box-body">
        <span id="errorMsg" class="label label-danger text-danger"></span>
        <p class="login-box-msg">Sign in to start your session</p>
        <%--<form id="loginForm" action="loginProcess" method="post">--%>
        <div class="form-group has-feedback">
            <input path="username" name="username" id="username" type="text" class="form-control" placeholder="Username"
                   required>
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>

        <div class="form-group has-feedback">
            <input path="password" name="password" id="password" type="password" class="form-control"
                   placeholder="Password" required/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-8">
                <div class="checkbox icheck">
                    <label>
                        <input type="checkbox"> Remember Me
                    </label>
                </div>
            </div>
            <!-- /.col -->
            <div class="col-lg-offset-2  col-xs-8">
                <button id="login" name="login" type="button" class="btn btn-primary btn-block btn-flat">Sign In
                </button>
            </div>
            <!-- /.col -->
        </div>
        <%--</form>--%>
        <br>
        <a href="#">I forgot my password</a><br>
        <%--<a href="${ctx}/register" class="text-center">Register a new membership</a>--%>
    </div>
</div>
<script>
    $(function () {
        $('#login').click(function () {
            var userName = $('#username').val();
            var password = $('#password').val();

            if (userName.length != 0 && password .length !=0) {
                $.ajax({
                    url: "${ctx}/ajaxLoginProcess",
                    type: "POST",
                    data: ({
                        username: userName,
                        password: password
                    }),
                    success: function (response) {
                        console.log(response);
                        if (response == "success") {
                            window.location.href = "${ctx}/login";
                        } else {
                            toastr.error("User name or password wrong");
                        }
                    },
                    error: function (request, textStatus, errorThrown) {
                        toastr.error("User name or password wrong");
                    },
                    failure: function () {
                        toastr.error("User name or password wrong");
                    }
                });
            } else {

                if(userName.length == 0){
                    $('#username').focus();
                    toastr.warning("User name cannot be empty");
                } else if(password.length == 0){
                    toastr.warning("Password cannot be empty");
                }
            }
        });
    });
</script>
