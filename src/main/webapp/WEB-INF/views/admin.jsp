<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>  
<!DOCTYPE html >
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

        
        #userTable thead tr th{
            text-align: center;
            vertical-align: middle;

        }
        #userTable tbody tr td{
            text-align: center;
            vertical-align: middle;
        }
        #userTable tbody tr td img{
            margin-left: 45%;
            height: 50px;
        }


    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
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


                        <li class="active"><a href="admin"><i class="glyphicon glyphicon-user"></i><span> 用户</span></a>
                        </li>
                        <li><a href="groupManagement"><i class="glyphicon glyphicon-flag"></i><span> 群组</span></a>
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
                        <a href="#">用户</a>
                    </li>
                </ul>
            </div>

            <div class="row">
                <div class="box col-md-12">
                    <div class="box-inner">
                        <div class="box-header well" data-original-title="">
                            <h2><i class="glyphicon glyphicon-star-empty"></i> 用户</h2>

                            <div class="box-icon">
                                <a href="#" class="btn btn-setting btn-round btn-default"><i
                                        class="glyphicon glyphicon-cog"></i></a>
                                <a href="#" class="btn btn-minimize btn-round btn-default"><i
                                        class="glyphicon glyphicon-chevron-up"></i></a>
                                <a href="#" class="btn btn-close btn-round btn-default"><i
                                        class="glyphicon glyphicon-remove"></i></a>
                            </div>
                              <form name="OPform" id="OPform"  method="post">
                            	<input id="userIds1" type="hidden" name="userIds1" value="?">
                            	<input id="userIds2" type="hidden" name="userIds2" value="?">
                           		 </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    查找用户
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">查找用户</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入用户名进行查找：</label>
                                                <form class="form-inline" style="text-align: center" id="searchUser" method="post" >
                                                    <input type="text" class="form-control" style="width: 80%" name="userForSearch" id="userForSearch">
                                                    <button type="button" class="btn btn-primary" id="search" onclick="searchUser()">查找</button>
                                                </form>
                                            </div>
                                            <div style="display: none;width: 100%" id="searchResult">
                                                
                                            </div>
                                            <div class="modal-footer">

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                 <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'select')" value="#changeModal">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    更改
                                </button>
                                <div class="modal fade" id="changeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel1">是否更改？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="updateVolume('updateVolume', 'userIds1','userIds2', 'select')" >是</button>
                                                <button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">否</button>
                                            </div>
                                            <div class="modal-footer">
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'select')" value="#deleteModal">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除用户
                                </button>
                                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel2">是否删除？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="deleteUser('deleteUser','userIds1','select')">是</button>
                                                <button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">否</button>
                                            </div>
                                            <div class="modal-footer">
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        <div class="box-content" >
                            <!-- put your content here -->
                            <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="userTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox" id="selectAll" onclick="selectAllOrNot()"></label></div></th>
                                    <th>头像</th>
                                    <th>用户名</th>
                                    <th>可用容量</th>
                                </tr>
                                </thead>
                                <tbody id="userTableBody">
                                <c:forEach items="${requestScope.allUsers }" var="user">
                                <tr id="User${user.userId}" onclick="clickTr(this.id)" name="userInfo">
                                    <td><div class="checkbox"><label><input type="checkbox" name="select" value="${user.userId}" id="User${user.userId}C"></label></div></td>
                                    <td><img src="images/tou.jpg" class="img-responsive img-rounded"></td>
                                    <td>${user.userNickname}</td>
                                    <td><input type="number" value="${user.totalVolume}"  id="User${user.userId}A" disabled>GB</td>


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
function searchUser(){
	var url="searchUserAdmin";
	var userNickname = document.getElementById("userForSearch").value;
	var args= {"userNickname":userNickname,"time":new Date()};
	$.getJSON(url,args,function(data){
		var userTbody = $("#userTableBody");
		var userTbodyTr = $("#userTableBody tr");
		userTbodyTr.remove();
		$("#myModal").modal("hide");
		var tr=document.createElement("tr");
		tr.setAttribute("id","User"+data.userId);
		tr.setAttribute("name","userInfo");
		
		tr.onclick=function(){
		    var indexNum = tr.id;
		    document.getElementById(indexNum+"C").click();
		    
		    if(document.getElementById(indexNum+"C").checked){
		        document.getElementById(indexNum+"A").disabled="";
		    }
		    else{
		        document.getElementById(indexNum+"A").disabled="disabled";
		    }
		};
		
		userTbody.append(tr);
		
		var td1=document.createElement("td");
		td1.innerHTML="<div class='checkbox'><label><input type='checkbox' name='select' value='"+ data.userId+"' id='User"+data.userId+"C'></label></div>";
		
		var td2=document.createElement("td");
		td2.innerHTML="<td><img src='images/tou.jpg' class='img-responsive img-rounded'></td>";
		
		var td3=document.createElement("td");
		td3.innerHTML=data.userNickname;
		
		var td4=document.createElement("td");
		td4.innerHTML="<input type='number' value='"+data.totalVolume+"'id='User"+data.userId+"A' disabled>GB";
		
		tr.appendChild(td1);
		tr.appendChild(td2);
		tr.appendChild(td3);
		tr.appendChild(td4);
	});
}
</script>


<script>
    function selectAllOrNot(){
        items=document.getElementsByName("select");
        itemAll=document.getElementById("selectAll");
        len=items.length;
        for(var i=0;i<len;i++){
            items[i].checked=itemAll.checked;
        }
    }
</script>
<script>
	function showYNModal(value,from){
		var obj=document.getElementsByName(from);
		var s="";
		for(var i=0; i<obj.length; i++){ 
		  	if(obj[i].checked) {
		  		s+=obj[i].value+','; //如果选中，将value添加到变量s中
		  	}
		  	}
		  	if(s==''){
		  		alert("你还没有选择任何内容!");
		  	}else{
		  		$(value).modal('show')
		  	
		  	}
	}
</script>




<script>
	function updateVolume(type,target1,target2,from){
		var obj=document.getElementsByName(from); 
	  	var s=''; 
	  	var b='';
	  	for(var i=0; i<obj.length; i++){ 
	  	if(obj[i].checked){
	  		s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	  		var temp=obj[i].value;
	  		b+=document.getElementById("User"+temp+"A").value+',';
	  	}
	  	}  
	  		document.getElementById(target1).value=s;
	  		document.getElementById(target2).value=b;
	  		document.getElementById('OPform').action=type;
	  		document.getElementById('OPform').submit();
	}
</script>
<script type="text/javascript">
      function deleteUser(type,target,from){
    	  var obj=document.getElementsByName(from);
    	  var s='';
    	  for(var i=0;i<obj.length;i++){
    		  if(obj[i].checked){
    			  s+=obj[i].value+','; //如果选中，将value添加到变量s中 
    		  }
    	  }
    	  document.getElementById(target).value=s;
    	  document.getElementById('OPform').action=type;
	  	  document.getElementById('OPform').submit();
      }
</script>
<script type="text/javascript">
function clickTr(thisId){

    var indexNum = thisId;
    document.getElementById(indexNum+"C").click();
    
    if(document.getElementById(indexNum+"C").checked){
        document.getElementById(indexNum+"A").disabled="";
    }
    else{
        document.getElementById(indexNum+"A").disabled="disabled";
    }

}
</script>




</body>
</html>