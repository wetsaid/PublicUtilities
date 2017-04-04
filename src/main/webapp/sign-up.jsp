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
    <script type="text/javascript" src="assets/js/jquery.min.js"></script>

    <!--  <link rel="stylesheet" href="assets/css/style.css"> -->
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/css/signin.css">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Fav and touch icons -->
    <link rel="shortcut icon" href="assets/ico/minus.png">


</head>

<body>

<div class="container">

    <div class="" id="login-wrapper">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div id="logo-login">
                    <h1>公用事业管理系统
                        <span>v1.0</span>
                    </h1>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="account-box">
                    <form id="form-register" role="form">
                        <div class="form-group">
                            <label for="input-code">用户名</label>
                            <input id="input-code" type="text" name="userCode" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="input-pwd">密码</label>
                            <input id="input-pwd" type="password" name="userPwd" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="input-cfm-pwd">确认密码</label>
                            <input id="input-cfm-pwd" type="password" name="userPwd" class="form-control">
                        </div>
                        <div class="pull-left">
                            <p id="p-reason" style="color: #ff3111"></p>
                        </div>
                    </form>
                    <button onclick="register()" class="btn btn btn-primary pull-right">
                        注 册
                    </button>
                    <%--<a class="forgotLnk" href="index.jsp"></a>--%>

                    <div class="or-box">
                        <center>
                            <span class="text-center login-with">
                                <b><a href="sign-in.jsp">登录</a></b> 或 注册
                            </span>
                        </center>
                    </div>

                    <div class="row-block">
                        <div class="row"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <p>&nbsp;</p>
    <div style="text-align:center;margin:0 auto;">
        <h6 style="color:#fff;">Copyright(C)2017 Shijf All Rights Reserved<br/>
            浙江大学城市学院 计算学院 31301179</h6>
    </div>

</div>

<!--  END OF PAPER WRAP -->

<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>

<script type="text/javascript">
    function register() {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/user/register',

            data: {
                userCode: $('#input-code').val(),
                userPwd: $('#input-pwd').val(),
                cfmPwd: $('#input-cfm-pwd').val()
            },
            success: function (data) {
                if (data.success) {
                    window.location.href = 'index';
                }
                else {
                    if (data.reason == '用户名已存在') {
                        $('#input-code').val('');
                    }
                    $('#input-pwd').val('');
                    $('#input-cfm-pwd').val('');
                    $('#p-reason').html(data.reason);
                    $('#p-reason').show('fast');
                }
            },
            beforeSend: function () {
                $('#p-reason').hide();
            }
        });
    }
</script>

</body>

</html>
