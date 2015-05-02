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
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- The styles -->

    <link href="css/charisma-app.css" rel="stylesheet">








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
        #groupTable thead tr th{
            text-align: center;
            vertical-align: middle;

        }
        #groupTable tbody tr td{
            text-align: center;
            vertical-align: middle;
        }
        #groupTable tbody tr td img{
            margin-left: 45%;
            height: 50px;
        }


        /*好友列表*/

        #memberTable thead tr th{
            text-align: center;
            vertical-align: middle;

        }
        #memberTable tbody tr td{
            text-align: center;
            vertical-align: middle;
        }
        #memberTable tbody tr td img{
            margin-left: 45%;
            height: 50px;
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
                        <li><a class="ajax-link " href="index"><i class="glyphicon glyphicon-home"></i><span> 首页</span></a>
                        </li>
                        <li><a class="ajax-link" href="uploadview"><i class="glyphicon glyphicon-upload"></i><span> 上传</span></a>
                        </li>
                        <li><a class="ajax-link" href="shareRecord"><i class="glyphicon glyphicon-share"></i><span> 分享</span></a></li>
                        <li><a class="ajax-link" href="recycle"><i class="glyphicon glyphicon-trash"></i><span> 回收站</span></a>
                        </li>

                        <li class="nav-header hidden-md">联系人/组</li>

                        <li><a class="ajax-link" href="showAllFriends"><i class="glyphicon glyphicon-user"></i><span> 好友</span></a>
                        </li>
                        <li class="active"><a  href="groups"><i class="glyphicon glyphicon-flag"></i><span> 群组</span></a>
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
                        <a href="groups">好友</a>
                    </li>
                </ul>
            </div>

            <div class="row">
                <div class="box col-md-12">
                    <div class="box-inner" id="boxContent">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 群组</h2>

                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                            <form name="OPform" id="OPform"  action="?" method="post">
                            		<input id="groupIds" type="hidden" name="groupIds" value="?">
                          		</form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    加入群组
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">添加群组</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入组名进行查找：</label>
                                                <form class="form-inline" style="text-align: center">
                                                    <input type="text" class="form-control" style="width: 80%">
                                                    <button type="button" class="btn btn-primary" id="search">查找</button>
                                                </form>
                                            </div>
                                            <div style="display: none;width: 100%" id="searchResult">
                                                <label style="margin-left: 7%">搜索结果：</label>
                                                <div style="margin-left: 7%">
                                                    <img src="images/tou.jpg" style="height: 50px;">
                                                    <span>群组号：xxx</span>
                                                </div>
                                                <button type="button" class="btn btn-primary"style="margin-left: 45%">加为好友</button>
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal2" >
                                    <i class="glyphicon glyphicon-pencil icon-white"></i>
                                    创建群组
                                </button>
                                <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel2">创建群组</h4>
                                            </div>
                                            <div class="modal-body" >
                                               <form id="creatGroup" class="form-horizontal">
                                                   <div class="form-group">
                                                   <label>请输入组名：</label>
                                                   <input type="text" class="form-control" name="groupName" placeholder="请输入组名">
                                                   </div>
                                                   <button type="button" class="btn btn-primary" >创建</button>
                                               </form>
                                            </div>

                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal6">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    退出群组
                                </button>
                                <div class="modal fade" id="myModal6" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel6">是否退出该群组？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="chk('exitGroup')">是</button>
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
                            <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="groupTable">
                                <thead>
                                <tr tabindex="0">
                                    <th><div class="checkbox"><label><input type="checkbox"  id="0" onclick="CheckAll(this.checked,'groupId')"></label></div></th>
                                    <th>头像</th>
                                    <th>组名</th>
                                </tr>
                                </thead>
                                <tbody>
								<c:forEach items="${requestScope.allGroups }" var="group">
                                <tr tabindex="${group.groupId}">
                                    <td><div class="checkbox"><label><input type="checkbox" name="groupId" value="${group.groupId}" id="${group.groupId}"></label></div></td>
                                    <td><img src="images/tou.jpg" class="img-responsive img-rounded"></td>
                                    <td><a name="groupFile" onclick="showGroupFile()">${group.groupName}</a></td>
								</tr>
								</c:forEach>
                                </tbody>
                            </table>

                        </div>

                    </div>

                    <!--群组文件显示框-->
                    <div class="box-inner" id="boxForGroupFile" style="display: none">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 群文件</h2>

                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal3" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    添加成员
                                </button>
                                <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel1">添加成员</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入用户名进行查找：</label>
                                                <form class="form-inline" style="text-align: center">
                                                    <input type="text" class="form-control" style="width: 80%">
                                                    <button type="button" class="btn btn-primary" id="search2">查找</button>
                                                </form>
                                            </div>
                                            <div style="display: none;width: 100%" id="searchResult2">
                                                <label style="margin-left: 7%">搜索结果：</label>
                                                <div style="margin-left: 7%">
                                                    <img src="images/tou.jpg" style="height: 50px;">
                                                    <span>群组号：xxx</span>
                                                </div>
                                                <button type="button" class="btn btn-primary"style="margin-left: 45%">加入群组</button>
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal4" >
                                    <i class="glyphicon glyphicon-pencil icon-white"></i>
                                    查看群成员
                                </button>
                                <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 5%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel5">群成员</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="memberTable">
                                                    <thead>
                                                    <tr>
                                                        <th><div class="checkbox"><label><input type="checkbox" id="selectAll1" onclick="selectAllOrNot1()"></label></div></th>
                                                        <th>头像</th>
                                                        <th>用户名</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>

                                                    <tr tabindex="11" >
                                                        <td><div class="checkbox"><label><input type="checkbox" name="select1" id="11"></label></div></td>
                                                        <td><img src="images/tou.jpg" class="img-responsive img-rounded"></td>
                                                        <td>历程器</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal5">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除文件
                                </button>
                                <div class="modal fade" id="myModal5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel4">是否删除该文件？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button">是</button>
                                                <button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">否</button>
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <!--框内容-->
                        <div class="box-content">
                            <table class="table table-striped table-hover table-condensed bootstrap-datatable datatable responsive" id="fileTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox" id="selectAll2" onclick="selectAllOrNot2()"></label></div></th>
                                    <th>文件名</th>
                                    <th>大小</th>
                                    <th>修改日期</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr tabindex="21">
                                    <td><div class="checkbox"><label><input type="checkbox" id="21" name="select2"></label></div></td>
                                    <td><i class="glyphicon glyphicon-file"></i><span class="hidden-sm hidden-xs"> java从入门到精通</span></td>
                                    <td >30Mb</td>
                                    <td>2017/08/23</td>
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
<script>
    $('#search').click(function(){
        document.getElementById('searchResult').style.display="table";
    });
