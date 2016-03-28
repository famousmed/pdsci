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
	function search(){
		$("#searchForm").submit();	
	}
	
	function goDetail(qcFlow,projFlow){
		location.href = "<s:url value='/gcp/qc/qcDetail'/>?beforePage=projQcList&projFlow="+projFlow+"&qcFlow="+qcFlow+"&roleScope=${param.roleScope}";
	}
	
	function back(){
		location.href = "<s:url value='/gcp/proj/main'/>";
	}
	
	function add(projFlow,remindRecordFlow){
		jboxOpen("<s:url value='/gcp/qc/editQcRecord'/>?beforePage=projQcList&projFlow="+projFlow+"&roleScope=${param.roleScope}&remindRecordFlow="+remindRecordFlow,"新增质控记录",550,450);
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<form id="searchForm" action="<s:url value="/gcp/qc/projQcList" />" method="post">
		<div class="title1 clearfix">
			&#12288;专业组：
			<select name="applyDeptFlow" class="xlselect" style="width: 100px">
			    <option value="">请选择</option>
			    <c:forEach items="${deptList }" var="dept">
			    	<option value="${dept.deptFlow }" <c:if test="${dept.deptFlow eq param.applyDeptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
			    </c:forEach>
		    </select>
		   	 项目名称：
		   	 <input type="text" name="projName" value="${param.projName}" class="xltext"/>
 		    <input type="button" onclick="search();" class="search" value="查&#12288;询"/>
 		    <input type="button" onclick="back();" class="search" value="返&#12288;回"/>
 		    <div style="float: right;width: 300px;margin-top: -5px">
 		    	<div>
 		    	<c:forEach items="${gcpQcTypeEnumList}" var="qcType">
 		    		<img style="padding-bottom: 2px" src="<s:url value='/css/skin/${skinPath}/images/qc${qcType.id}.png'/>">&nbsp;${qcType.name}&nbsp;
 		    	</c:forEach>
 		    	</div>
 		    	<div style="margin-top: 5px">
 		    	<img style="padding-bottom: 3px" src="<s:url value='/css/skin/${skinPath}/images/qcDeptRemind.png'/>">&nbsp;专业组质控提醒&nbsp;
 		    	<img style="padding-bottom: 3px" src="<s:url value='/css/skin/${skinPath}/images/qcOrgRemind.png'/>">&nbsp;机构质控提醒&nbsp;
 		    	</div>
 		    </div>
		</div>
		</form>
		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="20%">项目名称</th>
				<th width="10%">期类别</th>
				<th width="15%">项目来源简称</th>
				<c:forEach items="${gcpQcCategoryEnumList}" var="qcCategory">
					<th>${qcCategory.name}</th>
				</c:forEach>
			</tr>
			</thead>
			<c:forEach items="${projList}" var="proj">
			<tr>
				<td>${proj.projName}</td>
				<td>${proj.projSubTypeName}</td>
				<td>${proj.projShortDeclarer}</td>
				<c:forEach items="${gcpQcCategoryEnumList}" var="qcCategory">
					<c:set value="${proj.projFlow}${qcCategory.id}" var="qcRecordKey"/>
					<td 
						<c:if test="${qcCategory.id eq gcpQcCategoryEnumFirstCaseGroup.id && not empty patientMap[proj.projFlow]}">
							title="首例入组日期：${pdfn:transDate(patientMap[proj.projFlow]['firstInDate'])}<br/>受试者编号：${patientMap[proj.projFlow]['firstPatientCode']}<br/>受试者姓名缩写：${patientMap[proj.projFlow]['firstPatientNamePy']}<br/>入组例数：${patientMap[proj.projFlow]['inCount']}<br/>病例总数：${patientMap[proj.projFlow]['planCount']}"
						</c:if>
						<c:if test="${qcCategory.id eq gcpQcCategoryEnumOneThirdGroup.id && not empty patientMap[proj.projFlow]}">
							title="最新一例入组时间：${pdfn:transDate(patientMap[proj.projFlow]['lastInDate'])}<br/>是否超过1/3：${patientMap[proj.projFlow]['isOverOneThird'] eq GlobalConstant.FLAG_Y?'是':'否'}<br/>入组例数：${patientMap[proj.projFlow]['inCount']}<br/>病例总数：${patientMap[proj.projFlow]['planCount']}"
						</c:if>
					>
						<c:forEach items="${qcRecordMap[qcRecordKey]}" var="qcRecord">
							<img style="cursor: pointer;" onclick="goDetail('${qcRecord.qcFlow}','${proj.projFlow}');" title="${qcRecord.qcTypeName}&#12288;${qcRecord.qcStartDate}" src="<s:url value='/css/skin/${skinPath}/images/qc${qcRecord.qcTypeId}.png'/>">&#12288;
						</c:forEach>
						<c:forEach items="${qcRemindMap[qcRecordKey]}" var="qcRemind">
							<img style="cursor: pointer;" 
							<c:if test="${!(qcRemind.qcTypeId eq gcpQcTypeEnumDept.id)}">
							onclick="add('${qcRemind.projFlow}','${qcRemind.recordFlow}')" 
							</c:if>
							 title="${qcRemind.remindContent}" src="<s:url value='/css/skin/${skinPath}/images/qc${qcRemind.qcTypeId}Remind.png'/>">&#12288;
						</c:forEach>
					</td>
				</c:forEach>
			</tr>
		   </c:forEach>
		   <c:if test="${empty projList}">
			<tr><td colspan="${gcpQcCategoryEnumList.size()+3}" align="center">无记录!</td></tr>
		</c:if>
		</table>
	</div> 
</div>
</body>
</html>