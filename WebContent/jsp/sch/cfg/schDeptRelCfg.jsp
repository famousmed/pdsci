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
	var currDept = "";
	$(function(){
		//默认选择第一条
		$(".schDept:first").click();
	});
	
	//选择科室
	function selDept(dept,schDeptFlow){
		currDept = schDeptFlow;
		$(".schDept").css("backgroundColor","");
		$(dept).css("backgroundColor","pink");
		jboxStartLoading();
		jboxPost("<s:url value='/sch/cfg/loadRelDept'/>?schDeptFlow="+schDeptFlow,null,function(resp){
			if(resp){
				$(".standardDept").attr({
					checked:false,
					recordFlow:""
				});
				for(var index in resp){
					$("#"+resp[index].standardDeptId).attr({
						recordFlow:resp[index].recordFlow,
						checked:true
					});
				}
			}
			jboxEndLoading();
		},null,false);
	}
	
	//建立关系
	function operRel(standardDept){
		var recordFlow = $(standardDept).attr("recordFlow") || "";
		var recordStatus = standardDept.checked?"${GlobalConstant.RECORD_STATUS_Y}":"${GlobalConstant.RECORD_STATUS_N}";
		var data = {};
		data.recordFlow = recordFlow;
		if(standardDept.checked){
			data.schDeptFlow = currDept;
			data.standardDeptId = standardDept.value;
		}
		data.recordStatus = recordStatus;
		jboxStartLoading();
		jboxPost("<s:url value='/sch/cfg/saveDeptRel'/>",data,function(resp){
			if(resp){
				$(standardDept).attr("recordFlow",resp);
				var text = "";
				$(".standardDept:checked").each(function(){
					text+=(","+$(this).attr("dictName"));
				});
				text = text.substr(1) || "未关联";
				$("#"+currDept).text(text);
			}
			jboxEndLoading();
		},null,false);	
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div style="width: 48%;float: left;margin-top: 10px;">
			<table class="basic schDeptHome" width="100%">
				<tr>
					<th style="text-align: left;padding-left: 10px;">轮转科室</th>
				</tr>
				<c:forEach items="${deptList}" var="dept">
					<tr class="schDept" style="cursor: pointer;" onclick="selDept(this,'${dept.schDeptFlow}');">
						<td style="line-height: 25px;text-align: center;font-size: 15px;">
							${dept.schDeptName}
							<div style="color: #3d91d5;font-size: 8px;">
							(
							<font id="${dept.schDeptFlow}">
							<c:forEach items="${deptRelMap[dept.schDeptFlow]}" var="relMap" varStatus="status">
								<c:if test="${!status.first}">
									,
								</c:if>
								${relMap.value}
							</c:forEach>
							<c:if test="${empty deptRelMap[dept.schDeptFlow]}">未关联</c:if>
							</font>
							)
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div style="width: 48%;float: right;margin-top: 10px;">
			<table class="basic" width="100%">
				<tr>
					<th style="text-align: left;padding-left: 10px;">标准科室</th>
				</tr>
				<tr>
					<td>
						<c:forEach items="${dictTypeEnumStandardDeptList}" var="dict">
							<label>
								<input id="${dict.dictId}" class="standardDept" type="checkbox" value="${dict.dictId}" onclick="operRel(this);" dictName="${dict.dictName}"> ${dict.dictName}
							</label>
							<br/>
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>