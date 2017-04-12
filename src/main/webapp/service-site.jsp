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
    <!--加载鼠标绘制工具-->
    <script type="text/javascript"
            src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css"/>


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


<div id="allmap" style="width: 100%; height: 100%"></div>


<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>

</body>

<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap"); // 创建地图实例
    var point = new BMap.Point(120.160334, 30.327205); // 创建点坐标
    var options = {
        renderOptions: {
            map: map
        },
        onSearchComplete: function (results) {
//            alert(results.getPoi(0).point);
            //自定义回调函数
        }
    };
    var localSearch = new BMap.LocalSearch(map, options);
    map.addEventListener("load", function () {
        var circle = new BMap.Circle(point, 5000, {
            fillColor: "blue",
            strokeWeight: 1,
            fillOpacity: 0.3,
            strokeOpacity: 0.3
        });
        map.addOverlay(circle);
        localSearch.searchNearby(' ', point, 5000, {
            customData: {
                geotableId: 164910
            }
        });
    });
    map.centerAndZoom(point, 12); // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom();
    map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件


    var drawingManager = new BMapLib.DrawingManager(map, {
        isOpen: false, //是否开启绘制模式
        enableDrawingTool: true, //是否显示工具栏
        drawingToolOptions: {
            anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
            offset: new BMap.Size(5, 5), //偏离值
            scale: 0.8, //工具栏缩放比例
            drawingModes: [
                BMAP_DRAWING_CIRCLE
            ]
        }
    });
    var circle = null;
    drawingManager.addEventListener('circlecomplete', function (e, overlay) {
        map.clearOverlays();
        circle = e;
        map.addOverlay(overlay);
        var radius = parseInt(e.getRadius());
        var center = e.getCenter();
        drawingManager.close();
        localSearch.searchNearby(' ', center, radius, {
            customData: {
                geotableId: 164910
            }
        });
    });

</script>

</html>
