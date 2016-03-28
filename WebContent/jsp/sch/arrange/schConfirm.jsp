<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<script type="text/javascript">
	function viewProcess(processFlow){
		if(event.srcElement.tagName=="TH"){
			$("."+processFlow).toggle();
		}
	}
	function confirm(){
		jboxConfirm("确认选择该排班?选择后无法修改，系统将自动生成排班表!",function(){
			jboxGet("<s:url value='/sch/doConfirm'/>",$("#arrange").serialize(),function(){
				window.location.reload();
				window.parent.frames['mainIframe'].window.location.reload();
			},null,true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="arrange">
		<input type="hidden" name="arrangeFlow" value="${arrange.arrangeFlow}" />
			<div class="title1">
				<c:if test="${!empty arrangeProcessMap[schArrangeYearEnumFirstYear.id]}">
							<table class="basic" style="width: 100%;margin-bottom: 10px">
								<tr style="cursor: pointer;" onclick="viewProcess('${arrangeProcessMap[schArrangeYearEnumFirstYear.id].processFlow}');">
									<th colspan="2" style="text-align: left;padding-left: 10px;">
										${schArrangeYearEnumFirstYear.name}
										&#12288;&#12288;&#12288;&#12288;&#12288;
										排班指数：${arrangeProcessMap[schArrangeYearEnumFirstYear.id].arrangeIndex}
										<input type="hidden" name="firstProcessFlow" value="${arrangeProcessMap[schArrangeYearEnumFirstYear.id].processFlow}"/>
										<input type="hidden" name="firstEndIndex" value="${arrangeProcessMap[schArrangeYearEnumFirstYear.id].arrangeIndex}"/>
									</th>
								</tr>
								<tbody style="display: none;height: 300px;" class="${arrangeProcessMap[schArrangeYearEnumFirstYear.id].processFlow}">
									<tr><td>演算过程...</td></tr>
								</tbody>
							</table>
							</c:if>
							<c:if test="${!empty arrangeProcessMap[schArrangeYearEnumSecondYear.id]}">
							<table class="basic" style="width: 100%;margin-bottom: 10px">
								<tr style="cursor: pointer;" onclick="viewProcess('${arrangeProcessMap[schArrangeYearEnumSecondYear.id].processFlow}');">
									<th colspan="2" style="text-align: left;padding-left: 10px;">
										<input type="hidden" name="secondProcessFlow" value="${arrangeProcessMap[schArrangeYearEnumSecondYear.id].processFlow}"/>
										<input type="hidden" name="secondEndIndex" value="${arrangeProcessMap[schArrangeYearEnumSecondYear.id].arrangeIndex}"/>
										${schArrangeYearEnumSecondYear.name}
										&#12288;&#12288;&#12288;&#12288;&#12288;
										排班指数：${arrangeProcessMap[schArrangeYearEnumSecondYear.id].arrangeIndex}
									</th>
								</tr>
								<tbody style="display: none;height: 300px;" class="${arrangeProcessMap[schArrangeYearEnumSecondYear.id].processFlow}">
									<tr><td>演算过程...</td></tr>
								</tbody>
							</table>
							</c:if>
							<c:if test="${!empty arrangeProcessMap[schArrangeYearEnumThirdYear.id]}">
							<table class="basic" style="width: 100%;margin-bottom: 10px">
								<tr style="cursor: pointer;" onclick="viewProcess('${arrangeProcessMap[schArrangeYearEnumThirdYear.id].processFlow}');">
									<th colspan="2" style="text-align: left;padding-left: 10px;">
										<input type="hidden" name="thirdProcessFlow" value="${arrangeProcessMap[schArrangeYearEnumThirdYear.id].processFlow}"/>
										<input type="hidden" name="thirdEndIndex" value="${arrangeProcessMap[schArrangeYearEnumThirdYear.id].arrangeIndex}"/>
										${schArrangeYearEnumThirdYear.name}
										&#12288;&#12288;&#12288;&#12288;&#12288;
										排班指数：${arrangeProcessMap[schArrangeYearEnumThirdYear.id].arrangeIndex}
									</th>
								</tr>
								<tbody style="display: none;height: 300px;" class="${arrangeProcessMap[schArrangeYearEnumThirdYear.id].processFlow}">
									<tr><td>演算过程...</td></tr>
								</tbody>
							</table>
							</c:if>	
			</div>	
		</form>
	</div>
	<div style="text-align: center;">
		<input type="button" onclick="confirm();"  class="search" value="确&#12288;认"/>
	</div>
</div>
</body>
</html>