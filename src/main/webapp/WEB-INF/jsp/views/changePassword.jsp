<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .sidebar-toggle, .logo, .main-sidebar {
        display: none !important;
    }

    @media (min-width: 768px) {
        .sidebar-mini.sidebar-collapse .main-header .navbar, .sidebar-mini.sidebar-collapse .content-wrapper, .sidebar-mini.sidebar-collapse .right-side, .sidebar-mini.sidebar-collapse .main-footer {
            margin-left: 0px !important;
        }
    }
    #pswd_info {
        position:absolute;
        /*bottom:-75px;*/
        /*bottom: -115px\9; /* IE Specific */
        right:-70px;
        width:450px;
        padding:15px;
        background:#fefefe;
        font-size:.875em;
        border-radius:5px;
        box-shadow:0 1px 3px #ccc;
        border:1px solid #ddd;
        z-index: 9999;
    }
    #pswd_info h4 {
        margin:0 0 10px 0;
        padding:0;
        font-weight:normal;
    }
    #pswd_info::before {
        content: "\25B2";
        position:absolute;
        top:-12px;
        left:45%;
        font-size:14px;
        line-height:14px;
        color:#ddd;
        text-shadow:none;
        display:block;
    }
    .invalid {
        background:url(/theme/img/cross.png) no-repeat 0 50%;
        padding-left:22px;
        line-height:24px;
        color:#ec3f41;
    }
    .pvalid {
        background:url(/theme/img/tick.png) no-repeat 0 50%;
        padding-left:22px;
        line-height:24px;
        color:#3a7d34;
    }
    #pswd_info ul{
        list-style-type: none;
    }

    .hideShowPassword-toggle {
        background-color: transparent;
        background-image: url('/theme/img/wink.png'); /* fallback */
        background-image: url('/theme/img/wink.svg'), none;
        background-position: 0 center;
        background-repeat: no-repeat;
        border: 2px solid transparent;
        border-radius: 0.25em;
        cursor: pointer;
        font-size: 100%;
        height: 44px;
        margin: 0;
        max-height: 100%;
        padding: 0;
        overflow: 'hidden';
        text-indent: -999em;
        width: 46px;
        -moz-appearance: none;
        -webkit-appearance: none;
    }

    .hideShowPassword-toggle{
        position: absolute;
        right: 0px;
        top: 27%;
        margin-top: -17px;
        HEIGHT: 36pX;
    }

    .hideShowPassword-toggle-hide {
        background-position: -44px center;
    }

    .hideShowPassword-toggle:hover,
    .hideShowPassword-toggle:focus {
        border-color: #0088cc;
        outline: transparent;
    }
</style>
<div class="box box-warning">
    <div class="box-header with-border">
        <strong>Change Password</strong>
    </div>
    <form:form id="changePasswordForm" modelAttribute="user" action="changePassword" method="post" class="form-horizontal">
    <div class="box-body">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
              <div class="box-body">
                    <form:hidden path="password" id="password"/>
                    <div class="form-group">
                        <label for="oldPassword">Current Password :</label>
                        <input type="password" id="oldPassword" name="oldPassword" class="form-control" />
                    </div>

                    <div class="form-group">
                        <label for="newPassword">New Password :</label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control" />
                    </div>
                    <div id="pswd_info">
                        <h5>Password must meet the following requirements:</h5>
                        <ul>
                            <li id="letter" class="invalid">At least <strong>one letter</strong></li>
                            <li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
                            <li id="number" class="invalid">At least <strong>one number</strong></li>
                            <li id="length" class="invalid">Be at least <strong>8 characters</strong></li>
                        </ul>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password :</label>
                        <input type="password"  id="confirmPassword"  name="confirmPassword" class="form-control"/>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" disabled id="changePwdSubmitBtn">Submit</button>
                        <button type="reset" class="btn btn-default">Reset</button>
                    </div>
                </div>
        </div>
    </div>
</form:form>
</div>
<script>
    $(function() {
        $('#pswd_info').hide();
        onChangeOldPassword();
        checkPasswordStrength();
        validateForm();
        $('#newPassword').hidePassword(true);
        $('#confirmPassword').hidePassword(true);
        $("body").removeClass("skin-blue sidebar-mini").addClass("skin-blue sidebar-mini sidebar-collapse");
    });

    function onChangeOldPassword(){
        var oldPassword = $('#oldPassword');
        oldPassword.on('focusout',function(e){
            e.stopImmediatePropagation();
            if ($(this).val().trim() != '') {
                $.ajax({
                    url: '${ctx}/auth/user/confirmOldPassword',
                    type: 'POST',
                    data: {
                        oldPassword: oldPassword.val()
                    },
                    success: function (response) {
                        if (response == "false") {
                            toastr.error("Enter Correct Old Password");
                            oldPassword.val('');
                            oldPassword.focus();
                        }
                    },
                    error:function () {
                        toastr.error("Enter Correct the Old Password");
                    }
                });
            }
        });
    }

    function checkPasswordStrength(){
        $('#pswd_info').hide();

        $('input[name="newPassword"]').keyup(function() {
            var pswd = $(this).val();

            //validate the length
            if ( pswd.length < 8 ) {
                makeClassInValid('length');
            } else {
                makeValidClass('length');
            }

            //validate letter
            if ( pswd.match(/[A-z]/) ) {
                makeValidClass('letter');
            } else {
                makeClassInValid('letter');
            }

            //validate capital letter
            if ( pswd.match(/[A-Z]/) ) {
                makeValidClass('capital');
            } else {
                makeClassInValid('capital');
            }

            //validate number
            if ( pswd.match(/\d/) ) {
                makeValidClass('number');
            } else {
                makeClassInValid('number');
            }

            submitDisabledStatus();

        }).focus(function() {
            $('#pswd_info').show();
            submitDisabledStatus();
        }).blur(function() {
            $('#pswd_info').hide();
            submitDisabledStatus();
        });
    }

    function submitDisabledStatus() {
        $('#changePwdSubmitBtn').attr('disabled', $('#pswd_info ul li.invalid').length != 0);
    }

    function makeValidClass(element) {
        $('#'+element).removeClass('invalid').addClass('pvalid');
    }

    function makeClassInValid(element) {
        $('#'+element).removeClass('pvalid').addClass('invalid');
    }



    function validateForm() {
        var changePasswordForm = $("#changePasswordForm");
        changePasswordForm.validate({
            rules: {
                oldPassword: {
                    required: true,
                    minlength: 6
                },
                newPassword: {
                    required: true,
                    minlength: 8
                },
                confirmPassword: {
                    required: true,
                    minlength: 8,
                    equalTo: "#newPassword",
                },
            }
        });
    }
</script>