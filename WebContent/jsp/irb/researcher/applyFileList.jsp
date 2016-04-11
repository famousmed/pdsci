<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</head>
<script type="text/javascript">
	function saveFile(){
		$("[type='file']").each(function(i){
			var fileTempId = $(this).attr("name").split("file_")[1];
			if ($(this).val().length > 0) {
				$("#file_"+fileTempId).addClass("validate[required]");
				$("#version_"+fileTempId).addClass("validate[required]");
				$("#versionDate_"+fileTempId).addClass("validate[required]");
			}
		});
		
		$('#fileForm').submit();
	}
	
	function delFile(){
		var fileTempIds = $("input[name='fileIds']:enabled[name='fileIds']:checked");
		if(fileTempIds.length==0){
			jboxTip("请选择要删除的记录！");
			return false;
		}
		var requestData = $("#fileForm").serialize();
		jboxConfirm("确认删除所选记录？",function(){
			    var url = "<s:url value='/irb/researcher/delApplyFile'/>"
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						window.location.href="<s:url value='/irb/researcher/applyMain'/>?projFlow="+$("#projFlow").val()+"&irbFlow="+$("#irbFlow").val()+
								"&roleScope="+$("#roleScope").val()+"&operType=${param.operType}&from=view&backType=${backType}";
					}
				},null,true);
		},null);
	}
	
	function changeStyle(obj,flag){
		if ("y" == flag) {
			$(obj).removeClass("edit");
		} else {
			$(obj).addClass("edit");
		}
	}
	
	function changeFile(fileTempId){
		var content = '<input type="file" id="file_'+fileTempId+'" name="file_'+fileTempId+'" class="validate[required]" style="width: 90%;"/>';
		$("#operTd_"+fileTempId).html(content);
	}
