<%@ include file="/common/taglibs.jsp" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#financialyear').datepicker({
            format: 'yyyy-mm-dd'
        });
    });
</script>
<section class="content">
    <div class="box box-warning">
        <div class="box-header with-border">
            <h3 class="box-title">Company Leaves</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <%-- <form:form id="addcompanyleavesform" modelAttribute="companyleaves" action="savecompanyleaves" method="post">--%>
        <%--  <form:hidden path="id" id="id" name="id"></form:hidden>--%>
        <div class="box-body">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="financialyear">Financial Year</label>
                        <input type="text" class="form-control" id="financialyear" placeholder="Financial year"
                               name="financialyear"></input>
                    </div>
                </div>


                <div class="col-md-6">
                    <div class="form-group">
                        <label for="sickleaves">Sick Leaves</label>
                        <input type="text" class="form-control" id="sickleaves" placeholder="Sick Leaves"
                               name="sickleaves"></input>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="casualleaves">Casual Leaves</label>
                        <input type="text" class="form-control" id="casualleaves" placeholder="Casual Leaves"
                               name="casualleaves"></input>
                    </div>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button id="cancel" name="cancel" type="submit" class="btn btn-default">Cancel</button>
            <button id="save" name="save" type="submit" class="btn btn-primary">Save</button>
        </div>
        <%-- </form:form>--%>
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
                    url: "${ctx}/admin/savecompanyleaves",
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
                url: "${ctx}/admin/ajaxcheckFinancialyear",
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

    });
</script>
