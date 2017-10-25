<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .reason {
        display: inline-block;
        width: 180px;
        white-space: nowrap;
        overflow: hidden !important;
        text-overflow: ellipsis;
    }
</style>

<div class="box box-warning">
    <div class="box-header">
        <h3 class="box-title">${LeaveType} LEAVES LIST</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <table id="datatable" class="table table-striped table-bordered nowrap" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Requested By</th>
                    <th>Between</th>
                    <th>No of Day(s)</th>
                    <th>Reason</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${userleaves}">
                    <tr>
                        <td>${item.user.username}</td>
                        <td>${item.fromDate} <b>To</b> ${item.toDate}</td>
                        <td>${item.noOfDays}</td>
                        <td class="reason">${item.reason}</td>
                        <td>${item.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    $(function () {
        $('#datatable').DataTable({});
    });
</script>