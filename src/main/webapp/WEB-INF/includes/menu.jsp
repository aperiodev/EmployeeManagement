<%--<%@ include file="/common/taglibs.jsp" %>--%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="main-sidebar">
    <section class="sidebar">
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
                    <li><a href="${ctx}/auth/user/holidaysList"><i class="fa pull-left"></i> Holidays</a></li>
                    <li><a href="${ctx}/auth/companyleaves"><i class="fa pull-left"></i>Leaves Setup</a></li>
                    <li><a href="${ctx}/auth/read"><i class="fa pull-left"></i>Upload Payslips</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-users"></i> <span>Accounts</span>
              <i class="fa fa-angle-left pull-right"></i><i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${ctx}/auth/admin/register"><i class="fa fa-user-plus"></i>Employee Registration</a></li>
                    <li><a href="${ctx}/auth/admin/users"><i class="fa fa-user-circle-o"></i>Manage Employees</a></li>
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
                    <li><a href="${ctx}/auth/user/leaves"><i class="fa fa-hourglass-end"></i>Requested Leaves</a></li>
                    <li><a href="${ctx}/auth/user/leaves?status=APPROVED"><i class="fa fa-thumbs-up"></i>Approved Leaves</a></li>
                    <li><a href="${ctx}/auth/user/leaves?status=REJECTED"><i class="fa fa-thumbs-down"></i>Rejected Leaves</a></li>
                    <li><a href="${ctx}/auth/user/leaves?status=CANCEL"><i class="fa fa-ban"></i>Canceled Leaves</a></li>

                </ul>
            </li>
            </sec:authorize>
            <sec:authorize access='hasAnyRole("ROLE_USER") and !hasRole("ROLE_ADMIN")' >
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-list"></i>
                    <span>Leaves</span>
                    <i class="fa fa-angle-left pull-right"></i>
                    <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${ctx}/auth/user/requestLeave"><i class="fa fa-plus-circle"></i>Leave Application</a></li>
                    <li><a href="${ctx}/auth/user/leavesLists"><i class="fa fa-history"></i>Leaves History</a></li>
                    <li><a href="${ctx}/auth/user/holidaysList"><i class="fa fa-circle-o"></i>Holidays List</a></li>
                </ul>
            </li>
           </sec:authorize>
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
                       <li><a href="${ctx}/auth/user/holidaysList"><i class="fa pull-left"></i>Holidays</a></li>
                       <li><a href="${ctx}/auth/companyleaves"><i class="fa pull-left"></i>Leaves Setup</a></li>
                       <li><a href="${ctx}/auth/read"><i class="fa pull-left"></i>Upload Payslips</a></li>
                   </ul>
               </li>
               <li class="treeview">
                   <a href="#">
                       <i class="fa fa-users"></i> <span>Accounts</span>
                       <i class="fa fa-angle-left pull-right"></i>
                       <i class="fa fa-angle-left pull-right"></i>
            </span>
                   </a>
                   <ul class="treeview-menu">
                       <li><a href="${ctx}/auth/admin/register"><i class="fa fa-user-plus"></i>Employee Registration</a></li>
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
                       <li><a href="${ctx}/auth/user/leaves"><i class="fa fa-hourglass-end"></i>Requested Leaves</a></li>
                       <li><a href="${ctx}/auth/user/leaves?status=APPROVED"><i class="fa fa-thumbs-up"></i>Approved Leaves</a></li>
                       <li><a href="${ctx}/auth/user/leaves?status=REJECTED"><i class="fa fa-thumbs-down"></i>Rejected Leaves</a></li>
                       <li><a href="${ctx}/auth/user/leaves?status=CANCEL"><i class="fa fa-ban"></i>Canceled Leaves</a></li>

                   </ul>
               </li>
           </sec:authorize>
           <li class="treeview">
                <a href="#">
                    <i class="fa fa-gear"></i>
                    <span>Settings</span>
                    <i class="fa fa-angle-left pull-right"></i>
                    <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${ctx}/auth/user/profile"><i class="fa pull-left"></i>Profile</a></li>
                    <li><a href="${ctx}/auth/user/showChangePassword"><i class="fa pull-left"></i>Change Password</a></li>
                    <li><a href="${ctx}/j_spring_security_logout"><i class="fa pull-left"></i>Sign Out</a></li>
                </ul>
           </li>
        </ul>
    </section>
</aside>