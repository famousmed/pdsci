<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	
	function allotPlan(speId,speName){
		var doctorCategoryId = $("#doctorCategoryId").val();
		var rotationName = $("#"+$("#"+speId).val()).text();
		var confirmStr = "确认将<font color='blue'>"+rotationName+"</font>分配给";
		confirmStr+=("<font color='blue'>"+speName+"</font>专业");
		confirmStr+=("<font color='blue'>"+$("[value='"+doctorCategoryId+"']").text()+"</font>类型");
		confirmStr+=("的所有医师!");
		jboxConfirm(confirmStr,function(){
			var data = {
					trainingSpeId:speId,
					doctorCategoryId:doctorCategoryId,
					rotationFlow:$("#"+speId).val(),
					rotationName:rotationName
			};
			jboxPost("<s:url value='/res/platform/allotRotation'/>",data,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					search();
				}else{
					top.jboxTip("${GlobalConstant.OPRE_FAIL}");
				}
			},null,false);
		},null);
	}
	
	$(function(){
		if(!$("#doctorCategoryId").val()){
			$("#category").text("请选择人员类型!");
			return;
		}
		$("#category").text($("[value='"+$("#doctorCategoryId").val()+"']").text());
	});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" method="post" action="<s:url value='/res/platform/trainPlan'/>">
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<table  class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td>
							人员类型：
							<select id="doctorCategoryId" name="doctorCategoryId" onchange="search();">
								<option></option>
								<c:forEach items="${recDocCategoryEnumList}" var="category">
									<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
									<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
									<option value="${category.id}" ${param.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
									</c:if>
								</c:forEach>
							</select>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th colspan="9" style="text-align: left;">&#12288;<font id="category"></font></th>
					</tr>
					<tr style="font-weight: bold;">
						<td style="text-align: center;padding: 0px;width: 30%;">专业</td>
						<td style="text-align: center;padding: 0px;width: 10%;">总人数</td>
						<td style="text-align: center;padding: 0px;width: 10%;">待分配</td>
						<td style="text-align: center;padding: 0px;width: 10%;">已分配</td>
						<td style="text-align: center;padding: 0px;width: 40%;">轮转方案</td>
					</tr>
					<c:if test="${!empty param.doctorCategoryId}">
						<c:set value="0" var="count"/>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<c:set value="${dict.dictId}plan" var="plan"/>
							<c:set value="${dict.dictId}notPlan" var="notPlan"/>
							<tr>
								<td>${dict.dictName}</td>
								<td>${countMap[notPlan]+countMap[plan]+0}</td>
								<td>${countMap[notPlan]+0}</td>
								<td>${countMap[plan]+0}</td>
								<td style="text-align: center;padding: 0px;">
									<c:set value="${dict.dictId}${param.doctorCategoryId}" var="key"/>
									<c:if test="${!empty selRotationMap[key]}">
										<font id="${selRotationMap[key].flow}">${selRotationMap[key].name}</font>
										<c:if test="${countMap[notPlan]+0!=0}">
											<input type="hidden" value="${selRotationMap[key].flow}" id="${dict.dictId}"/>
											<font style="float: right;margin-right: 20px;">[<a style="color: blue;cursor: pointer;" onclick="allotPlan('${dict.dictId}','${dict.dictName}');">追加分配</a>]</font>
										</c:if>
									</c:if>
									<c:if test="${empty selRotationMap[key]}">
										<c:if test="${empty rotationMap[dict.dictId]}">暂无方案!</c:if>
										<c:if test="${!empty rotationMap[dict.dictId]}">
											<select id="${dict.dictId}" style="width: 60%;margin-top: 7px;">
												<c:forEach items="${rotationMap[dict.dictId]}" var="rotation">
													<option id="${rotation.rotationFlow}" value="${rotation.rotationFlow}">${rotation.rotationName}</option>
												</c:forEach>
											</select>
											<c:if test="${countMap[notPlan]+0!=0}">
												<font style="float: right;margin-right: 20px;">[<a style="color: blue;cursor: pointer;" onclick="allotPlan('${dict.dictId}','${dict.dictName}');">分&nbsp;配</a>]</font>
											</c:if>
										</c:if>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty dictTypeEnumDoctorTrainingSpeList}">
						<tr><td style="text-align: center;padding: 0px;">无记录</td></tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</body>
</html>