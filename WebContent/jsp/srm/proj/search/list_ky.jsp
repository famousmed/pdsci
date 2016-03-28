<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
</head>
<script type="text/javascript">
		function searchProj(){
			jboxStartLoading();
			$("#searchForm").submit();
		}
		function resProj(){
			jboxStartLoading();
			$("#paramForm").submit();
		}
		function auditList(projFlow){
			jboxStartLoading();
			jboxOpen("<s:url value='/srm/proj/mine/auditList?projFlow='/>"+projFlow, "审核信息", 900, 600);
		}
		function audit(projFlow){
			$("#recForm").attr("action","<s:url value='/srm/proj/search/recList?projFlow='/>"+projFlow);
			jboxStartLoading();
			$("#recForm").submit();
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
		
		//加载项目状态枚举
		function loadProjStatusId(){
			var paramStatusId = '${param.projStatusId}';
			var status=$("#projStatusId");
			status.html('<option value="">请选择</option>');
			var stage=$("#projStageId").val();	
			if(stage){
				var url = "<s:url value='/srm/proj/search/loadProjStatus'/>?projStageId="+stage;
				jboxStartLoading();
				jboxGet(url , null , function(data){
					for(key in data){
						var sel = "";
						if(key == paramStatusId){sel = "selected"};
						status.append('<option value="'+key+'" '+sel+'>'+data[key]+'</option>');
					}
				} , null , false);
			}
		}
		
		$(document).ready(function(){
			loadProjStatusId();
		});
		
		function toPage(page) {
			if(page!=undefined){
				$("#currentPage").val(page);			
			}
			searchProj();
		}
	
		function exportExcel(){
			var url = "<s:url value='/srm/proj/search/exportExcel/${sessionScope.projListScope}/${sessionScope.projCateScope}'/>"
			jboxSubmit($('#searchForm'), url, null, null);
			jboxEndLoading();
		}
</script>
<body>
  <div class="mainright">
	  <div class="content">
        <div class="title1 clearfix">
            <form id="paramForm" action="<s:url value="/srm/proj/search/toExcel/${sessionScope.projListScope}/${sessionScope.projCateScope}?flag=y" />"
				method="post">
				<input type="hidden" name="projYear" value="${param.projYear}"/>
				<input type="hidden" name="projTypeId" value="${param.projTypeId}"/>
				<input type="hidden" name="projNo" value="${param.projNo}"/>
                <input type="hidden" name="projStageId" value="${param.projStageId}"/>
          		<input type="hidden" name="projStatusId" value="${param.projStatusId}"/>
          		<input type="hidden" name="applyOrgFlow" value="${param.applyOrgFlow}"/>
          		<input type="hidden" name="chargeOrgFlow" value="${param.chargeOrgFlow}"/>
          		<input type="hidden" name="orgFlow" value="${param.orgFlow}"/>
          		<input type="hidden" name="projName" value="${param.projName}"/>
		    </form>
        	<form id="searchForm" action="<s:url value="/srm/proj/search/list/${sessionScope.projListScope}/${sessionScope.projCateScope}?flag=y" />"
				method="post">
              <p>
              	年&#12288;&#12288;份：
              	<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
          		  项目类型：
          		  	<select class="xlselect" name="projTypeId">
          		  		<option value="">请选择</option>
                       	<c:forEach var="dict" items="${dictTypeEnumProjTypeList}">
                       		<option value="${dict.dictId}" <c:if test='${param.projTypeId==dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
                       	</c:forEach>
          		  	</select>
          		  项目编号：<input name="projNo" value="${param.projNo}" class="xltext"/>
            </p>
            <p>
                                                   项目阶段：&nbsp;<select id="projStageId" name="projStageId" onchange="loadProjStatusId();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="stage" items="${projStageEnumList}">
            				<option value="${stage.id}" <c:if test="${param.projStageId==stage.id}">selected</c:if>>${stage.name}</option>
            			</c:forEach>
            		    </select>
                                                     项目状态：&nbsp;<select id="projStatusId" name="projStatusId" class="xlselect">
            			<option value="">请选择项目阶段</option>
            		    </select>
                                                    项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext"/>
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
            	
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
				<c:if test="${pdfn:contains(param.projTypeId, 'yhwsj')  and  sessionScope.projListScope eq 'global'}">
					<input type="button" class="search" onclick="exportExcel();" value="导出Excel">
				</c:if>
				<!-- <input type="button" class="search" onclick="resProj();" value="导出Excel"> -->  
            </p>
         </form>
        </div>
        <form id="recForm" method="post">
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%" >年份</th>
					<th width="10%" >项目类别</th>
					<th >项目名称</th>
					<th >立项编号</th>
					<th width="10%" >起止时间</th>
					<th width="7%" >项目负责人</th>
					<th width="10%" >当前阶段</th>
					<th width="10%" >当前状态</th>
					<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
					<th width="20%" >申报单位</th>
					</c:if>
					<th width="7%" >审核意见</th>
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projList}" var="proj">
				<c:choose>
				  <c:when test="${sessionScope.projListScope == GlobalConstant.PROJ_STATUS_SCOPE_LOCAL}">
				       <tr>
						<td><span>${proj.projYear }</span></td>
						<td>${proj.projTypeName }</td>
						<td><a style="color:blue" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
						<td>${proj.projNo}</td>
						<td>${proj.projStartTime }~<br/>${proj.projEndTime }</td>
						<td>${proj.applyUserName}</td>
						<td>${proj.projStageName }</td>
						<td>${proj.projStatusName }</td>
						<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
						<td>${proj.applyOrgName }</td>
						</c:if>
						<td>[<a href="javascript:void(0)" onclick="auditList('${proj.projFlow}');">查看</a>]</td>
                		<td>
                		  [<a href="javascript:void(0)" onclick="audit('${proj.projFlow}');">进入</a>]
                		</td>
					</tr>
				  </c:when>
				  <c:otherwise>
				     <c:choose>
					<c:when test="${proj.projStageId == projStageEnumApply.id and  proj.projStatusId == projApplyStatusEnumApply.id }"></c:when>
				    <c:otherwise>
					<tr>
						<td><span>${proj.projYear }</span></td>
						<td>${proj.projTypeName }</td>
						<td><a style="color:blue" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
						<td>${proj.projNo}</td>
						<td>${proj.projStartTime }~<br/>${proj.projEndTime }</td>
						<td>${proj.applyUserName}</td>
						<td>${proj.projStageName }</td>
						<td>${proj.projStatusName }</td>
						<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
						<td>${proj.applyOrgName }</td>
						</c:if>
						<td>[<a href="javascript:void(0)" onclick="auditList('${proj.projFlow}');">查看</a>]</td>
                		<td>
                		  [<a href="javascript:void(0)" onclick="audit('${proj.projFlow}');">进入</a>]
                		</td>
					</tr>
			     </c:otherwise>
			     </c:choose>
				  </c:otherwise>
			     </c:choose>
				</c:forEach>
			</tbody>
		</table>
		</form>
		<c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
	</div>
	</div>
</body>


</html>