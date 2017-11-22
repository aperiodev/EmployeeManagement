<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    .reason {

        width: 180px;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
    }

    .reason a p
    {
        width: 100% !important;
        height:30px !important;

    }

    .text-wrap {
        word-wrap: break-word !important;
        text-overflow: ellipsis !important;
        max-width: 0px !important;
        white-space: normal !important;
    }
</style>

<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">Leaves Lists</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <table id="userLeaveList" class="table table-striped table-bordered nowrap" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th style="width: 5% !important;">ID</th>
                <th style="width: 11% !important;">Requested By</th>
                <th style="width: 11% !important;">From Date</th>
                <th style="width: 11% !important;">To Date</th>
                <th style="width: 11% !important;">No of Days</th>
                <th style="width: 17% !important;">Reason</th>
                <th style="width: 11% !important;">Status</th>
                <th style="width: 11% !important;">To</th>
                <th style="width: 11% !important;">Action</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${userleaves}">
                <tr>
                    <td style="width: 5% !important;" class="text-wrap">${item.id}</td>
                    <td style="width: 11% !important;" class="text-wrap">${item.user.username}</td>
                    <td style="width: 11% !important;" class="text-wrap">${item.fromDate}</td>
                    <td style="width: 11% !important;" class="text-wrap">${item.toDate}</td>
                    <td style="width: 11% !important;" class="text-wrap">${item.noOfDays}</td>
                    <td class="reason text-wrap" style="width: 17% !important;"><a href="#" data-reason="${item.reason.replaceAll("\"", "\'")}" onclick="showModal(this)">${item.reason}</a></td>
                    <td style="width: 11% !important;" class="text-wrap">${fn:replace(item.status, '_', ' ')}</td>
                    <td style="width: 11% !important;" class="text-wrap">${item.toUser.username}</td>
                    <td align="center" style="width: 11% !important;" class="text-wrap">
                            <c:if test="${item.status == 'WAITING_FOR_APPROVAL'}">
                                <button type="button"
                                        class="cbutton btn btn-block btn-warning ${item.status == 'CANCEL' ?'disabled' : ''} "
                                    ${item.status == 'CANCEL' ?'disabled' : ''}
                                    <%--<c:choose>
                                        <c:when test="${item.status == 'CANCEL'}">
                                            class="cbutton btn btn-block btn-warning disabled" disabled
                                        </c:when>
                                        <c:otherwise>
                                            class="cbutton btn btn-block btn-warning"
                                        </c:otherwise>
                                    </c:choose>--%>
                                        onclick="comfirm_decision(${item.id});">CANCEL
                                </button>
                            </c:if>
                        </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- /.box-body -->
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
                <p id="reasonTxt"></p>
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
            'paging': true,
            'lengthChange': true,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': true,
            'responsive': true,
            "columnDefs": [{
                "targets": 8,
                "orderable": false
            }]
        });
    });
    function showModal(identifier) {
        $('#myModal').modal();
       $('#reasonTxt').empty().html($(identifier).data('reason'));
    }
    function comfirm_decision(leave_id) {
        // this will pop up confirmation box and if yes is clicked it call servlet else return to page
        if (confirm("Do you want to cancel this leave request?")) {
            $.ajax({
                url: "${ctx}/auth/user/ajaxCancleLeave",
                type: "POST",
                data: ({
                    leaveId: leave_id
                }),
                success: function (response) {
                    console.log(response);
                    if (response == "success") {
                        window.location.href = "${ctx}/auth/user/leavesLists";
                    } else {
                        toastr.error("Please tyr again...");
                        $(".cbutton").removeClass('disabled');
                        $(".cbutton").prop("disabled", false);
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    toastr.error("Please tyr again...");
                    $(".cbutton").removeClass('disabled');
                    $(".cbutton").prop("disabled", false);
                },
                failure: function () {
                    toastr.error("Please tyr again...");
                    $(".cbutton").removeClass('disabled');
                    $(".cbutton").prop("disabled", false);
                }
            });
        } else {
            return false;
        }
        return true;
    }
</script>