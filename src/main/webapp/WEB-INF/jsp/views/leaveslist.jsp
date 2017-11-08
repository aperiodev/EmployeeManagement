<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    .reason {
        display: inline-block;
        width: 180px;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
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
                <th>ID</th>
                <th>Requested By</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>No of Days</th>
                <th>Reason</th>
                <th>Status</th>
                <th>To</th>
                <th>Action</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${userleaves}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.user.username}</td>
                    <td>${item.fromDate}</td>
                    <td>${item.toDate}</td>
                    <td>${item.noOfDays}</td>
                    <td class="reason"><a href="#" data-reason="${item.reason}" onclick="showModal(this)">${item.reason}</a></td>
                    <td>${fn:replace(item.status, '_', ' ')}</td>
                    <td>${item.toUser.username}</td>
                    <td align="center">
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
            'paging': true,
            'lengthChange': true,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': true,
            'responsive': true,
            "columnDefs": [{
                "targets": 7,
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