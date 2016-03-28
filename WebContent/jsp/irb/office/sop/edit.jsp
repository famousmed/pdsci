<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
<script type="text/javascript">
	
	function saveRegulation(){
		if(false==$("#regulationForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/irb/office/saveRegulation'/>";
		var data = $("#regulationForm");
		jboxSubmit(data,url,function(resp){
			window.parent.frames['mainIframe'].location.reload(true);
			doClose();				
		},function(resp){
			alert("error");
		});
	}
	
	function reCheck(obj){
		$(obj).hide();
		$("#down").hide();
		$("#file").show();
	}
	
	function doClose() {
		jboxClose();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	
		<form id="regulationForm" action="<s:url value='/irb/office/saveRegulation'/>" method="POST" enctype="multipart/form-data">
			<table class="basic" style="width: 100%;">
				<%-- <tr>
					<th>制度类型：</th>
					<td>
						<select name="regTypeId" class="xlselect">
							<option value="">请选择</option>
							<c:forEach items="${irbRegulationTypeEnumList}" var="dict">
								<option value="${dict.id}" 
									<c:if test="${regulation.regTypeId eq dict.id}">selected="selected"</c:if>
								 >${dict.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr> --%>
				<tr>
					<th>制度名称：</th>
					<td>
						<input type="hidden" name="regFlow" value="${regulation.regFlow}"/>
						<input type="hidden" name="regTypeId" value="${regulation.regTypeId}"/>
						<input type="text" class="validate[required] xltext" name="regName" value="${regulation.regName}"/>
					</td>
				</tr>
				<tr>
					<th>附件：</th>
					<td>
						<c:choose>
		                  <c:when test="${not empty file.fileName}">
		                  		<a id="down" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a>
								<input type="hidden" name="fileFlow" value="${file.fileFlow}"/>
								<input type="file" id="file" class="validate[required]" name="uploadFile" style="display: none;"/>
								<span style="float: right; padding-right: 10px;">
	                  				<a href="javascript:void(0);" onclick="reCheck(this);">[重新选择文件]</a>
	                  			</span>
		                  </c:when>
		                 <c:otherwise>
		                   		<input type="file" id="file" class="validate[required]" name="uploadFile"/>     
		                 </c:otherwise>
		                </c:choose>
					</td>
				</tr>
				<tr>
					<th>序号：</th>
					<td>
						<input type="text" class="validate[custom[integer]] validate[maxSize[5]] xltext" name="ordinal" value="${regulation.ordinal}"/>
					</td>
				</tr>
			</table>
			
			<p style="text-align: center;">
				<input type="button" class="search" value="保&#12288;存" onclick="saveRegulation();" />
				<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" />
			</p>
		</form>
		
	</div>
	</div>
</div>
</body>
</html>