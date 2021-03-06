<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<jsp:useBean id="date" class="java.util.Date" />


<style>
    .text-wrap {
        word-wrap: break-word !important;
        text-overflow: ellipsis !important;
        max-width: 0px !important;
        white-space: normal !important;
    }

    .table-responsive
    {
        overflow-x: hidden !important;
    }

</style>
<script>
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace

    $(function () {
        $('.yearselect').yearselect({
            order: 'desc'
        });

        $(".numeric").bind("keypress", function (e) {
            var keyCode = e.which ? e.which : e.keyCode
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
            $(".error").css("display", ret ? "none" : "inline");
            return ret;
        });
        $(".numeric").bind("paste", function (e) {
            return false;
        });
        $(".numeric").bind("drop", function (e) {
            return false;
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
                        <label for="financialyear"><strong style="color: red">*</strong>Financial Year</label>
                        <input type="text" class="form-control yearselect" id="financialyear" placeholder="Financial year"
                               name="financialyear"></input>
                    </div>
                </div>


                <div class="col-md-4">
                    <div class="form-group">
                        <label for="sickleaves"><strong style="color: red">*</strong>Sick Leaves</label>
                        <input type="text" class="form-control numeric" id="sickleaves" placeholder="Sick Leaves"
                               name="sickleaves" maxlength="2"></input>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="casualleaves"><strong style="color: red">*</strong>Casual Leaves</label>
                        <input type="text" class="form-control numeric" id="casualleaves" placeholder="Casual Leaves"
                               name="casualleaves" maxlength="2"></input>
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
                        <th style="width: 25% !important;">Financial Year</th>
                        <th style="width: 25% !important;">Sick Leaves</th>
                        <th style="width: 25% !important;">Casual Leaves</th>
                        <th style="width: 25% !important;">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${companyleaves}" var="companyleave">
                    <tr>
                        <td style="width: 25% !important;">${companyleave[0]}</td>
                        <td style="width: 25% !important;">${companyleave[1]}</td>
                        <td style="width: 25% !important;">${companyleave[2]}</td>
                        <td data-year="${companyleave[0]}"
                            class="deletecompanyLeave btn btn-sm btn-flat btn-custom" style="width: 25% !important;">
                            <%--<fmt:formatDate value="${date}" var="dateyear" pattern="yyyy" />
                            <c:if test="${companyleave[5] eq dateyear}">
                                <b class="btn btn-primary" style="padding:3px 12px !important; text-align: left !important; display: inline !important;">Edit</b>
                            </c:if>--%>
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

                $('#save').addClass('disabled');
                $('#save').prop("disabled", true);
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
                            //clearfields();
                            $('#save').removeClass('disabled');
                            $('#save').prop("disabled", false);
                            toastr.success("Successfully financial year leaves added");

                            setTimeout(function(){// wait for 5 secs(2)
                                location.reload(); // then reload the page.(3)
                            }, 2000);

                        } else if (response == "financialyearexists") {
                            $('#save').removeClass('disabled');
                            $('#save').prop("disabled", false);
                            toastr.error("Financial Year already exists, please try another");

                        }
                        else {
                            $('#save').removeClass('disabled');
                            $('#save').prop("disabled", false);
                            toastr.warning("Something went wrong, please try again");
                        }
                    },
                    error: function (request, textStatus, errorThrown) {
                        $('#save').removeClass('disabled');
                        $('#save').prop("disabled", false);
                        toastr.error("Something went wrong, please try again");
                    },
                    failure: function () {
                        $('#save').removeClass('disabled');
                        $('#save').prop("disabled", false);
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
            $('.yearselect').yearselect({
                order: 'desc'
            });
        }



        $('.deletecompanyLeave').on('click', function () {
            var year = $(this).data("year");

            $('.deletecompanyLeave').addClass('disabled');
            $('.deletecompanyLeave').prop("disabled", true);

            $.ajax({
                url: "${ctx}/auth/admin/deleteCompanyleave",
                type: "POST",
                data: ({
                    year: year
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "success") {

                        $('.deletecompanyLeave').removeClass('disabled');
                        $('.deletecompanyLeave').prop("disabled", false);

                        toastr.success("Financial Year leaves deleted successfully");
                        setTimeout(function(){// wait for 5 secs(2)
                            location.reload(); // then reload the page.(3)
                        }, 2000);

                    } else {
                        $('.deletecompanyLeave').removeClass('disabled');
                        $('.deletecompanyLeave').prop("disabled", false);
                        toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    $('.deletecompanyLeave').removeClass('disabled');
                    $('.deletecompanyLeave').prop("disabled", false);
                    toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                },
                failure: function () {
                    $('.deletecompanyLeave').removeClass('disabled');
                    $('.deletecompanyLeave').prop("disabled", false);
                    toastr.error("Financial Year leaves cannot be deleted, Please try again!");
                }
            });
        });

        $('#example').DataTable({
            responsive: true,
            order: [0],
            columnDefs: [ { orderable: false, targets: [3] } ]
        });

    });
</script>
