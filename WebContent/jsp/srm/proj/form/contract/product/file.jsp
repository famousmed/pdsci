<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
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

function addFile(){
	var url = "?pageName="+$('#pageName').val()+
			"&itemGroupName="+$('#itemGroupName').val()+
			"&recFlow="+$('#recFlow').val()+
			"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加附件", 700,500);
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
</head>

<body>
<div id="main">
	<div class="mainright">
		<div class="content">
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
						<input type="hidden" id="pageName" name="pageName" value="file"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
						<input type="hidden" id="itemGroupName" value="fileEdit"/>
						<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
                			<tr>
               					<th colspan="11" class="theader">五、附件信息<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="添加附件" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile();"></img></a></span></c:if></th>
           					</tr>
				            <tr>
				           		<td width="30%" style="font-weight:bold;padding: 0px;">文件名</td>
				                <td style="font-weight:bold;padding: 0px;">备注</td>
				                <!-- <td>文件流水号</td> -->
				                <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
				                <td width="15%">操作</td>
				                </c:if>
				            </tr>
				            <tbody>
				           	<c:forEach items="${resultMap.fileEdit}" var="file">
								<tr>
									<td>&#12288;${file.objMap.fileEdit_fileName}</td>
									<td>${file.objMap.fileEdit_fileRemark}</td>
									<!-- <td>${file.objMap.file}</td> -->
									<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
									<td>
										[<a href="javascript:del('${file.flow}');">删除</a>]
									</td>
									</c:if>
								</tr>
							</c:forEach>
							</tbody>
      					</table>
					 </form>
					 <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
                	 <div class="button" style="width:100%;">
				 		<input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
        	            <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完成"/>
      			     </div>
      			     </c:if>
      			   </div>
			</div>
		</div>
</body>
</body>
</html>