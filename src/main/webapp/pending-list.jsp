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
    <link rel="stylesheet" href="assets/css/media.css">
    <link rel="stylesheet" href="assets/css/social.css">
    <link href="assets/js/iCheck/line/all.css" rel="stylesheet">

</head>

<body>


<!--CONTENT-->
<div class="row" style="margin-top:30px;padding:0 15px;">

    <div class="col-sm-12">

        <div class="blog-list-nest">
            <div class="vendor">
                <img id="img-name" width="50%" src="">
            </div>
            <div class="blog-list-content">
                <h4 id="news-type"></h4>
                <h5 id="news-description"></h5>
                <div style="clear:both;"></div>
            </div>
        </div>


        <div class="nest">
        </div>

        <div class="comment-nest">
            <h1>审核</h1>
            <div class="well">
                <form role="form">

                    <div class="skin skin-line">
                        <ul class="list">
                            <li>
                                <input type="radio" id="type-radio-1"
                                       name="isPass" value="true" checked>
                                <label for="type-radio-1">通过</label>
                            </li>
                        </ul>
                    </div>
                    <div class="skin skin-line">
                        <ul class="list">
                            <li>
                                <input type="radio" id="type-radio-2"
                                       name="isPass" value="false">
                                <label for="type-radio-2">不通过</label>
                            </li>
                        </ul>
                    </div>

                    <div class="form-group">
                                <textarea name="failReason" id="textarea-fail-reason"
                                          placeholder="不通过请说明原因" rows="5" class="form-update"></textarea>
                    </div>
                    <label class="col-sm-11"></label>
                </form>
                <button class="btn btn-info" onclick="review()">提交</button>
            </div>
        </div>

        <ul class="pager success">
            <li class="previous"><a href="javascript:void(0)" onclick="getPendingList(-1)">上一条</a>
            </li>
            <li class="next"><a href="javascript:void(0)" onclick="getPendingList(1)">下一条</a>
            </li>
        </ul>

    </div>

</div>
<!-- /END OF CONTENT -->


<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>
<script src="assets/js/flatvideo/jquery.fitvids.js"></script>

<script type="text/javascript" src="assets/js/iCheck/jquery.icheck.js"></script>


<script>
    // Basic FitVids Test
    $(".blog-list-nest").fitVids();
    // Custom selector and No-Double-Wrapping Prevention Test
    $(".blog-list-nest").fitVids({
        customSelector: "iframe[src^='http://socialcam.com']"
    });
</script>

<%--单选框--%>
<script type="text/javascript">
    $(document).ready(function () {
        $('.skin-line input').each(function () {
            var self = $(this),
                label = self.next(),
                label_text = label.text();

            label.remove();
            self.iCheck({
                checkboxClass: 'icheckbox_line-blue',
                radioClass: 'iradio_line-blue',
                insert: '<div class="icheck_line-icon"></div>' + label_text
            });
        });
    });
</script>

<%--返回顶部--%>
<script type="text/javascript">

    var timer = null;
    var isTop = true;

    window.onload = function () {

        //滚动条滚动时触发
        window.onscroll = function () {
            //回到顶部过程中用户滚动滚动条，停止定时器
            if (!isTop) {
                clearInterval(timer);
            }
            isTop = false;
        };

    };

    function toTop() {
        //设置定时器
        timer = setInterval(function () {
            //获取滚动条距离顶部高度
            var osTop = document.documentElement.scrollTop || document.body.scrollTop;
            var ispeed = Math.floor(-osTop / 7);

            document.documentElement.scrollTop = document.body.scrollTop = osTop + ispeed;
            //到达顶部，清除定时器
            if (osTop == 0) {
                clearInterval(timer);
            }
            isTop = true;

        }, 30);
    }

</script>

<script>
    $(document).ready(function () {
        getPendingList(0);
    });

    function getPendingList(page) {
        $.ajax({
            type: 'POST',
            url: '/publicNews/pendingList',
            dataType: 'json',
            data: {
                page: page
            },
            success: function (data) {
                if (!data.success) {
                    if (data.size == 0) {
                        alert("没有需要审核的爆料");
                        $('.row').attr('hidden', true);
                    } else {
                        alert(data.reason);
                    }
                    return
                }

                $('.row').attr('hidden', false);

                if (data.news.imgName == null) {
                    $('#img-name').attr('hidden', true);
                } else {
                    $('#img-name').attr('src', data.news.imgName);
                    $('#img-name').attr('hidden', false);
                }
                $('#news-type').html(data.newsType);
                $('#news-description').html(data.news.newsDescription);
                $('#textarea-fail-reason').val('');

                // 回到顶部
                toTop();
            },
            error: function () {
                alert("网络连接错误");
            }
        });
    }

    function review() {
        $.ajax({
            type: 'POST',
            url: '/publicNews/reviewANews',
            dataType: 'json',
            data: {
                isPass: $('input[name="isPass"]:checked').val(),
                failReason: $('textarea[name="failReason"]').val()
            },
            success: function (data) {
                if (data.success) {
                    getPendingList(0);
                } else {
                    alert(data.reason);
                }
            },
            error: function () {
                alert("网络连接错误");
            }
        });
    }
</script>

</body>

</html>
