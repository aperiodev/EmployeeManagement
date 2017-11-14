<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">Employee Registration</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <form:form id="regForm" modelAttribute="user" action="registration" method="post">
        <div class="box-body">
            <div class="row">

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="username">Email</label>
                        <form:input path="username" type="text" class="form-control" id="username" placeholder="Email"/>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <form:input path="password" type="password" class="form-control" id="password" placeholder="Password"/>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Role</label>

                            <select name="userRole" id="userRole" class="form-control">
                                <option value="">Select..</option>
                                <c:forEach items="${authorities}" var="authorities">
                                    <c:if test="${authorities != 'ROLE_ADMIN'}">
                                        <option>${authorities}</option>
                                    </c:if>
                                </c:forEach>
                            </select>

                    </div>
                </div>

            </div>
        </div>
        <div class="box-footer">
            <button type="reset" class="btn btn-default" id="cancel">Cancel</button>
            <form:button type="submit" id="register" name="register" class="btn btn-info pull-right">Save</form:button>
           &nbsp;

        </div>
    </form:form>
</div>

<script>
    $(function () {
        registerFormValidate();

        $('#cancel').click(function () {
            clearfields();
        });

        function clearfields() {
            $('#username').val('');
            $('#password').val('');

            $('#username-error').text('');
            $('#password-error').text('');
            $('#userRole-error').text('');
        }
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
                    minlength: 8,
                },
                userRole: "required"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    }
</script>
