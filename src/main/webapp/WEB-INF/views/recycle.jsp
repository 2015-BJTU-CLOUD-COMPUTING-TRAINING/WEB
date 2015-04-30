<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                        <li><a class="ajax-link active" href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="shareRecord"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li class="active"><a class="ajax-link" href="recycle"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li><a class="ajax-link" href="showAllFriends"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
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
                        <a href="recycle">回收站</a>
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
                            <form name="OPform" id="OPform"  action="download" method="post">
                            	<input id="uploadIds" type="hidden" name="uploadIds" value="?">
                            </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <a class="btn btn-default" onclick="chk('restore')" >
                                    <i class="glyphicon glyphicon-refresh icon-white"></i>
                                    还原
                                </a>
                                <a class="btn btn-default" onclick="chk('deleteRecycleFile')">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    彻底删除
                                </a>
                            </div>

                        </div>

                        <div class="box-content" >
                            <!-- put your content here -->

                            <table class="table table-striped table-hover table-condensed bootstrap-datatable datatable responsive" id="fileTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox" onclick="CheckAll(this.checked)"></label></div></th>
                                    <th>文件名</th>
                                    <th>大小</th>
                                    <th>删除时间</th>
                                </tr>
                                </thead>
                                <tbody>
								<c:forEach items="${requestScope.userAllRecycleFile }" var="file">
								<tr>
									<td><div  class="checkbox"><label ><input type="checkbox"  name="uploadId" value="${file.uploadId}"></label></div></td>
									<td>${file.fileName}</td>
									<c:choose>
                                    	<c:when test="${file.hdfs.fileSize/1099511627776>1}">
                                    	<td><fmt:formatNumber value="${file.hdfs.fileSize/1099511627776}" type="number" maxFractionDigits="2"/> T</td>
                                    	</c:when>
                                    	<c:when test="${file.hdfs.fileSize/1073741824>1}">
                                    	<td><fmt:formatNumber value="${file.hdfs.fileSize/1073741824}" type="number" maxFractionDigits="2"/> G</td>
                                    	</c:when>
                                    	<c:when test="${file.hdfs.fileSize/1048576>1}">
                                    	<td><fmt:formatNumber value="${file.hdfs.fileSize/1048576}" type="number" maxFractionDigits="2"/> M</td>
                                    	</c:when>
                                    	<c:when test="${file.hdfs.fileSize/1024>1}">
                                    	<td><fmt:formatNumber value="${file.hdfs.fileSize/1024}" type="number" maxFractionDigits="2"/> KB</td>
                                    	</c:when>
                                    	<c:otherwise>
                                    	<td>${file.hdfs.fileSize} B</td>
										</c:otherwise>
                                    </c:choose>
									<td><fmt:formatDate value="${file.deleteTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								</c:forEach>
                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div><!--/row-->




        </div>
    </div>
</div>
<script type="text/javascript">
function chk(type){ 
	 //选择所有name="'fileId'"的对象，返回数组 
	var obj=document.getElementsByName('uploadId'); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}  
	
	if(s=='') {
	alert('你还没有选择任何内容!'); 
	}else{ 
		document.getElementById('uploadIds').value=s;
		document.getElementById('OPform').action=type;
		document.getElementById('OPform').submit();
	} 
}
function CheckAll(flag)
{
	var obj=document.getElementsByName('uploadId');
    for (var i = 0; i < obj.length ; i++ )
        if (obj[i].type.toLowerCase() == 'checkbox')
        	obj[i].checked = flag;
}

</script>
</body>
</html>



