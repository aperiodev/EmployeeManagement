<%--<%@ include file="/common/taglibs.jsp" %>--%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="main-sidebar">
    <section class="sidebar">
      <%--  <div class="user-panel">
           <div class="pull-left image">
                <img src="${ctx}/theme/img/defaultImg.png" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p><sec:authentication property="principal.username" /></p>
            </div>
        </div>--%>

        <ul class="sidebar-menu" data-widget="tree">
       <sec:authorize access='hasAnyRole("ROLE_ADMIN")' >
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cogs"></i>
                    <span>Configurations</span>
                    <i class="fa fa-angle-left pull-right"></i>
                    <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                   <%-- <li><a href="#"><i class="fa fa-angle-left pull-left"></i> Employee Leaves</a></li>--%>
                   <%-- <li><a href="#"><i class="fa fa-angle-left pull-left"></i> Yearly Leaves</a></li>--%>
                    <li><a href="/auth/user/holidaysList"><i class="fa fa-angle-left pull-left"></i> Holidays</a></li>
                    <li><a href="/auth/admin/companyleaves"><i class="fa fa-angle-left pull-left"></i>Leaves Setup</a>
                    </li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-users"></i> <span>Accounts</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="active"><a href="/auth/admin/register"><i class="fa fa-user-plus"></i>User Registration</a></li>
                    <li><a href="/auth/admin/users"><i class="fa fa-user-circle-o"></i>Manage Accounts</a></li>
                </ul>
            </li>

            <li class="treeview">
                <a href="#">
                    <i class="fa fa-envelope-o"></i>
                    <span>Leave Management</span>
                    <i class="fa fa-angle-left pull-right"></i>
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/auth/user/leaves"><i class="fa fa-hourglass-end"></i>Requested Leaves</a></li>
                    <li><a href="/auth/user/leaves?status=APPROVED"><i class="fa fa-thumbs-up"></i>Approved Leaves</a></li>
                    <li><a href="/auth/user/leaves?status=REJECTED"><i class="fa fa-thumbs-down"></i>Rejected Leaves</a></li>
                    <li><a href="/auth/user/leaves?status=CANCEL"><i class="fa fa-ban"></i>Canceled Leaves</a></li>

                </ul>
            </li>
            </sec:authorize>
            <sec:authorize access='hasAnyRole("ROLE_USER") and !hasRole("ROLE_ADMIN")' >
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-list"></i>
                    <span>Leaves</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/auth/user/requestLeave"><i class="fa fa-plus-circle"></i>Leave Application</a></li>
                    <li><a href="/auth/user/leavesLists"><i class="fa fa-history"></i>Leaves History</a></li>
                    <li><a href="/auth/user/holidaysList"><i class="fa fa-circle-o"></i>Holidays List</a></li>
                    <li><a href="/auth/user/sendMail"><i class="fa fa-mail-reply"></i>Email</a></li>
                </ul>
            </li>
           </sec:authorize>
            <%--<li class="treeview">
                <a href="#">
                    <i class="fa fa-edit"></i> <span>Forms</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="pages/forms/general.html"><i class="fa fa-circle-o"></i> General Elements</a></li>
                    <li><a href="pages/forms/advanced.html"><i class="fa fa-circle-o"></i> Advanced Elements</a></li>
                    <li><a href="pages/forms/editors.html"><i class="fa fa-circle-o"></i> Editors</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-table"></i> <span>Tables</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="pages/tables/simple.html"><i class="fa fa-circle-o"></i> Simple tables</a></li>
                    <li><a href="pages/tables/data.html"><i class="fa fa-circle-o"></i> Data tables</a></li>
                </ul>
            </li>
            <li>
                <a href="pages/calendar.html">
                    <i class="fa fa-calendar"></i> <span>Calendar</span>
                    <span class="pull-right-container">
              <small class="label pull-right bg-red">3</small>
              <small class="label pull-right bg-blue">17</small>
            </span>
                </a>
            </li>
            <li>
                <a href="pages/mailbox/mailbox.html">
                    <i class="fa fa-envelope"></i> <span>Mailbox</span>
                    <span class="pull-right-container">
              <small class="label pull-right bg-yellow">12</small>
              <small class="label pull-right bg-green">16</small>
              <small class="label pull-right bg-red">5</small>
            </span>
                </a>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-folder"></i> <span>Examples</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="pages/examples/invoice.html"><i class="fa fa-circle-o"></i> Invoice</a></li>
                    <li><a href="pages/examples/profile.html"><i class="fa fa-circle-o"></i> Profile</a></li>
                    <li><a href="pages/examples/login.html"><i class="fa fa-circle-o"></i> Login</a></li>
                    <li><a href="pages/examples/register.html"><i class="fa fa-circle-o"></i> Register</a></li>
                    <li><a href="pages/examples/lockscreen.html"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
                    <li><a href="pages/examples/404.html"><i class="fa fa-circle-o"></i> 404 Error</a></li>
                    <li><a href="pages/examples/500.html"><i class="fa fa-circle-o"></i> 500 Error</a></li>
                    <li><a href="pages/examples/blank.html"><i class="fa fa-circle-o"></i> Blank Page</a></li>
                    <li><a href="pages/examples/pace.html"><i class="fa fa-circle-o"></i> Pace Page</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-share"></i> <span>Multilevel</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
                    <li class="treeview">
                        <a href="#"><i class="fa fa-circle-o"></i> Level One
                            <span class="pull-right-container">
                  <i class="fa fa-angle-left pull-right"></i>
                </span>
                        </a>
                        <ul class="treeview-menu">
                            <li><a href="#"><i class="fa fa-circle-o"></i> Level Two</a></li>
                            <li class="treeview">
                                <a href="#"><i class="fa fa-circle-o"></i> Level Two
                                    <span class="pull-right-container">
                      <i class="fa fa-angle-left pull-right"></i>
                    </span>
                                </a>
                                <ul class="treeview-menu">
                                    <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                                    <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
                </ul>
            </li>--%>

           <sec:authorize access="hasAnyRole('ROLE_HR')">
               <li class="treeview">
                   <a href="#">
                       <i class="fa fa-cogs"></i>
                       <span>Configurations</span>
                       <i class="fa fa-angle-left pull-right"></i>
                       <i class="fa fa-angle-left pull-right"></i>
                       </span>
                   </a>
                   <ul class="treeview-menu">
                           <%-- <li><a href="#"><i class="fa fa-angle-left pull-left"></i> Employee Leaves</a></li>--%>
                           <%-- <li><a href="#"><i class="fa fa-angle-left pull-left"></i> Yearly Leaves</a></li>--%>
                       <li><a href="/auth/user/holidaysList"><i class="fa fa-angle-left pull-left"></i> Holidays</a></li>
                       <li><a href="/auth/admin/companyleaves"><i class="fa fa-angle-left pull-left"></i>Leaves Setup</a>
                       </li>
                   </ul>
               </li>
               <li class="treeview">
                   <a href="#">
                       <i class="fa fa-users"></i> <span>Accounts</span>
                       <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                   </a>
                   <ul class="treeview-menu">
                       <li class="active"><a href="/auth/admin/register"><i class="fa fa-user-plus"></i>User Registration</a></li>
                   </ul>
               </li>

               <li class="treeview">
                   <a href="#">
                       <i class="fa fa-envelope-o"></i>
                       <span>Leave Management</span>
                       <i class="fa fa-angle-left pull-right"></i>
                       <i class="fa fa-angle-left pull-right"></i>
                       </span>
                   </a>
                   <ul class="treeview-menu">
                       <li><a href="/auth/user/leaves"><i class="fa fa-hourglass-end"></i>Requested Leaves</a></li>
                       <li><a href="/auth/user/leaves?status=APPROVED"><i class="fa fa-thumbs-up"></i>Approved Leaves</a></li>
                       <li><a href="/auth/user/leaves?status=REJECTED"><i class="fa fa-thumbs-down"></i>Rejected Leaves</a></li>
                       <li><a href="/auth/user/leaves?status=CANCEL"><i class="fa fa-ban"></i>Canceled Leaves</a></li>

                   </ul>
               </li>

           <%--<ul class="sidebar-menu" data-widget="tree">
               <li class="header">HR Management</li>
               <li class="active treeview">
                   <a href="#">
                       <i class="fa fa-dashboard"></i> <span>Account</span>
                       <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                   </a>
                   <ul class="treeview-menu">
                       <li class="active"><a href="/holidaysList"><i class="fa fa-circle-o"></i>Holidays List</a></li>
                       <li><a href="#"><i class="fa fa-circle-o"></i>Leaves List</a></li>
                       <li><a href="#"><i class="fa fa-circle-o"></i>Leave Request</a></li>
                       <li><a href="#"><i class="fa fa-circle-o"></i>Leave Rejected</a></li>
                   </ul>
               </li>
           </ul>--%>
           </sec:authorize>
        </ul>
    </section>
</aside>