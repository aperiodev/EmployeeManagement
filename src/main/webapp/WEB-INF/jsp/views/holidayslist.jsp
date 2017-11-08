<%@ include file="/common/taglibs.jsp" %>
<jsp:useBean id="date" class="java.util.Date"/>

<script>
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace

    $(function () {
        $('#fdate').datepicker({
            format: 'yyyy-mm-dd'
        });

    });
</script>
<section class="content">
    <c:if test="${role ne '[ROLE_USER]'}">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Add Holiday's</h3>

                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
                <%-- <form:form id="addcompanyleavesform" modelAttribute="companyleaves" action="savecompanyleaves" method="post">--%>
                <%--  <form:hidden path="id" id="id" name="id"></form:hidden>--%>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="fdate">Date</label>
                            <input type="text" class="form-control" id="fdate" placeholder="Date"
                                   name="fdate"></input>
                        </div>
                    </div>


                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="occasion">Occasion</label>
                            <textarea class="form-control" rows="3" placeholder="Occasion" id="occasion" maxlength="200"
                                      name="occasion"></textarea>
                        </div>
                    </div>

                </div>
            </div>
            <div class="box-footer">
                <button id="save" name="save" type="submit" class="btn btn-info">Save</button>
                <button id="cancel" name="cancel" type="reset" class="btn btn-default">Cancel</button>
            </div>
                <%-- </form:form>--%>
        </div>
    </c:if>

    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">Holidays Lists</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>


    <div class="table-responsive">
        <div class="box-body">
            <table id="example" class="display table-responsive table table-striped table-bordered nowrap cell-border"
                   cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Occasion</th>
                    <c:if test="${role ne '[ROLE_USER]'}">
                        <th>Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${holidays}" var="holiday">
                <tr>
                    <td>${holiday[1]}</td>
                    <td >${holiday[2]}</td>
                    <c:if test="${role ne '[ROLE_USER]'}">
                        <td data-id="${holiday[0]}"
                            class="deleteholiday btn btn-sm btn-flat btn-custom">
                                <%--<fmt:formatDate value="${date}" var="dateyear" pattern="yyyy" />
                                <c:if test="${companyleave[5] eq dateyear}">
                                    <b class="btn btn-primary" style="padding:3px 12px !important; text-align: left !important; display: inline !important;">Edit</b>
                                </c:if>--%>
                           <%-- <b class="btn btn-primary"
                               style="padding:3px 12px !important;text-align: left !important; display: inline !important;">Edit</b>--%>
                            <b class="btn btn-danger"
                               style="padding:3px 12px !important;text-align: left !important; display: inline !important;">Delete</b>
                        </td>
                    </c:if>
                </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    </div>

</section>
<script>
    $(function () {
        $('#save').click(function () {
            var fdate = $('#fdate').val();
            var occasion = $('#occasion').val();


            if (fdate.length != 0 && occasion.length != 0) {

                $('#save').addClass('disabled');
                $('#save').prop("disabled", true);

                $.ajax({
                    url: "${ctx}/auth/admin/saveholiday",
                    type: "POST",
                    data: ({
                        fdate: fdate,
                        occasion: occasion
                    }),
                    success: function (response) {
                        console.log(response);
                        if (response == "success") {
                            //clearfields();

                            $('#save').removeClass('disabled');
                            $('#save').prop("disabled", false);
                            toastr.success("Successfully holiday added");
                            setTimeout(function () {// wait for 5 secs(2)
                                location.reload(); // then reload the page.(3)
                            }, 2000);

                        } else if (response == "holidayexists") {
                            $('#save').removeClass('disabled');
                            $('#save').prop("disabled", false);
                            toastr.error("Holiday already exists, please try another");
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

                if (fdate.length == 0) {
                    toastr.warning("Date cannot be empty");
                    fdate.focus();
                } else if (occasion.length == 0) {
                    toastr.warning("Occasion cannot be empty");
                    occasion.focus();
                }
            }
        });

        $("#fdate").on('change', function () {
            var fdate = $('#fdate').val();
            $.ajax({
                url: "${ctx}/auth/admin/ajaxcheckholiday",
                type: "POST",
                data: ({
                    fdate: fdate
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "failure") {
                        toastr.error("Holiday already exists, please try another");
                    }
                    /*else {
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
            $('#fdate').val('');
            $('#occasion').val('');
        }

        $('#example').DataTable({
          //  responsive: true,
           order: [0],
           columnDefs: [{orderable: false, targets: [2]}]
        });

        $('.deleteholiday').on('click', function () {
            var id = $(this).data("id");

            $('.deleteholiday').addClass('disabled');
            $('.deleteholiday').prop("disabled", true);

            $.ajax({
                url: "${ctx}/auth/admin/deleteholiday",
                type: "POST",
                data: ({
                    id: id
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "success") {

                        $('.deleteholiday').removeClass('disabled');
                        $('.deleteholiday').prop("disabled", false);
                        toastr.success("Holiday deleted successfully");
                        setTimeout(function () {// wait for 5 secs(2)
                            location.reload(); // then reload the page.(3)
                        }, 2000);

                    } else {
                        $('.deleteholiday').removeClass('disabled');
                        $('.deleteholiday').prop("disabled", false);
                        toastr.error("Holiday cannot be deleted, Please try again!");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    $('.deleteholiday').removeClass('disabled');
                    $('.deleteholiday').prop("disabled", false);
                    toastr.error("Holiday cannot be deleted, Please try again!");
                },
                failure: function () {
                    $('.deleteholiday').removeClass('disabled');
                    $('.deleteholiday').prop("disabled", false);
                    toastr.error("Holiday cannot be deleted, Please try again!");
                }
            });
        })

    });
</script>
