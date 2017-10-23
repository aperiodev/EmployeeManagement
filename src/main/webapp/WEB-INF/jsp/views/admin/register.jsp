<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="box box-warning">
    <div class="box-header with-border">
        <h3 class="box-title">User Registration</h3>
    </div>
    <form:form id="regForm" modelAttribute="user" action="registration" method="post" class="form-horizontal">
        <div class="box-body">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">Username</label>

                <div class="col-sm-10">
                    <form:input path="username" type="text" class="form-control" id="username" placeholder="username"/>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-10">
                    <form:input path="password" type="password" class="form-control" id="password" placeholder="Password"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Role</label>
                <div class="col-sm-10">
                     <select name="userRole" id="userRole" class="form-control">
                           <option value=""></option>
                           <c:forEach items="${authorities}" var="authorities">
                               <option>${authorities}</option>
                           </c:forEach>
                       </>
                       </select>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button type="reset" class="btn btn-default">Cancel</button>
            <form:button type="submit" id="register" name="register" class="btn btn-primary ">Save</form:button>
        </div>
    </form:form>
</div>
