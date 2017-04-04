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


<%--<div class="content-wrap">--%>
<%--<div class="row">--%>

<%--<div class="col-sm-12">--%>
<%--<div class="nest">--%>

<%--<div style="padding:0;" class="body-nest">--%>


<div id="allmap" style="width: 100%; height: 100%"></div>


<%--</div>--%>
<%--</div>--%>
<%--</div>--%>


<%--</div>--%>
<%--</div>--%>


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
            //可添加自定义回调函数
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
        localSearch.searchNearby('捕鼠', point, 5000, {
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
        //	circlecomplete
        map.clearOverlays();
        circle = e;
        map.addOverlay(overlay);
        var radius = parseInt(e.getRadius());
        var center = e.getCenter();
        drawingManager.close();
        localSearch.searchNearby('捕鼠', center, radius, {
            customData: {
                geotableId: 164910
            }
        });
    });


    // 步行规划
    //    var walking = new BMap.WalkingRoute(map, {renderOptions:{map: map, autoViewport: true}});
    //    walking.search("浙江大学城市学院南校区", "浙江大学城市学院北校区");
</script>

</html>

<%--<script type="text/javascript">--%>
<%--// 百度地图API功能--%>
<%--var map = new BMap.Map("allmap");          // 创建地图实例--%>
<%--var point = new BMap.Point(120.160334, 30.327205);  // 创建点坐标--%>
<%--map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别--%>
<%--map.enableScrollWheelZoom();--%>
<%--map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件--%>
<%--var customLayer;--%>
<%--function addCustomLayer(keyword) {--%>
<%--if (customLayer) {--%>
<%--map.removeTileLayer(customLayer);--%>
<%--}--%>
<%--customLayer = new BMap.CustomLayer({--%>
<%--geotableId: 164910,--%>
<%--q: '', //检索关键字--%>
<%--tags: '', //空格分隔的多字符串--%>
<%--filter: '' //过滤条件,参考http://developer.baidu.com/map/lbs-geosearch.htm#.search.nearby--%>
<%--});--%>
<%--map.addTileLayer(customLayer);--%>
<%--customLayer.addEventListener('hotspotclick', callback);--%>
<%--}--%>
<%--function callback(e)//单击热点图层--%>
<%--{--%>
<%--var customPoi = e.customPoi;//poi的默认字段--%>
<%--//        var contentPoi = e.content;//poi的自定义字段--%>
<%--//        var content = '<p style="width:280px;margin:0;line-height:20px;">地址：' + customPoi.address + '</p>';--%>
<%--var content = 'test';--%>
<%--var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {--%>
<%--title: customPoi.title, //标题--%>
<%--width: 290, //宽度--%>
<%--height: 40, //高度--%>
<%--panel: "panel", //检索结果面板--%>
<%--enableAutoPan: true, //自动平移--%>
<%--enableSendToPhone: false, //是否显示发送到手机按钮--%>
<%--searchTypes: [--%>
<%--BMAPLIB_TAB_SEARCH,   //周边检索--%>
<%--BMAPLIB_TAB_TO_HERE,  //到这里去--%>
<%--BMAPLIB_TAB_FROM_HERE //从这里出发--%>
<%--]--%>
<%--});--%>
<%--var point = new BMap.Point(customPoi.point.lng, customPoi.point.lat);--%>
<%--searchInfoWindow.open(point);--%>
<%--}--%>

<%--map.addEventListener("load", addCustomLayer());--%>
<%--</script>--%>


