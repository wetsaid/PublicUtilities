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

    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link rel="stylesheet" href="assets/js/button/ladda/ladda.min.css">

    <!-- Fav and touch icons -->
    <link rel="shortcut icon" href="assets/ico/minus.png">
</head>

<body>
<div>
    <!-- TOP NAVBAR -->
    <nav role="navigation" class="navbar navbar-static-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button data-target="#bs-example-navbar-collapse-1" data-toggle="collapse" class="navbar-toggle"
                        type="button">
                    <span class="entypo-menu"></span>
                </button>

                <div id="logo-mobile" class="visible-xs">
                    <h1>公用事业管理系统<span>v1.0</span></h1>
                </div>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div id="bs-example-navbar-collapse-1" class="collapse navbar-collapse">

                <div id="nt-title-container" class="navbar-left running-text visible-lg">
                    <ul class="date-top">
                        <li class="entypo-calendar" style="margin-right:5px"></li>
                        <li id="Date"></li>
                    </ul>

                    <ul id="digital-clock" class="digital">
                        <li class="entypo-clock" style="margin-right:5px"></li>
                        <li class="hour"></li>
                        <li>:</li>
                        <li class="min"></li>
                        <li>:</li>
                        <li class="sec"></li>
                        <li class="meridiem"></li>
                    </ul>

                    <ul id="nt-title">
                        <li><i class="${weatherIcon}"></i>&#160;&#160;&#160;&#160;杭州&#160;
                            <b>${temperature}</b><i class="wi-celcius"></i>&#160;
                        </li>
                        <li><i class="${weatherIcon}"></i>&#160;&#160;&#160;&#160;杭州&#160;
                            <b>${temperature}</b><i class="wi-celcius"></i>&#160;
                        </li>
                    </ul>
                </div>

                <ul style="margin-right:0;" class="nav navbar-nav navbar-right">
                    <li>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            你好，${currentUser.userName}
                            <b class="caret"></b>
                        </a>
                        <ul style="margin-top:14px;" role="menu" class="dropdown-setting dropdown-menu">
                            <li>
                                <a href="profile.jsp" target="CONTENT" id="a-profile">
                                    <span class="entypo-user"></span>&#160;&#160;我的信息</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="/signOut">
                                    <span class="entypo-logout"></span>&#160;&#160;登出</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="icon-gear"></span>&#160;&#160;设置</a>
                        <ul role="menu" class="dropdown-setting dropdown-menu">

                            <li class="theme-bg">
                                <div id="button-bg"></div>
                                <div id="button-bg2"></div>
                                <div id="button-bg3"></div>
                                <div id="button-bg5"></div>
                                <div id="button-bg6"></div>
                                <div id="button-bg7"></div>
                                <div id="button-bg8"></div>
                                <div id="button-bg9"></div>
                                <div id="button-bg10"></div>
                                <div id="button-bg11"></div>
                                <div id="button-bg12"></div>
                                <div id="button-bg13"></div>
                            </li>
                        </ul>
                    </li>
                </ul>

            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <!-- /END OF TOP NAVBAR -->

    <!-- SIDE MENU -->
    <div id="skin-select">
        <div id="logo">
            <h1 style="font-size: 20px">公用事业管理系统<span>v1.0</span></h1>
        </div>

        <a id="toggle">
            <span class="entypo-menu"></span>
        </a>

        <%--搜索菜单--%>
        <div class="dark">
            <form action="#">
    <span>
    <input type="text" name="search" value="" class="search rounded id_search"
           placeholder="搜索目录..." autofocus="">
    </span>
            </form>
        </div>

        <div class="skin-part">
            <div id="tree-wrap">
                <div class="side-bar">
                    <ul class="topnav menu-left-nest">
                        <li>
                            <a class="tooltip-tip ajax-load" href="#" title="便民服务站点录入">
                                <i class="entypo-upload-cloud"></i>
                                <span>便民服务站点录入</span>
                            </a>
                            <ul>
                                <li>
                                    <a class="tooltip-tip2 ajax-load" href="createPoint.jsp" target="CONTENT"
                                       title="单条录入">
                                        <i class="icon-location"></i><span>单条录入</span></a>
                                </li>
                                <li>
                                    <a class="tooltip-tip2 ajax-load" href="multiple-upload.jsp" target="CONTENT"
                                       title="批量录入">
                                        <i class="icon-map"></i><span>批量录入</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="tooltip-tip ajax-load" href="service-site.jsp" target="CONTENT" title="便民服务站点查询">
                                <i class="icon-search"></i>
                                <span>便民服务站点查询</span>
                            </a>
                        </li>
                    </ul>

                    <ul class="topnav menu-left-nest">
                        <li>
                            <a class="tooltip-tip ajax-load" href="pending-list.jsp" target="CONTENT" title="审核爆料">
                                <i class="icon-document-edit"></i>
                                <span>审核爆料</span>

                                <div class="noft-blue" style="display: inline-block; float: none;"></div>
                            </a>
                        </li>
                        <li>
                            <a class="tooltip-tip ajax-load" href="chart.jsp" target="CONTENT" title="统计分析">
                                <i class="icon-graph-bar"></i>
                                <span>统计分析</span>
                            </a>
                        </li>
                    </ul>

                    <ul class="topnav menu-left-nest">
                        <li>
                            <a class="tooltip-tip ajax-load" href="traffic-control.jsp" target="CONTENT" title="实时交通">
                                <i class="icon-direction"></i>
                                <span>实时交通</span>
                            </a>
                        </li>
                    </ul>

                    <%--<ul class="topnav menu-left-nest">--%>
                    <%--<li>--%>
                    <%--<a class="tooltip-tip ajax-load" href="break-the-news.jsp" target="CONTENT" title="我要爆料">--%>
                    <%--<i class="icon-camera"></i>--%>
                    <%--<span>我要爆料</span>--%>
                    <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                    <%--<a class="tooltip-tip ajax-load" href="/myNews" target="CONTENT" title="我的爆料">--%>
                    <%--<i class="icon-view-list-large"></i>--%>
                    <%--<span>我的爆料</span>--%>
                    <%--</a>--%>
                    <%--</li>--%>
                    <%--</ul>--%>

                </div>
            </div>
        </div>
    </div>
    <!-- END OF SIDE MENU -->

    <!--  PAPER WRAP -->
    <div class="wrap-fluid">
        <div class="container-fluid paper-wrap bevel tlbr">

            <!-- CONTENT -->
            <!--TITLE -->
            <div class="row">
                <div id="paper-top">
                    <div class="col-sm-3">
                        <h2 class="tittle-content-header">
                            <i class="icon-heart"></i>
                            <span>欢迎</span>
                        </h2>

                    </div>

                    <div class="col-sm-7">
                        <div class="devider-vertical visible-lg"></div>
                        <div class="tittle-middle-header">
                            <div class="alert">
                                <button type="button" class="close" data-dismiss="alert">×</button>
                                <span class="tittle-alert entypo-info-circled"></span>
                                欢迎回来，
                                <strong>${currentUser.userName}</strong>！&nbsp;&nbsp;&nbsp;&nbsp;您上次登录的时间&nbsp;${lastSignIn}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ TITLE -->

            <!-- BREADCRUMB -->
            <ul id="breadcrumb">
                <li>
                    <a href="/index"><span class="entypo-home"></span></a>
                </li>
                <li><i class="fa fa-lg fa-angle-right"></i></li>
                <li id="li-first">欢迎</li>
                <div id="div-secondary" hidden>
                    <li><i class="fa fa-lg fa-angle-right"></i></li>
                    <li id="li-second"></li>
                </div>
            </ul>
            <!-- END OF BREADCRUMB -->

            <iframe name="CONTENT" src="welcome/welcome.jsp" scrolling="auto" frameborder="0" width="100%"
                    height="71%"></iframe>

        </div>
        <!--  END OF PAPER WRAP -->
    </div>
