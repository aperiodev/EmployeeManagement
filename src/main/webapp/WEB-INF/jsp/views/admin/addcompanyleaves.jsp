<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<jsp:useBean id="date" class="java.util.Date" />

<script>
    $(function () {
        $('#financialyear').datepicker({
            format: 'yyyy-mm-dd'
        });
    });
</script>
<section class="content">
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">Add Financial Year Leaves</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            </div>
        </div>
        <%-- <form:form id="addcompanyleavesform" modelAttribute="companyleaves" action="savecompanyleaves" method="post">--%>
        <%--  <form:hidden path="id" id="id" name="id"></form:hidden>--%>
        <div class="box-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="financialyear">Financial Year</label>
                        <input type="text" class="form-control" id="financialyear" placeholder="Financial year"
                               name="financialyear"></input>
                    </div>
                </div>


                <div class="col-md-4">
                    <div class="form-group">
                        <label for="sickleaves">Sick Leaves</label>
                        <input type="text" class="form-control" id="sickleaves" placeholder="Sick Leaves"
                               name="sickleaves" maxlength="3"></input>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="casualleaves">Casual Leaves</label>
                        <input type="text" class="form-control" id="casualleaves" placeholder="Casual Leaves"
                               name="casualleaves" maxlength="3"></input>
                    </div>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button id="cancel" name="cancel" type="submit" class="btn btn-default">Cancel</button>
            <button id="save" name="save" type="submit" class="btn btn-info pull-right">Save</button>
        </div>
        <%-- </form:form>--%>
    </div>

    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">Financial Year Leaves</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            </div>
        </div>


        <div class="box-body">
            <table id="example" class="display responsive table table-striped table-bordered nowrap cell-border"
                       cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th>Financial Year</th>
                        <th>Sick Leaves</th>
                        <th>Casual Leaves</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${companyleaves}" var="companyleave">
                    <tr>
                        <td>${companyleave[0]}</td>
                        <td>${companyleave[1]}</td>
                        <td>${companyleave[2]}</td>
                        <td data-user="${companyleave[4]}"
                            class="editcompanyLeave btn btn-sm btn-flat btn-custom">
                            <fmt:formatDate value="${date}" var="dateyear" pattern="yyyy" />
                            <c:if test="${companyleave[5] eq dateyear}">
                                <b class="btn btn-primary" style="padding:3px 12px !important; text-align: left !important; display: inline !important;">Edit</b>
                            </c:if>
                            <b class="btn btn-danger" style="padding:3px 12px !important;text-align: left !important; display: inline !important;">Delete</b>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
        </div>
    </div>

</section>
<script>
    $(function () {
        $('#save').click(function () {
            var financialYear = $('#financialyear').val();
            var sickleave = $('#sickleaves').val();
            var casualleave = $('#casualleaves').val();

            if (financialYear.length != 0 && sickleave.length != 0 && casualleave.length != 0) {
                $.ajax({
                    url: "${ctx}/auth/admin/savecompanyleaves",
                    type: "POST",
                    data: ({
                        financialyear: financialYear,
                        sickleaves: sickleave,
                        casualleaves: casualleave
                    }),
                    success: function (response) {
                        console.log(response);
                        if (response == "success") {
                            clearfields();



                            toastr.success("Successfully financial year leaves added");
                        } else if (response == "financialyearexists") {
                            toastr.error("Financial Year already exists, please try another");
                        }
                        else {
                            toastr.warning("Something went wrong, please try again");
                        }
                    },
                    error: function (request, textStatus, errorThrown) {
                        toastr.error("Something went wrong, please try again");
                    },
                    failure: function () {
                        toastr.error("Something went wrong, please try again");
                    }
                });
            } else {

                if (financialYear.length == 0) {
                    $('#financialyear').focus();
                    toastr.warning("Financial Year cannot be empty");
                    financialYear.focus();
                } else if (sickleave.length == 0) {
                    toastr.warning("Sick Leaves cannot be empty");
                    sickleave.focus();
                } else if (casualleave.length == 0) {
                    toastr.warning("Casual Leaves cannot be empty");
                    casualleave.focus();
                }
            }
        });

        $("#financialyear").on('change', function () {
            var financialYear = $('#financialyear').val();
            $.ajax({
                url: "${ctx}/auth/admin/ajaxcheckFinancialyear",
                type: "POST",
                data: ({
                    financialyear: financialYear
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "failure") {
                        toastr.error("Financial Year already exists, please try another");
                    } /*else {
                        toastr.error("Something went wrong, please try again");
                    }*/
                },
                error: function (request, textStatus, errorThrown) {
                    toastr.error("Something went wrong");
                },
                failure: function () {
                    toastr.error("Something went wrong");
                }
            });

        });

        $('#cancel').click(function () {
            clearfields();
        });

        function clearfields() {
            $('#financialyear').val('');
            $('#sickleaves').val('');
            $('#casualleaves').val('');
        }

        $('#example').DataTable({
            responsive: true,
            order: [],
            columnDefs: [ { orderable: false, targets: [3] } ]
        });

        $('.deletecompanyLeave').on('click', function () {
            var companyleaveid = $(this).data("user");

            $.ajax({
                url: "${ctx}/admin/deleteCompanyleave",
                type: "POST",
                data: ({
                    companyleaveid: companyleaveid
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "success") {
                        toastr.success("Financial Year leaves deleted successfully");
                        window.setTimeout(function(){location.href = "${ctx}/admin/users"},800)
                    } else {
                        toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                },
                failure: function () {
                    toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                }
            });
        })

    });
</script>
