<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.cloud.app.model.User"%>
<%@page import="com.cloud.app.model.Messages"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<%  User user = (User)request.getSession().getAttribute("currentUser");
			String Nickname = user.getUserNickname();
		%>
        <!-- user dropdown starts -->
        <div class="btn-group pull-right">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs"><%=Nickname%></span>
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
        <%  List<Messages> messages = (List<Messages>)request.getSession().getAttribute("messages");
			Integer counts = messages.size();
		%>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">您有<%=counts%>条消息待处理<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                    <c:if test="${empty sessionScope.messages }">
							<li style="text-align: center">没有待处理信息</li>
					</c:if>
					<c:if test="${!empty sessionScope.messages }">
                    <c:forEach items="${sessionScope.messages }" var="message">
                    <li>
                     <form>
                    <input type="hidden" name="fromId" value="${message.fromId}"> 
                    ${message.fromUser.userNickname}
                    <c:if test="${message.messageType=='1'}">请求添加你为好友</c:if>
                   <c:if test="${message.messageType=='3'}">邀请你加入${message.group.groupName}</c:if>
                   <c:if test="${message.messageType=='5'}">申请加入${message.group.groupName}</c:if>
                    </form> 
                    </li>
                    </c:forEach>
					</c:if>
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
                        <li><a class="ajax-link" href="recycleview"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li class="active"><a class="ajax-link" href="showAllFriends"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
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
                             <form name="OPform" id="OPform"  action="download" method="post">
                            	<input id="friendIds" type="hidden" name="friendIds" value="?">
                           		 </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    添加好友
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">添加好友</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入用户名进行查找：</label>
                                                <form class="form-inline" style="text-align: center">
                                                <input type="text" class="form-control" style="width: 80%">
                                                <button type="button" class="btn btn-primary" id="search">查找</button>
                                                    </form>
                                            </div>
                                            <div style="display: none;width: 100%" id="searchResult">
                                                <label style="margin-left: 7%">搜索结果：</label>
                                                
                                                <div style="margin-left: 7%">
                                                    <img src="images/tou.jpg" style="height: 50px;">
                                                    <span>百度账号：xxx</span>
                                                </div>
                                                <button type="button" class="btn btn-primary"style="margin-left: 45%">加为好友</button>
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
                                <a class="btn btn-default" onclick="chk('deleteFriend')">
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
                                    <th><div class="checkbox"><label><input type="checkbox" id="selectAll" onclick="selectAllOrNot()"></label></div></th>
                                    <th>头像</th>
                                    <th>用户名</th>
                                    
                                </tr>
                                </thead>
                                <tbody>
								<c:forEach items="${requestScope.allFriends }" var="friend">
                                <tr>
                                    <td><div class="checkbox"><label><input type="checkbox" name=friendId value="${friend.userId}"></label></div></td>
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
<script src="js/jquery-2.1.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<script>
  $('#search').click(function(){
      document.getElementById('searchResult').style.display="table";
  });

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
			alert(s);
			document.getElementById('friendIds').value=s;
			document.getElementById('OPform').action=type;
			document.getElementById('OPform').submit();
		} 
	}
  
    function selectAllOrNot(){
        items=document.getElementsByName("friendId");
        itemAll=document.getElementById("selectAll");
        len=items.length;
        for(var i=0;i<len;i++){
            items[i].checked=itemAll.checked;
        }
    }
</script>





</body>
</html>



