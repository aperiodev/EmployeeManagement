<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>

<div class="row">
    <div class="col-xs-12">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Employees</h3>
                <a href="${ctx}/auth/admin/register"  class="btn btn-sm btn-primary pull-right"><i class="fa fa-plus-circle"> Register</i></a>

            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <table id="example" class="display responsive table table-striped table-bordered nowrap cell-border"
                       cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th> Email</th>
                        <th>Designation</th>
                        <th>Employee Id</th>
                        <th>isEmployee</th>
                       <%-- <th>Email</th>--%>
                        <th>Mobile</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${users}" var="user">
                    <tr>
                        <td><a href="/auth/user/profile?user=${user[0]}">${user[0]}</a></td>
                        <td>${user[1]}</td>
                        <td>${user[2]}</td>
                        <td>${user[3].toString().toUpperCase()}</td>
                        <%--<td>${user[4]}</td>--%>
                        <td>${user[5]}</td>
                        <td data-user="${user[0]}"
                            class="userAccount btn btn-${user[6].toString() == "true" ? 'primary' : 'danger'} btn-sm btn-flat btn-custom">
                                ${user[6].toString() == "true" ? 'Active' : 'InActive'}
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#example').DataTable({
            responsive: true
        });

        $('.userAccount').on('click', function () {
            var username = $(this).data("user");

            $.ajax({
                url: "${ctx}/auth/admin/enableOrDisableAccount",
                type: "POST",
                data: ({
                    username: username
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "success") {
                        toastr.success("Account status changed successfully");
                        window.setTimeout(function(){location.href = "${ctx}/auth/admin/users"},800)
                    } else {
                        toastr.error("Account status cannot be changed, Please try again!");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    toastr.error("Account status cannot be changed, Please try again!");
                },
                failure: function () {
                    toastr.error("Account status cannot be changed, Please try again!");
                }
            });
        })
    });
</script>