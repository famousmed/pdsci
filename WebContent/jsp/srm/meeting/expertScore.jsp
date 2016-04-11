<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

function saveExpertProj(status){
	
	if(false==$("#expertScore").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/srm/meeting/saveExpertScore?status='/>"+status+"&evalSetFlow=${param.evalSetFlow}";
	jboxStartLoading();
	jboxPost(url , $('#expertScore').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<form id="expertScore" action="<s:url value='/srm/meeting/saveExpertScore'/>">
			<p><b style="font-size: 15px;font-weight: bold;">一、专家意见</b></p>
			<table class="xllist" style="margin-top: 10px;">
					<tr>
						<th  width="50px">序号</th>
						<th  width="150px">专家姓名</th>
						<th width="100px">总分</th>
						<th width="200px">评审结果</th>
						<th width="300px">专家意见</th>
					</tr>
				<c:set var='btnFlag' value="1"/>
				<c:set var='index' value="0"/>
				<c:forEach var="expertProj" items="${expertProjList}" varStatus="sta">
					<tr>
						<td width="50px">${sta.count}</td>
						<td width="150px">${expertProj.userExt.userName}</td>
						<c:if test='${evaluationStatusEnumSubmit.id eq expertProj.evalStatusId}'>
							<td width="100px">${expertProj.scoreTotal}</td>
							<td width="200px">${expertProj.scoreResultName}</td>
							<td width="300px">${expertProj.expertOpinion}</td>
						</c:if>
						<c:if test='${(empty expertProj.evalStatusId) || (evaluationStatusEnumSave.id eq expertProj.evalStatusId)}'>
							<c:set var='btnFlag' value="0"/>
							<td width="100px">
								<input name='srmExpertProjList[${index}].expertProjFlow' type="hidden" value='${expertProj.expertProjFlow}'/>
								<input name='srmExpertProjList[${index}].scoreTotal' style="width: 90%" value='${expertProj.scoreTotal}' class="validate[required,custom[number],maxSize[3]]"/>
							</td>
							<td width="200px">
								<input type="radio" class="validate[required]" name="srmExpertProjList[${index}].scoreResultId" id="scoreResultIdY_${sta.index}" value="${expertScoreResultEnumAgree.id }" <c:if test="${expertScoreResultEnumAgree.id eq expertProj.scoreResultId}">checked</c:if>/><label for="scoreResultIdY_${sta.index}">同&#12288;意</label>
                            	&#12288;<input class="validate[required]" name="srmExpertProjList[${index}].scoreResultId"  id="scoreResultIdN_${sta.index}" type="radio" value="${expertScoreResultEnumNotAgree.id  }" <c:if test="${expertScoreResultEnumNotAgree.id eq expertProj.scoreResultId}">checked</c:if> /><label for="scoreResultIdN_${sta.index}">不同意</label>&#12288;
							</td>
							<td  width="300px">
								<input style='width: 90%' name='srmExpertProjList[${index}].expertOpinion' value='${expertProj.expertOpinion}'/>
							</td>
							<c:set var='index' value="${index+1}"/>
						</c:if>
					</tr>
				</c:forEach>
			</table>
			<p><b style="font-size: 15px;font-weight: bold;">二、审查意见</b></p>
			<textarea style="margin-top: 10px;width: 100%;" rows="5" name="evalOpinion" placeholder="字数不允许超过500字" class="validate[maxSize[500]]">${evalOpinion }</textarea>
			<div style="text-align: center; margin-top: 20px">
			<c:if test='${btnFlag eq "0"}'>
				<input type="button" value='保&#12288;存' onclick='saveExpertProj("${evaluationStatusEnumSave.id}");' class="search"/>
				<input type="button" value='提&#12288;交' onclick='saveExpertProj("${evaluationStatusEnumSubmit.id}")' class="search"/>
			</c:if>
			<input type="button" value='关&#12288;闭' onclick='jboxClose();' class="search"/>
			</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>