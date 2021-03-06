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
                        <li><a class="ajax-link" href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li class="active"><a class="ajax-link" href="shareRecord"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
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
                        <a href=shareRecord>分享</a>
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
                            	<input id="shareMarks" type="hidden" name="shareMarks" value="?">
                            </form>
                            <div class="pull-right" style="margin-top: -0.45%">

                                <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'shareMark')" value="#myModal">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    取消分享
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">是否取消分享？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="Delete('deleteShare','shareMarks','shareMark')">是</button>
                                                <button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">否</button>
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="box-content" >
                            <!-- put your content here -->

                            <table class="table table-striped table-hover table-condensed bootstrap-datatable datatable responsive" id="fileTable">
                                <thead>
                                <tr tabindex="0" >
                                    <th><div class="checkbox"><label><input type="checkbox" onclick="CheckAll(this.checked)" id="0"></label></div></th>
                                    <th>文件名</th>
                                    <th>链接</th>
                                    <th>分享日期</th>
                                </tr >
                                </thead>
                                <tbody>
								<c:forEach items="${requestScope.shareRecord}" var="shareRecord">
                                <tr tabindex="${shareRecord.shareId}" >
                                    <td><div class="checkbox"><label><input type="checkbox" name="shareMark" value="${shareRecord.mark}" id="${shareRecord.shareId}"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i><span class="hidden-sm hidden-xs"> ${shareRecord.fileName}</span></td>
                                    <td><a href="/cloud/s/${shareRecord.mark}">192.168.1.106:8080/cloud/s/${shareRecord.mark}</a></td>
                                    <td><fmt:formatDate value="${shareRecord.shareTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>


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
//弹出确定框(目标弹窗，判获取参数的节点名)
function showYNModal(value,from){
	var obj=document.getElementsByName(from); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}
	if(s==''){
		alert("你还没有选择任何内容!");
	}else{
		$(value).modal('show')
	}
	
}
//删除时的确认性操作(调用方法，传递参数的节点名，获取参数的节点名)
function Delete(type,target,from){ 
	 //选择所有name="from"的对象，返回数组 
	var obj=document.getElementsByName(from); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}  
	
		document.getElementById(target).value=s;
		document.getElementById('OPform').action=type;
		document.getElementById('OPform').submit();
	 
}
function chk(type){ 
	 //选择所有name="'fileId'"的对象，返回数组 
	var obj=document.getElementsByName('shareMark'); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}  
	
	if(s=='') {
	alert('你还没有选择任何内容!'); 
	}else{ 
		document.getElementById('shareMarks').value=s;
		document.getElementById('OPform').action=type;
		document.getElementById('OPform').submit();
	} 
}
function CheckAll(flag)
{
	var obj=document.getElementsByName('shareMark');
    for (var i = 0; i < obj.length ; i++ )
        if (obj[i].type.toLowerCase() == 'checkbox')
        	obj[i].checked = flag;
}
$('#fileTable tr').click(function(){
    var indexNum = this.tabIndex;
    document.getElementById(indexNum).click();
})

</script>

</body>
</html>



