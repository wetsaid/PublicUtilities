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
    <link rel="stylesheet" href="assets/js/iCheck/line/all.css">


    <%--<link rel="stylesheet" href="file-upload.css">--%>

    <%--<link href="http://www.jq22.com/jquery/bootstrap-3.3.4.css" rel="stylesheet">--%>
    <link href="assets/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <%--<script src="http://www.jq22.com/jquery/1.11.1/jquery.min.js"></script>--%>
    <script src="assets/js/fileinput.js" type="text/javascript"></script>
    <script src="assets/js/locales/fr.js" type="text/javascript"></script>
    <script src="assets/js/locales/es.js" type="text/javascript"></script>
    <script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js" type="text/javascript"></script>

</head>

<body>


<!-- CONTENT -->
<div class="content-wrap">
    <div class="row">


        <div class="col-sm-12">
            <div class="nest">

                <div class="body-nest">
                    <div class="panel-body">
                        <form enctype="multipart/form-data" id="form-news" class="form-horizontal">

                            <div class="form-group">
                                <label class="col-sm-2 control-label">图片</label>
                                <div class="col-sm-8">
                                    <input id="file-0b" class="file" type="file" name="newsImg">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">描述</label>
                                <div class="col-sm-8">
                                    <textarea rows="5" class="form-update" id="textarea-content"
                                              name="newsDescription"
                                              placeholder="请告知问题发生的时间、地址及具体情况，以便我们尽快处理，谢谢配合！（每条不超过200字）"></textarea>
                                    <br/>
                                    <span>还可输入</span>
                                    <span id="span-count">200</span>
                                    <span>字</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">案卷类型</label>
                                <div class="col-sm-4">
                                    <div class="skin skin-line">
                                        <br/>
                                        <ul class="list">
                                            <li>
                                                <input tabindex="11" type="radio" id="type-radio-1"
                                                       name="newsType" value="1">
                                                <label for="type-radio-1">市容环境</label>
                                            </li>
                                            <li>
                                                <input tabindex="12" type="radio" id="type-radio-2"
                                                       name="newsType" value="2">
                                                <label for="type-radio-2">市政公用设施</label>
                                            </li>
                                            <li>
                                                <input tabindex="13" type="radio" id="type-radio-3"
                                                       name="newsType" value="3">
                                                <label for="type-radio-3">园林绿化</label>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="skin skin-line">
                                        <br/>
                                        <ul class="list">
                                            <li>
                                                <input tabindex="14" type="radio" id="type-radio-4"
                                                       name="newsType" value="4">
                                                <label for="type-radio-4">街面秩序</label>
                                            </li>
                                            <li>
                                                <input tabindex="15" type="radio" id="type-radio-5"
                                                       name="newsType" value="5">
                                                <label for="type-radio-5">紧急突发事件</label>
                                            </li>
                                            <li>
                                                <input tabindex="16" type="radio" id="type-radio-6"
                                                       name="newsType" value="6">
                                                <label for="type-radio-6">其他类型</label>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </form>

                        <br/>
                        <div class="form-group">
                            <label class="col-sm-4 control-label"></label>
                            <div class="col-sm-5">
                                <button type="button" class="btn btn-warning" onclick="breakTheNews()">
                                    <span class="icon-warning"></span>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;确认爆料&nbsp;&nbsp;&nbsp;&nbsp;
                                </button>
                            </div>
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

<!-- /MAIN EFFECT -->
<script type="text/javascript" src="assets/js/iCheck/jquery.icheck.js"></script>

<%--剩余可输入字符计数--%>
<script type="text/javascript">

    var maxCount = 200;  // 最高字数
    $("#textarea-content").on('keyup', function () {
        var len = getStrLength(this.value);
        $("#span-count").html(maxCount - len);
    });

    // 中文字符判断
    function getStrLength(str) {
        var len = str.length;
        var reLen = 0;
        for (var i = 0; i < len; i++) {
            if (str.charCodeAt(i) < 27 || str.charCodeAt(i) > 126) {
                // 全角
                reLen += 2;
            } else {
                reLen++;
            }
        }
        return reLen;
    }
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

<%--表单校验--%>
<script type="text/javascript">

    function validate_img(field, alerttxt) {
        with (field) {
            if (value == null || value == "") {
                alert("null");
                return true
            }
            var file_arr = value.toLowerCase().split('.');
            var file_type = file_arr[file_arr.length - 1];
            if (file_type != 'jpg' && file_type != 'jpeg' && file_type != 'png' && file_type != 'bmp') {
                alert(alerttxt);
                return false
            } else {
                return true
            }
        }
    }

    function validate_required(field, alerttxt) {
        with (field) {
            if (value == null || value == "") {
                return false
            } else {
                return true
            }
        }
    }

    function validate_form(thisform) {
        with (thisform) {
            if (validate_img(newsImg, "上传图片格式不正确，请选择jpg, jpeg, png或bmp格式的图片\n\n或不上传图片") == false) {
                newsImg.focus();
                return false
            }
            if (validate_required(newsDescription, "请简单描述一下问题！") == false) {
                newsDescription.focus();
                return false
            }
            if (validate_required(newsType, "请选择一项案卷类型！") == false) {
                newsType.focus();
                return false
            }
            return true
        }
    }
</script>

<script>

    function breakTheNews() {

        var form = document.getElementById('form-news');

        if (!validate_form(form)) {
            return
        }

        $.ajax({
            url: '/publicNews/breakTheNews',
            type: 'POST',
            data: new FormData($('#form-news')[0]),
            dataType: "json",
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert("爆料成功");
                    window.location = 'break-the-news.jsp';
                } else {
                    alert("爆料失败, " + data.reason);
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
