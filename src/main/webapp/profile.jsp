<%@ page import="cn.edu.zucc.shijf.model.TUser" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="cn.edu.zucc.shijf.constant.CardType" %>
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
    <link rel="stylesheet" href="assets/js/validate/validate.css">

    <link rel="stylesheet" href="assets/css/profile.css">

</head>

<body>


<div class="row">
    <div class="col-sm-12">
        <div class="well profile" style="width: 100%;align-content: center">
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-2 text-center">

                    <%--<ul class="list-group">--%>
                    <%--<li class="list-group-item text-left">--%>
                    <%--<span class="entypo-user"></span>&nbsp;&nbsp;个人信息--%>
                    <%--</li>--%>
                    <%--<li class="list-group-item text-center">--%>
                    <%--<img src="http://api.randomuser.me/portraits/men/10.jpg" alt=""--%>
                    <%--class="img-circle img-responsive img-profile">--%>

                    <%--</li>--%>
                    <%--<li class="list-group-item text-center">--%>
                    <%--<span class="pull-left">--%>
                    <%--<strong>Ratings</strong>--%>
                    <%--</span>--%>


                    <%--<div class="ratings">--%>

                    <%--<a href="#">--%>
                    <%--<span class="fa fa-star"></span>--%>
                    <%--</a>--%>
                    <%--<a href="#">--%>
                    <%--<span class="fa fa-star"></span>--%>
                    <%--</a>--%>
                    <%--<a href="#">--%>
                    <%--<span class="fa fa-star"></span>--%>
                    <%--</a>--%>
                    <%--<a href="#">--%>
                    <%--<span class="fa fa-star"></span>--%>
                    <%--</a>--%>
                    <%--<a href="#">--%>
                    <%--<span class="fa fa-star-o"></span>--%>
                    <%--</a>--%>

                    <%--</div>--%>


                    <%--</li>--%>

                    <%--<li class="list-group-item text-right">--%>
                    <%--<span class="pull-left">--%>
                    <%--<strong>Joined</strong>--%>
                    <%--</span>2.13.2014--%>
                    <%--</li>--%>
                    <%--<li class="list-group-item text-right">--%>
                    <%--<span class="pull-left">--%>
                    <%--<strong>Last seen</strong>--%>
                    <%--</span>Yesterday--%>
                    <%--</li>--%>
                    <%--<li class="list-group-item text-right">--%>
                    <%--<span class="pull-left">--%>
                    <%--<strong>Nickname</strong>--%>
                    <%--</span>themesmile--%>
                    <%--</li>--%>

                    <%--</ul>--%>

                </div>
                <div class="col-xs-12 col-sm-8 profile-name" style="width: 65%">
                    <h2>
                        <span class="entypo-user"></span>
                        ${currentUser.userName}
                        <%--<span class="pull-right social-profile">--%>
                        <%--<i class="entypo-facebook-circled"></i>--%>
                        <%--<i class="entypo-twitter-circled"></i>  --%>
                        <%--<i class="entypo-linkedin-circled"></i>--%>
                        <%--<i class="entypo-github-circled"></i>  --%>
                        <%--<i class="entypo-gplus-circled"></i>--%>
                        <%--</span>--%>
                    </h2>
                    <hr>

                    <dl class="dl-horizontal-profile">

                        <dt>手机</dt>
                        <dd>${currentUser.mobileCode}</dd>

                        <dt>Email</dt>
                        <dd>${currentUser.email}</dd>

                        <dt>地址</dt>
                        <dd>${currentUser.address}</dd>

                        <%
                            TUser currentUser = (TUser) session.getAttribute("currentUser");
                            String cardType;
                            if (currentUser.getCardType() == null) {
                                cardType = "";
                            } else {
                                cardType = CardType.getName(currentUser.getCardType());
                            }
