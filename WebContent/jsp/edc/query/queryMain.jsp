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
</head>
<body> 
<script type="text/javascript">
	function selUnsolvedQuery(){
		if ($("#selUnsolvedQuery").attr("checked")=="checked") {
			$("tr.queryTr.query_${edcQuerySolveStatusEnumSolved.id}").hide();
		} else {
			$(".queryTr").show();
		}
	}
	
	function searchQuery() {
		jboxGet("<s:url value='/edc/query/list?orgFlow='/>"+$("#orgFlow").val()+"&patientCode="+$("#patientCode").val(),null,function(resp){
			$("#listDiv").html(resp);
		},null,false);	
	}
	function downDcf(){
		if($("#orgFlow").val()==""){
			jboxTip("请选择机构!");
			return;
		}
		var count = 0;
		$("input[name='queryFlow']").each(function(){
			if($("#"+$(this).val()+"_queryStatusId").val() == "${edcQueryStatusEnumSended.id}" && $("#"+$(this).val()+"_dcfNo").val() ==""){
				count++;
			}
		});
		if(count>0){
			jboxConfirm("确认下载当前 <font color=red>"+count+" </font>条疑问?",function(){
				jboxOpen("<s:url value='/edc/query/dcf'/>?orgFlow="+$("#orgFlow").val(),"DCF",$('.main_fix').width(),600);
			});
		}else {
			jboxTip("当前机构暂无疑问!");
		}
	}
	</script>
	<div class="mainright">
	<div class="content">
		<div style="margin-top: 5px">
			机构：
			<select  name="orgFlow" id="orgFlow"  style="width:200px;" onchange="searchQuery();">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>&#12288;
			受试者编号：
			<input type="text" id="patientCode" name="patientCode" style="width: 80px"/>&#12288;
			<label><input type="checkbox" id="selUnsolvedQuery" value="" onchange="selUnsolvedQuery();" />待处理</label>&#12288;
			<input type="button" class="search" onclick="searchQuery();" value="查&#12288;询"/>
			<input type="button" class="search" onclick="downDcf();" value="下载DCF"/>
			&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/>已发送&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>提交更新&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/gou1.gif'/>"/>CRA确认&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/gou2.gif'/>"/>DM确认
			<hr/>
		</div>
		
		<div class="main_fix" style="width: 98%;">
			<div class="title1 clearfix">
				<div id="listDiv">
					
				</div>
			</div>
		</div>
</div>
</div>
</body>
</html>