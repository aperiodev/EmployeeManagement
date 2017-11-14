<%@include file="/common/taglibs.jsp" %>
<header class="main-header">
    <!-- Logo -->
    <a href="/EM/welcome" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b>EM</b></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg">
            <b>EM</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Navigation</span>
        </a>

        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li class="dropdown user user-menu">
                    <a <%--href="#"--%> <%--class="dropdown-toggle" data-toggle="dropdown"--%>>
                       <%-- <img src="${ctx}/theme/img/defaultImg.png" class="user-image" alt="User Image">--%>
                        <span class="hidden-xs"><sec:authentication property="principal.username" /></span>
                    </a>
                 <%--   <ul class="dropdown-menu">
                        <!-- User image -->
                        <li class="user-header">
                            <p>
                                <sec:authentication property="principal.username" /> </small></br>
                            </p>
                            <p><a style="color: #FFFFFF;" href="/EM/auth/user/profile" ><i class="fa  fa-pencil"></i> Profile</a></p>
                        </li>
                        <li>
                            <div class="row">
                                <div class="col-xs-4 text-center">
                                    <a href="#"></a>
                                </div>
                            </div>
                        </li>
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="/EM/auth/user/showChangePassword" class="btn btn-primary btn-flat">Change Password</a>
                            </div>
                            <div class="pull-right">
                                <a href="/EM/j_spring_security_logout"  class="btn btn-danger btn-flat"> Sign Out</a>
                            </div>
                        </li>
                    </ul>--%>
                </li>
            </ul>
        </div>
    </nav>
</header>
