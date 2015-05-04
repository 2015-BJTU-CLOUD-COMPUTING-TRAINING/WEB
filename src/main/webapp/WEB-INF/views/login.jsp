<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        body{
            margin-top: 50px;
        }
        .carousel{
            margin-bottom: 50px;
        }
        .carousel .item img{
            position: relative;
            width: 100%;
        }
        #loginform{
            position:relative;
            top: -130%;
            width:20.6%;
            height:80%;
            background:white;
            border-radius:3px;
            margin-right: 15.6%;

        }
        .wrap{
            position:relative;
            z-index:0;
            height:600px;
        }
        #loginTitle{
            height:50px;line-height:50px;text-align:center;font-size:30px;
            margin-top: 20px;
        }
        #loginform form div input {
            margin:40px 0;
            height: 45px;
            font-size: 20px;
        }
        #loginform form a{
            margin: 40px 0;
        }



    </style>

</head>
<body>
<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
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
    </div>
</nav>

<div class="wrap">
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="/cloud/images/网盘10.jpg"  alt="1 slide">
                <div class="carousel-caption">
                </div>
            </div>
            <div class="item">
                <img src="/cloud/images/网盘20.jpg" alt="2 slide">
                <div class="carousel-caption">
                </div>
            </div>

            <div class="item">
                <img src="/cloud/images/网盘30.jpg" alt="3 slide">
                <div class="carousel-caption">
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <div class="container" id="loginform"> 
            <div id="loginTitle" >登&nbsp;&nbsp;&nbsp;录</div>
            <form  method="post" action="login">
           
                <div class="form-group">
                
                    <label for="InputUsername" class="sr-only">UserName</label>
                   <font color="red"> ${requestScope.wrong }</font>
                    <input type="text" class="form-control" id="InputUsername" name="userName" placeholder="UserName">
                </div>
                <div class="form-group">
                    <label for="InputPassword" class="sr-only">Password</label>
                    <input type="password" class="form-control" id="InputPassword" name="password" placeholder="Password">
                </div>

                <button type="submit" class="btn btn-success btn-lg btn-block active" role="button">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
                <a href="registview" class="btn btn-success btn-lg btn-block active " role="button">注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;册</a>
            </form>
    </div>
</div>
<script src="/cloud/js/jquery-2.1.3.min.js"></script>
<script src="/cloud/js/bootstrap.min.js"></script>
</body>
</html>