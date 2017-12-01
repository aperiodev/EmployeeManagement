<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<style>
    .reason {
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
        height:80px !important;
    }

    .reason a
    {
        width: 100% !important;
        height:50px !important;

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

    .text-wrap {
        word-wrap: break-word !important;
        text-overflow: ellipsis !important;
        max-width: 0px !important;
        white-space: normal !important;
    }
    .wraptext
    {
        width:100% !important;
        height:100px !important;
        overflow: hidden !important;
    }

    .table-responsive
    {
        overflow-x: hidden !important;
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
    <%--<div class="table-responsive">--%>
        <div class="box-body">
            <table id="userLeaveList" class="display responsive table table-striped table-bordered table-hover nowrap" cellspacing="0"
                   width="100%">
                <thead>
                <tr>
                    <th style="width: 14% !important;">Requested By</th>
                    <th style="width: 14% !important;">From Date</th>
                    <th style="width: 14% !important;">To Date</th>
                    <th style="width: 14% !important;">No of Days</th>
                    <th style="width: 14% !important;">Reason</th>
                    <th style="width: 14% !important;">To</th>
                    <th style="width: 14% !important;"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${userleaves}">
                    <tr>
                        <td style="width: 14% !important;" class="text-wrap">${item.user.username}</td>
                        <td style="width: 14% !important;" class="text-wrap">${item.fromDate}</td>
                        <td style="width: 14% !important;" class="text-wrap">${item.toDate}</td>
                        <td style="width: 14% !important;">${item.noOfDays}</td>
                        <td style="width: 14% !important;" class="reason text-wrap"><div class="wraptext"> <a href="#" data-reason="${item.reason.replaceAll("\"", "\'")}"
                                              onclick="showModal(this)" style="width: 100%;">${item.reason}</a></div></td>
                        <td style="width: 14% !important;" class="text-wrap">${item.toUser.username}</td>
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
   <%-- </div>--%>
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
            <div class="modal-body">
                <p  id="reasonTxt"></p>

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
            columnDefs: [{orderable: false, targets: [6]}]
        });
    });

    function showModal(identifier) {
        $('#myModal').modal();
        $('#reasonTxt').empty().html($(identifier).data('reason'));
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