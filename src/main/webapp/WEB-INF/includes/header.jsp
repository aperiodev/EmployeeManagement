<%@include file="/common/taglibs.jsp" %>
<header class="main-header">
    <!-- Logo -->
    <a href="/welcome" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b>EM</b></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg">
            <b>EM </b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>

        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <!-- User Account: style can be found in dropdown.less -->
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="${ctx}/theme/img/defaultImg.png" class="user-image" alt="User Image">
                        <span class="hidden-xs"><sec:authentication property="principal.username" /></span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- User image -->
                        <li class="user-header">
                            <img src="${ctx}/theme/img/defaultImg.png" class="img-circle" alt="User Image">

                            <p>
                                <sec:authentication property="principal.username" /> </small>
                            </p>
                        </li>
                        <!-- Menu Body -->
                        <%--<li class="user-body">
                            <div class="row">
                                <div class="col-xs-4 text-center">
                                    <a href="#">Followers</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Sales</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Friends</a>
                                </div>
                            </div>
                            <!-- /.row -->
                        </li>--%>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="/auth/user/profile" class="btn btn-primary btn-flat">Profile</a>
                            </div>
                            <div class="pull-right">
                                <%--<c:url value="/j_spring_security_logout"  var="logoutUrl" />
                                <form action="${logoutUrl}" method="post" id="logoutForm">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>--%>

                                <a href="/j_spring_security_logout"  class="btn btn-danger btn-flat"> Sign Out</a>
                            </div>
                        </li>
                    </ul>
                </li>
                <!-- Control Sidebar Toggle Button -->
                <%--<li>
                    <a href="#" data-toggle="control-sidebar"><sec:authentication property="principal.username" /></a>
                </li>--%>
            </ul>
        </div>
    </nav>
</header>
<%--
<script>
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }
</script>--%>
