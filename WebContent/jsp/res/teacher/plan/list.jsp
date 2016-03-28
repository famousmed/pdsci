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
	<jsp:param name="jquery_fullcalendar" value="true" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>

<style type="text/css">
	caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; border-bottom:1px solid #ddd;color:#f60;}
</style>

<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}

	function editPlan(recFlow,schDeptFlow,recordFlow){
		jboxOpen("<s:url value='/res/teacher/editTeachPlan'/>?recFlow="+recFlow+"&schDeptFlow="+schDeptFlow+"&recordFlow="+recordFlow,"教学安排",700,500);
	}
	
	function delPlan(recFlow,schDeptFlow,recordFlow){
		jboxConfirm("确认删除？",function(){
			var url = "<s:url value='/res/teacher/saveTeachPlan'/>?delFlag=${GlobalConstant.FLAG_Y}&recFlow="+recFlow+"&schDeptFlow="+schDeptFlow+"&recordFlow="+recordFlow;
			jboxPost(url,null,function(resp){
				if('${GlobalConstant.OPRE_SUCCESSED_FLAG}'==resp){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					search();
				}
			},null,false);
		},null);
	}
	
	function editSummary(recFlow,schDeptFlow){
		$(".summary"+schDeptFlow).toggle();
		$("#"+schDeptFlow).focus();
	}
	
	var editFlag = true;
	function cancelEdit(recFlow,schDeptFlow){
		if(editFlag){
			$(".summary"+schDeptFlow).toggle();
			$("#"+schDeptFlow).val($.trim($(".summary"+schDeptFlow+":first").text()));
		}
	}
	
	function operCancelEdit(recFlow,flag){
		editFlag = flag=="start";
	}
	
	function saveSummary(recFlow,schDeptFlow){
		var url = "<s:url value='/res/teacher/saveTeachPlan'/>?recFlow="+recFlow+"&schDeptFlow="+schDeptFlow;
		var teachSummary = $("#"+schDeptFlow).val() || "";
		jboxPost(url,{teachSummary:teachSummary},function(resp){
			if('${GlobalConstant.OPRE_SUCCESSED_FLAG}'==resp){
				top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				$("#"+schDeptFlow+"View").text(teachSummary).show();
				$("#"+schDeptFlow).hide();
// 				$(".summary"+schDeptFlow+":first").text(teachSummary);
// 				$(".summary"+schDeptFlow).toggle();
			}
		},null,false);
	}
	
	function selTag(tag,schDeptFlow){
		$(".selectTag").removeClass("selectTag");
		$(tag).addClass("selectTag");
		location.href = "<s:url value='/res/teacher/teachPlanList'/>?schDeptFlow="+schDeptFlow;
	}
	
	$(function(){
		$("[onclick]").click(function(e){
			e.stopPropagation();
		});
		
		var result = $(".sortTr").sort(function(a,b){
			return $(a).attr("teachType")>$(b).attr("teachType");
		});
		$("#sortHome").append(result);
	});
</script>

</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" action="<s:url value='/res/teacher/teachPlanList'/>" method="get">
<!-- 		<table class="basic" style="width: 100%;margin-top: 10px;margin-bottom: 10px;"> -->
<!-- 			<tr> -->
<!-- 				<td> -->
<!-- 					轮转科室： -->
<!-- 					<select name="schDeptFlow" onchange="search();"> -->
<!-- 						<option> -->
<%-- 						<c:forEach items="${schDeptList}" var="schDept"> --%>
<%-- 							<option value="${schDept.schDeptFlow}" <c:if test="${param.schDeptFlow eq schDept.schDeptFlow}">selected</c:if>>${schDept.schDeptName}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 					&#12288; -->
<!-- 					教学形式： -->
<!-- 					<select> -->
<!-- 						<option> -->
<%-- 						<c:forEach items="${dictTypeEnumTeachTypeList}" var="dict"> --%>
<%-- 							<option value="${dict.dictId}">${dict.dictName}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
		</form>
		
		<ul id="tags" style="margin-top: 10px;">
			<c:forEach items="${schDeptList}" var="schDept" varStatus="deptStatus">
				<li <c:if test="${empty param.schDeptFlow?deptStatus.first:(schDept.schDeptFlow eq param.schDeptFlow)}">class="selectTag"</c:if> onclick="selTag(this,'${schDept.schDeptFlow}');" style="cursor: pointer;">
					<a>
						${schDept.schDeptName}
