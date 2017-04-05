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

    <%--<link rel="stylesheet" href="assets/css/style.css">--%>
    <link rel="stylesheet" href="assets/css/style-for-content.css">
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">


    <%--百度地图--%>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5"></script>
    <script src="http://api.map.baidu.com/api/src/EventWrapper.js"></script>

    <%--实时交通--%>
    <link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript"
            src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>

    <!-- 加载百度地图样式信息窗口 -->
    <script type="text/javascript"
            src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css"/>
</head>

<body>


<div id="trafficMap" style="width: 100%; height: 100%"></div>


<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>

<script type="text/javascript">
    var map = new BMap.Map("trafficMap");

    map.centerAndZoom(new BMap.Point(120.160334, 30.327205), 15);
    map.enableScrollWheelZoom();
    var ctrl = new BMapLib.TrafficControl({
        showPanel: true //是否显示路况提示面板
    });
    map.addControl(ctrl);
    ctrl.showTraffic();
    ctrl.setAnchor(BMAP_ANCHOR_BOTTOM_RIGHT);

</script>

</body>

</html>
