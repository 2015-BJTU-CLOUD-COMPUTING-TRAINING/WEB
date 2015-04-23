<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>

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
                        <li><a class="ajax-link " href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="shareview"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="recycleview"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li class="active"><a class="ajax-link" href="friendsview"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
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
                        <a href="friendsview">好友</a>
                    </li>
                </ul>
            </div>

            <div class="row">
                <div class="box col-md-12">
                    <div class="box-inner">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 好友</h2>

                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    添加好友
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                            </div>
                                            <div class="modal-body">
                                                .11
                                                1
                                                1
                                                1
                                                1
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    分享
                                </a>
                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除好友
                                </a>
                            </div>
                        </div>
                        <div class="box-content" >
                            <!-- put your content here -->
                            <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="friendTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox"></label></div></th>
                                    <th>头像</th>
                                    <th>用户名</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/tou.jpg" class="img-responsive img-rounded"></td>
                                    <td>历程器</td>


                                </tr>

                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg" class="img-responsive img-rounded"></td>
                                    <td>张三</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg" class="img-responsive img-rounded"></td>
                                    <td>Jhon Doe</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg" class="img-responsive img-rounded"></td>
                                    <td>李四</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg" class="img-responsive img-rounded"></td>
                                    <td>王二麻子</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg"class="img-responsive img-rounded" ></td>
                                    <td>王二小</td>


                                </tr>
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox"></label></div></td>
                                    <td><img src="images/toutou.jpg" class="img-responsive img-rounded"></td>
                                    <td>小婊砸</td>


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



