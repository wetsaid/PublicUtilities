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


    <link href="assets/js/footable/css/footable.core.css?v=2-0-1" rel="stylesheet" type="text/css">
    <link href="assets/js/footable/css/footable.standalone.css" rel="stylesheet" type="text/css">
    <link href="assets/js/footable/css/footable-demos.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="assets/js/dataTable/lib/jquery.dataTables/css/DT_bootstrap.css">
    <link rel="stylesheet" href="assets/js/dataTable/css/datatables.responsive.css">


</head>

<body>


<!-- CONTENT -->
<div class="content-wrap">
    <div class="row">
        <div class="col-sm-12">
            <div class="nest">

                <div class="body-nest">
                    <br/>

                    <div class="row" style="margin-bottom:10px;">
                        <div class="col-sm-4">
                            <input class="form-control" id="filter" placeholder="搜索..." type="text">
                        </div>
                        <div class="col-sm-8">
                            <a href="#clear" style="margin-left:10px;"
                               class="pull-right btn btn-info clear-filter" title="clear filter">重置</a>
                        </div>
                    </div>

                    <table id="footable-res2" class="demo" data-filter="#filter" data-filter-text-only="true">
                        <thead>
                        <tr>
                            <th data-toggle="true">
                                案卷类型
                            </th>
                            <th>
                                上报时间
                            </th>
                            <th data-hide="phone,tablet">
                                描述
                            </th>
                            <th data-hide="phone,tablet">
                                审核未通过原因
                            </th>
                            <th>
                                状态
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${myNews}" var="news">
                            <tr>
                                <td>${news.newsType}</td>
                                <td>${news.reportTime}</td>
                                <td>${news.newsDescription}</td>
                                <td>${news.failReason}</td>
                                <td>${news.newsStatus}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${errMsg != null}">
                            <script>
                                alert('你还没有爆过料');
                            </script>
                        </c:if>

                        </tbody>
                    </table>

                </div>

            </div>


        </div>

    </div>
</div>
<!-- /END OF CONTENT -->


<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>


<!-- /MAIN EFFECT -->
<script type="text/javascript" src="assets/js/toggle_close.js"></script>
<script src="assets/js/footable/js/footable.js?v=2-0-1" type="text/javascript"></script>
<script src="assets/js/footable/js/footable.sort.js?v=2-0-1" type="text/javascript"></script>
<script src="assets/js/footable/js/footable.filter.js?v=2-0-1" type="text/javascript"></script>
<script src="assets/js/footable/js/footable.paginate.js?v=2-0-1" type="text/javascript"></script>
<script src="assets/js/footable/js/footable.paginate.js?v=2-0-1" type="text/javascript"></script>

<script type="text/javascript">
    $(function () {
        $('#footable-res2').footable().bind('footable_filtering', function (e) {
            var selected = $('.filter-status').find(':selected').text();
            if (selected && selected.length > 0) {
                e.filter += (e.filter && e.filter.length > 0) ? ' ' + selected : selected;
                e.clear = !e.filter;
            }
        });

        $('.clear-filter').click(function (e) {
            e.preventDefault();
            $('.filter-status').val('');
            $('table.demo').trigger('footable_clear_filter');
        });

        $('.filter-status').change(function (e) {
            e.preventDefault();
            $('table.demo').trigger('footable_filter', {
                filter: $('#filter').val()
            });
        });

        $('.filter-api').click(function (e) {
            e.preventDefault();

            //get the footable filter object
            var footableFilter = $('table').data('footable-filter');

            alert('about to filter table by "tech"');
            //filter by 'tech'
            footableFilter.filter('tech');

            //clear the filter
            if (confirm('clear filter now?')) {
                footableFilter.clearFilter();
            }
        });
    });
</script>

</body>

</html>
