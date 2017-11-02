<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style>
    .reason {
        display: inline-block;
        width: 180px;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
    }

    div.dataTables_wrapper div.dataTables_paginate ul.pagination {
        margin: 2px 0;
        white-space: nowrap;
    }

    .pagination {
        display: inline-block;
        padding-left: 0;
        margin: 20px 0;
        border-radius: 4px;
    }
</style>

<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">Requested Leaves</h3>
        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <table id="userLeaveList" class="table table-striped table-bordered table-hover nowrap" cellspacing="0"
               width="100%">
            <thead>
            <tr>
                <th>Requested By</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>No of Days</th>
                <th>Reason</th>
                <th>To</th>
                <th width="60px"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${userleaves}">
                <tr>
                    <td>${item.user.username}</td>
                    <td>${item.fromDate}</td>
                    <td>${item.toDate}</td>
                    <td>${item.noOfDays}</td>
                    <td class="reason"><a href="#" onclick="showModal('${item.reason}')">${item.reason}</a></td>
                    <td>${item.toUser.username}</td>
                    <td>
                        <button type="button" class="cbutton btn btn-block btn-success btn-sm" data-type="APPROVED"
                                onclick="approval_decision(${item.id}, 'APPROVED');">Approve
                        </button>
                        <button type="button" class="cbutton btn btn-block btn-danger btn-sm" data-type="REJECTED"
                                onclick="approval_decision(${item.id}, 'REJECTED');">Reject
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Leave Reason </h4>
            </div>
            <div class="modal-body">
                <p id="reasonTxt">Some text in the modal.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<script>
    $(function () {

        $('#userLeaveList').DataTable({
            responsive: true,
            columnDefs: [ { orderable: false, targets: [6] } ]
        });
    });

    function showModal(reason) {
        $('#myModal').modal();
        $('#reasonTxt').empty().html(reason);
    }

    function approval_decision(leave_id, status) {
        // this will pop up confirmation box and if yes is clicked it call servlet else return to page
        console.log(status);
        if (status.toString() == 'APPROVED') {
            leaveAjaxCall(leave_id, status)
        } else {
            if (confirm("Do you want to Reject this leave request?")) {
                leaveAjaxCall(leave_id, status)
            } else {
                return false;
            }
        }
        return true;
    }

    function leaveAjaxCall(leave_id, status) {
        $.ajax({
            url: "${ctx}/auth/user/ajaxApproveOrRejectLeave",
            type: "POST",
            data: ({
                leaveId: leave_id,
                leaveStatus: status
            }),
            success: function (response) {
                console.log(response);
                if (response == "success") {
                    window.location.href = "${ctx}/auth/user/leaves?status=" + status;
                } else {
                    toastr.error("Please tyr again...");
                }
            },
            error: function (request, textStatus, errorThrown) {
                toastr.error("Please tyr again...");
            },
            failure: function () {
                toastr.error("Please tyr again...");
            }
        });
    }
</script>