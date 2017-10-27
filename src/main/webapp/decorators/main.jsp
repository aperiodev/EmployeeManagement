<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ include file="/common/taglibs.jsp" %>
<%@ include file="/common/toastr.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@page contentType="text/html;charset=UTF-8" %>
    <%@page pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta charset="utf-8"/>

    <title>Layout</title>

    <link type="text/css" href="${theme}/bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet"/>

    <link rel="stylesheet" href="${theme}/css/fonts.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="${theme}/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${theme}/bower_components/Ionicons/css/ionicons.min.css">

    <link rel="stylesheet" href="${theme}/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="${theme}/bower_components/datatables.net-bs/css/responsive.dataTables.min.css">

    <!-- Date Picker -->
    <link rel="stylesheet" href="${theme}/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="${theme}/bower_components/bootstrap-daterangepicker/daterangepicker.css">

    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="${theme}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

    <!-- Theme style -->
    <link rel="stylesheet" href="${theme}/css/AdminLTE.css">

    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="${theme}/css/skins/_all-skins.css">

    <!-- Custom css style-->
    <link type="text/css" href="${theme}/css/custom.css" rel="stylesheet"/>

    <script src="//code.jquery.com/jquery.min.js"></script>
    <script src="${theme}/js/year-select.js"></script>

    <decorator:head/>
</head>

</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <%@ include file="/WEB-INF/includes/menu.jsp" %>

    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <%--<section class="content-header">
            <h1>
                Dashboard
                <small>Control panel</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Dashboard</li>
            </ol>
        </section>--%>
        <section class="content">
            <decorator:body/>
        </section>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</div>

<!-- jQuery UI 1.11.4 -->
<script src="${theme}/bower_components/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>

<script src="${theme}/js/jquery.validate.js"></script>

<script src="${theme}/bower_components/bootstrap/dist/js/bootstrap.js"></script>

<script src="${theme}/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>

<script src="${theme}/bower_components/datatables.net-bs/js/dataTables.responsive.min.js"></script>

<!-- Sparkline -->
<script src="${theme}/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>

<!-- jQuery Knob Chart -->
<script src="${theme}/bower_components/jquery-knob/dist/jquery.knob.min.js"></script>


<script src="${theme}/bower_components/moment/min/moment.min.js"></script>

<!-- daterangepicker -->
<script src="${theme}/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>

<!-- datepicker -->
<script src="${theme}/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>



<!-- Bootstrap WYSIHTML5 -->
<script src="${theme}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

<!-- Slimscroll -->
<script src="${theme}/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>

<!-- FastClick -->
<script src="${theme}/bower_components/fastclick/lib/fastclick.js"></script>


<!-- AdminLTE App -->
<script src="${theme}/js/adminlte.min.js"></script>

<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="${theme}/js/pages/dashboard.js"></script>

<!-- AdminLTE for demo purposes -->
<script src="${theme}/js/demo.js"></script>

</body>
</html>
