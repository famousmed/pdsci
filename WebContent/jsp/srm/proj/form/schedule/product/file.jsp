<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function nextOpt(step){
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}

function addFile(){
	var url = "?pageName="+$('#pageName').val()+
			"&itemGroupName="+$('#itemGroupName').val()+
			"&recFlow="+$('#recFlow').val()+
			"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加文件", 700,500);
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
	jboxPost(url , datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}
</script>
<input type="hidden" id="itemGroupName" value="fileEdit"/>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	<input type="hidden" id="pageName" name="pageName" value="file"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
	    <tr>
		    <th colspan="4" class="theader">六、附件信息
			    <c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile();"></img></span></c:if>
		    </th>
		</tr>
		<tr>
		    <td style="font-weight: bold;color:#333;width:25%;">文件流水号</td>
			<td style="font-weight: bold;color:#333;">文件名</td>
			<td style="font-weight: bold;color:#333;width:35%;">备注</td>
			<td style="font-weight: bold;color:#333;width:15%;">操作</td>
		</tr>
		<tbody>
		    <c:forEach items="${resultMap.fileEdit}" var="file">
			    <tr>
				    <td>${file.objMap.fileEdit_file}</td>
					<td>${file.objMap.fileEdit_fileName}</td>
					<td>${file.objMap.fileEdit_fileRemark}</td>
					<td>
					[<a href="javascript:del('${file.flow}');">删除</a>]
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form>
<div class="button" style="width: 100%;
    <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input onclick="nextOpt('step5')" id="prev" class="search" type="button" value="上一步"/>
        <input onclick="nextOpt('finish')" id="nxt" class="search" type="button" value="完成"/>
</div>