//                            int cardType = currentUser.getCardType();
//                            System.out.println(cardType);
//                            int cardType = currentUser.getCardType();
//                            if ()
//                            cardType = CardType.getName(0);
                        %>
                        <dt>证件类型</dt>
                        <dd><%=cardType%>
                        </dd>

                        <dt>证件号码</dt>
                        <dd>${currentUser.cardCode}</dd>

                        <%
                            String createDate = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date(currentUser.getCreateDate()));
                        %>
                        <dt>注册日期</dt>
                        <dd><%=createDate%>
                        </dd>

                        <%--<dt>技能</dt>--%>
                        <%--<dd>--%>
                        <%--<span class="tags">html5</span>--%>
                        <%--<span class="tags">css3</span>--%>
                        <%--<span class="tags">jquery</span>--%>
                        <%--<span class="tags">bootstrap3</span>--%>
                        <%--</dd>--%>

                    </dl>


                    <%--<hr>--%>

                    <%--<h5>--%>
                    <%--<span class="entypo-arrows-ccw"></span>&nbsp;&nbsp;Recent Activities</h5>--%>

                    <%--<div class="table-responsive">--%>
                    <%--<table class="table table-hover table-striped table-condensed">--%>

                    <%--<tbody>--%>
                    <%--<tr>--%>
                    <%--<td><i class="pull-right fa fa-edit"></i> Today, 1:00 - Jeff Manzi liked your post.--%>
                    <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td><i class="pull-right fa fa-edit"></i> Today, 12:23 - Mark Friendo liked and--%>
                    <%--shared your post.--%>
                    <%--</td>--%>
                    <%--</tr>--%>
                    <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<td><i class="pull-right fa fa-edit"></i> Today, 12:20 - You posted a new blog entry&ndash;%&gt;--%>
                    <%--&lt;%&ndash;title "Why social media is".&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<td><i class="pull-right fa fa-edit"></i> Yesterday - Karen P. liked your post.</td>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<td><i class="pull-right fa fa-edit"></i> 2 Days Ago - Philip W. liked your post.&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<td><i class="pull-right fa fa-edit"></i> 2 Days Ago - Jeff Manzi liked your post.&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</tr>&ndash;%&gt;--%>
                    <%--</tbody>--%>

                    <%--</table>--%>
                    <%--</div>--%>

                </div>

            </div>
        </div>
    </div>


    <div class="row">


        <div class="col-sm-12">
            <!-- BLANK PAGE-->

            <div style="margin:-20px 15px;" class="nest" id="Blank_PageClose">
                <div class="title-alt">
                    <h6>
                        编辑</h6>
                    <div class="titleClose">
                        <a class="gone" href="#Blank_PageClose">
                            <span class="entypo-cancel"></span>
                        </a>
                    </div>
                    <div class="titleToggle">
                        <a class="nav-toggle-alt" href="#Blank_Page_Content">
                            <span class="entypo-up-open"></span>
                        </a>
                    </div>

                </div>

                <div class="body-nest" id="Blank_Page_Content">


                    <div class="row">


                        <!-- left column -->
                        <div class="col-md-1">
                            <%--<div class="text-center">--%>
                            <%--<img src="http://placehold.it/150" class="avatar img-circle" alt="avatar">--%>
                            <%--<h6>Upload a different photo...</h6>--%>

                            <%--<div class="input-group">--%>
                            <%--<span class="input-group-btn">--%>
                            <%--<span class="btn btn-primary btn-file">--%>
                            <%--Browse--%>
                            <%--<input type="file" multiple="">--%>
                            <%--</span>--%>
                            <%--</span>--%>
                            <%--<input type="text" class="form-control">--%>
                            <%--</div>--%>

                            <%--</div>--%>
                        </div>

                        <!-- edit form column -->
                        <div class="col-md-9 personal-info">
                            <div class="alert alert-info alert-dismissable">
                                <a class="panel-close close" data-dismiss="alert">×</a>
                                <i class="fa fa-coffee"></i>
                                &nbsp;&nbsp;编辑个人信息，<strong>不填即不修改</strong>
                            </div>
                            <h3>个人信息</h3>

                            <form class="form-horizontal" id="form-profile">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">昵称:</label>
                                    <div class="col-lg-8">
                                        <input class="form-control" name="userName" value="${currentUser.userName}"
                                               type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">手机:</label>
                                    <div class="col-lg-8">
                                        <div class="input-group">
                                            <input class="form-control" name="mobileCode"
                                                   value="${currentUser.mobileCode}"
                                                   type="text" id="input-mobile">
                                            <span class="input-group-addon ">eg.123-4567-8901</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">Email:</label>
                                    <div class="col-lg-8">
                                        <div class="input-group">
                                            <input class="form-control" name="email" value="${currentUser.email}"
                                                   type="text">
                                            <span class="input-group-addon ">eg.name@example.com</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group errMsg" id="emailErr" hidden>
                                    <label class="col-lg-3"></label>
                                    <p id="email-reason" class="col-lg-8" style="color: #ff3111">Email格式不正确</p>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">地址:</label>
                                    <div class="col-lg-8">
                                        <input class="form-control" name="address" value="${currentUser.address}"
                                               type="text">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">证件类型:</label>
                                    <div class="col-lg-8">
                                        <div class="ui-select">
                                            <select id="user_time_zone" class="form-control" name="cardType">
                                                <option value="0"
                                                        <c:if test="${currentUser.cardType == null}">selected</c:if>>请选择
                                                <option value="1"
                                                        <c:if test="${currentUser.cardType == 1}">selected</c:if>>身份证
                                                <option value="2"
                                                        <c:if test="${currentUser.cardType == 2}">selected</c:if>>护照
                                                <option value="3"
                                                        <c:if test="${currentUser.cardType == 3}">selected</c:if>>军人证
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">证件号码:</label>
                                    <div class="col-lg-8">
                                        <input class="form-control" name="cardCode" value="${currentUser.cardCode}"
                                               type="text">
                                    </div>
                                </div>
                                <%--TODO 证件号码格式校验--%>
                                <div class="form-group errMsg" id="cardErr" hidden>
                                    <label class="col-lg-3"></label>
                                    <p id="card-reason" class="col-lg-8" style="color: #ff3111">证件号码格式不正确</p>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">用户名:</label>
                                    <div class="col-md-8">
                                        <input class="form-control" name="userCode" value="${currentUser.userCode}"
                                               type="text" disabled>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">密码:</label>
                                    <div class="col-md-8">
                                        <input class="form-control" name="userPwd" value="" type="password">
                                    </div>
                                </div>
                                <div class="form-group errMsg" id="pwdErr" hidden>
                                    <label class="col-md-3"></label>
                                    <p id="pwd-reason" class="col-md-8" style="color: #ff3111">两次密码不一致</p>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label">确认密码:</label>
                                    <div class="col-md-8">
                                        <input class="form-control" name="cfmPwd" value="" type="password">
                                    </div>
                                </div>
                            </form>
                            <div class="form-group">
                                <label class="col-md-3 control-label"></label>
                                <div class="col-md-8">
                                    <button class="btn btn-primary" onclick="updateProfile()">保存更改</button>
                                    <span></span>
                                    <%--TODO 清空--%>
                                    <input class="btn btn-default" value="取消" type="reset">
                                </div>
                            </div>
                            <%--</form>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END OF BLANK PAGE -->

    </div>
