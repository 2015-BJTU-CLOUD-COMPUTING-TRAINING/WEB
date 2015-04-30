<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.cloud.app.model.Messages"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    <link href="/cloud/css/charisma-app.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default  navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">一保七网盘</a>
        </div>
		
        <!-- user dropdown starts -->
        
        <div class="btn-group pull-right">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i>
                <span class="hidden-sm hidden-xs">${sessionScope.currentUser.userNickname}</span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="profileview">Profile</a></li>
                <li class="divider"></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
        
        <!-- user dropdown ends -->
        <!-- theme selector starts -->
        <div class="btn-group pull-right theme-container animated tada">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-tint"></i><span
                    class="hidden-sm hidden-xs"> Change Theme / Skin</span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" id="themes">
                <li><a data-value="classic" href="#"><i class="whitespace"></i> Classic</a></li>
                <li><a data-value="cerulean" href="#"><i class="whitespace"></i> Cerulean</a></li>
                <li><a data-value="cyborg" href="#"><i class="whitespace"></i> Cyborg</a></li>
                <li><a data-value="simplex" href="#"><i class="whitespace"></i> Simplex</a></li>
                <li><a data-value="darkly" href="#"><i class="whitespace"></i> Darkly</a></li>
                <li><a data-value="lumen" href="#"><i class="whitespace"></i> Lumen</a></li>
                <li><a data-value="slate" href="#"><i class="whitespace"></i> Slate</a></li>
                <li><a data-value="spacelab" href="#"><i class="whitespace"></i> Spacelab</a></li>
                <li><a data-value="united" href="#"><i class="whitespace"></i> United</a></li>
            </ul>
        </div>
        <!-- theme selector ends -->
      <%  List<Messages> messages = (List<Messages>)request.getSession().getAttribute("messages");
			Integer counts = messages.size();
		%> 
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">您有<%=counts%>条消息待处理<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                    <c:if test="${empty sessionScope.messages }">
							<li style="text-align: center">没有待处理信息</li>
					</c:if>
					<c:if test="${!empty sessionScope.messages }">
                    <c:forEach items="${sessionScope.messages }" var="message">
                    <li>
                     <form>
                    <input type="hidden" name="fromId" value="${message.fromId}"> 
                    <input type="hidden" name="messageId" value="${message.messageId}">
                    ${message.fromUser.userNickname}
                    <c:if test="${message.messageType=='1'}">请求添加你为好友</c:if>
                   <c:if test="${message.messageType=='3'}">邀请你加入${message.group.groupName}
                   </c:if>
                   <c:if test="${message.messageType=='5'}">申请加入${message.group.groupName}</c:if>
                    </form> 
                    </li>
                    </c:forEach>
					</c:if>
                    </ul>
                </li>
                <li><a href="#">帮助</a></li>
            </ul>
        </div>
    </div>
</nav>
<script src="/cloud/js/jquery-2.1.3.min.js"></script>
<script src="/cloud/js/bootstrap.min.js"></script>
<script src="/cloud/js/jquery.cookie.js"></script>
</body>
</html>