<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
		function searchProj() {
			jboxStartLoading();
			$("#searchForm").submit();
		}
		
		function viewExpertAudit(projFlow){
			jboxStartLoading();
			jboxOpen("<s:url value='/srm/proj/evaluation/viewExpertAudit'/>?projFlow="+projFlow+'&evaluationId='+$('#evaluationId').val(), "查看专家审核结果", 900, 600);
		}
		function groupProjConfig(projFlow){
			var evaluationId = $('#evaluationId').val();
			window.location.href="<s:url value='/srm/proj/evaluation/groupProjConfig'/>?projFlow="+projFlow+"&evaluationId="+evaluationId;
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
</head>
<body>
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<input name="evaluationId" id="evaluationId" value="${evaluationId}" type="hidden"/>
        	<form id="searchForm" action="<c:if test='${evaluationId eq evaluationEnmuApproveEvaluation.id}'><s:url value="/srm/proj/evaluation/approveList/${sessionScope.projListScope}/${sessionScope.projCateScope}" /></c:if><c:if test='${evaluationId eq evaluationEnmuCompleteEvaluation.id}'><s:url value="/srm/proj/evaluation/completeList/${sessionScope.projListScope}/${sessionScope.projCateScope}" /></c:if>"
				method="post">
              <p>
              	年&#12288;&#12288;份：
              	<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
          		  项目类型：
          		  	<select class="xlselect" name="projTypeId">
          		  		<option value="">请选择</option>
                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
                       		<option value="${dictEnuProjType.dictId}" <c:if test='${param.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
                       	</c:forEach>
          		  	</select>
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
            	
            	<c:if test='${sessionScope.projListScope=="global" }'>
            		主管部门：
            		<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="chargeOrg" items="${chargeOrgList}">
            				<option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            			</c:forEach>
            		</select>
            		
            		申报单位：
            		<select id="org" name="applyOrgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option value="${org.orgFlow}" <c:if test="${param.applyOrgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
            	</c:if>
            	
            	项目名称：&nbsp;<input type="text" name="projName" value="${param.projName}" class="xltext"/>
            	   <input id="currentPage" type="hidden" name="currentPage" value=""/>
                   <input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
            </p>
         </form>      
        </div>
        <table class="xllist">
            <thead>
                <tr>
                    <th width="5%">年份</th>
                    <th width="10%">项目类别</th>
                    <th width="20%">项目名称</th>
                    <th width="10%">起止时间</th>
                    <th width="15%">申报单位</th>
                    <th width="10%">申报人</th>
                    <th width="10%">评审类型</th>
                    <th width="10%">评审方案</th>
                    <th width="12%">操作</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${projList}" var="proj" varStatus="sta"> 
                <tr>
                    <td>${proj.projYear}</td>
                    <td>${proj.projTypeName}</td>
                    <td><a style="color:blue" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
                    <td>${proj.projStartTime}~<br/>${proj.projEndTime}</td>
                    <td>${proj.applyOrgName}</td>
                    <td>${proj.applyUserName}</td>
                    <td>${proj.srmExpertGroupProj.evaluationWayName}</td>
                    <td>
                        <c:if test='${empty proj.srmExpertGroupProj.schemeName}'>未设置</c:if>
                        <c:if test='${!empty proj.srmExpertGroupProj.schemeName}'>${proj.srmExpertGroupProj.schemeName}</c:if>
                    </td>
                    <td>
						[<a href="javascript:groupProjConfig('${proj.projFlow}');">评审设置</a>]&nbsp;
						<!-- |<a href="javascript:expertNotice('${proj.projFlow}');">委员通知</a> -->
						[<a href="javascript:viewExpertAudit('${proj.projFlow}');">评审结果</a>]
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