</div>


<!-- MAIN EFFECT -->
<script type="text/javascript" src="assets/js/preloader.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/load.js"></script>
<script type="text/javascript" src="assets/js/main.js"></script>
<script type="text/javascript" src="assets/js/inputMask/jquery.maskedinput.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#input-mobile").mask("999-9999-9999", {
            placeholder: "*"
        });
//        $("input[name='mobileCode']").mask("999-9999-9999", {
//            placeholder: "*"
//        });
    });
</script>

<%--表单验证(email)--%>
<script type="text/javascript">

    function validate_email(field) {
        with (field) {
            if (value == "") {
                return true
            }
            apos = value.indexOf("@");
            dotpos = value.lastIndexOf(".");
            if (apos < 1 || dotpos - apos < 2) {
                $('input[name="email"]').val('');
                $('#emailErr').attr('hidden', false);
                return false
            } else {
                return true
            }
        }
    }

    function validate_form(thisform) {
        with (thisform) {
            if (validate_email(email) == false) {
                email.focus();
                return false
            }
            return true
        }
    }
</script>

<script>
    function updateProfile() {

        // 清除错误提示信息
        $('.errMsg').attr('hidden', true);

        // 校验email
        var form = document.getElementById('form-profile');
        if (!validate_form(form)) {
            return
        }

        // 校验两次密码
        var userPwd = $('input[name="userPwd"]');
        var cfmPwd = $('input[name="cfmPwd"]');
        if (userPwd.val() != '' || cfmPwd.val() != '') {
            if (userPwd.val() != cfmPwd.val()) {
                userPwd.val('');
                cfmPwd.val('');
                $('#pwdErr').attr('hidden', false);
                userPwd.focus();
                return
            }
        }

        $.ajax({
            type: 'POST',
            url: '/user/updateProfile',
            dataType: 'json',
            data: $('#form-profile').serializeArray(),
            success: function (data) {
                alert('成功');
                window.location = 'profile.jsp';
            },
            error: function () {
                alert('网络连接错误');
            }
        });
    }
</script>

</body>

</html>
