<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
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
            <%--<div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>--%>
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
                            <form:input type="text" class="form-control" id="doj" placeholder="Date of Joining" readonly="true"
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