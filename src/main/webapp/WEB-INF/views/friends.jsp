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
        #friendTable thead tr th{
            text-align: center;
            vertical-align: middle;

        }
        #friendTable tbody tr td{
            text-align: center;
            vertical-align: middle;
        }
        #friendTable tbody tr td img{
            margin-left: 45%;
            height: 50px;
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
                        <li><a class="ajax-link " href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="shareRecord"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="recycle"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li class="active"><a class="ajax-link" href="showAllFriends"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
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
                             <form name="OPform" id="OPform"  action="download" method="post">
                            	<input id="friendIds" type="hidden" name="friendIds" value="?">
                           		 </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal3" id="addMemberbtn">
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    添加成员
                                </button>
                                <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel1">添加好友</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入用户名/用户ID进行查找：</label>
                                                <form class="form-inline" style="text-align: center">
                                                    <input type="text" class="form-control" style="width: 80%" id="searchUser">
                                                    <button type="button" class="btn btn-primary" id="searchUserbtn">查找</button>
                                                </form>
                                            </div>
                                             <div style="display: none;width: 100%" id="searchUserResult">
                                                <label style="margin-left: 7%">搜索结果：</label>
                                                <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="searchUserTable">
                                                    <thead id="searchUserTablethead">
                                                    </thead>
                                                    <tbody id="searchUserTableTbody">
                                                    </tbody>
                                                </table>
                                                <button type="button" class="btn btn-primary"style="margin-left: 45%" onclick="inviteFriend()">发送请求</button>
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>
								
                                <a class="btn btn-default" href="#">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    分享
                                </a>
                                	 <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'friendId')" value="#deleteModal">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除好友
                                </button>
                                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">是否删除？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="Delete('deleteFriend','friendIds','friendId')">是</button>
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
                            <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="friendTable">
                                <thead>
                                <tr tabindex="0">
                                    <th><div class="checkbox"><label><input type="checkbox" id="0" onclick="CheckAll(this.checked)"></label></div></th>
                                    <th>用户ID</th>
                                    <th>头像</th>
                                    <th>用户名</th>
                                    
                                </tr>
                                </thead>
                                <tbody>
								<c:forEach items="${requestScope.allFriends }" var="friend">
                                <tr tabindex="${friend.userId}">
                                    <td><div class="checkbox"><label><input type="checkbox" name="friendId" value="${friend.userId}" id="${friend.userId}"></label></div></td>
                                    <td>${friend.userId}</td>
                                    <td><img src="images/tou.jpg" class="img-responsive img-rounded"></td>
                                    <td>${friend.userNickname}</td>
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

<script>
$('#searchUserbtn').click(function(){
 	var userIdOrName=document.getElementById('searchUser').value;
 	var url="searchUser";
 	var args={"userIdOrName":userIdOrName}
 	$.getJSON(url,args,function(data){
 		$("#searchUserTable tr").remove();
 		if(data[0]==null){
 			$("#searchUserTablethead").append("<tr><td>没有找到任何东西</td></tr>")
 		}else{
 			$("#searchUserTablethead").append("<tr id='searchUserTabletr' onclick='clickTr(this.id)'><th><div class='checkbox'><label><input type='checkbox' id='searchUserTabletrC' onclick='ChecksearchUserIdAll(this.checked)'></label></div></th><th>ID</th><th>昵称</th></tr>")
 		for(var i=0;i<data.length;i++){
 			var userId=data[i].userId;
 			var userNickName=data[i].userNickname;
 			$("#searchUserTableTbody").append("<tr id='searchUser"+userId+"' onclick='clickTr(this.id)'><td><div class='checkbox'><label><input type='checkbox' name='searchUserId' value='"+userId+"' id='searchUser"+userId+"C'></label></div></td><td>"+userId+"</td><td>"+userNickName+"</td></tr>")	
 			}
 		}})
     document.getElementById('searchUserResult').style.display="table";
 }); 
//添加好友
function inviteFriend(){
	var obj=document.getElementsByName("searchUserId"); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}
	if(s==''){
		alert("你还没有选择任何内容!");
	}
	else{
		var url="inviteFriend";
		var args={"userIds":s};
		$.getJSON(url,args,function(data){
			var result="";
			for(var i=0;i<data.length;i++){
				result += data[i]+"\n";
				}
			alert(result);
			
		})
		
	}
}
//searchUserId首行全选(自身是否被选择，目标节点名)
function ChecksearchUserIdAll(flag)
{	
	var obj=document.getElementsByName("searchUserId");
    for (var i = 0; i < obj.length ; i++ )
        if (obj[i].type.toLowerCase() == 'checkbox')
        	obj[i].checked = flag;
}
//点击行
function clickTr(id){ 
    indexNum=id+"C";
    document.getElementById(indexNum).click();
}
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
		var obj=document.getElementsByName('friendId'); 
		var s=''; 
		for(var i=0; i<obj.length; i++){ 
		if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
		}  
		
		if(s=='') {
		alert('你还没有选择任何内容!'); 
		}else{ 
			document.getElementById('friendIds').value=s;
			document.getElementById('OPform').action=type;
			document.getElementById('OPform').submit();
		} 
	}
  
  function CheckAll(flag)
  {
  	var obj=document.getElementsByName('friendId');
      for (var i = 0; i < obj.length ; i++ )
          if (obj[i].type.toLowerCase() == 'checkbox')
          	obj[i].checked = flag;
  }
    
    $('#friendTable tr').click(function(){
        var indexNum = this.tabIndex;
        document.getElementById(indexNum).click();
    })

</script>
</body>
</html>