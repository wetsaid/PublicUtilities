<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>公用事业管理系统 1.0</title>

    <link rel="stylesheet" href="assets/css/style-for-content.css">
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <script type="text/javascript" src="assets/js/chart/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="assets/js/chart/highcharts.js"></script>
</head>
<body>

<div class="content-wrap">
    <div class="row">
        <div class="col-sm-12">
            <div class="nest">
                <div class="body-nest">

                    <div id="chart_news" class="chart_combo"></div>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var chart;

    $(function () {

        $.ajax({
            type: 'POST',
            url: '/publicNews/statistics',
            dataType: 'json',
            data: {},
            success: function (data) {

                setData(data);

            },
            error: function () {
                alert('网络连接错误');
            }
        });

    });

    function setData(data) {

        var sunType = [0, 0, 0, 0, 0, 0];
        var sumMonth = [0, 0, 0];
        $.each(data.types, function (i, type) {
            $.each(type, function (j, n) {
                sunType[i] += n;
                sumMonth[j] += n;
            })
        });

        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart_news' //关联页面元素div#id
            },

            title: { //图表标题
                text: '近三个月内本市事件统计'
            },

            xAxis: { //x轴
                categories: data.xCategories, //X轴类别
                labels: {y: 18}  //x轴标签位置：距X轴下方18像素
            },
            yAxis: { //y轴
                title: {text: '事件（笔）'}, //y轴标题
                lineWidth: 2 //基线宽度
            },
            tooltip: {
                formatter: function () { //格式化鼠标滑向图表数据点时显示的提示框
                    var s;
                    if (this.point.name) { // 饼状图
                        s = '<b>' + this.point.name + '</b>: <br>' + this.y + '笔(' + twoDecimal(this.percentage) + '%)';
                    } else {
                        s = this.y + '笔';
//                        s = '' + this.x + ': ' + this.y + '笔';
                    }
                    return s;
                }
            },
            labels: { //图表标签
                items: [{
                    html: '各类型事件比例',
                    style: {
                        left: '56px',
                        top: '-16px'
                    }
                }]
            },
            exporting: {
                enabled: false  //设置导出按钮不可用
            },
            credits: {
                text: '',
                href: '#'
            },
            series: [ //数据列 TODO
                {
                    type: 'column',
                    name: '市容环境',
                    data: data.types[0]
                },
                {
                    type: 'column',
                    name: '市政公用设施',
                    data: data.types[1]
                },
                {
                    type: 'column',
                    name: '园林绿化',
                    data: data.types[2]
                },
                {
                    type: 'column',
                    name: '街面秩序',
                    data: data.types[3]
                },
                {
                    type: 'column',
                    name: '紧急突发事件',
                    data: data.types[4]
                },
                {
                    type: 'column',
                    name: '其他类型',
                    data: data.types[5]
                },
                {
                    type: 'spline',
                    name: '平均',
                    data: [sumMonth[0] / 6, sumMonth[1] / 6, sumMonth[2] / 6]
                },
                {
                    type: 'pie', //饼状图
                    name: '事件发生总量',
                    data: [
                        {
                            name: '市容环境',
                            y: sunType[0],
                            color: '#4572A7'
                        },
                        {
                            name: '市政公用设施',
                            y: sunType[1],
                            color: '#AA4643'
                        },
                        {
                            name: '园林绿化',
                            y: sunType[2],
                            color: '#89A54E'
                        },
                        {
                            name: '街面秩序',
                            y: sunType[3],
                            color: '#80699B'
                        },
                        {
                            name: '紧急突发事件',
                            y: sunType[4],
                            color: '#3D96AE'
                        },
                        {
                            name: '其他类型',
                            y: sunType[5],
                            color: '#DB843D'
                        }
                    ],
                    center: [100, 60],  //饼状图坐标
                    size: 100,  //饼状图直径大小
                    dataLabels: {
                        enabled: false  //不显示饼状图数据标签
                    }
                }
            ]
        });
    }

    //保留2位小数
    function twoDecimal(x) {
        var f_x = parseFloat(x);
        if (isNaN(f_x)) {
            alert('错误的参数');
            return false;
        }
        var f_x = Math.round(x * 100) / 100;
        var s_x = f_x.toString();
        var pos_decimal = s_x.indexOf('.');
        if (pos_decimal < 0) {
            pos_decimal = s_x.length;
            s_x += '.';
        }
        while (s_x.length <= pos_decimal + 2) {
            s_x += '0';
        }
        return s_x;
    }
</script>

</body>
</html>