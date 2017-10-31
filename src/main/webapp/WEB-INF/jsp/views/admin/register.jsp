<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="box box-warning">
    <div class="box-header with-border">
        <h3 class="box-title">User Registration</h3>
    </div>
    <form:form id="regForm" modelAttribute="user" action="registration" method="post" class="form-horizontal">
        <div class="box-body">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">Username</label>

                <div class="col-sm-10">
                    <form:input path="username" type="text" class="form-control" id="username" placeholder="username"/>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-10">
                    <form:input path="password" type="password" class="form-control" id="password"
                                placeholder="Password"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Role</label>
                <div class="col-sm-10">
                    <select name="userRole" id="userRole" class="form-control">
                        <option value="">Select..</option>
                        <c:forEach items="${authorities}" var="authorities">
                            <c:if test="${authorities != 'ROLE_ADMIN'}">
                                <option>${authorities}</option>
                            </c:if>
                        </c:forEach>
                    </>
                    </select>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button type="reset" class="btn btn-default">Cancel</button>
            <form:button type="submit" id="register" name="register" class="btn btn-primary ">Save</form:button>
        </div>
    </form:form>
</div>
<script>
    $(function () {
        registerFormValidate();
    });

    function registerFormValidate() {
        var registerForm = $("#regForm");

        // email
        jQuery.validator.addMethod("emailValidator", function (value, element) {
            var emailPattern = /^([A-Za-z]{1})([A-Za-z0-9+_.-])+([\w$]{1})\@(([\w]{1})([\w-]+([\w$]{1})\.)+)([a-zA-Z0-9]{2,3})$/;
            if (value.length > 0) {
                return (emailPattern.test(value));
            }
            return true;
        }, "Please enter valid email address");

        registerForm.validate({
            rules: {
                username: {
                    required: true,
                    emailValidator: true
                },
                password: {
                    required: true,
                    minlength: 6,
                },
                userRole: "required"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    }
</script>
