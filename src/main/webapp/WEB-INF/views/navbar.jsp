<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.cloud.app.model.User"%>

<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    

    <link href="/cloud/css/charisma-app.css" rel="stylesheet">
 
    <style>
        body {
            padding-top: 50px;
            padding-bottom: 40px;
            color: #5a5a5a;
        }
        .sidebar-nav{
            margin-top: 70px;
        }


       .sidebar-nav div li a{
           height: 60px;
       }
        .sidebar-nav div li a i{
            font-size: 25px;

        }
        .sidebar-nav div li a span{
            font-size: 25px;
        }

        
        #fileTable thead tr th{
            text-align: center;
            vertical-align: middle;

        }
        #fileTable tbody tr td{
            text-align: center;
            vertical-align: middle;
        }


    </style>

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
		<%  User user = (User)request.getSession().getAttribute("currentUser");
			String name = user.getUserName();
		%>
        <!-- user dropdown starts -->
        <div class="btn-group pull-right">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs"><%=name%></span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">Profile</a></li>
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
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">功能<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li class="dropdown-header">功能1</li>
                        <li><a href="#">功能2</a></li>
                        <li><a href="#">功能3</a></li>
                        <li><a href="#">功能4</a></li>
                        <li class="divider"></li>
                        <li class="dropdown-header">系统功能</li>
                        <li><a href="#">设置</a></li>
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