</script>
<body>
<div class="mainright">
	<div class="content" >
	<form id="fileForm" style="position: relative;" action="<s:url value="/irb/researcher/saveApplyFile"/>" method="post" enctype="multipart/form-data">
		<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic nofix">
				<tr>
					<th colspan="6" style="text-align: left;">&#12288;送审文件清单
					<span style="float: right;">
						<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || showNotice || 'edit' eq param.operType}">
							<a href="javascript:void(0)" onclick="delFile()">[删除]</a>
						</c:if>
					</span>
					</th>
				</tr>
				<tr>
					<th width="10px"></th>
					<th width="110px" style="text-align: center">文件名</th>
					<th width="40px" style="text-align: center">版本号</th>
					<th width="40px" style="text-align: center">版本日期</th>
					<th width="80px" style="text-align: center">修改意见</th>
					<th width="60px" style="text-align: center">浏览</th>
				</tr>
			<c:if test="${!empty appForm && 'show' != param.type}">
				<tr >
					<td width="10px" style="text-align: center">
						<input type="hidden"  id="application" name="fileTempIds" value="application"/>
						<input type="hidden" name="url_application" value="${appForm.url}">
					</td>
					<td width="110px">
						<span style="width: 15px;">
						<c:if test="${!empty confirmMap[GlobalConstant.FLAG_N]}">
							<img title="已确认" src="<s:url value="/css/skin/${skinPath}/images/gou.gif" />"/>
						</c:if>
						<c:if test="${empty confirmMap[GlobalConstant.FLAG_N]}">&#12288;&nbsp;
						</c:if>
						</span>
						<a href="javascript:void(0)" style="color:red;" onclick="jboxOpen('${appForm.url}','${appForm.fileName}',900,600)" >1、${appForm.fileName}</a><br>
					</td>
					<td width="40px"></td>
					<td width="40px"></td>
					<td width="80px" style="text-align: center;">
						<c:if test="${!empty addMap[GlobalConstant.FLAG_N]}">
							未提交，请补充！
						</c:if>
						<c:if test="${!empty modMap[GlobalConstant.FLAG_N]}">
							${modMap[GlobalConstant.FLAG_N].suggest}
						</c:if>
					</td>
					<td width="60px"></td>	
				</tr>
			</c:if>
			<c:if test="${'show' != param.type }">
			<c:forEach items="${fileList}" var="file" varStatus="status">
				<tr>
					<td width="10px" style="text-align: center">
						<input type="checkbox"  name="fileIds" id="${file.id }" value="${file.id }" 
						<c:if test="${!empty confirmMap[file.id] || empty rMap[file.id]}"> disabled="disabled"</c:if>/>
						<input type="hidden"  name="fileTempIds" value="${file.id }"/>
					</td>
					<td width="110px">
						<span style="width: 15px;">
						<c:if test="${!empty confirmMap[file.id]}">
							<img title="已确认" src="<s:url value="/css/skin/${skinPath}/images/gou.gif" />"/>
						</c:if>
						<c:if test="${empty confirmMap[file.id]}">&#12288;&nbsp;
						</c:if>
						</span>
						<c:if test="${!empty rMap[file.id]}">
							<a  href="${ctxPath}/pub/file/down?fileFlow=${rMap[file.id].fileFlow}"   style="color:red;">
							<c:if test="${!empty appForm }">${status.count+1}</c:if><c:if test="${empty appForm }">${status.count}</c:if>、${file.name }</a>
						</c:if>
						<c:if test="${empty rMap[file.id]}">
							<c:if test="${!empty appForm }">${status.count+1}</c:if><c:if test="${empty appForm }">${status.count}</c:if>、${file.name }
						</c:if>
						<input type="hidden" name="fileName_${file.id }" value="${file.name }">
					</td>
					<td width="40px" style="text-align: center;">
						<c:if test="${file.version==GlobalConstant.FLAG_Y}">
							<c:if test="${empty confirmMap[file.id]}">
								<input type="text" id="version_${file.id }" name="version_${file.id }" value="${empty rMap[file.id]?'':rMap[file.id].version }" class="SelectList inputText" style="width: 90%;text-align: center;">
							</c:if>
							<c:if test="${!empty confirmMap[file.id]}">
								${empty rMap[file.id]?'':rMap[file.id].version }
							</c:if>
						</c:if>
					</td>
					<td width="40px" style="text-align: center;">
						<c:if test="${file.versionDate==GlobalConstant.FLAG_Y}">
							<c:if test="${empty confirmMap[file.id]}">
								<input type="text" id="versionDate_${file.id }" name="versionDate_${file.id }"  value="${empty rMap[file.id]?'':rMap[file.id].versionDate }" class="SelectList inputText" style="width: 90%;text-align: center;" />
							</c:if>
							<c:if test="${!empty confirmMap[file.id]}">
								${empty rMap[file.id]?'':rMap[file.id].versionDate }
							</c:if>
						</c:if>
					</td>
					<td width="80px" style="text-align: center;">
						<c:if test="${!empty addMap[file.id]}">
							未提交，请补充！
						</c:if>
						<c:if test="${!empty modMap[file.id]}">
							${modMap[file.id].suggest}
						</c:if>
						<input type="hidden" name="fileType_${file.id }" value="${file.fileType }">
						<input type="hidden" name="showNotice_${file.id }" value="${file.showNotice }">
					</td>	
					<td width="60px" style="text-align: center;" id="operTd_${file.id}">
						<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || showNotice || 'edit' eq param.operType}">
						<c:choose>
	                       <c:when test="${empty rMap[file.id]  }">
	                         	<input type="file" id="file_${file.id}" name="file_${file.id}" style="width: 90%;"/>
	                       </c:when>
	                       <c:when test="${empty confirmMap[file.id]  }">
	                         	<a href="javascript:void(0)" onclick="changeFile('${file.id}')" >[重新上传]</a>
	                       </c:when>
	                    </c:choose>
	                    </c:if>
					</td>	
				</tr>
			</c:forEach>
			</c:if>
			
			<c:if test="${'show' eq param.type }">
			<c:forEach items="${uploadFiles}" var="file" varStatus="status">
				<tr>
					<td width="10px" style="text-align: center">
					</td>
					<td width="110px">
						<span style="width: 15px;">
						<c:if test="${!empty confirmMap[file.fileTempId]}">
							<img title="已确认" src="<s:url value="/css/skin/${skinPath}/images/gou.gif" />"/>
						</c:if>
						<c:if test="${empty confirmMap[file.fileTempId]}">&#12288;&nbsp;
						</c:if>
						</span>
						<a <c:if test="${empty file.fileFlow}"> href="javascript:void(0)" onclick="jboxOpen('${file.url}','${file.fileName}',900,600)"</c:if>
							<c:if test="${!empty file.fileFlow}"> href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}"</c:if>
						  style="color:red;">
						${status.count}、${empty fileNameMap[file.fileFlow]?file.fileName:fileNameMap[file.fileFlow] }</a>
					</td>
					<td width="40px" style="text-align: center;">
						${file.version }
					</td>
					<td width="40px" style="text-align: center;">
						${file.versionDate }
					</td>
					<td width="80px" style="text-align: center;">
					</td>	
					<td width="60px">
					</td>	
				</tr>
			</c:forEach>
			</c:if>
		</table>
	</div>
	<div class="button">
		<input type="hidden" id="roleScope" name="roleScope" value="${param.roleScope }">
		<input type="hidden" id="operType" name="operType" value="${param.operType }">
		<input type="hidden" id="projFlow" name="projFlow" value="${sessionScope.currIrb.projFlow }">
		<input type="hidden" id="irbFlow" name="irbFlow" value="${sessionScope.currIrb.irbFlow }">
		<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || showNotice || 'edit' eq param.operType}">
			<input class="search" type="button" onclick="saveFile();" value="保&#12288;存"/>
		</c:if>
    </div>
    </form>
	</div></div>
</body>
</html>