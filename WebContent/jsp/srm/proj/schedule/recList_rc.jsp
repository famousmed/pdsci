<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
</head>
<script type="text/javascript">
	function audit(recFlow){
		var url = "<s:url value='/srm/proj/schedule/audit?recFlow='/>" + recFlow;
		var html =  $("#auditDiv").html().trim();
		if(html == ""){
			jboxStartLoading();
			jboxGet(url , null , function(data){
				$("#auditDiv").html(data);
				$("#auditDiv").slideDown();
			} , null , false);
		}else{
			$("#auditDiv").slideToggle();
		}
	}
</script>
</head>

<body >
  <div class="mainright">
   <div class="content">
          <div class="title1 clearfix">
        	  <div>
        		<table>
        		<tr height="30px">
        			<td style="font-weight: bold;">人才名称：</td><td colspan="3"><a target="_blank" style="color:blue;" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>">${proj.projName}</a></td>
        		</tr> 
        		<tr  height="30px">
        			<td style="font-weight: bold;">人才类型：</td>
        			<td width="200px">${proj.projTypeName}</td>
        			<td style="font-weight: bold;">起止时间：</td>
        			<td>${proj.projStartTime}~${proj.projEndTime}</td>
        		</tr>
        		<tr  height="30px">
        			<td style="font-weight: bold;">承担单位：</td>
        			<td>${proj.applyOrgName}</td>
        			<td style="font-weight: bold;">负责人：</td>
        			<td>${proj.applyUserName}</td>
        		</tr>
              </table>
              </div>
        </div>
          <hr/>
	<div >
		<table class="xllist" >
                   		<tr>
                   			<th>名称</th><th width="100px">填写人</th><th width="200px">填写时间</th>
                   			<th width="100px">当前状态</th><th width="100px">操作</th>
                   		</tr>
                   		<c:forEach items="${recList }" var="report">
                   			<tr >
                   				<td>${report.recTypeName }</td>
                   				<td>${report.operUserName }</td>
                    			<td>${pdfn: transDateTime(report.operTime)}</td>
                    			<td>
                    				<c:choose>
                    					<c:when test="${report.projStatusId==projScheduleStatusEnumApply.id }">${projScheduleStatusEnumApply.name }</c:when>
										<c:when test="${report.projStatusId==projScheduleStatusEnumSubmit.id }">${projScheduleStatusEnumSubmit.name }</c:when>
										<c:when test="${report.projStatusId==projScheduleStatusEnumFirstAudit.id }">${projScheduleStatusEnumFirstAudit.name }</c:when>
										<c:when test="${report.projStatusId==projScheduleStatusEnumSecondAudit.id }">${projScheduleStatusEnumSecondAudit.name }</c:when>
										<c:when test="${report.projStatusId==projScheduleStatusEnumThirdAudit.id }">${projScheduleStatusEnumThirdAudit.name }</c:when>                            				
                    				</c:choose>
                    			</td> 
                    			<td style="text-align: center;">
                    				<c:if test="${(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL == sessionScope.projListScope and  report.projStatusId == projScheduleStatusEnumSubmit.id )||
                    							 (GlobalConstant.PROJ_STATUS_SCOPE_CHARGE == sessionScope.projListScope  and  report.projStatusId == projScheduleStatusEnumFirstAudit.id ) ||
                    							 (GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL == sessionScope.projListScope  and ( report.projStatusId != projScheduleStatusEnumThirdAudit.id && report.projStatusId != projScheduleStatusEnumApply.id) )
                    				}">
                    					&#12288;<a href="javascript:audit('${report.recFlow}');">[审核]</a>
                    				</c:if>
                    				<a href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}&recTypeId=${report.recTypeId}&recFlow=${report.recFlow}'/>"  target="_blank"> &nbsp;[查看]</a>
								</td>
                   			</tr>
           		</c:forEach>
           	</table>
	</div>
      <hr/>
      <div id="auditDiv" style="display: none">
      </div>
   </div>
   </div>
</body>
</html>
