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

    <script type="text/javascript">
        function login() {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: '/user/login',

                data: $('#form-login').serializeArray(),
//                data: {
//                    userName: $('#id-name').val(),
//                    userPwd: $('#id-pwd').val()
//                },
                success: function (data) {
                    if (data.success) {
                        window.location = 'index.jsp';
                    }
                    else {
                        if (data.reason == '用户不存在') {
                            $('#input-name').val('');
                        }
                        $('#input-pwd').val('');
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

</head>

<body>
<!-- Preloader -->
<%--<div id="preloader">--%>
    <%--<div id="status">&nbsp;</div>--%>
<%--</div>--%>

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
                    <form id="form-login" role="form">
                        <div class="form-group">
                            <!--a href="#" class="pull-right label-forgot">Forgot email?</a-->
                            <label for="input-name">用户名</label>
                            <input id="input-name" type="text" name="userName" class="form-control">
                        </div>
                        <div class="form-group">
                            <a href="#" class="pull-right label-forgot">Forgot password?</a>
                            <label for="input-pwd">密码</label>
                            <input id="input-pwd" type="password" name="userPwd" class="form-control">
                        </div>
                        <div class="pull-left">
                            <p id="p-reason" style="color: #ff3111"></p>
                        </div>
                        <%--<div class="checkbox pull-left">--%>
                        <%--<label><input type="checkbox">记住用户名</label>--%>
                        <%--</div>--%>
                    </form>
                    <button onclick="login()" class="btn btn btn-primary pull-right">
                        登 录
                    </button>
                    <%--<a class="forgotLnk" href="index.html"></a>--%>
                    <div class="or-box">
                        <center>
                            <span class="text-center login-with">
                                Sign in or <b><a href="sign-up.jsp">Sign Up</a></b>
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
        <h6 style="color:#fff;">Copyright(C)2017 shijf All Rights Reserved<br/>
            浙江大学城市学院 版权所有 浙IP备31301179号</h6>
    </div>

</div>
<div id="test1" class="gmap3"></div>

<!--  END OF PAPER WRAP -->

<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
<script type="text/javascript" src="assets/js/map/gmap3.js"></script>

<%--地图--%>
<script type="text/javascript">
    $(function () {

        $("#test1").gmap3({
            marker: {
                latLng: [30.321351, 120.153778],
                options: {
                    draggable: true
                },
                events: {
                    dragend: function (marker) {
                        $(this).gmap3({
                            getaddress: {
                                latLng: marker.getPosition(),
                                callback: function (results) {
                                    var map = $(this).gmap3("get"),
                                        infowindow = $(this).gmap3({
                                            get: "infowindow"
                                        }),
                                        content = results && results[1] ? results && results[1].formatted_address : "no address";
                                    if (infowindow) {
                                        infowindow.open(map, marker);
                                        infowindow.setContent(content);
                                    } else {
                                        $(this).gmap3({
                                            infowindow: {
                                                anchor: marker,
                                                options: {
                                                    content: content
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        });
                    }
                }
            },
            map: {
                options: {
                    zoom: 15
                }
            }
        });

    });
</script>

</body>

</html>
