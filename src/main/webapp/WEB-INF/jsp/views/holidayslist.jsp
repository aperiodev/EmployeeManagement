<%@ include file="/common/taglibs.jsp" %>
<jsp:useBean id="date" class="java.util.Date"/>
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
        $('#fdate').datepicker({
            format: 'yyyy-mm-dd'
        });

    });
</script>
<c:if test="${role ne '[ROLE_USER]'}">
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Add Holiday's</h3>

                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="fdate"><strong style="color: red">*</strong>Date</label>
                            <input type="text" class="form-control" id="fdate" placeholder="Date"
                                   name="fdate"></input>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="occasion"><strong style="color: red">*</strong>Occasion</label>
                            <textarea class="form-control" placeholder="Occasion" id="occasion" rows="2"
                                   name="occasion" maxlength="250"></textarea>
                        </div>
                    </div>

                </div>
            </div>
            <div class="box-footer">
                <button id="cancel" name="cancel" type="reset" class="btn btn-default">Cancel</button>
                <button id="save" name="save" type="submit" class="btn btn-info pull-right">Save</button>
            </div>
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
                <table id="example" class="display table table-striped table-bordered cell-border"
                       cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th style="width: 20% !important;">Date</th>
                        <th style="width: 65% !important;">Occasion</th>
                        <c:if test="${role ne '[ROLE_USER]'}">
                            <th style="width: 15% !important;">Actions</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${holidays}" var="holiday">
                    <tr>
                        <td style="width: 20% !important;">${holiday[1]}</td>
                        <td class="text-wrap" style="width: 65% !important;">${holiday[2]}</td>
                        <c:if test="${role ne '[ROLE_USER]'}">
                            <td data-id="${holiday[0]}"
                                class="deleteholiday btn btn-sm btn-flat btn-custom" style="width: 15% !important;">
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

<script>
    $(function () {
        $('#save').click(function () {
            var fdate = $('#fdate').val();
            var occasion = $('#occasion').val().trim();


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
        });

        $('#example').DataTable({
            responsive: true

        });

    });
</script>
