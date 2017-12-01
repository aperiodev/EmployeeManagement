<%@ include file="/common/taglibs.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                        <td style="width: 22% !important;" class="text-wrap">${item.user.username}</td>
                        <td style="width: 22% !important;" class="text-wrap">${item.fromDate} <b> To </b> ${item.toDate}</td>
                        <td style="width: 22% !important;" class="text-wrap">${item.noOfDays}</td>
                        <td style="width: 22% !important;" class="reason text-wrap"><div class="wraptext"><a href="#" data-reason="${item.reason.replaceAll("\"", "\'")}"
                                                                                                             onclick="showModal(this)" style="width: 100%;">${item.reason}</a></div></td>
                        <td style="width: 12% !important;" class="text-wrap">${item.status}</td>
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
            responsive: true,
            columnDefs: [{orderable: false, targets: [4]}]
        });
    });

    function showModal(identifier) {
        $('#myModal').modal();
        $('#reasonTxt').empty().html($(identifier).data('reason'));
    }
</script>