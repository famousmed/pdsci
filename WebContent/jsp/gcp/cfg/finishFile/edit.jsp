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
<script type="text/javascript">
	function save(){
		if(false==$("#fileForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/gcp/cfg/saveFinishFile'/>";
		var requestData = $("#fileForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.search();
				jboxClose();
			}
		},null,true);
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
	<form id="fileForm"  method="post" >
		<table class="basic" width="100%" style="margin-top: 5px;"> 
			<tr>
				<th>文 件 名：</th>
				<td>
					<input type="hidden" name="stage"
						<c:if test="${empty file.stage}">value="${param.stage}"</c:if>
						<c:if test="${file.stage}">value="${file.stage}"</c:if>  >
			 		<input type="hidden" name="id" value="${file.id}">
			 		
					<input type="text" name="fileName" class="validate[required] xltext" value="${file.fileName}" style="width: 90%">
				</td>
			</tr>
			<%-- <tr>
				<th>阶段：</th>
				<td>
					<select name="stage" class="validate[required] xlselect">
	                   <option value="">请选择</option>
	                   <c:forEach var="stageEnum" items="${gcpProjStageEnumList}">
                   			<option value="${stageEnum.id}" <c:if test="${file.stage eq stageEnum.id}">selected="selected"</c:if>>${stageEnum.name}</option>
	                   </c:forEach>
	                </select>
				</td>
			</tr> --%>
		</table>
		
		 <p align="center" style="margin-top: 10px;">
	     	<input type="button" value="保&#12288;存" onclick="save();" class="search"/>
	     	<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	     </p>
		</form>
	</div> 
</div>
</body>
</html>