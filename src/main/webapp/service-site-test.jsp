<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html>--%>

<%--<head>--%>
    <%--<title>公用事业管理系统 1.0</title>--%>

    <%--&lt;%&ndash;百度地图&ndash;%&gt;--%>
    <%--<script src="http://api.map.baidu.com/api?v=2.0&ak=lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5"></script>--%>

    <%--<!-- 加载百度地图样式信息窗口 -->--%>
    <%--<script src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>--%>
    <%--<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css"/>--%>

<%--</head>--%>

<%--<body>--%>

<%--<div id="allmap" style="width: 1000px; height: 500px"></div>--%>

<%--</body>--%>

<%--<script type="text/javascript">--%>
    <%--// 百度地图API功能--%>
    <%--var map = new BMap.Map("allmap"); // 创建地图实例--%>
    <%--var point = new BMap.Point(120.160334, 30.327205); // 创建点坐标--%>
    <%--var options = {--%>
        <%--renderOptions: {--%>
            <%--map: map--%>
        <%--},--%>
        <%--onSearchComplete: function (results) {--%>
            <%--var marker = new BMap.Marker(results.getPoi(1).point);--%>
            <%--new BMapLib.SearchInfoWindow(map, "content", {--%>
                <%--title: "title",      //标题--%>
<%--//                width: 290,             //宽度--%>
<%--//                height : 105,              //高度--%>
                <%--panel: "panel",         //检索结果面板--%>
                <%--enableAutoPan: true,     //自动平移--%>
                <%--searchTypes: [--%>
<%--//                    BMAPLIB_TAB_SEARCH,   //周边检索--%>
                    <%--BMAPLIB_TAB_TO_HERE,  //到这里去--%>
                    <%--BMAPLIB_TAB_FROM_HERE //从这里出发--%>
                <%--]--%>
            <%--}).open(marker);--%>
        <%--}--%>
    <%--};--%>
    <%--var localSearch = new BMap.LocalSearch(map, options);--%>
    <%--map.addEventListener("load", function () {--%>
        <%--var circle = new BMap.Circle(point, 5000, {--%>
            <%--fillColor: "blue",--%>
            <%--strokeWeight: 1,--%>
            <%--fillOpacity: 0.3,--%>
            <%--strokeOpacity: 0.3--%>
        <%--});--%>
        <%--map.addOverlay(circle);--%>
        <%--localSearch.searchNearby('捕鼠', point, 5000, {--%>
            <%--customData: {--%>
                <%--geotableId: 164910--%>
            <%--}--%>
        <%--});--%>
    <%--});--%>
    <%--map.centerAndZoom(point, 12); // 初始化地图，设置中心点坐标和地图级别--%>
    <%--map.enableScrollWheelZoom();--%>
<%--</script>--%>


<%--</html>--%>



<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html{width: 100%;height: 100%;margin:0;
            font-family: "微软雅黑", serif;}
        #allmap {height: 500px;width:100%;overflow: hidden;}
        #result {width:100%;font-size:12px;}
        dl,dt,dd,ul,li{
            margin:0;
            padding:0;
            list-style:none;
        }
        dt{
            font-size:14px;
            font-family: "微软雅黑", serif;
            font-weight:bold;
            border-bottom:1px dotted #000;
            padding:5px 0 5px 5px;
            margin:5px 0;
        }
        dd{
            padding:5px 0 0 5px;
        }
        li{
            line-height:28px;
        }
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=lSgygOFifAH9G7fXOYB7Uap9lqnjcXe5"></script>
    <%--<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>--%>
    <script type="text/javascript" src="test.js"></script>
    <%--<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />--%>
    <link rel="stylesheet" href="test.css" />
    <title>带检索功能的信息窗口</title>
</head>
<body>
<div id="allmap">
</div>
<div id="result">
    <input type="button" value="默认样式" onclick="searchInfoWindow.open(marker);"/>
    <input type="button" value="样式1" onclick="openInfoWindow1()"/>
    <input type="button" value="样式2" onclick="openInfoWindow2()"/>
    <input type="button" value="样式3" onclick="openInfoWindow3()"/>
</div>











<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map('allmap');
    var poi = new BMap.Point(116.307852,40.057031);
    map.centerAndZoom(poi, 16);
    map.enableScrollWheelZoom();

    var content = '<div style="margin:0;line-height:20px;padding:2px;">' +
        '<img src="../img/baidu.jpg" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>' +
        '地址：北京市海淀区上地十街10号<br/>电话：(010)59928888<br/>简介：百度大厦位于北京市海淀区西二旗地铁站附近，为百度公司综合研发及办公总部。' +
        '</div>';

    //创建检索信息窗口对象
    var searchInfoWindow = null;
    searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
        title  : "百度大厦",      //标题
        width  : 290,             //宽度
        height : 105,              //高度
        panel  : "panel",         //检索结果面板
        enableAutoPan : true,     //自动平移
        searchTypes   :[
            BMAPLIB_TAB_SEARCH,   //周边检索
            BMAPLIB_TAB_TO_HERE,  //到这里去
            BMAPLIB_TAB_FROM_HERE //从这里出发
        ]
    });
    var marker = new BMap.Marker(poi); //创建marker对象
    marker.enableDragging(); //marker可拖拽
    marker.addEventListener("click", function(e){
        searchInfoWindow.open(marker);
    })
    map.addOverlay(marker); //在地图中添加marker
    //样式1
    var searchInfoWindow1 = new BMapLib.SearchInfoWindow(map, "信息框1内容", {
        title: "信息框1", //标题
        panel : "panel", //检索结果面板
        enableAutoPan : true, //自动平移
        searchTypes :[
            BMAPLIB_TAB_FROM_HERE, //从这里出发
            BMAPLIB_TAB_SEARCH   //周边检索
        ]
    });
    function openInfoWindow1() {
        searchInfoWindow1.open(new BMap.Point(116.319852,40.057031));
    }
    //样式2
    var searchInfoWindow2 = new BMapLib.SearchInfoWindow(map, "信息框2内容", {
        title: "信息框2", //标题
        panel : "panel", //检索结果面板
        enableAutoPan : true, //自动平移
        searchTypes :[
            BMAPLIB_TAB_SEARCH   //周边检索
        ]
    });
    function openInfoWindow2() {
        searchInfoWindow2.open(new BMap.Point(116.324852,40.057031));
    }
    //样式3
    var searchInfoWindow3 = new BMapLib.SearchInfoWindow(map, "信息框3内容", {
        title: "信息框3", //标题
        width: 290, //宽度
        height: 40, //高度
        panel : "panel", //检索结果面板
        enableAutoPan : true, //自动平移
        searchTypes :[
        ]
    });
    function openInfoWindow3() {
        searchInfoWindow3.open(new BMap.Point(116.328852,40.057031));
    }
</script>
</body>
</html>