<%-- 						<img style="margin-left: 10px;cursor: pointer;" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" onclick="editPlan('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}','');"></img> --%>
					</a>
				</li>
			</c:forEach>
		</ul>
		<div id="tagContent" class="divContent" align="center">
			<c:forEach items="${schDeptList}" var="schDept" varStatus="deptStatus">
				<c:if test="${empty param.schDeptFlow?deptStatus.first:(schDept.schDeptFlow eq param.schDeptFlow)}">
	<%-- 			<c:if test="${(!empty param.schDeptFlow && param.schDeptFlow eq schDept.schDeptFlow) || empty param.schDeptFlow}"> --%>
				<div style="margin: 10px 10px 10px 0px;text-align: right;">
					<input type="button" value="新&#12288;增" class="search" onclick="editPlan('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}','');"/>
				</div>
				<table class="basic" style="width: 95%;margin-bottom: 20px;">
<!-- 					<caption style="margin-bottom: 10px;"> -->
<%-- 						${schDept.schDeptName} --%>
<%-- 						<img style="margin-right: 10px;cursor: pointer;color: blue;float: right;margin-top: 15px;" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" onclick="editPlan('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}','');"></img> --%>
<!-- 					</caption> -->
					<tbody id="sortHome">
					<c:forEach items="${contentMap[recMap[schDept.schDeptFlow].recFlow]['teachPlan']}" var="plan">
						<tr class="sortTr" teachType="${plan.objMap.teachTypeName}">
							<th width="100px" style="padding-left: 10px;text-align: left;">教学形式：${plan.objMap.teachTypeName}</th>
							<td>教学内容：
								<div style="padding-left: 20px;width: 100%;">
									${plan.objMap.teachContent}
								</div>
							</td>
							<td width="80px">
								<a style="cursor: pointer;color: blue;" onclick="editPlan('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}','${plan.flow}');">编辑</a>
								|
								<a style="cursor: pointer;color: blue;" onclick="delPlan('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}','${plan.flow}');">删除</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
					<c:if test="${!empty contentMap[recMap[schDept.schDeptFlow].recFlow]['teachPlan']}">
						<tr>
							<th colspan="5" style="text-align: left;padding-left: 10px;">
								教学考核 ：
								<a style="color: blue;cursor: pointer;float: right;font-weight: normal;margin-right: 5px;" onclick="$('#${schDept.schDeptFlow}').show().focus();$('#${schDept.schDeptFlow}View').hide();">编辑</a>
							</th>
						</tr>
						<tr>
<%-- 							<td title="点击编辑" colspan="5" class="summary${schDept.schDeptFlow}" onclick="editSummary('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}');"> --%>
<%-- 								${contentMap[recMap[schDept.schDeptFlow].recFlow]['teachSummary']} --%>
<!-- 							</td> -->
							<td colspan="5" class="summary${schDept.schDeptFlow}">
								<div id="${schDept.schDeptFlow}View">${contentMap[recMap[schDept.schDeptFlow].recFlow]['teachSummary']}</div>
								<textarea placeholder="请输入教学考核" id="${schDept.schDeptFlow}" style="width: 100%;border: none;height: 200px;display: none;" onblur="saveSummary('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}');">${contentMap[recMap[schDept.schDeptFlow].recFlow]['teachSummary']}</textarea>
<!-- 								<div align="center" style="margin-top: 10px;margin-bottom: 10px;"> -->
<%-- 									<input type="button" value="保&#12288;存" class="search" onclick="saveSummary('${recMap[schDept.schDeptFlow].recFlow}','${schDept.schDeptFlow}');" onmouseover="operCancelEdit('${recMap[schDept.schDeptFlow].recFlow}','stop');" onmouseout="operCancelEdit('${recMap[schDept.schDeptFlow].recFlow}','start');"/> --%>
<!-- 								</div> -->
							</td>
						</tr>
					</c:if>
				</table>
				<c:if test="${empty contentMap[recMap[schDept.schDeptFlow].recFlow]['teachPlan']}">
					<div style="margin-bottom: 20px;">暂无教学安排！</div>
				</c:if>
	<%-- 			</c:if> --%>
			</c:if>
			</c:forEach>
    	</div>
		
	</div>
</div>
</body>
</html>
