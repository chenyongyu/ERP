<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:property value="getText('COM.OSFI.WINDOW.TITLE')" /></title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet" href="<%=path%>/css/font-awesome.css">
<link rel="stylesheet" href="<%=path%>/js/select2/select2.css">
<link rel="stylesheet"
	href="<%=path%>/js/datetimepicker/bootstrap-datetimepicker.css">
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<!-- Demo page code -->
<style type="text/css">
#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>
<link href="<%=path%>/img/favicon_32.ico" rel="bookmark"
	type="image/x-icon" />
<link href="<%=path%>/img/favicon_32.ico" rel="icon" type="image/x-icon" />
<link href="<%=path%>/img/favicon_32.ico" rel="shortcut icon"
	type="image/x-icon" />
</head>
<!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
<!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
<!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
<!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<body class="">
	<!--<![endif]-->
	<%@ include file="/pages/common/titleWithNav.jsp"%>
	<%@ include file="/pages/common/sidebarWithNav.jsp"%>

	<div class="content">
		<div class="header">
			<div class="stats">
				<p class="stat">
					<span class="number">53</span>tickets
				</p>
				<p class="stat">
					<span class="number"><s:property value="#session.taskSize"/></span>tasks
				</p>
				<p class="stat">
					<span class="number">15</span>waiting
				</p>
			</div>

			<h1 class="page-title" id="menu2Name">&nbsp;</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href="<%=path%>/home/main.jspa">主页</a> <span class="divider">/</span></li>
			<li>系统公告</li>
		</ul>

		<div class="container-fluid">
			<form id="editForm" class="form-horizontal"
				action="${menu2Id}!save.jspa" method="post">
				<div class="row-fluid">
					
					<div class="well">
						
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane active" id="home">
								<dir class="span3" ></dir>
								<dir class="span6" >
									
										<h1>${notice.title}</h1>
										<br/>
										<p>${notice.content}</p>
								</dir>
								<dir class="span3" ></dir>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/pages/common/footer.jsp"%>
	<script src="<%=path%>/js/bootstrap.js"></script>
	<script src="<%=path%>/js/collapsePulg.js"></script>
	<script src="<%=path%>/js/common.js"></script>
	<script src="<%=path%>/js/jquery-validate.js"></script>
	<script src="<%=path%>/js/datetimepicker/bootstrap-datetimepicker.js"></script>
	<script src="<%=path%>/js/select2/select2.js"></script>
	<script src="<%=path%>/js/select2/select2_locale_zh-CN.js"></script>
	<script
		src="<%=path%>/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>

	<script type="text/javascript">
		$("[rel=tooltip]").tooltip();
		var menuId = '${menuId}';
		var menu2Id = '${menu2Id}';
		var url = $("#" + menuId).attr('url');

		$("#inputroleId").select2();
		$("#inputroleId").val("${userInfo.roleId}").trigger("change");
		$("#inputenterpriseId").select2();
		$("#inputenterpriseId").val("${userInfo.enterpriseId}").trigger(
				"change");
		$("#inputsex").select2();
		$("#inputsex").val("${userInfo.sex}").trigger("change");
		
		$("#inputeducationBackground").select2();
		$("#inputeducationBackground").val("${userInfo.educationBackground}").trigger("change");

		jQuery.validateExtend({
			PassWordVali : {
				onChange : true,
				pattern : /^[A-Za-z0-9]+$/,
				conditional : function(value) {
					password = $("#inputnewPassWord").val();
					password1 = $("#inputnewPassWord1").val();
					return password == password1;
				}
			},
			loginName : {
				onKeyup : false,
				sendForm:true,
				onSubmit : true,
				pattern : /^[A-Za-z0-9]{3,}$/,
				conditional : function(value) {
					var bool=true;
					if(value.length<3)
					{
						return false;	
					}
					$.ajax({
						type: "POST",   //访问WebService使用Post方式请求
						url: menuId + "!validatorUserName.jspa", //调用WebService的地址和方法名称组合 ---- WsURL/方法名
						async:false,
						data: {"loginName":value},  //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到       
						dataType: 'json',   //WebService 会返回Json类型
						traditional: false,	//不要序列化参数
						error: function(err, textStatus){
							//alert("error: " + err + " textStatus: " + textStatus);
						},
						success: function(result) {//回调函数，result，返回值
							if(result.success)
							{
								bool=true;	
							}else
							{
								bool=false;	
							}
						}
					});
					return bool;
				}
			}
		});
	</script>
</body>
</html>