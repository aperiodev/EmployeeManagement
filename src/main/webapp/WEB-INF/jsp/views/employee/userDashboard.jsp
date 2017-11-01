<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="content">

    <div class="row">
        <!-- /.col -->
        <div class="col-md-12">
            <!-- Widget: user widget style 1 -->
            <div class="box box-widget widget-user">
                <!-- Add the bg color to the header using any of the bg-* classes -->
                <div class="widget-user-header bg-aqua-active">
                    <h3 class="widget-user-username">${username}</h3>
                    <h5 class="widget-user-desc">${userrole}</h5>
                    <h5>In the current year <b>(${currentyear})</b> you have used <b>${nol}</b> leaves out of
                        <b>${tnofleaves}</b> paid leaves.
                        <c:if test="${(tnofleaves - nol) >= 0}">
                            You have <b>${tnofleaves - nol}</b> paid leaves remaining.
                        </c:if>
                        <c:if test="${(tnofleaves - nol) < 0}">
                            You have exceeded your paid leaves.
                        </c:if>
                    </h5>
                </div>
                <div class="box-footer">
                    <div class="row">
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>${leavesapply}</h3>
                                    <p>Total Application(s)</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-fw fa-hand-rock-o"></i>
                                </div>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>${approvedleaves}</h3>

                                    <p>Approved Application(s)</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-fw fa-thumbs-o-up"></i>
                                </div>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>${cancelleaves}</h3>

                                    <p>Cancel Application(s)</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-fw fa-hand-scissors-o"></i>
                                </div>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>${rejectedleaves}</h3>

                                    <p>Rejected Application(s)</p>


                                </div>
                                <div class="icon">
                                    <i class="fa fa-fw fa-thumbs-o-down"></i>
                                </div>
                            </div>
                        </div>
                        <!-- ./col -->
                    </div>
                    <!-- /.row -->
                </div>
            </div>
            <!-- /.widget-user -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
    <!-- Small boxes (Stat box) -->
    <!-- Custom tabs (Charts with tabs)-->
    <div class="nav-tabs-custom">
        <!-- Tabs within a box -->
        <ul class="nav nav-tabs pull-right">
            <li><a href="#revenue-chart" data-toggle="tab">Yearly</a></li>
            <li class="active"><a href="#sales-chart" data-toggle="tab">Current Year</a></li>
            <li class="pull-left header"><i class="fa fa-area-chart"></i>LEAVES</li>
        </ul>
        <div class="tab-content no-padding">
            <!-- Morris chart - Sales -->
            <div class="chart tab-pane active" id="sales-chart" style="position: relative; height: 300px;"></div>
            <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 300px;"></div>
        </div>
    </div>
</section>

<style>
    .icon {
        top: 20px !important;
        right: 20px !important;
        font-size: 60px !important;
    }

    .img-circle {
        border: 3px solid #3c8dbc !important;
    }

    .widget-user-header {
        height: 100px !important;
    }
</style>

<script>

    $(function () {
        var yearaly = new Morris.Line({
            element: 'revenue-chart',
            resize: true,
            data: ${allyears},
            xkey: 'y',
            ykeys: ['item1'],
            labels: ['NoOf Leaves'],
            lineColors: ['#3c8dbc'],
            hideHover: 'auto'
        });

        var curent_year = new Morris.Line({
            element: 'sales-chart',
            resize: true,
            data: ${cymonth},
            xkey: 'y',
            ykeys: ['item1'],
            labels: ['NoOf Leaves'],
            lineColors: ['#3c8dbc'],
            hideHover: 'auto'
        });
        $("#revenue-chart").removeClass("active");
        $('.box ul.nav a').on('shown.bs.tab', function () {
            yearaly.redraw();
            curent_year.redraw();
        });
    });
</script>