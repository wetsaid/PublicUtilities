<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>html5 canvas首屏自适应背景动画循环效果代码</title>

<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/demo.css" />

<!--必要样式-->
<link rel="stylesheet" type="text/css" href="css/component.css" />

<!--[if IE]>
<script src="js/html5.js"></script>
<![endif]-->
</head>
<body>
		<div class="container demo-1">
			<div class="content">
				<div id="large-header" class="large-header">
					<canvas id="demo-canvas"></canvas>
					<h1 class="main-title">公用事业管理系统<span class="thin">v1.0</span></h1>
				</div>
				<!--<nav class="codrops-demos">-->
					<!--<a class="current-demo" href="index1.html">Demo 1</a>-->
					<!--<a href="index2.jsp">Demo 2</a>-->
					<!--<a href="index3.jsp">Demo 3</a>-->
					<!--<a href="index4.jsp">Demo 4</a>-->
				<!--</nav>-->
			</div>
		</div><!-- /container -->
		<script src="js/TweenLite.min.js"></script>
		<script src="js/EasePack.min.js"></script>
		<script src="js/rAF.js"></script>
		<script src="js/demo-1.js"></script>
	</body>
</html>