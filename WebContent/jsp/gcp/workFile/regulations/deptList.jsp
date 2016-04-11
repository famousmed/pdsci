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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
	$(function(){
		/*查询科室*/
		loadDeptList();
		$("#searchParam").keyup(function(){ 
			  if(event.keyCode == 13){      
				  var deptFlow =  $("#SuggestResult").val();
				  window.location.href="<s:url value='/gcp/workFile/regulationFiles?regulationCategoryId=Dept'/>&deptFlow=" + deptFlow;
			  }
		  });
	});
	function loadDeptList() {
		var depts = new Array();
		var url = "<s:url value='/gcp/fin/seachDeptListJson'/>";
		jboxPost(url,null,function(data){
			if(data!=null){
				for ( var i = 0; i < data.length; i++) {
					depts[i]=new Array(data[i].deptFlow,data[i].deptName,data[i].deptCode);
				}
			}
		},null,false);
		$("#searchParam").suggest(depts,{
			attachObject:'#suggest',
		});
	}
	
	function search(){
		$("#searchForm").submit();	
	}

	function toRegulationFiles(deptFlow){
		window.location.href="<s:url value='/gcp/workFile/regulationFiles?regulationCategoryId=Dept'/>&deptFlow=" + deptFlow;
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<div style="height: 50px">
			<input style="float: right;margin-right: 14.5%" id="searchParam" placeholder="输入部门名称">
		    <div id="suggest" class="ac_results" style="margin-left: 0px;"></div>
		   	<input id="SuggestResult" type="hidden"/>
		</div>
		<table style="margin: 0 auto;">
			<c:forEach items="${deptList }" varStatus="status">
				<c:if test="${status.index % 5 eq 0}">
					<tr>
						<c:forEach items="${deptList }" var="dept" begin="${status.index}" end="${status.index+4}">
							<td>
								<table onmouseover="this.className='dept_over'" onmouseout="this.className='dept_out'" onclick="toRegulationFiles('${dept.deptFlow}')">
									<tr>
										<td class="dept_img"></td>
									</tr>
									<tr>
										<td class="dept_name">${dept.deptName }</td>
									</tr>
								</table>
							</td>
							<td class="dept_blank"></td>	
						</c:forEach>
					</tr>
					<tr class="dept_blank"><td colspan="9"></td></tr>
				</c:if>
			</c:forEach>
		</table>
		</div>
	</div> 
	</div>
</body>
</html>