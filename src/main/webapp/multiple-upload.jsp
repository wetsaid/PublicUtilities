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

    <link rel="stylesheet" href="assets/css/file-upload.css">
</head>

<body>


<!-- CONTENT -->
<div class="content-wrap">
    <div class="row">


        <div class="col-sm-12">
            <div class="nest" id="basicClose">
                <br/><br/><br/>
                <%--<div class="title-alt">--%>
                    <%--<h6>批量上传数据</h6>--%>
                    <%--<div class="titleClose">--%>
                        <%--<a class="gone" href="#basicClose">--%>
                            <%--<span class="entypo-cancel"></span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                    <%--<div class="titleToggle">--%>
                        <%--<a class="nav-toggle-alt" href="#basic">--%>
                            <%--<span class="entypo-up-open"></span>--%>
                        <%--</a>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <div class="body-nest" id="basic">
                    <div class="form_center">

                        <div class="form-group">
                            <form id="importCsvForm" enctype="multipart/form-data">
                                <label for="input-filename">便民服务站点数据</label><br/>
                                <div class="uploader white">
                                    <input style="color: #777" id="input-filename" type="text" class="filename"
                                           readonly>
                                    <input type="button" name="file" class="button" value="浏览...">
                                    <input id="input-file" type="file" name="csv">
                                </div>
                            </form>
                            <p class="help-block">上传的数据文件格式须为csv</p>
                            <p class="help-block">每次上传的文件大小要小于8M</p>
                            <p class="help-block">csv文件的字段名须与<a href="/downloadTemplate?fileName=data.csv">模板</a>中一致</p>
                            <button type="button" class="btn btn-success" onclick="importConfirm()">
                                <span class="entypo-upload"></span>&nbsp;&nbsp;上传
                            </button>
                        </div>

                    </div>


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
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<script type="text/javascript">
    $(function () {
        $("input[type=file]").change(function () {
            var fileName = $(this).val();
            var inputFileName = $(this).parents(".uploader").find(".filename");
            if (!validateFile(fileName)) {
                alert('请选择csv文件');
                inputFileName.val("请选择数据文件");
                $(this).val(null);
                return
            }
            inputFileName.val(fileName);
        });
        $("input[type=file]").each(function () {
            if ($(this).val() == "") {
                $(this).parents(".uploader").find(".filename").val("请选择数据文件");
            }
        });
    });

    function validateFile(fileName) {
        var fileArr = fileName.toLowerCase().split('.');
        var fileType = fileArr[fileArr.length - 1];
        return fileType == 'csv';
    }
</script>

<script>

    function importConfirm() {
        $.ajax({
            url: '/site/csvImport',
            type: 'POST',
            data: new FormData($('#importCsvForm')[0]),
            dataType: "json",
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert('上传成功');
                } else {
                    alert('失败' + data.reason);
                }
            },
            error: function () {
                alert('网络连接错误');
            }
        });
    }
</script>

</body>

</html>
