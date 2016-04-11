<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
<script type="text/javascript">
	
	function setUp(projFlow){
		jboxStartLoading();
		jboxOpen("<s:url value='/srm/proj/approve/setUp?projFlow='/>"+projFlow , "立项信息" , 900 , 600 );
	}
	
	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	
</script>
</head>
<body>
<div class="mainright">
   <div class="content">
	<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/proj/approve/list/${sessionScope.projListScope}/${sessionScope.projCateScope}" />"
				method="post">
				<p>
					年&#12288;&#12288;份：
					<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
					
					&#12288;&#12288;学科类型：
					<select name="projTypeId" class="xlselect">
							<option value="">请选择</option>
                       	<c:forEach var="dict" items="${dictTypeEnumSubjTypeList}">
                       		<option value="${dict.dictId}" <c:if test='${param.projTypeId==dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
                       	</c:forEach>
					</select>
				</p>
				<p>
					学科名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 160px" />
					&#12288;&#12288;申报单位：
					<select name="applyOrgFlow" class="xlselect">
							<option value="">请选择</option>
						<c:forEach var="org" items="${sysOrgList}">
							<option value="${org.orgFlow}" <c:if test="${param.applyOrgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
						</c:forEach>
					</select>
					&#12288;&#12288;
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询"> 
				</p>
			</form>
		</div>
		<table class="xllist">
             <thead>
                  <tr>
                      <th width="5%">年份</th>
                      <th width="10%">学科类别</th>
                      <th >学科名称</th>
                      <th width="20%">申报单位</th>
                      <th width="10%">学科负责人</th>
                      <th width="15%">起止时间</th>
                      <th width="5%">操作</th>
                  </tr>
              </thead>
              <tbody>
              	<c:forEach var="proj" items="${projList}">
                  <tr>
                  	<td>${proj.projYear}</td>
                      <td><span>${proj.projTypeName}</span></td>
                      <td><a style="color:blue;"  href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
                    	<td>${proj.applyOrgName}</td> 
                      <td>${proj.applyUserName}</td>
                    	<td width="200px">${proj.projStartTime}~${proj.projEndTime}</td>
                      <td>
                      	[<a href="javascript:void(0)" onclick="setUp('${proj.projFlow}')">审批</a>]
                      </td>
                  </tr>
                  </c:forEach>
              </tbody>
          </table>
          <c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
     </div> 	
   </div>
</body>
</html>