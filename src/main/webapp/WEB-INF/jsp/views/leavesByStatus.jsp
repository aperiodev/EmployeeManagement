<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .reason {
        display: inline-block;
        width: 344px !important;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
    }
    .text-wrap {
        word-wrap: break-word;
        text-overflow: ellipsis;
        max-width: 0px;
    }

    .table-responsive
    {
        overflow-x: hidden !important;
    }
</style>

<div class="box box-primary">

    <div class="box-header with-border">
        <h3 class="box-title" style="text-transform: capitalize">${fn:toLowerCase(LeaveType)} Leaves</h3>

        <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
        </div>
    </div>
    <!-- /.box-header -->
   <%-- <div class="table-responsive">--%>
        <div class="box-body">
            <table id="datatable" class="display responsive table table-striped table-bordered  cell-border" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th style="width: 22% !important;">Requested By</th>
                    <th style="width: 22% !important;">Between</th>
                    <th style="width: 22% !important;">No of Day(s)</th>
                    <th style="width: 22% !important;">Reason</th>
                    <th style="width: 12% !important;">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${userleaves}">
                    <tr>
                        <td>${item.user.username}</td>
                        <td>${item.fromDate} <b>To</b> ${item.toDate}</td>
                        <td>${item.noOfDays}</td>
                        <td class="reason"><a href="#" data-reason="${item.reason.replaceAll("\"", "\'")}"
                                              onclick="showModal(this)">${item.reason}</a></td>
                        <td>${item.status}</td>
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
        $('#datatable').DataTable({
            responsive: true
        });
    });

    function showModal(identifier) {
        $('#myModal').modal();
        $('#reasonTxt').empty().html($(identifier).data('reason'));
    }
</script>