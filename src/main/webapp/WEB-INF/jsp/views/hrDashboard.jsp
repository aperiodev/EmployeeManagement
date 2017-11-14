<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .datepicker table tr td.active, .datepicker table tr td.active.disabled, .datepicker table tr td.active.disabled:hover {
        background-image: linear-gradient(to bottom, #09ccb9, #09ccb9);
    }

    .datepicker table tr td.active:hover {
        background-image: linear-gradient(to bottom, #6fccc5, #6fccc5);
    }

    .table {
        padding: 15px;
    }

    .datepicker-days tbody tr td.red {
        color: #f00 !important;
    }

    .day {
        background: grey !important;;
        color: white !important;
        border: white solid 5px !important;
    }

    .disabled {
        background: none !important;
        color: grey !important;
    }

    .active {
        background: #367fa9 !important;;
        color: white !important;
        border: white solid 5px !important;
    }

    .reason {
        display: inline-block;
        width: 180px;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
    }

</style>
<div class="box box-solid box-primary">
    <div class="box-header with-border">
       <h3 class="box-title">Calendar</h3>
        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <div class="box-body">
        <div id="calendar" style="width: 100%"></div>
    </div>
    <!-- /.box-body -->
</div>
<div class="box box-info">
    <div class="box-header with-border">
        <h3 class="box-title">Leaves</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <div class="box-body">
        <table id="userLeaveList" class="display responsive table table-striped table-bordered nowrap cell-border" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th style="width: 50% !important;">User</th>
                <th style="width: 50% !important;">Reason</th>
            </tr>
            </thead>
        </table>
    </div>

</div>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content" style="width: 800px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Leave Reason </h4>
            </div>
            <div class="modal-body table-responsive">
                <p  id="reasonTxt"></p>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<Script>
    $(function () {
        var curentdate = new Date();
        var flag = 0;
        var holidays = [
            <c:forEach items="${date_all}" var="ctag" varStatus="loop">
            new Date('${ctag}')${!loop.last ? ', ' : ''}
            </c:forEach>
        ];

        $('#calendar').datepicker({
            //startDate: curentdate,
            daysOfWeekDisabled: [0, 6],
            beforeShowDay: function (date) {
                for (var i = 0; i < holidays.length; i++) {
                    holidays[i].setHours(0, 0, 0, 0);
                    date.setHours(0, 0, 0, 0);
                    var dd = holidays[i].toString();
                    var ddd = date.toString();
                    if (dd == ddd) {
                        flag = flag + 1;
                    } else {
                        flag = flag + 0;
                    }
                }
                if (flag == 1) {
                    flag = 0;
                    return true;
                } else {
                    return false;

                }
            }
        }).datepicker("setDate", new Date()).on('changeDate', function (ev) {
            go(formatDate(ev.date));
        });
        go(formatDate(curentdate));

        table = $('#userLeaveList').DataTable({
            'paging': false,
            'lengthChange': false,
            'searching': false,
            'ordering': true,
            'info': false,
            'autoWidth': true,
            'responsive': true,
            "columns": [
                {
                    "data": "username"
                },
                {
                    "data": "reason",
                    'orderable': false,
                    "render": function (data, type, row, meta) {
                        var sc = '<script> function showModal(identifier) {console.log($(identifier).data("reason")); $("#myModal").modal();$("#reasonTxt").empty().html($(identifier).data("reason"));} ';

                        var str = '<a data-reason= '+ hex2a(data) +' class="reason" onclick="showModal(this);">'+hex2a(data)+'</a> '+ sc;
                        return  str;
                    }
                }
            ]
        });

        function hex2a(hex) {
            var str = '';
            for (var i = 0; i < hex.length; i += 2) {
                var v = parseInt(hex.substr(i, 2), 16);
                if (v) str += String.fromCharCode(v);
            }
            //return str.replace(/"/g, '');
            return str.replace(/[_\s]/g, '');
        }

        function go(selecteddate) {
            $.ajax({
                url: "${ctx}/auth/user/ajaxgettodayLeaves",
                type: "POST",
                data: ({
                    selecteddate: selecteddate
                }),
                success: function (demo) {
                    table.clear().draw();
                    table.rows.add(JSON.parse(demo)).draw();
                },
                error: function (request, textStatus, errorThrown) {
                    toastr.error("Please tyr again...");
                    //$("button").removeClass('disabled');
                    //$("button").prop("disabled", false);
                },
                failure: function () {
                    toastr.error("Please tyr again...");
                    //$("button").removeClass('disabled');
                    //$("button").prop("disabled", false);
                }
            });
        }

        function formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        }
    });
</Script>