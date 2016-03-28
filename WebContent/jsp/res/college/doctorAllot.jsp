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
<style type="text/css">
	.cur{border-color:red};
</style>
<script type="text/javascript">
	function search() {
		$("#searchForm").submit();
	}
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
	}
		search();
}
	function isInt(num){
		return !isNaN(num) && num.indexOf(".")<0 && num!="";
	}
	var oldNum = 0;
	function saveOldNum(oldNumTemp){
		if(isInt(oldNumTemp)){
			oldNum=oldNumTemp;
		}else{
			oldNum=0;
		}
		
	}
	function check(flow,newNum){
		var sum=$("#"+flow).text();
		if(sum==""){
			sum=0;
		}else{
			sum=parseInt(sum);
		}
		if(!isInt(newNum)){
			newNum=0;
		}else{
			newNum=parseInt(newNum);
		}
		sum += newNum-oldNum;
//		f.each(function(){
// 			if(isInt(this.value)){
// 				$(this).removeClass("cur"); 
// 				sum+=parseInt(this.value);
// 			}else{
// 				if(this.value!=""){
// 					$(this).addClass("cur");
// 				}
// 			}
// 		});
		$("#"+flow).html(sum);
	}

	</script>

</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<form  id="searchForm"  action="<s:url value="/res/platform/doctorAllot"/>" method="post">
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<table class="basic" style="width: 100%;">
				<tr>
					<td>
						医院：<input type="text"  onchange="search();" name="orgName" value="${param.orgName }"/>
					</td>
				</tr>
				</table>
			</form>
			</div>
				<table id="orgTable" class="xllist">
					<thead>
						<tr>
							<th>医院</th>
							<th>接受人数</th>
							<c:forEach items="${deptList}" var="dept">
								<th>${dept.deptName }</th>
							</c:forEach>
						</tr>
					</thead>
				<tbody>
					<c:forEach items="${sysOrgList}" var="org">
							<tr>
								<td>${org.orgName}</td>
								<td id="${org.orgFlow}"></td>
								<c:forEach items="${deptList}" var="dept">
									<td><input type="text" class="${org.orgFlow}" onfocus="saveOldNum(this.value);" onchange="check('${org.orgFlow}',this.value);" style="width: 40px; margin-right: 0px;" value=""/></td>
								</c:forEach>
							</tr>
					</c:forEach>
				</tbody>
				</table>
				<c:set var="pageView" value="${pdfn:getPageView(sysOrgList)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
				
			</div>
		</div>
</body>
</html>