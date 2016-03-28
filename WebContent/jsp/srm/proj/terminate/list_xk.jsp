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
<script type="text/javascript">
		function searchProj() {
			jboxStartLoading();
			$("#searchForm").submit();
		}
		function auditList(projFlow){
			jboxStartLoading();
			jboxOpen("<s:url value='/srm/proj/mine/auditList?projFlow='/>"+projFlow, "审核信息", 900, 600);
		}
		function viewScheduleRec(projFlow){
			jboxStartLoading();
			jboxOpen("<s:url value='/srm/proj/terminate/audit'/>?projFlow="+projFlow, "审核", 900, 600);
		}
		
		//加载申请单位
		function loadApplyOrg(){
			//清空
			var org = $('#org');
			org.html('<option value="">请选择</option>');
			var chargeOrgFlow = $('#chargeOrg').val();
			if(!chargeOrgFlow){
				return ;
			}
			var url = "<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow;
			jboxStartLoading();
			jboxGet(url , null , function(data){
				$.each(data , function(i , n){
					org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
				});
			} , null , false);
		}
		function toPage(page) {
			if(page!=undefined){
				$("#currentPage").val(page);			
			}
			searchProj();
		}
</script>
<body>
	  <div class="content">
        <div class="title1 clearfix">
        	<form id="searchForm" action="<s:url value="/srm/proj/terminate/list/${sessionScope.projListScope}/${sessionScope.projCateScope}?recTypeId=${param.recTypeId}" />"
				method="post">
              <p>
              	年&#12288;&#12288;份：
              	<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
          		  学科类型：
          		  	<select class="xlselect" name="projTypeId">
          		  		<option value="">请选择</option>
                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumSubjTypeList}">
                       		<option value="${dictEnuProjType.dictId}" <c:if test='${param.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
                       	</c:forEach>
          		  	</select>
          		  学科编号：<input name="projNo" value="${param.projNo}" class="xltext"/>
           	</p>
            <p>
            	<c:if test='${sessionScope.projListScope=="charge"}'>
            		申报单位：
            		<select name="applyOrgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option  value="${org.orgFlow}" <c:if test="${param.applyOrgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
            	</c:if>
            	
            	<c:if test='${sessionScope.projListScope=="global"}'>
            		主管部门：
            		<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="chargeOrg" items="${chargeOrgList}">
            				<option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            			</c:forEach>
            		</select>
            		
            		申报单位：
            		<select id="org" name="orgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
            	</c:if>
            	
            	学科名称：<input type="text" name="projName" value="${param.projName}" class="xltext"/>
            	   <input id="currentPage" type="hidden" name="currentPage" value=""/>
                   <input type="button" class="search" onclick="searchProj();" value="查&#12288;询"> 
            </p>
         </form>
        </div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="10%" >年份</th>
					<th width="10%" >学科类别</th>
					<th width="10%" >学科名称</th>
					<th width="20%" >起止时间</th>
					<th width="10%" >学科负责人</th>
					<th width="10%" >当前阶段</th>
					<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
					<th width="10%" >申报单位</th>
					</c:if>
					<th width="10%" >审核意见</th>
					<th width="10%" >操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projList}" var="proj">
					<tr>
						<td><span>${proj.projYear }</span></td>
						<td>${proj.projTypeName }</td>
						<td><a href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
						<td>${proj.projStartTime }~${proj.projEndTime }</td>
						<td>${proj.applyUserName}</td>
						<td>${proj.projStageName }</td>
						<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
						<td>${proj.applyOrgName }</td>
						</c:if>
						<td><a href="javascript:void(0)" onclick="auditList('${proj.projFlow}');">查看</a></td>
                		<td><a href="javascript:viewScheduleRec('${proj.projFlow}');">审核</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
	</div>
</body>
</html>