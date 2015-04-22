<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    <!-- The styles -->

    <link href="/cloud/css/charisma-app.css" rel="stylesheet">







    <![endif]-->
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

<body >
<!--下面是顶部导航栏的代码-->
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
                <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs"> admin</span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">Profile</a></li>
                <li class="divider"></li>
                <li><a href="login.html">Logout</a></li>
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

<!―自适应布局-->
<div class="container-fluid">
    <div class="row">
        <!―左侧导航栏-->
        <div class="col-sm-2 collg-2">
            <div class="sidebar-nav">
                <div class="nav-canvas">
                    <div class="nav-sm nav nav-stacked">

                    </div>
                    <ul class="nav nav-pills nav-stacked main-menu">
                        <li class="nav-header">Main</li>
                        <li class="active"><a class="ajax-link" href="/cloud/indexview"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="/cloud/uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="/cloud/shareview"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="/cloud/recycleview"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li><a class="ajax-link" href="../friendsview"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
                        </li>
                        <li><a class="ajax-link" href="#"><i class="glyphicon glyphicon-flag"></i><span> 群组</span></a>
                        </li>

                    </ul>
                </div>
            </div>
        </div>



        <!―右侧管理控制台-->
        <div class="col-lg-10 col-sm-10">

            <div>
                <ul class="breadcrumb">
                    <li>
                        <a href="#">Home</a>
                    </li>
                    <li>
                        <a href="#">主页</a>
                    </li>
                </ul>
            </div>

            <div class="row">
                <div class="box col-md-12">
                    <div class="box-inner">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 文件列表</h2>


                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <a class="btn btn-default" href="file/download" >
                                    <i class="glyphicon glyphicon-download icon-white"></i>
                                    下载
                                </a>
                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    分享
                                </a>
                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除
                                </a>
                            </div>

                        </div>

                        <div class="box-content" >
                            <!-- put your content here -->

                            <table class="table table-striped table-hover table-condensed bootstrap-datatable datatable responsive" id="fileTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox"></label></div></th>
                                    <th>文件名</th>
                                    <th>大小</th>
                                    <th>修改日期</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i><span class="hidden-sm hidden-xs"> java从入门到精通</span></td>
                                    <td >30Mb</td>
                                    <td>2017/08/23</td>


                                </tr>

                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">Andro Christopher</span></td>
                                    <td class="center">1kb</td>
                                    <td class="center">2015/08/23</td>



                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">Jhon Doe</span></td>
                                    <td class="center">5kb</td>
                                    <td class="center">2015/06/01</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">如何和傻逼相处</span></td>
                                    <td class="center">10Mb</td>
                                    <td class="center">2015/06/01</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">哈哈哈</span></td>
                                    <td class="center">11Mb</td>
                                    <td class="center">2015/06/01</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">嘻嘻嘻</span></td>
                                    <td class="center">20Mb</td>
                                    <td class="center">2015/06/01</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">傻逼是怎样炼成的</span></td>
                                    <td class="center">30Mb</td>
                                    <td class="center">2016/03/01</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i><span class="hidden-sm hidden-xs"> java从入门到精通</span></td>
                                    <td >30Mb</td>
                                    <td>2017/08/23</td>


                                </tr>

                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i>
                                        <span class="hidden-sm hidden-xs">Andro Christopher</span></td>
                                    <td class="center">1kb</td>
                                    <td class="center">2015/08/23</td>



                                </tr>


                                </tbody>
                            </table>
                            <ul class="pagination pagination-centered">
                                <li><a href="#">Prev</a></li>
                                <li class="active">
                                    <a href="#">1</a>
                                </li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">Next</a></li>
                            </ul>

                        </div>

                    </div>
                </div>
            </div><!--/row-->




        </div>
    </div>
</div>


<script src="/cloud/js/jquery-2.1.3.min.js"></script>
<script src="/cloud/js/bootstrap.min.js"></script>
<script src="/cloud/js/jquery.cookie.js"></script>






</body>
</html>





