<%@page import="com.cloud.app.model.Group"%>
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


                        <li><a href="admin"><i class="glyphicon glyphicon-user"></i><span> 用户</span></a>
                        </li>
                        <li class="active"><a href="groupManagement"><i class="glyphicon glyphicon-flag"></i><span> 群组</span></a>
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
                              <form name="OPform" id="OPform"   method="post">
                            	<input id="groupIds1" type="hidden" name="groupIds1" value="?">
                            	<input id="groupIds2" type="hidden" name="groupIds2" value="?">
                           		 </form>
                            <div class="pull-right" style="margin-top: -0.45%">
                                <button type="button" class="btn btn-default"  data-toggle="modal" data-target="#myModal" >
                                    <i class="glyphicon glyphicon-plus icon-white"></i>
                                    查找群组
                                </button>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">查找群组</h4>
                                            </div>
                                            <div class="modal-body" >
                                                <label style="margin-left:4.5%">请输入群组名进行查找：</label>
                                                <form class="form-inline" style="text-align: center">
                                                    <input type="text" class="form-control" style="width: 80%" name="groupForSearch" id="groupForSearch">
                                                    <button type="button" class="btn btn-primary" id="search" onclick="searchGroup()">查找</button>
                                                </form>
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
                                                <h4 class="modal-title" id="myModalLabel1">是否删除？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="updateVolume('updateGroupVolume', 'groupIds1','groupIds2','select')" >是</button>
                                                <button class="col-md-2 col-md-offset-2 btn btn-danger" data-dismiss="modal" type="button">否</button>
                                            </div>
                                            <div class="modal-footer">
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                <button type="button" class="btn btn-default"  data-toggle="modal" onclick="showYNModal(this.value,'select')" value="#deleteModal">
                                    <i class="glyphicon glyphicon-trash icon-white"></i>
                                    删除群组
                                </button>
                                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                                    <div class="modal-dialog" style="margin-top: 15%">
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel2">是否删除？</h4>
                                            </div>
                                            <div class="row">
                                                <button class="col-md-2 col-md-offset-3 btn btn-success" data-dismiss="modal" type="button" onclick="deleteGroup('deleteGroup','groupIds1','select')" >是</button>
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
                            <table class="table table-striped table-hover bootstrap-datatable datatable responsive" id="groupTable">
                                <thead>
                                <tr>
                                    <th><div class="checkbox"><label><input type="checkbox" id="selectAll" onclick="selectAllOrNot()"></label></div></th>
                                    <th>组号</th>
                                    <th>组名</th>
                                    <th>群主名</th>
                                    <th>主题</th>
                                    <th>创建时间</th>
                                    <th>可用容量</th>
                                </tr>
                                </thead>
                                <tbody id="groupTableBody">
                                <c:forEach items="${requestScope.allGroups}" var="group">
                                <tr id="Group${group.groupId}">
                                    <td><div class="checkbox"><label><input type="checkbox" name="select" value="${group.groupId}" id="Group${group.groupId}C"></label></div></td>
                                    <td>${group.groupId}</td>
                                    <td>${group.groupName}</td>
                                    <td>${group.groupLeaderNickname}</td>
                                    <td>${group.groupTheme}</td>
                                    <td>${group.groupTimeBuild}</td>
                                    <td><input type="number" value="${group.totalVolume}"  id="Group${group.groupId}A" disabled>GB</td>
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
    $('#groupTable tbody tr').click(function(){

        var indexNum = this.id;
        document.getElementById(indexNum+"C").click();
        if(document.getElementById(indexNum+"C").checked){
            document.getElementById(indexNum+"A").disabled="";
        }
        else{
            document.getElementById(indexNum+"A").disabled="disabled";
        }
    })
</script>
<script type="text/javascript">
      function deleteGroup(type,target,from){
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
<script>
	function updateVolume(type,target1,target2,from){
		var obj=document.getElementsByName(from); 
	  	var s=''; 
	  	var b='';
	  	for(var i=0; i<obj.length; i++){ 
	  	if(obj[i].checked){
	  		s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	  		var temp=obj[i].value;
	  		b+=document.getElementById("Group"+temp+"A").value+',';
	  	}
	  	}  
	  		document.getElementById(target1).value=s;
	  		document.getElementById(target2).value=b;
	  		document.getElementById('OPform').action=type;
	  		document.getElementById('OPform').submit();
	}
</script>

<script type="text/javascript">
function searchGroup(){
	var url="searchGroupAdmin";
	var groupName = document.getElementById("groupForSearch").value;
	var args= {"groupName":groupName,"time":new Date()};
	$.getJSON(url,args,function(data){
		var groupTbody = $("#groupTableBody");
		var groupTbodyTr = $("#groupTableBody tr");
		groupTbodyTr.remove();
		$("#myModal").modal("hide");
		var tr=document.createElement("tr");
		tr.setAttribute("id","Group"+data.groupId);
		
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
		
		groupTbody.append(tr);
		
		var td1=document.createElement("td");
		td1.innerHTML="<div class='checkbox'><label><input type='checkbox' name='select' value='"+ data.groupId+"' id='Group"+data.groupId+"C'></label></div>";
		
		var td2=document.createElement("td");
		td2.innerHTML=data.groupId;
		
		var td3=document.createElement("td");
		td3.innerHTML=data.groupName;
		
		var td4=document.createElement("td");
		td4.innerHTML=data.groupLeaderNickname;
		
		var td5=document.createElement("td");
		td5.innerHTML=data.groupTheme;
		
		var td6=document.createElement("td");
		td6.innerHTML=data.groupTimeBuild;
		
		var td7=document.createElement("td");
		td7.innerHTML="<input type='number' value='"+data.totalVolume+"'id='Group"+data.groupId+"A' disabled>GB";
		
		tr.appendChild(td1);
		tr.appendChild(td2);
		tr.appendChild(td3);
		tr.appendChild(td4);
		tr.appendChild(td5);
		tr.appendChild(td6);
		tr.appendChild(td7);
	});
}
</script>



</body>
</html>