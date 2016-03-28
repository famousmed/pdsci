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

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}
function edit(talentsFlow) {
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/edit?talentsFlow='/>"+talentsFlow+"&role=${role}", "人才培养专项资金申请表", 1000, 500);
}
function assess(talentsFlow,role) {
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/assess?talentsFlow='/>"+talentsFlow+"&role="+role, "人才培养绩效评价表", 900, 600);
}
function check(talentsFlow,role){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/assess?talentsFlow='/>"+talentsFlow+"&viewAll=N&role="+role, "审核", 900, 600);
}
function oper(talentsFlow,oper){
	var msg = "删除";
	var url = "<s:url value='/srm/aid/talents/del'/>?talentsFlow="+talentsFlow;
	if(oper=="sendCheck"){
		 msg = "送审";
		 url = "<s:url value='/srm/aid/talents/sendCheck'/>?talentsFlow="+talentsFlow;
	}
	jboxConfirm("确定"+msg+"该记录？",function(){
		jboxPost(url,null,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				search();
			}
		},null,true);
	},null);
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
function viewAll(talentsFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/assess?talentsFlow='/>"+talentsFlow+"&viewAll=Y", "查看全部", 900, 600);
}
function print(talentsFlow,type){
	var url ="<s:url value='/srm/aid/talents/print'/>?watermarkFlag=${GlobalConstant.FLAG_Y}&talentsFlow="+talentsFlow+"&type="+type;
	window.location.href= url;
}
</script>
</head>
<body>

 <div class="mainright" id="mainright">
    <div class="content">
	  <form id="searchForm" action="<s:url value="/srm/aid/talents/list/${role}"/>" method="post">
	   <div class="title1 clearfix">
		<p>
		    研修项目名称：
		 		<input type="text" name="studyName" value="${param.studyName}" class="xltext"/>
			<c:if test="${role==GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}">
	 		单位：
	 		<input type="text" name="orgName" value="${param.orgName}" class="xltext"/>
	 		</c:if>
	 		<c:if test="${role!=GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL}">
	 		姓名：
	 		<input type="text" name="userName" value="${param.userName}" class="xltext" style="width: 120px;"/>
	 		</c:if>
	 		<c:if test="${role!=GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}">
	 		申请状态：
	 		<select name="statusId" class="xlselect" style="width: 130px;">
	 			<option value="">全部</option>
	 			<c:forEach items="${aidTalentsStatusEnumList}" var="status">
	 				<option value="${status.id}" <c:if test="${status.id == param.statusId}">selected="selected"</c:if> >${status.name }</option>
	 			</c:forEach>
	 		</select>
	 		评价状态：
	 		<select name="assessStatusId" class="xlselect" style="width: 80px;">
	 			<option value="">全部</option>
	 			<c:forEach items="${aidAssessStatusEnumList}" var="status">
	 				<option value="${status.id}" <c:if test="${status.id == param.assessStatusId}">selected="selected"</c:if> >${status.name }</option>
	 			</c:forEach>
	 		</select>
	 		</c:if>
			<input type="button" class="search" onclick="search();" value="查&#12288;询">
			<c:if test="${role!=GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}">
			<input type="button" class="search" onclick="edit('');" value="新&#12288;增">
			</c:if>
		</p>
		</div>
  <table class="xllist">
  	<thead>
         <tr>
            <th width="10%">姓名</th>
            <th width="15%">单位</th>
            <!--<th width="10%">部门</th>
            <th width="10%">职务</th>
            <th width="10%">职称</th> -->
            <th width="10%">赴国家(地区)</th>
            <th width="15%">研修项目名称</th>
            <th width="17%">研修起止时间</th>
            <th width="10%">申请资助经费</th>
            <th width="10%">申请状态</th>
            <th width="8%">评价状态</th>
            <th width="15%">操作</th>
         </tr>
     </thead>
     <c:forEach items="${aidList}" var="aid">
     <tr>
	     <td>${aid.userName }</td>
	     <td>${aid.orgName }</td>
	     <%--   <td>${aid.deptName }</td>
	     <td>${aid.postName }</td>
	     <td>${aid.titleName }</td> --%>
	     <td>${aid.studyCountry}</td>
	     <td>${aid.studyName}</td>
	     <td>${aid.startDate}~${aid.endDate}</td>
	     <td>${aid.applyFee}</td>
	     <td>${aid.statusName}</td>
	     <td>${aid.assessStatusName}</td>
	     <td>
	     	 <c:if test="${aid.statusId==aidTalentsStatusEnumEdit.id||aid.statusId==aidTalentsStatusEnumLocalNoPassed.id}">
		     <a href="javascript:void(0)" onclick="edit('${aid.talentsFlow}');">[编辑]</a>
		     </c:if>
		   	 <c:if test="${role==GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL&&aid.statusId==aidTalentsStatusEnumLocalPassed.id}">               
			     <a href="javascript:void(0)" onclick="check('${aid.talentsFlow}','${role}');">[审核]</a>
		      </c:if> 
		   	 <c:if test="${role==GlobalConstant.PROJ_STATUS_SCOPE_LOCAL&&aid.statusId==aidTalentsStatusEnumPassing.id}">               
			     <a href="javascript:void(0)" onclick="check('${aid.talentsFlow}','${role}');">[审核]</a>
		      </c:if> 
		      <c:if test="${role==GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL&&(aid.statusId==aidTalentsStatusEnumEdit.id||aid.statusId==aidTalentsStatusEnumLocalNoPassed.id)}">
		      	<a href="javascript:void(0)" onclick="oper('${aid.talentsFlow}','sendCheck');">[送审]</a> 
		      </c:if> 
		      <c:if test="${aid.statusId==aidTalentsStatusEnumEdit.id||aid.statusId==aidTalentsStatusEnumLocalNoPassed.id}">            
		     	<a href="javascript:void(0)" onclick="oper('${aid.talentsFlow}','del');">[删除]</a>
		      </c:if>
		      <c:if test="${aid.statusId==aidTalentsStatusEnumGlobalPassed.id&&aid.assessStatusId==aidAssessStatusEnumAssessing.id }">            
		     	<a href="javascript:void(0)" onclick="assess('${aid.talentsFlow}','${role}');">[评价]</a> 
		      </c:if> 
		     	<a href="javascript:void(0)" onclick="viewAll('${aid.talentsFlow}');">[查看]</a>
		      <c:if test="${role!=GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}">  
		       <a href="javascript:void(0)" onclick="print('${aid.talentsFlow}','${GlobalConstant.AID_DOC_TYPE_TALENTS }');" >[打印申请]</a>
			       <c:if test="${aid.assessStatusId==aidAssessStatusEnumAssessed.id }">              
			       <a href="javascript:void(0)" onclick="print('${aid.talentsFlow}','${GlobalConstant.AID_DOC_TYPE_ASSESS }');" >[打印评价]</a>
			       </c:if> 
		       </c:if>             
	      </td>
	 </tr>
     </c:forEach>
  </table>
  
 	<p>
		<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
	    <c:set var="pageView" value="${pdfn:getPageView2(aidList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
	
	  </form>
  </div>
</div> 	

</body>
</html>