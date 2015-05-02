<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.cloud.app.model.Messages"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 


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
       <c:if test="${!empty sessionScope.currentUser }">
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
        <input type="hidden" id="existedVolume" value="${sessionScope.currentUser.existedVolume}"/>
           <input type="hidden" id="totalVolume" value="${sessionScope.currentUser.totalVolume}"/>
          <div class="btn-group pull-right" >
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown"> 
            
                <span class="hidden-sm hidden-xs">
                					<c:choose>
                                    	<c:when test="${sessionScope.currentUser.existedVolume/1099511627776>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.existedVolume/1099511627776}" type="number" maxFractionDigits="2"/>T</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.existedVolume/1073741824>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.existedVolume/1073741824}" type="number" maxFractionDigits="2"/>G</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.existedVolume/1048576>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.existedVolume/1048576}" type="number" maxFractionDigits="2"/>M</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.existedVolume/1024>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.existedVolume/1024}" type="number" maxFractionDigits="2"/>KB</td>
                                    	</c:when>
                                    	<c:otherwise>
                                    	<td>${sessionScope.currentUser.existedVolume} B</td>
										</c:otherwise>
                                    </c:choose>
                                    /
                					<c:choose>
                                    	<c:when test="${sessionScope.currentUser.totalVolume/1099511627776>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.totalVolume/1099511627776}" type="number" maxFractionDigits="2"/>T</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.totalVolume/1073741824>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.totalVolume/1073741824}" type="number" maxFractionDigits="2"/>G</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.totalVolume/1048576>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.totalVolume/1048576}" type="number" maxFractionDigits="2"/>M</td>
                                    	</c:when>
                                    	<c:when test="${sessionScope.currentUser.totalVolume/1024>1}">
                                    	<td><fmt:formatNumber value="${sessionScope.currentUser.totalVolume/1024}" type="number" maxFractionDigits="2"/>KB</td>
                                    	</c:when>
                                    	<c:otherwise>
                                    	<td>${sessionScope.currentUser.totalVolume} B</td>
										</c:otherwise>
                                    </c:choose>
                </span>
                <span class="caret"></span>
          </button>
            
        </div>
        </c:if>
        <c:if test="${empty sessionScope.currentUser }">
         <div class="btn-group pull-right">
            <a href="/cloud/login">
            <button class="btn btn-default dropdown-toggle" >
               	<span class="hidden-sm hidden-xs">登录</span>
                <span class="caret"></span>
            </button>
            </a>
            <a href="/cloud/registview">
            <button class="btn btn-default dropdown-toggle"  >
               	<span class="hidden-sm hidden-xs">注册</span>
                <span class="caret"></span>
            </button>
           </a>
        </div>
        </c:if>
        
        
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
      
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页</a></li>
                 <c:if test="${!empty sessionScope.currentUser }">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">您有${fn:length(sessionScope.messages)}条消息待处理<span class="caret"></span></a>
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
                </c:if>
                <c:if test="${empty sessionScope.currentUser }">
                </c:if>
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