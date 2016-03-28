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
	function sendConfirm(queryFlow){
		jboxConfirm("确认发送?",function(){
			jboxGet("<s:url value='/edc/query/sendConfirm'/>?queryFlow="+queryFlow,null,function(){
				//$("#sendBtn").hide();
				window.parent.frames['mainIframe'].window.searchQuery();
				jboxCloseMessager();
			},null,true);
		});
	}
	function modifyQueryData(patientFlow){
		var width = $(top.window.document).width();
		//jboxOpen("<s:url value='/edc/query/crf'/>?patientFlow="+patientFlow,"数据澄清",width-200,600);
		window.parent.frames['mainIframe'].window.location.href="<s:url value='/edc/query/crf'/>?patientFlow="+patientFlow;
		jboxCloseMessager();
	}
</script>
</head>
<style>
.divPicSdving{background-image: url('<s:url value='/css/skin/${skinPath}/images/shu.gif' />');background-repeat: no-repeat;background-position: center;}
.divPicSdved{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<body>
	<script type="text/javascript">
		
	</script>
		<table class="xllist">
			<tr>
				<th width="100px">访视名称</th>
				<th width="100px">模块名称</th>
				<th width="100px">元素名称</th>
				<th width="50px">录入序号</th>
				<th width="100px">属性名称</th>
				<th width="100px">录入值</th>
				<th width="100px">修改值</th>
			</tr>
			<c:forEach items="${dataList}" var="data">
				<tr >
					<td>${data.visitName}</td>
					<td>${data.moduleName }</td>
					<td>${data.elementName}</td>
					<td>${data.elementSerialSeq}</td>
					<td>${data.attrName}</td>
					<td>${pdfn:getAttrValue(sessionScope.projDescForm,data.attrCode,data.attrValue)}</td>
					<td>${pdfn:getAttrValue(sessionScope.projDescForm,data.attrCode,data.attrEventValue)}</td>
				</tr>
			</c:forEach>
		</table>
		
		<p style="margin-top: 20px">更新人：${query.solveUserName }&#12288; &#12288;更新时间：${pdfn:transDateTime(query.solveTime) }&#12288; &#12288;
			<!-- 
			CRA状态：${query.craStatus == GlobalConstant.FLAG_Y?'已确认':'未确认' }&#12288; &#12288; DM状态：${query.dmStatus == GlobalConstant.FLAG_Y?'已确认':'未确认' }
			 -->
			 <c:if test="${query.queryStatusId ==  edcQueryStatusEnumUnSend.id}">
			 <input type="button" id="sendBtn" value="确认发送" class="search" onclick="sendConfirm('${query.queryFlow}');"/>
			 </c:if>
			 <c:if test="${query.solveStatusId == edcQuerySolveStatusEnumUnSolve.id &&  projParam.projLock !=  GlobalConstant.FLAG_Y}">
			 	<input type="button" id="sendBtn" value="数据更新" class="search" onclick="modifyQueryData('${query.patientFlow}');"/>
			 </c:if>
		</p>
</body>
</html>