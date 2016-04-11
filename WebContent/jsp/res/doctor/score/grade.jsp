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
	<jsp:param name="jquery_cxselect" value="true"/>
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
<c:set value="${!empty param.isRead}" var="isOpen"></c:set>
<c:set value="${isOpen && param.isRead}" var="isRead"></c:set>
<script type="text/javascript">
	function saveRec(){
		if($("#resRecGradeForm").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveGrade'/>",$("#resRecGradeForm").serialize(),function(resp){
				$("[name='recFlow']").val(resp);
				$("#submitButton").show();
				window.parent.frames['mainIframe'].window.$(".box.selected").click();
				top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			},null,false);
		}
	}
	
	function back(){
		window.location.href="<s:url value='/res/doc/rotationDetail'/>?resultFlow=${param.resultFlow}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}";
	}
	
	function countScore(){
		var count = 0;
		$(".scoreCount").each(function(){
			var score = $(this).val();
			if($.trim(score)!="" && !isNaN(score)){
				count+=parseFloat(score);
			}
		});
		$("#totalScore").val(count.toFixed(1));
	}
	
	function submit(){
		jboxConfirm("确认提交?",function(){
			var recFlow = $("[name='recFlow']").val();
			jboxPost("<s:url value='/res/rec/opreResRec'/>",{"recFlow":recFlow,"statusId":"${recStatusEnumSubmit.id}"},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					<c:if test="${isOpen}">
						window.parent.frames['mainIframe'].window.location.reload(true);
						jboxClose();
					</c:if>
					<c:if test="${!isOpen}">
						jboxClose();
						//location.reload(true);
					</c:if>
				}
			},null,true);
		},null);
	}
	
	$(function(){
		<c:if test="${isRead || rec.statusId eq recStatusEnumSubmit.id}">
			$("input:text").attr("readonly",true);
		</c:if>
	});
</script>
</head>
<body>	
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div style="padding-top: 10px;padding-left: 5px;padding-right: 5px;padding-bottom: 5px;">
					<form id="resRecGradeForm">
						<input type="hidden" name="schDeptFlow" value="${empty rec?param.schDeptFlow:rec.schDeptFlow}"/>
						<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
						<input type="hidden" name="recTypeId" value="${empty rec?param.recTypeId:rec.recTypeId}"/>
					 	<c:forEach items="${titleFormList}" var="title">
					 		<table class="xllist nofix"  style="margin-top: 10px;">
					 		<tr>
								<th style="text-align: left;" colspan="3">&#12288;${title.name}</th>
							</tr>
					 		<c:forEach items="${title.itemList}" var="item">
					 			<tr>
									<td style="text-align: left;"  colspan="3">&#12288;&#12288;${item.name}</td>
								</tr>
								<tr>
									<td style="text-align: left;width: 100px;">&#12288;&#12288;分值：${item.score}<input type="hidden" name="assessId" value="${item.id}"/></td>
									<td style="text-align: left;width: 200px;">&#12288;我的打分：<input style="width:100px;" name="score" type="text" class="inputText validate[custom[number],max[${item.score}],min[0]] scoreCount" value="${gradeMap[item.id]['score']}" onkeyup="countScore();"/></td>
									<td style="text-align: left;">&#12288;扣分原因：<input type="text" class="inputText" name="lostReason" style="width:600px;text-align: left;" value="${gradeMap[item.id]['lostReason']}"/></td>
								</tr>
					 		</c:forEach>
					 		</table>
					 	</c:forEach>
					 
						<div style="padding-left: 140px;padding-top: 5px;">总分：<input style="width:100px;" type="text" name="totalScore" id="totalScore" class="inputText" value="${empty gradeMap['totalScore']?0:gradeMap['totalScore']}" readonly="readonly"/></div>
					</form>
					
					<div style="text-align: center;margin-top: 5px;">
						<c:if test="${empty rec.statusId}">
							<input id="submitButton" type="button" value="提&#12288;交" class="search" onclick="submit();" style="${!empty rec?'':'display: none;'}"/>
							<input type="button" value="保&#12288;存" class="search" onclick="saveRec();"/>
						</c:if>
						<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
					</div>
				</div> 	
			</div>
		</div>
	</div>
</body>
</html>