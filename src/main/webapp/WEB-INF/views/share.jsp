<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
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
<%@ include file="navbar.jsp" %>

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
                        <li><a class="ajax-link" href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li class="active"><a class="ajax-link" href="shareview"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="recycleview"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li><a class="ajax-link" href="friendsview"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
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
                        <a href="index">Home</a>
                    </li>
                    <li>
                        <a href="shareview">分享</a>
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

                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    取消分享
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
                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div><!--/row-->




        </div>
    </div>
</div>


</body>
</html>



