<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="box box-warning">
    <div class="box-header">
        <h3 class="box-title">List of Holidays</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <table id="holidaysList" class="table table-bordered table-striped">
            <thead>
            <tr>
                <th style="width: 10px">ID</th>
                <th>Date</th>
                <th>Occasion</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${holidaylist}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.date}</td>
                    <td>${item.occasion}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- /.box-body -->
</div>

<script>
    $(function () {
        $('#holidaysList').DataTable({
            'paging': false,
            'lengthChange': false,
            'searching': true,
            'ordering': true,
            'info': false,
            'autoWidth': true
        });
    });
</script>