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
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>一保七网盘</title>
    <link href="/cloud/css/bootstrap.min.css" rel="stylesheet">
    <link href="/cloud/css/charisma-app.css" rel="stylesheet">

    
</head>

<body >
<!-- 导入导航栏 -->
<%@ include file="navbar.jsp" %>
<!―自适应布局-->
<c:choose>
<c:when test="${fn:length(requestScope.shareRecordDetail)>0}">
<div class="container-fluid">
    <div class="row">
     <div class="col-sm-2 collg-2">
            <div class="sidebar-nav">
                <div class="nav-canvas">
                    <div class="nav-sm nav nav-stacked">

                    </div>
                    <ul class="nav nav-pills nav-stacked main-menu">
                        <li class="nav-header">分享者</li>
                        <li class="active"><i class="glyphicon glyphicon-home"></i><span> ${requestScope.shareRecordDetail.get(0).user.userNickname }</span>
                        
                        </li>

                        <li class="nav-header hidden-md">分享时间</li>

                       
                        <li><i class="glyphicon glyphicon-flag"></i><span> <fmt:formatDate value="${requestScope.shareRecordDetail.get(0).shareTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
        <!―右侧管理控制台-->
        <div class="col-lg-10 col-sm-10">

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
                                <a class="btn btn-default"  onclick="chk('/cloud/download')">
                                    <i class="glyphicon glyphicon-download icon-white"></i>
                                    下载
                                </a>
                                <a class="btn btn-default" onclick="chk('/cloud/saveFile')">
                                    <i class="glyphicon glyphicon-share icon-white"></i>
                                    保存至网盘
                                </a>
                             
                            </div>

                        </div>

                        <div class="box-content" >
                            <!-- put your content here -->

                            <table class="table table-striped table-hover table-condensed bootstrap-datatable datatable responsive" id="fileTable">
                                <thead>
                                <tr tabindex="0">
                                    <th><div class="checkbox"><label><input type="checkbox"  id="0" onclick="CheckAll(this.checked)"></label></div></th>
                                    <th>文件名</th>
                                    <th>大小</th>
                                    <th>修改日期</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.shareRecordDetail}" var="share">
								<tr tabindex="${share.userfile.uploadId}">
									<td><div  class="checkbox"><label ><input type="checkbox"  name="uploadId" value="${share.userfile.uploadId}" id="${share.userfile.uploadId}"></label></div></td>
									 <td><i class="glyphicon glyphicon-file"></i><span class="hidden-sm hidden-xs"> ${share.fileName}</span></td>
                                    <c:choose>
                                    	<c:when test="${share.hdfs.fileSize/1099511627776>1}">
                                    	<td><fmt:formatNumber value="${share.hdfs.fileSize/1099511627776}" type="number" maxFractionDigits="2"/> T</td>
                                    	</c:when>
                                    	<c:when test="${share.hdfs.fileSize/1073741824>1}">
                                    	<td><fmt:formatNumber value="${share.hdfs.fileSize/1073741824}" type="number" maxFractionDigits="2"/> G</td>
                                    	</c:when>
                                    	<c:when test="${share.hdfs.fileSize/1048576>1}">
                                    	<td><fmt:formatNumber value="${share.hdfs.fileSize/1048576}" type="number" maxFractionDigits="2"/> M</td>
                                    	</c:when>
                                    	<c:when test="${share.hdfs.fileSize/1024>1}">
                                    	<td><fmt:formatNumber value="${share.hdfs.fileSize/1024}" type="number" maxFractionDigits="2"/> KB</td>
                                    	</c:when>
                                    	<c:otherwise>
                                    	<td>${share.hdfs.fileSize} B</td>
										</c:otherwise>
                                    </c:choose>
                                    
                                    <td><fmt:formatDate value="${share.userfile.fileLastmodified}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
</c:when>
<c:otherwise>
<div align="center" style="font-size: 24;margin-top: 7%;color: gray;" ><h2>啊哦，你来晚了，分享的文件已经被取消了，下次要早点哟。</h2></div>
</c:otherwise>
</c:choose>
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
$('#fileTable tr').click(function(){
    var indexNum = this.tabIndex;
    document.getElementById(indexNum).click();
})
</script>
</body>
</html>