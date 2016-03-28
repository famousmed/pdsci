<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
var form = $('#projForm');
form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
$('#nxt').attr({"disabled":"disabled"});
$('#prev').attr({"disabled":"disabled"});
jboxStartLoading();
form.submit();
}

function addFile(itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
			"&itemGroupName="+itemGroupName+
			"&recFlow="+$('#recFlow').val()+
			"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加附件", 800,500);
}


function del(flow){
	var datas = {
			"pageName":$('#pageName').val(),
			"itemGroupName":$('#itemGroupName').val(),
			"recFlow":$('#recFlow').val(),
			"projFlow":$('#projFlow').val(),
			"itemGroupFlow":flow,
	};
	var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
	jboxPost(url ,datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}


</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px;padding-bottom: 10px;font-weight: bold;color: #333;}
</style>
</head>
<body>
<input type="hidden" id="itemGroupName" value="fileEdit"/>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" id="pageName" name="pageName" value="file"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">六、附件情况</div>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
			<tr>
			    <th colspan="4" class="theader" >项目合同上传<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img  src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('contractEdit');" title="添加附件"></img></a></span> </c:if></th>
			 </tr>
			<tr>
				<td width="35%" style="font-weight:bold;">文件名</td>
				<td width="50%" style="font-weight:bold;">备注</td>
				<!--<td>文件流水号</td>  -->
				<td width="15%" style="font-weight:bold;">操作</td>
			</tr>
			<c:forEach items="${resultMap.contractEdit}" var="file">
				<tr>
					<td>${file.objMap.contractEdit_fileName}</td>
					<td>${file.objMap.contractEdit_fileRemark}</td>
					<!-- <td>${file.objMap.file}</td> -->
					<td>
					[<a href='<s:url value="/pub/file/down?fileFlow=${file.objMap.contractEdit_file}"/>'>下载</a>]
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					[<a href="javascript:del('${file.flow}');">删除</a>]
					</c:if>
					</td>
				</tr>
			</c:forEach>
			 <tr>
			    <th colspan="4" class="theader">项目经费决算表上传<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img  src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('costEdit');" title="添加附件"></img></a></span> </c:if></th>
			 </tr>
			<tr>
				<td style="font-weight:bold;">文件名</td>
				<td style="font-weight:bold;">备注</td>
				<!--<td>文件流水号</td>  -->
				<td style="font-weight:bold;">操作</td>
			</tr>
			<c:forEach items="${resultMap.costEdit}" var="file">
				<tr>
					<td>${file.objMap.costEdit_fileName}</td>
					<td>${file.objMap.costEdit_fileRemark}</td>
					<!-- <td>${file.objMap.file}</td> -->
					<td>
					[<a href="<s:url value="/pub/file/down?fileFlow=${file.objMap.costEdit_file}"/>">下载</a>]
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					[<a href="javascript:del('${file.flow}');">删除</a>]
					</c:if>
					</td>
				</tr>
			</c:forEach>
			 <tr>
			    <th colspan="4" class="theader">总结报告上传<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img  src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('reportEdit');" title="添加附件"></img></a></span> </c:if></th>
			 </tr>
			<tr>
				<td style="font-weight:bold;">文件名</td>
				<td style="font-weight:bold;">备注</td>
				<!--<td>文件流水号</td>  -->
				<td style="font-weight:bold;">操作</td>
			</tr>
			<c:forEach items="${resultMap.reportEdit}" var="file">
				<tr>
					<td>${file.objMap.reportEdit_fileName}</td>
					<td>${file.objMap.reportEdit_fileRemark}</td>
					<!-- <td>${file.objMap.file}</td> -->
					<td>
					[<a href="<s:url value="/pub/file/down?fileFlow=${file.objMap.reportEdit_file}"/>">下载</a>]
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					[<a href="javascript:del('${file.flow}');">删除</a>]
					</c:if>
					</td>
				</tr>
			</c:forEach>
			
			 <tr>
			    <th colspan="4" class="theader">文件上传<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img  src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('fileEdit');" title="添加附件"></img></a></span> </c:if></th>
			 </tr>
			<tr>
				<td style="font-weight:bold;">文件名</td>
				<td style="font-weight:bold;">备注</td>
				<!--<td>文件流水号</td>  -->
				<td style="font-weight:bold;">操作</td>
			</tr>
			<c:forEach items="${resultMap.fileEdit}" var="file">
				<tr>
					<td>${file.objMap.fileEdit_fileName}</td>
					<td>${file.objMap.fileEdit_fileRemark}</td>
					<!-- <td>${file.objMap.file}</td> -->
					<td>
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					[<a href="javascript:del('${file.flow}');">删除</a>]
					</c:if>
					</td>
				</tr>
			</c:forEach>
			 
		</table>
</form>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
 <div class="button" style="width: 100%;">
     <input onclick="nextOpt('step5')" id="prev" class="search" type="button" value="上一步"/>
     <input onclick="nextOpt('finish')" id="nxt"  class="search" type="button" value="完成"/>
</div>
</c:if>