</div>
<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>

<script>

    $('.ajax-load').click(function () {
//        alert("1");

        var self = $(this);

        if (self.attr('href') == '#') {
            return
        }

        if (self.attr('class').indexOf('tooltip-tip2') != -1) { // 二级目录
            $('#div-secondary').attr('hidden', false);

            var second = self.find('span');
            $('#li-second').html(second.html());

            var first = self.parent().parent().siblings('a').find('span');
            $('#li-first').html(first.html());

        } else {
            $('#div-secondary').attr('hidden', true);

            $('#li-first').html(self.find('span').html());
        }

        $('.tittle-content-header').html(self.find('i').clone());
        $('.tittle-content-header').append('&nbsp;&nbsp;');
        $('.tittle-content-header').append(self.find('span').clone());

    });

    // 我的信息
    $('#a-profile').click(function () {
        $('#div-secondary').attr('hidden', true);
        $('#li-first').html('我的信息');

        $('.tittle-content-header').html($(this).html());
    });

</script>

<script>
    $(function () {
        $.ajax({
            type: 'POST',
            url: '/publicNews/pendingSize',
            dataType: 'json',
            data: {},
            success: function (data) {
                if (data.size == '0') {
                    $('.noft-blue').html(null);
                } else {
                    $('.noft-blue').html('New');
                }
            },
            error: function () {
                alert('网络连接错误')
            }
        });
    })
</script>

</body>

</html>