</script>
<script>
function CheckAll(flag,which)
{
	var obj=document.getElementsByName(which);
    for (var i = 0; i < obj.length ; i++ )
        if (obj[i].type.toLowerCase() == 'checkbox')
        	obj[i].checked = flag;
}
function chk(type){ 
	 //选择所有name="groupId"的对象，返回数组 
	var obj=document.getElementsByName('groupId'); 
	var s=''; 
	for(var i=0; i<obj.length; i++){ 
	if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	}  
	
	if(s=='') {
	alert('你还没有选择任何内容!'); 
	}else{ 
		document.getElementById('groupIds').value=s;
		document.getElementById('OPform').action=type;
		document.getElementById('OPform').submit();
	} 
}
</script>

<script>
    $('#groupTable tr').click(function(){
        var indexNum = this.tabIndex;
        document.getElementById(indexNum).click();
    })
    $('#memberTable tr').click(function(){
        var indexNum = this.tabIndex;
        document.getElementById(indexNum).click();
    })
    $('#fileTable tr').click(function(){
        var indexNum = this.tabIndex;
        document.getElementById(indexNum).click();
    })


</script>
<script>
    function showGroupFile(){
        document.getElementById("boxContent").style.display="none";
        document.getElementById("boxForGroupFile").style.display="block";
    }
</script>







</body>
</html>



