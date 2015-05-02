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
        .box-inner{
            height: 800px;
        }
    </style>
</head>

<body onload="bodyload()" >
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
                        <li class="active"><a class="ajax-link" href="/cloud/uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="shareRecord"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="recycle"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li><a class="ajax-link" href="showAllFriends"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
                        </li>
                        <li><a class="ajax-link" href="groups"><i class="glyphicon glyphicon-flag"></i><span> 群组</span></a>
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
                        <a href="uploadview">上传</a>
                    </li>
                </ul>
            </div>

            <div class="row">
                <div class="box col-md-12">
                    <div class="box-inner">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 上传</h2>

                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                        </div>
                        <div class="box-content" >
                            <!-- put your content here -->
                         <div>
                                <div >
                                	<font color="red"> ${requestScope.errorV }</font>
                                    <form id="uploadform" action="upload" method="POST" enctype="multipart/form-data" >
                                        <div class="form-group">
                                            <label class="sr-only">上传文件</label>
                                            <input id="file" type="file" multiple="true"  name="file" style="display: none">
                                            <div class="input-append" style="text-align: center;margin-top: 200px">
                                                <input id="showInfo" class="input-large"  onclick="$('input[id=file]').click();" type="text" style="height:30px;width: 600px">
                                                <input class="btn btn-success"  onclick="showFile();" type="button" value="上传" >
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div id="fileInfo">
                                <table class="table table-striped" width="100%"><thead><th>文件名称</th><th>文件大小</th><th>文件类型</th><th>文件修改日期</th></thead>
                                <tbody id="test">
                                </tbody></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/row-->
        </div>
    </div>
</div>
<script>
    function bodyload() {
        var info = document.getElementById("fileInfo");
        info.style.display = "none";
    }
</script>
<script>
    $('input[id=file]').change(function(){
        $('#showInfo').val($(this).val());
    });
</script>

<script>
    function showFile() {
    	var existedVolume = document.getElementById("existedVolume").value;
    	var totalVolume = document.getElementById("totalVolume").value;
        var files = document.getElementById("file").files;
        if(files.length>0){
        var tableTitle = '<table class="table table-striped" width="100%"><thead><th>文件名称</th><th>文件大小</th><th>文件类型</th><th>文件修改日期</th></thead><tbody>'
        var info1 = "";
        var totalV=Number(existedVolume);
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var fName = file.name;
            var fSize = file.size + "字节";
            totalV+=file.size;
            var fType = file.type;
            var fDate = file.lastModifiedDate;
            info1 += "<tr><td>" + fName + "</td><td>" + fSize + "</td><td>" + fType + "</td><td>" + fDate + "</td></tr>"
        }
        document.getElementById("test").innerHTML = info1; 
        document.getElementById("fileInfo").style.display = "block";
         if(totalVolume>totalV){
        	document.getElementById("uploadform").submit();
        }else
        	alert("空间不足！");
        
        }else
        	alert("你还没有选择任何文件！");
    }
</script>


</body>
</html>



