<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
    <meta charset="utf-8">
    <title>公用事业管理系统 1.0</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <script type="text/javascript" src="assets/js/jquery.js"></script>

    <%--<link rel="stylesheet" href="assets/css/style.css">--%>
    <link rel="stylesheet" href="assets/css/style-for-content.css">
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link href="assets/js/iCheck/flat/all.css" rel="stylesheet">

    <link href="assets/js/colorPicker/bootstrap-colorpicker.css" rel="stylesheet">
    <link href="assets/js/switch/bootstrap-switch.css" rel="stylesheet">
    <link href="assets/js/validate/validate.css" rel="stylesheet">
    <link href="assets/js/idealform/css/jquery.idealforms.css" rel="stylesheet">

</head>

<body>

<div class="content-wrap">
    <div class="row">
        <div class="col-sm-12">
            <div class="nest" id="elementClose">

                <div class="body-nest" id="element">
                    <br/>

                    <div class="panel-body">
                        <form method="post" class="form-horizontal bucket-form" id="form-point">

                            <div class="form-group">
                                <label class="col-sm-4 control-label">标题</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="title">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label">地址</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="address">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label">经度</label>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="input-longitude"
                                               name="longitude">
                                        <span class="input-group-addon ">eg.120.160334</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label">纬度</label>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="input-latitude"
                                               name="latitude">
                                        <span class="input-group-addon ">eg.30.327205</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label">坐标类型</label>
                                <div class="col-sm-6">
                                    <div class="skin skin-flat">
                                        <br/>
                                        <ul class="list">
                                            <li>
                                                <input type="radio" id="type-radio-1"
                                                       name="coordType" value="1" checked>
                                                <label for="type-radio-1">GPS经纬度坐标</label>
                                            </li>
                                            <li>
                                                <input type="radio" id="type-radio-2"
                                                       name="coordType" value="2">
                                                <label for="type-radio-2">国测局加密经纬度坐标</label>
                                            </li>
                                            <li>
                                                <input type="radio" id="type-radio-3"
                                                       name="coordType" value="3">
                                                <label for="type-radio-3">百度加密经纬度坐标</label>
                                            </li>
                                            <li>
                                                <input type="radio" id="type-radio-4"
                                                       name="coordType" value="4">
                                                <label for="type-radio-4">百度加密墨卡托坐标</label>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </form>

                        <br/>
                        <div class="form-group">
                            <label class="col-sm-5 control-label"></label>
                            <div class="col-sm-5">
                                <button type="button" class="btn btn-primary" onclick="createPoint()">
                                    <span class="entypo-plus-squared"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加&nbsp;&nbsp;
                                </button>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>
<script type="text/javascript" src="assets/js/inputMask/jquery.maskedinput.js"></script>
<script type="text/javascript" src="assets/js/iCheck/jquery.icheck.js"></script>

<%--单选框--%>
<script type="text/javascript">
    $(document).ready(function () {
        $('.skin-flat input').iCheck({
            checkboxClass: 'icheckbox_flat-red',
            radioClass: 'iradio_flat-red'
        });
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#input-longitude").mask("999.999999", {
            placeholder: "*"
        });
        $("#input-latitude").mask("99.999999", {
            placeholder: "*"
        });
    });
</script>

<%--表单校验--%>
<script type="text/javascript">

    function validate_required(field, alerttxt) {
        with (field) {
            if (value == null || value == "") {
                alert(alerttxt);
                return false
            }
            else {
                return true
            }
        }
    }

    function validate_form(thisform) {
        with (thisform) {
            if (validate_required(title, "标题不能为空！") == false) {
                title.focus();
                return false
            }
            if (validate_required(address, "地址不能为空！") == false) {
                address.focus();
                return false
            }
            if (validate_required(longitude, "经度不能为空！") == false) {
                longitude.focus();
                return false
            }
            if (validate_required(latitude, "纬度不能为空！") == false) {
                latitude.focus();
                return false
            }
            return true
        }
    }
</script>

<script>

    function createPoint() {

        var form = document.getElementById('form-point');

        if (!validate_form(form)) {
            return
        }

        $.ajax({
            type: 'POST',
            url: '/site/createPoint',
            dataType: 'json',
            data: $('#form-point').serializeArray(),
            success: function (data) {
                if (data.success) {
                    alert("添加成功");
                    $('input[type="text"]').val('');
                } else {
                    alert("失败, " + data.reason);
                }
            },
            error: function () {
                alert('网络连接错误');
            }
        });
    }
</script>

</body>

</html>
