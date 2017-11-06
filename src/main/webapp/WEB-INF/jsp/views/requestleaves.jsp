<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">Request Leaves</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <div class="box-body">

        <div class="form-group">
            <label>Date range:</label>
            <div class="input-group">
                <div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                </div>
                <input type="text" class="form-control pull-right" id="fromtodate" readonly>
            </div>
        </div>

        <div class="form-group">
            <label>No of Days:</label>
            <div class="input-group">
                <div class="input-group-addon">
                    <i class="fa fa-calendar-o"></i>
                </div>
                <input type="text" class="form-control" value="1" id="datecount" readonly>
            </div>
        </div>

        <div class="form-group">
            <label>To:</label>

            <select id="touser" class="form-control select2" style="width: 100%;">
                <option value="select" selected="selected">select</option>
                <c:forEach var="item" items="${userslist}">
                    <option value="${item.user.username}"><c:out value="${item.user.username}"/></option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Reason:</label>
            <textarea id="reason" class="form-control" rows="10" placeholder="Enter ..."></textarea>
        </div>

        <div class="box-footer">
            <button id="clear" type="reset" class="btn btn-default">Clear</button>
            <button id="submit" type="submit" class="btn btn-primary">Submit</button>
        </div>
    </div>
</div>

<script>
    $(function () {

        $("#clear").click(function () {
            $("#touser").val("select");
            $("#reason").val("");
            $('#fromtodate').val('').daterangepicker("update");
            $("#datecount").val("1");
        });

        $("#submit").click(function () {
            var cal = $('#fromtodate').val().split(' - ');
            $("button").addClass('disabled');
            $("button").prop("disabled", true);
            if ($("#touser").val().trim() == "select" || $("#datecount").val().trim() == 0 || $("#reason").val().trim() == "") {

                $("button").removeClass('disabled');
                $("button").prop("disabled", false);
                if ($("#touser").val().trim() == "select") {
                    toastr.error("Please select TO");
                }
                if ($("#datecount").val().trim() == 0) {
                    toastr.error("No of day must be greater then \"0\"");
                }
                if ($("#reason").val().trim() == "") {
                    toastr.error("Reason sould not be null");
                }
            } else {
                $.ajax({
                    url: "${ctx}/auth/user/ajaxRequestLeave",
                    type: "POST",
                    data: ({
                        touser: $("#touser").val(),
                        reason: $("#reason").val(),
                        noofdays: $("#datecount").val(),
                        fromdate: cal[0],
                        todate: cal[1]
                    }),
                    success: function (response) {
                        if (response == "success") {
                            window.location.href = "${ctx}/auth/user/leavesLists";
                        } else {
                            toastr.error("Please tyr again...");
                            $("button").removeClass('disabled');
                            $("button").prop("disabled", false);
                        }
                    },
                    error: function (request, textStatus, errorThrown) {
                        toastr.error("Please tyr again...");
                        $("button").removeClass('disabled');
                        $("button").prop("disabled", false);
                    },
                    failure: function () {
                        toastr.error("Please tyr again...");
                        $("button").removeClass('disabled');
                        $("button").prop("disabled", false);
                    }
                });
            }
        });

        $('#fromtodate').daterangepicker({"minDate": new Date(),
            locale: {
                format: 'YYYY-MM-DD'
            },
            isInvalidDate: function(date) {
                return (date.day() == 0 || date.day() == 6);
            }
        });

        $('#fromtodate').change(function () {
            var cal = $(this).val().split(' - ');
            $('#datecount').val(calcBusinessDays(new Date(cal[0]), new Date(cal[1])));
        });
    });

    function calcBusinessDays(start, end) {
        var date_array = [
            <c:forEach items="${holidaylist}" var="ctag" varStatus="loop">
            new Date('${ctag.date}')${!loop.last ? ', ' : ''}
            </c:forEach>
        ];

        var days_count = 0;

        while (start <= end) {
            if (start.getDay() > 0 && start.getDay() < 6) {
                days_count = days_count + 1;
                for (var dat in date_array) {
                    var new_date_array_val = date_array[dat];
                    new_date_array_val.setHours(0, 0, 0, 0);
                    start.setHours(0, 0, 0, 0);
                    if (new_date_array_val.getTime() == start.getTime()) {
                        days_count = days_count - 1;
                    }
                }
            }
            var newDate = start.setDate(start.getDate() + 1);
            start = new Date(newDate);
        }
        return days_count;
    }
</script>