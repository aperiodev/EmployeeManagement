<%@ include file="/common/taglibs.jsp" %>

<style>

    div.error
    {
        color:red;
        position: absolute;
        font-weight: bold;

    }
</style>

<form id="updateForm" action="savefile" method="post" enctype="multipart/form-data">
<div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">PaySlips Upload</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="file"><strong style="color: red">*</strong>Select File (Please select zip files only)</label>
                        <input type="file" name="file" id="file" class="form-control" accept="application/zip" placeholder="Zip Files Only"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <%--<button id="cancel" name="cancel" type="reset" class="btn btn-default">Cancel</button>--%>
            <button id="save" name="save" type="submit" class="btn btn-info pull-left submit">Save</button>
        </div>
    <div class="loading" style="display: none; width: 100%;">
        <b style="color:blue;text-align: center; font-size: x-large;"> Uploading........</b>
    </div>
    </div>
</form>
<script>
    $(function () {
        updateFormValidate();

        var msg=getParameterByName('msg');

        if(msg.length)
        {
            toastr.success(msg);
        }
    });

    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    function updateFormValidate() {
        var updateForm = $("#updateForm");

        updateForm.validate({
            ignore: [],
            rules: {
                file: {
                    required: true/*,
                    extension: "zip"*/
                }
            },
            messages:{
                file: {
                    required: "This field is required!"/*,
                    extension: "Accepts only zip file!"*/
                }
            },
            errorElement: "div",
            submitHandler: function (form) {
                $('#save').prop('disabled', 'disabled');
                $('.loading').show();
                form.submit();
            }
        });

        /*$.validator.addMethod("extension", function(value) {
            return /^[A-Za-z0-9\d=!\-@._*]*$/.test(value) // consists of only these
                && /[A-Z]/.test(value) // has a lowercase letter
                && /\d/.test(value) // has a digit
        });*/
    }
</script>

