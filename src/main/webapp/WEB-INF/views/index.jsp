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
<!-- 导入导航栏 -->
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
                        <li class="active"><a class="ajax-link" href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
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
                        <a href="index">主页</a>
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
                            	<input id="groupIds" type="hidden" name="groupIds" value="?">
                            </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <a class="btn btn-default"  onclick="chk('download')">
                                    <i class="glyphicon glyphicon-download icon-white"></i>
                                    下载
                                </a>
                                <a class="btn btn-default" onclick="chk('share')">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    分享
                                </a>
                                <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showGroups()" id="showGroups" >
                                    <i class="glyphicon glyphicon-pencil icon-white"></i>
                                    分享至群组
                                </button>
                                <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 5%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel5">所有群</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="groupTable">
                                                    <thead>
                                                    <tr id="groupTabletr" onclick="clickTr(this.id)">
                                                        <th><div class="checkbox"><label><input type="checkbox" id="groupTabletrC" onclick="CheckAll(this.checked,'groupId')"></label></div></th>
                                                        <th>组号</th>
                                  						<th>组名</th>
                                   						<th>主题</th>
                                   						<th>空间</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="groupTableTbody">
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="modal-footer">
												<button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="shareToGroup('shareToGroup')">确定</button>
                                            	<button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">取消</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                            	 <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'uploadId')" value="#myModal">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">是否删除？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="Delete('deleteFile','uploadIds','uploadId')">是</button>
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
                                <tr id="fileTabletr" onclick="clickTr(this.id)">
                                    <th><div class="checkbox"><label><input type="checkbox" onclick="CheckAll(this.checked,'uploadId')" id="fileTabletrC"></label></div></th>
                                    <th>文件名</th>
                                    <th>大小</th>
                                    <th>修改日期</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.userAllFile }" var="file">
								<tr id="File${file.uploadId}" onclick="clickTr(this.id)">
									<td><div  class="checkbox"><label ><input type="checkbox"  name="uploadId" value="${file.uploadId}" id="File${file.uploadId}C" ></label></div></td>
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
									<td><fmt:formatDate value="${file.fileLastmodified}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								</c:forEach>
			
                             

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
	 //选择所有name="uploadId"的对象，返回数组 
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
//首行全选(自身是否被选择，目标节点名)
function CheckAll(flag,which)
{	
	var obj=document.getElementsByName(which);
    for (var i = 0; i < obj.length ; i++ )
        if (obj[i].type.toLowerCase() == 'checkbox')
        	obj[i].checked = flag;
}
//点击行
function clickTr(id){ 
    indexNum=id+"C";
    document.getElementById(indexNum).click();
}
//获得群
function showGroups(){
	var obj=document.getElementsByName("uploadId"); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}
	if(s==''){
		alert("你还没有选择任何内容!");
	}else{
		document.getElementById('uploadIds').value=s;
		//格式化文件大小
		var formatFileSize = function(fileSize){
		if(Number(fileSize)/1099511627776>1){
			fileSize = (Number(fileSize)/1099511627776).toFixed(2)+"T";
		}else if(Number(fileSize)/1073741824>1){
			fileSize = (Number(fileSize)/1073741824).toFixed(2)+"G";
		}else if(Number(fileSize)/1048576>1){
			fileSize = (Number(fileSize)/1048576).toFixed(2)+"M";
		}else if(Number(fileSize)/1024>1){
			fileSize = (Number(fileSize)/1024).toFixed(2)+"KB";
		}else{
			fileSize= fileSize+"B";
		}
		return fileSize;
		}
		
	$("#groupTable tr:not(:first)").remove();
	var url="showGroupAjax";
	var args = {"time":new Date()};
 $.getJSON(url,args,function(data){
			for(var i=0;i<data.length;i++){
				var groupId = data[i].groupId;
				var groupName = data[i].groupName;
				var groupTheme = data[i].groupTheme;
				var existedVolume = data[i].existedVolume;
				var totalVolume = data[i].totalVolume;
				existedVolume = formatFileSize(existedVolume);
				totalVolume = formatFileSize(totalVolume);
				$("#groupTableTbody").append("<tr id='Group"+groupId+"' onclick='clickTr(this.id)'><td><div class='checkbox'><label><input type='checkbox' name='groupId' value='"+groupId+"' id='Group"+groupId+"C'></label></div></td><td>"+groupId+"</td><td>"+groupName+"</td><td>"+groupTheme+"</td><td>"+existedVolume+"/"+totalVolume+"</td></tr>")
			}
	}) 
	$('#myModal4').modal('show')
	}
}
//分享至群(调用方法，传递参数的节点名，获取参数的节点名)
function shareToGroup(type){ 
	 //选择所有name="from"的对象，返回数组 
	var obj=document.getElementsByName("groupId"); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}  
		var url=type;
		var uploads = document.getElementById("uploadIds").value;
		var args={"groupIds":s,"uploadIds":uploads};
		$.getJSON(url,args,function(data){
			var result="";
			for(var i=0;i<data.length;i++){
				result += data[i]+"\n";
				}
			alert(result);
		})
	 	
}
</script>
</body>
</html>