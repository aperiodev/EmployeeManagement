<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>

<style>
    <sec:authorize access="!hasRole('ROLE_ADMIN')">
    <c:if test="${account.firstname == null || account.lastname == null || account.designation == null}">
    .sidebar-toggle, .main-sidebar {
        display: none !important;
    }

    @media (min-width: 768px) {
        .sidebar-mini.sidebar-collapse .content-wrapper, .sidebar-mini.sidebar-collapse .right-side, .sidebar-mini.sidebar-collapse .main-footer {
            margin-left: 0px !important;
        }
    }

    </c:if>
    </sec:authorize>
</style>

<script>
    $(function () {
        $('#doj').datepicker({
            format: 'yyyy-mm-dd',
            setDate: new Date()
        });

        $('#dob').datepicker({
            format: 'yyyy-mm-dd',
            setDate: new Date()
        });
    });
</script>

<section class="content">
    <div class="box box-warning">
        <div class="box-header with-border">
            <h3 class="box-title">Profile</h3>
        </div>
        <form:form id="updateForm" modelAttribute="account" action="updateProfile" method="post">
            <form:hidden path="user" id="user" name="user"/>
            <form:hidden path="id" id="id" name="id"/>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="firstname">Firstname</label>
                            <form:input type="text" class="form-control" id="firstname" placeholder="Firstname"
                                        path="firstname" name="firstname"/>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <form:input type="text" class="form-control" id="email" placeholder="Email" path="email"
                                        readonly="true"
                                        name="email"/>
                        </div>
                    </div>

                    <div class="col-md-6">

                        <div class="form-group">
                            <label for="lastname">Lastname</label>
                            <form:input type="text" class="form-control" id="lastname" placeholder="Lastname"
                                        path="lastname" name="lastname"/>
                        </div>

                        <div class="form-group">
                            <label>
                                Gender
                            </label>
                            <form:select class="form-control" data-placeholder="Select a Role" id="gender" path="gender"
                                         name="gender">
                                <form:option value="">Select..</form:option>
                                <form:option value="MALE">MALE</form:option>
                                <form:option value="FEMALE">FEMALE</form:option>
                            </form:select>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Date of Birth</label>
                            <form:input type="text" class="form-control" id="dob" path="dob"
                                        name="dob" value="${account.dob}" readonly="true"/>
                        </div>

                        <div class="form-group">
                            <label>Designation</label>
                            <form:input type="text" class="form-control" id="designation" placeholder="Designation"
                                        path="designation" name="designation"/>
                        </div>
                    </div>

                    <div class="col-md-6">

                        <div class="form-group">
                            <label>Phonenumber</label>
                            <form:input type="text" class="form-control" id="phonenumber" placeholder="Phonenumber"
                                        path="phonenumber" name="phonenumber"/>
                        </div>

                        <div class="form-group">
                            <label>Emergency Contact Number</label>
                            <form:input type="text" class="form-control" name="emergencycontactnumber"
                                        id="emergencycontactnumber" placeholder="Emergency Contact Number"
                                        path="emergencycontactnumber"/>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Pannumber</label>
                            <form:input type="text" class="form-control" id="pannumber" placeholder="Pannumber"
                                        path="pannumber" name="pannumber"/>
                        </div>

                        <div class="form-group">
                            <label>Date of Joining</label>
                            <form:input type="text" class="form-control" id="doj" placeholder="Date of Joining"
                                        readonly="true"
                                        path="doj" name="doj" value="${account.doj}"/>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Aadharnumber</label>
                            <form:input type="text" class="form-control" id="aadharnumber" placeholder="Aadharnumber"
                                        path="aadharnumber" name="aadharnumber"/>
                        </div>
                        <div class="form-group">
                            <label>Employee Code</label>
                            <form:input type="text" class="form-control" id="employeecode" placeholder="Employee Code"
                                        path="employeecode" name="employeecode"/>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Address</label>
                            <form:textarea class="form-control" rows="4" id="address" placeholder="Address"
                                           path="address" name="address"/>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>
                                Current Employee
                            </label>
                            <form:select class="form-control" data-placeholder="Select" id="currentemployee"
                                         name="currentemployee" path="currentemployee">
                                <form:option value="True">Yes</form:option>
                                <form:option value="False">No</form:option>
                            </form:select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-footer">
                <form:button id="register" name="register" type="submit" class="btn btn-primary">Update</form:button>
            </div>
        </form:form>
    </div>
</section>
<script>
    $(function () {
        updateFormValidate();

        <sec:authorize access="!hasRole('ROLE_ADMIN')">
            <c:if test="${account.firstname == null || account.lastname == null || account.designation == null}">
                $("body").removeClass("skin-blue sidebar-mini").addClass("skin-blue sidebar-mini sidebar-collapse");
            </c:if>
        </sec:authorize>
    });

    function updateFormValidate() {
        var updateForm = $("#updateForm");

        updateForm.validate({
            rules: {
                firstname: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        },},
                    minlength: 2
                },
                lastname: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        },},
                    minlength: 1
                },
                gender: "required",
                email: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    },
                    email: true
                },
                dob: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    }
                },
                doj: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    }
                },
                designation: "required",
                phonenumber: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    },
                    number: true,
                    maxlength: 10,
                    minlength: 10
                },
                emergencycontactnumber: {
                    number: true,
                    minlength: 10,
                    maxlength: 10
                },
                pannumber:{
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    },
                },
                aadharnumber: {
                    required: {
                        depends: function () {
                            $(this).val($.trim($(this).val()));
                            return true;
                        }
                    },
                },
                // employeecode: "required",
                // currentemployee: "required"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    }
</script>